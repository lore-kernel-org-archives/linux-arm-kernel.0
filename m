From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 22 Aug 2018 22:43:01 +0200
Subject: [PATCH 08/14] USB: EHCI: ehci-mv: use phy-pxa-usb
In-Reply-To: <20180822204307.13251-1-lkundrak@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
Message-ID: <20180822204307.13251-9-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a proper PHY driver, instead of hooks to a board support package.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/mach-mmp/devices.c | 11 +---------
 drivers/usb/host/ehci-mv.c  | 44 ++++++++++++++++++-------------------
 2 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
index d162fabd38e7..822b8be042b9 100644
--- a/arch/arm/mach-mmp/devices.c
+++ b/arch/arm/mach-mmp/devices.c
@@ -298,21 +298,12 @@ struct platform_device pxa168_device_u2o = {
 
 #if IS_ENABLED(CONFIG_USB_EHCI_MV_U2O)
 struct resource pxa168_u2oehci_resources[] = {
-	/* regbase */
 	[0] = {
-		.start	= PXA168_U2O_REGBASE + U2x_CAPREGS_OFFSET,
+		.start	= PXA168_U2O_REGBASE,
 		.end	= PXA168_U2O_REGBASE + USB_REG_RANGE,
 		.flags	= IORESOURCE_MEM,
-		.name	= "capregs",
 	},
-	/* phybase */
 	[1] = {
-		.start	= PXA168_U2O_PHYBASE,
-		.end	= PXA168_U2O_PHYBASE + USB_PHY_RANGE,
-		.flags	= IORESOURCE_MEM,
-		.name	= "phyregs",
-	},
-	[2] = {
 		.start	= IRQ_PXA168_USB1,
 		.end	= IRQ_PXA168_USB1,
 		.flags	= IORESOURCE_IRQ,
diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index 705d1b43b2dd..43b300c90875 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -18,6 +18,9 @@
 
 #include "ehci.h"
 
+/* registers */
+#define U2x_CAPREGS_OFFSET       0x100
+
 #define CAPLENGTH_MASK         (0xff)
 
 #define hcd_to_ehci_hcd_mv(h) ((struct ehci_hcd_mv *)hcd_to_ehci(h)->priv)
@@ -26,13 +29,14 @@ struct ehci_hcd_mv {
 	/* Which mode does this ehci running OTG/Host ? */
 	int mode;
 
-	void __iomem *phy_regs;
+	void __iomem *base;
 	void __iomem *cap_regs;
 	void __iomem *op_regs;
 
 	struct usb_phy *otg;
 
 	struct mv_usb_platform_data *pdata;
+	struct phy *phy;
 
 	struct clk *clk;
 };
@@ -49,22 +53,13 @@ static void ehci_clock_disable(struct ehci_hcd_mv *ehci_mv)
 
 static int mv_ehci_enable(struct ehci_hcd_mv *ehci_mv)
 {
-	int retval;
-
 	ehci_clock_enable(ehci_mv);
-	if (ehci_mv->pdata->phy_init) {
-		retval = ehci_mv->pdata->phy_init(ehci_mv->phy_regs);
-		if (retval)
-			return retval;
-	}
-
-	return 0;
+	return phy_init(ehci_mv->phy);
 }
 
 static void mv_ehci_disable(struct ehci_hcd_mv *ehci_mv)
 {
-	if (ehci_mv->pdata->phy_deinit)
-		ehci_mv->pdata->phy_deinit(ehci_mv->phy_regs);
+	phy_exit(ehci_mv->phy);
 	ehci_clock_disable(ehci_mv);
 }
 
@@ -121,6 +116,14 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	ehci_mv = hcd_to_ehci_hcd_mv(hcd);
 	ehci_mv->pdata = pdata;
 
+	ehci_mv->phy = devm_phy_get(&pdev->dev, "usb");
+	if (IS_ERR(ehci_mv->phy)) {
+		retval = PTR_ERR(ehci_mv->phy);
+		if (retval != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to get phy.\n");
+		goto err_put_hcd;
+	}
+
 	ehci_mv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ehci_mv->clk)) {
 		dev_err(&pdev->dev, "error getting clock\n");
@@ -128,17 +131,12 @@ static int mv_ehci_probe(struct platform_device *pdev)
 		goto err_put_hcd;
 	}
 
-	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phyregs");
-	ehci_mv->phy_regs = devm_ioremap_resource(&pdev->dev, r);
-	if (IS_ERR(ehci_mv->phy_regs)) {
-		retval = PTR_ERR(ehci_mv->phy_regs);
-		goto err_put_hcd;
-	}
 
-	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "capregs");
-	ehci_mv->cap_regs = devm_ioremap_resource(&pdev->dev, r);
-	if (IS_ERR(ehci_mv->cap_regs)) {
-		retval = PTR_ERR(ehci_mv->cap_regs);
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ehci_mv->base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(ehci_mv->base)) {
+		retval = PTR_ERR(ehci_mv->base);
 		goto err_put_hcd;
 	}
 
@@ -148,6 +146,8 @@ static int mv_ehci_probe(struct platform_device *pdev)
 		goto err_put_hcd;
 	}
 
+	ehci_mv->cap_regs =
+		(void __iomem *) ((unsigned long) ehci_mv->base + U2x_CAPREGS_OFFSET);
 	offset = readl(ehci_mv->cap_regs) & CAPLENGTH_MASK;
 	ehci_mv->op_regs =
 		(void __iomem *) ((unsigned long) ehci_mv->cap_regs + offset);
-- 
2.17.1
