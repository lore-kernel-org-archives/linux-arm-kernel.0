From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 20:10:33 +0000
Subject: [PATCH 5/5] USB: sa1111: add hcd .reset method
In-Reply-To: <20120203200406.GI14129@n2100.arm.linux.org.uk>
References: <20120203200406.GI14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPSr-00048k-6G@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the .reset method to the HCD, and update the .start method
accordingly for this change.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/usb/host/ohci-sa1111.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/ohci-sa1111.c b/drivers/usb/host/ohci-sa1111.c
index 95c3f0f..e1004fb 100644
--- a/drivers/usb/host/ohci-sa1111.c
+++ b/drivers/usb/host/ohci-sa1111.c
@@ -55,22 +55,25 @@ static void dump_hci_status(struct usb_hcd *hcd, const char *label)
 }
 #endif
 
+static int ohci_sa1111_reset(struct usb_hcd *hcd)
+{
+	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+
+	ohci_hcd_init(ohci);
+	return ohci_init(ohci);
+}
+
 static int __devinit ohci_sa1111_start(struct usb_hcd *hcd)
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
 	int ret;
 
-	ret = ohci_init(ohci);
-	if (ret < 0)
-		return ret;
-
 	ret = ohci_run(ohci);
 	if (ret < 0) {
-		err("can't start %s", hcd->self.bus_name);
+		ohci_err(ohci, "can't start\n");
 		ohci_stop(hcd);
-		return ret;
 	}
-	return 0;
+	return ret;
 }
 
 static const struct hc_driver ohci_sa1111_hc_driver = {
@@ -87,6 +90,7 @@ static const struct hc_driver ohci_sa1111_hc_driver = {
 	/*
 	 * basic lifecycle operations
 	 */
+	.reset =		ohci_sa1111_reset,
 	.start =		ohci_sa1111_start,
 	.stop =			ohci_stop,
 	.shutdown =		ohci_shutdown,
@@ -200,8 +204,6 @@ static int ohci_hcd_sa1111_probe(struct sa1111_dev *dev)
 	if (ret)
 		goto err2;
 
-	ohci_hcd_init(hcd_to_ohci(hcd));
-
 	ret = usb_add_hcd(hcd, dev->irq[1], 0);
 	if (ret == 0)
 		return ret;
-- 
1.7.4.4
