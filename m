From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 20:10:13 +0000
Subject: [PATCH 4/5] USB: sa1111: add OHCI shutdown methods
In-Reply-To: <20120203200406.GI14129@n2100.arm.linux.org.uk>
References: <20120203200406.GI14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPSX-00048g-2Q@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add OHCI shutdown methods to cleanly shutdown the OHCI controller on
system shutdowns and reboots.  This avoids the controller continuing
to run should be soft-reboot the platform, potentially scribbling
over system memory.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/usb/host/ohci-sa1111.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ohci-sa1111.c b/drivers/usb/host/ohci-sa1111.c
index 83f3a40..95c3f0f 100644
--- a/drivers/usb/host/ohci-sa1111.c
+++ b/drivers/usb/host/ohci-sa1111.c
@@ -89,6 +89,7 @@ static const struct hc_driver ohci_sa1111_hc_driver = {
 	 */
 	.start =		ohci_sa1111_start,
 	.stop =			ohci_stop,
+	.shutdown =		ohci_shutdown,
 
 	/*
 	 * managing i/o requests and associated device resources
@@ -232,6 +233,16 @@ static int ohci_hcd_sa1111_remove(struct sa1111_dev *dev)
 	return 0;
 }
 
+static void ohci_hcd_sa1111_shutdown(struct sa1111_dev *dev)
+{
+	struct usb_hcd *hcd = sa1111_get_drvdata(dev);
+
+	if (test_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags)) {
+		hcd->driver->shutdown(hcd);
+		sa1111_stop_hc(dev);
+	}
+}
+
 static struct sa1111_driver ohci_hcd_sa1111_driver = {
 	.drv = {
 		.name	= "sa1111-ohci",
@@ -240,4 +251,5 @@ static struct sa1111_driver ohci_hcd_sa1111_driver = {
 	.devid		= SA1111_DEVID_USB,
 	.probe		= ohci_hcd_sa1111_probe,
 	.remove		= ohci_hcd_sa1111_remove,
+	.shutdown	= ohci_hcd_sa1111_shutdown,
 };
-- 
1.7.4.4
