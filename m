From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon, 12 Nov 2018 04:20:27 +0100
Subject: [PATCH v3 18/18] USB: gadget: mv-udc: use phy-pxa-usb
In-Reply-To: <20181112032027.653931-1-lkundrak@v3.sk>
References: <20181112032027.653931-1-lkundrak@v3.sk>
Message-ID: <20181112032027.653931-19-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a proper PHY driver, instead of hooks to a board support package.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/mach-mmp/devices.c          | 11 +-------
 drivers/usb/gadget/udc/mv_udc.h      |  7 ++++-
 drivers/usb/gadget/udc/mv_udc_core.c | 38 ++++++++--------------------
 3 files changed, 17 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
index eb9b3c34e90a..d925be9f14a9 100644
--- a/arch/arm/mach-mmp/devices.c
+++ b/arch/arm/mach-mmp/devices.c
@@ -263,21 +263,12 @@ struct platform_device pxa168_device_usb_phy = {
 
 #if IS_ENABLED(CONFIG_USB_MV_UDC)
 struct resource pxa168_u2o_resources[] = {
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
diff --git a/drivers/usb/gadget/udc/mv_udc.h b/drivers/usb/gadget/udc/mv_udc.h
index b3f759c0962c..6f04f432964d 100644
--- a/drivers/usb/gadget/udc/mv_udc.h
+++ b/drivers/usb/gadget/udc/mv_udc.h
@@ -6,6 +6,9 @@
 #ifndef __MV_UDC_H
 #define __MV_UDC_H
 
+/* registers */
+#define U2x_CAPREGS_OFFSET	0x100
+
 #define VUSBHS_MAX_PORTS	8
 
 #define DQH_ALIGNMENT		2048
@@ -174,9 +177,9 @@ struct mv_udc {
 	struct platform_device		*dev;
 	int				irq;
 
+	void __iomem                    *base;
 	struct mv_cap_regs __iomem	*cap_regs;
 	struct mv_op_regs __iomem	*op_regs;
-	void __iomem                    *phy_regs;
 	unsigned int			max_eps;
 	struct mv_dqh			*ep_dqh;
 	size_t				ep_dqh_size;
@@ -219,6 +222,8 @@ struct mv_udc {
 
 	/* some SOC has mutiple clock sources for USB*/
 	struct clk      *clk;
+
+	struct phy	*phy;
 };
 
 /* endpoint data structure */
diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
index cafde053788b..35b0bde2d46f 100644
--- a/drivers/usb/gadget/udc/mv_udc_core.c
+++ b/drivers/usb/gadget/udc/mv_udc_core.c
@@ -1069,14 +1069,11 @@ static int mv_udc_enable_internal(struct mv_udc *udc)
 	if (retval)
 		return retval;
 
-	if (udc->pdata->phy_init) {
-		retval = udc->pdata->phy_init(udc->phy_regs);
-		if (retval) {
-			dev_err(&udc->dev->dev,
-				"init phy error %d\n", retval);
-			udc_clock_disable(udc);
-			return retval;
-		}
+	retval = phy_init(udc->phy);
+	if (retval) {
+		dev_err(&udc->dev->dev, "init phy error %d\n", retval);
+		udc_clock_disable(udc);
+		return retval;
 	}
 	udc->active = 1;
 
@@ -1095,8 +1092,7 @@ static void mv_udc_disable_internal(struct mv_udc *udc)
 {
 	if (udc->active) {
 		dev_dbg(&udc->dev->dev, "disable udc\n");
-		if (udc->pdata->phy_deinit)
-			udc->pdata->phy_deinit(udc->phy_regs);
+		phy_exit(udc->phy);
 		udc_clock_disable(udc);
 		udc->active = 0;
 	}
@@ -2147,30 +2143,16 @@ static int mv_udc_probe(struct platform_device *pdev)
 	if (IS_ERR(udc->clk))
 		return PTR_ERR(udc->clk);
 
-	r = platform_get_resource_byname(udc->dev, IORESOURCE_MEM, "capregs");
+	r = platform_get_resource(udc->dev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
 		dev_err(&pdev->dev, "no I/O memory resource defined\n");
 		return -ENODEV;
 	}
 
-	udc->cap_regs = (struct mv_cap_regs __iomem *)
-		devm_ioremap(&pdev->dev, r->start, resource_size(r));
-	if (udc->cap_regs == NULL) {
-		dev_err(&pdev->dev, "failed to map I/O memory\n");
-		return -EBUSY;
-	}
-
-	r = platform_get_resource_byname(udc->dev, IORESOURCE_MEM, "phyregs");
-	if (r == NULL) {
-		dev_err(&pdev->dev, "no phy I/O memory resource defined\n");
-		return -ENODEV;
-	}
+	udc->base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
 
-	udc->phy_regs = devm_ioremap(&pdev->dev, r->start, resource_size(r));
-	if (udc->phy_regs == NULL) {
-		dev_err(&pdev->dev, "failed to map phy I/O memory\n");
-		return -EBUSY;
-	}
+	udc->cap_regs =
+		(void __iomem *) ((unsigned long)udc->base + U2x_CAPREGS_OFFSET);
 
 	/* we will acces controller register, so enable the clk */
 	retval = mv_udc_enable_internal(udc);
-- 
2.19.1
