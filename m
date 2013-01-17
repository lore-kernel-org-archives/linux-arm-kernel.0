From: rogerq@ti.com (Roger Quadros)
Date: Thu, 17 Jan 2013 13:30:21 +0200
Subject: [PATCH v7 12/22] mfd: omap-usb-host: know about number of ports from
 revision register
In-Reply-To: <1358422231-24736-1-git-send-email-rogerq@ti.com>
References: <1358422231-24736-1-git-send-email-rogerq@ti.com>
Message-ID: <1358422231-24736-13-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The revision register should tell us how many ports are present.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-host.c |   33 ++++++++++++++++++++++++++++-----
 1 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 310aaa9..26319ca 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -91,6 +91,8 @@
 
 
 struct usbhs_hcd_omap {
+	int				nports;
+
 	struct clk			*xclk60mhsp1_ck;
 	struct clk			*xclk60mhsp2_ck;
 	struct clk			*utmi_p1_fck;
@@ -347,8 +349,6 @@ static void omap_usbhs_init(struct device *dev)
 
 	pm_runtime_get_sync(dev);
 	spin_lock_irqsave(&omap->lock, flags);
-	omap->usbhs_rev = usbhs_read(omap->uhh_base, OMAP_UHH_REVISION);
-	dev_dbg(dev, "OMAP UHH_REVISION 0x%x\n", omap->usbhs_rev);
 
 	reg = usbhs_read(omap->uhh_base, OMAP_UHH_HOSTCONFIG);
 	/* setup ULPI bypass and burst configurations */
@@ -483,7 +483,32 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
-	for (i = 0; i < OMAP3_HS_USB_PORTS; i++)
+	platform_set_drvdata(pdev, omap);
+	pm_runtime_get_sync(dev);
+
+	omap->usbhs_rev = usbhs_read(omap->uhh_base, OMAP_UHH_REVISION);
+
+	/* we need to call runtime suspend before we update omap->nports
+	 * to prevent unbalanced clk_disable()
+	 */
+	pm_runtime_put_sync(dev);
+
+	switch (omap->usbhs_rev) {
+	case OMAP_USBHS_REV1:
+		omap->nports = 3;
+		break;
+	case OMAP_USBHS_REV2:
+		omap->nports = 2;
+		break;
+	default:
+		omap->nports = OMAP3_HS_USB_PORTS;
+		dev_dbg(dev,
+		  "USB HOST Rev : 0x%d not recognized, assuming %d ports\n",
+		   omap->usbhs_rev, omap->nports);
+		break;
+	}
+
+	for (i = 0; i < omap->nports; i++)
 		if (is_ehci_phy_mode(i) || is_ehci_tll_mode(i) ||
 			is_ehci_hsic_mode(i)) {
 			omap->ehci_logic_fck = clk_get(dev, "ehci_logic_fck");
@@ -573,8 +598,6 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 				"failed error:%d\n", ret);
 	}
 
-	platform_set_drvdata(pdev, omap);
-
 	omap_usbhs_init(dev);
 	ret = omap_usbhs_alloc_children(pdev);
 	if (ret) {
-- 
1.7.4.1
