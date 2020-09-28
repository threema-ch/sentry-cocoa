import Sentry
import SwiftUI

struct ContentView: View {
    var addBreadcrumbAction: () -> Void = {
        let crumb = Breadcrumb(level: SentryLevel.info, category: "Debug")
        crumb.message = "tapped addBreadcrumb"
        crumb.type = "user"
        SentrySDK.addBreadcrumb(crumb: crumb)
    }
    
    var captureMessageAction: () -> Void = {
        SentrySDK.capture(message: "Yeah captured a message")
    }
    
    var captureErrorAction: () -> Void = {
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Object does not exist"])
        SentrySDK.capture(error: error) { (scope) in
            scope.setTag(value: "value", key: "myTag")
        }
    }
    
    var captureNSExceptionAction: () -> Void = {
        let exception = NSException(name: NSExceptionName("My Custom exeption"), reason: "User clicked the button", userInfo: nil)
        let scope = Scope()
        scope.setLevel(.fatal)
        SentrySDK.capture(exception: exception, scope: scope)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Button(action: addBreadcrumbAction) {
                    Text("Add Breadcrumb")
                }
                
                Button(action: captureMessageAction) {
                    Text("Capture Message")
                }
                
                Button(action: captureErrorAction) {
                    Text("Capture Error")
                }
                
                Button(action: captureNSExceptionAction) {
                    Text("Capture NSException")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
