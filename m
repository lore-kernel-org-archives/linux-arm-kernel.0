From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue,  1 May 2012 17:36:54 -0400
Subject: [PATCH] usb: [ARM] fix unresolved err() reference in
 host/ohci-pxa27x.c
Message-ID: <1335908214-4803-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit af4e1ee04026908086d7ed252db2619a8ceaa333 (usb-next)

    "USB: remove err() macro"

was preceeded by a tree-wide cleanup of users, however this
one squeaked through the cracks because it had whitespace
between the function name and the bracket for the args.

Map it onto dev_err, just like all the "pre-commits" made
in advance of af4e1ee04026, such as the example seen in
the commit d57b177208b6ec20cacd7321ee32ef02f9f9e7fa:

    "USB: ohci-xls.c: remove err() usage"

Build tested with the ARM magician_defconfig settings.

Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index c31b281..e1a3cc6 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -419,7 +419,8 @@ ohci_pxa27x_start (struct usb_hcd *hcd)
 		return ret;
 
 	if ((ret = ohci_run (ohci)) < 0) {
-		err ("can't start %s", hcd->self.bus_name);
+		dev_err(hcd->self.controller, "can't start %s",
+			hcd->self.bus_name);
 		ohci_stop (hcd);
 		return ret;
 	}
-- 
1.7.9.1
