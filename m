From: awallis@codeaurora.org (Adam Wallis)
Date: Tue, 28 Nov 2017 12:11:46 -0500
Subject: [PATCH v1] usb: xhci: allow imod-interval to be configurable
Message-ID: <1511889106-9239-1-git-send-email-awallis@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The xHCI driver currently has the IMOD set to 160, which
translates to an IMOD interval of 40,000ns (160 * 250)ns

Commit 0cbd4b34cda9 ("xhci: mediatek: support MTK xHCI host controller")
introduced a QUIRK for the MTK platform to adjust this interval to 20,
which translates to an IMOD interval of 5,000ns (20 * 250)ns. This is
due to the fact that the MTK controller IMOD interval is 8 times
as much as defined in xHCI spec.

Instead of adding more quirk bits for additional platforms, this patch
introduces the ability for vendors to set the IMOD_INTERVAL as is
optimal for their platform. By using device_property_read_u32() on
"imod-interval", the IMOD INTERVAL can be specified in nano seconds. If
no interval is specified, the default of 40,000ns (IMOD=160) will be
used.

No bounds checking has been implemented due to the fact that a vendor
may have violated the spec and would need to specify a value outside of
the max 8,000 IRQs/second limit specified in the xHCI spec.

Backwards compatibility is maintained for MTK_HOSTS through the quirk
bit, however, imod_interval should be pushed into device tree at a
future point and this quirk should be removed from xhci_plat_probe

Signed-off-by: Adam Wallis <awallis@codeaurora.org>
---
 Documentation/devicetree/bindings/usb/usb-xhci.txt |  1 +
 drivers/usb/host/xhci-plat.c                       | 15 +++++++++++++++
 drivers/usb/host/xhci.c                            |  7 ++-----
 drivers/usb/host/xhci.h                            |  2 ++
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index ae6e484..3998459 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -29,6 +29,7 @@ Optional properties:
   - usb2-lpm-disable: indicate if we don't want to enable USB2 HW LPM
   - usb3-lpm-capable: determines if platform is USB3 LPM capable
   - quirk-broken-port-ped: set if the controller has broken port disable mechanism
+  - imod-interval: IMOD_INTERVAL in nano-seconds. Default is 40000
 
 Example:
 	usb at f0931000 {
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 09f164f..f7730c8 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -23,6 +23,7 @@
 #include "xhci-plat.h"
 #include "xhci-mvebu.h"
 #include "xhci-rcar.h"
+#include "xhci-mtk.h"
 
 static struct hc_driver __read_mostly xhci_plat_hc_driver;
 
@@ -269,6 +270,20 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (device_property_read_bool(&pdev->dev, "quirk-broken-port-ped"))
 		xhci->quirks |= XHCI_BROKEN_PORT_PED;
 
+	/* imod interval in nanoseconds */
+	if (device_property_read_u32(sysdev,
+		"imod-interval", &xhci->imod_interval))
+		xhci->imod_interval = 40000;
+	else if (xhci->quirks & XHCI_MTK_HOST)
+		/*
+		 * The increment interval is 8 times as much as that defined in
+		 * the xHCI spec on MTK's controller. This is added to provide
+		 * backwards compatibility, however, this should be pushed into
+		 * the device tree files at some point in the future and
+		 * removed from xhci_plat_probe
+		 */
+		xhci->imod_interval = 5000;
+
 	hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
 	if (IS_ERR(hcd->usb_phy)) {
 		ret = PTR_ERR(hcd->usb_phy);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 2424d30..6a09311 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -586,11 +586,8 @@ int xhci_run(struct usb_hcd *hcd)
 			"// Set the interrupt modulation register");
 	temp = readl(&xhci->ir_set->irq_control);
 	temp &= ~ER_IRQ_INTERVAL_MASK;
-	/*
-	 * the increment interval is 8 times as much as that defined
-	 * in xHCI spec on MTK's controller
-	 */
-	temp |= (u32) ((xhci->quirks & XHCI_MTK_HOST) ? 20 : 160);
+	temp |= (u16) (xhci->imod_interval / 250);
+
 	writel(temp, &xhci->ir_set->irq_control);
 
 	/* Set the HCD state before we enable the irqs */
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 99a014a..2a4177b 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1717,6 +1717,8 @@ struct xhci_hcd {
 	u8		max_interrupters;
 	u8		max_ports;
 	u8		isoc_threshold;
+	/* imod_interval in ns (I * 250ns) */
+	u32		imod_interval;
 	int		event_ring_max;
 	/* 4KB min, 128MB max */
 	int		page_size;
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
