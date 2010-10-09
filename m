From: paulius.zaleckas@gmail.com (Paulius Zaleckas)
Date: Sat, 09 Oct 2010 17:49:54 +0300
Subject: [PATCH 2/2] USB: s3-hsotg: Remove PHY initialization code and use CLK
	API
In-Reply-To: <20101009143307.30918.15164.stgit@localhost.localdomain>
References: <20101009143307.30918.15164.stgit@localhost.localdomain>
Message-ID: <20101009144954.30918.63864.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All USB PHY initialization now is handled hy xusbxti clock
enable procedure.

Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---

 arch/arm/plat-samsung/include/plat/udc-hs.h |    2 -
 drivers/usb/gadget/s3c-hsotg.c              |   94 +++++----------------------
 2 files changed, 16 insertions(+), 80 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/udc-hs.h b/arch/arm/plat-samsung/include/plat/udc-hs.h
index a22a4f2..a8221cf 100644
--- a/arch/arm/plat-samsung/include/plat/udc-hs.h
+++ b/arch/arm/plat-samsung/include/plat/udc-hs.h
@@ -21,9 +21,7 @@ enum s3c_hsotg_dmamode {
 /**
  * struct s3c_hsotg_plat - platform data for high-speed otg/udc
  * @dma: Whether to use DMA or not.
- * @is_osc: The clock source is an oscillator, not a crystal
  */
 struct s3c_hsotg_plat {
 	enum s3c_hsotg_dmamode	dma;
-	unsigned int		is_osc : 1;
 };
diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index a229744..129e6ff 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -151,6 +151,7 @@ struct s3c_hsotg {
 	struct resource		*regs_res;
 	int			irq;
 	struct clk		*clk;
+	struct clk		*phy_clk;
 
 	unsigned int		dedicated_fifos:1;
 
@@ -2791,51 +2792,6 @@ static void __devinit s3c_hsotg_initep(struct s3c_hsotg *hsotg,
 	}
 }
 
-/**
- * s3c_hsotg_otgreset - reset the OtG phy block
- * @hsotg: The host state.
- *
- * Power up the phy, set the basic configuration and start the PHY.
- */
-static void s3c_hsotg_otgreset(struct s3c_hsotg *hsotg)
-{
-	struct clk *xusbxti;
-	u32 pwr, osc;
-
-	pwr = readl(S3C_PHYPWR);
-	pwr &= ~0x19;
-	writel(pwr, S3C_PHYPWR);
-	mdelay(1);
-
-	osc = hsotg->plat->is_osc ? S3C_PHYCLK_EXT_OSC : 0;
-
-	xusbxti = clk_get(hsotg->dev, "xusbxti");
-	if (xusbxti && !IS_ERR(xusbxti)) {
-		switch (clk_get_rate(xusbxti)) {
-		case 12*MHZ:
-			osc |= S3C_PHYCLK_CLKSEL_12M;
-			break;
-		case 24*MHZ:
-			osc |= S3C_PHYCLK_CLKSEL_24M;
-			break;
-		default:
-		case 48*MHZ:
-			/* default reference clock */
-			break;
-		}
-		clk_put(xusbxti);
-	}
-
-	writel(osc | 0x10, S3C_PHYCLK);
-
-	/* issue a full set of resets to the otg and core */
-
-	writel(S3C_RSTCON_PHY, S3C_RSTCON);
-	udelay(20);	/* at-least 10uS */
-	writel(0, S3C_RSTCON);
-}
-
-
 static void s3c_hsotg_init(struct s3c_hsotg *hsotg)
 {
 	u32 cfg4;
@@ -3206,32 +3162,6 @@ static void __devexit s3c_hsotg_delete_debug(struct s3c_hsotg *hsotg)
 	debugfs_remove(hsotg->debug_root);
 }
 
-/**
- * s3c_hsotg_gate - set the hardware gate for the block
- * @pdev: The device we bound to
- * @on: On or off.
- *
- * Set the hardware gate setting into the block. If we end up on
- * something other than an S3C64XX, then we might need to change this
- * to using a platform data callback, or some other mechanism.
- */
-static void s3c_hsotg_gate(struct platform_device *pdev, bool on)
-{
-	unsigned long flags;
-	u32 others;
-
-	local_irq_save(flags);
-
-	others = __raw_readl(S3C64XX_OTHERS);
-	if (on)
-		others |= S3C64XX_OTHERS_USBMASK;
-	else
-		others &= ~S3C64XX_OTHERS_USBMASK;
-	__raw_writel(others, S3C64XX_OTHERS);
-
-	local_irq_restore(flags);
-}
-
 static struct s3c_hsotg_plat s3c_hsotg_default_pdata;
 
 static int __devinit s3c_hsotg_probe(struct platform_device *pdev)
@@ -3257,20 +3187,27 @@ static int __devinit s3c_hsotg_probe(struct platform_device *pdev)
 	hsotg->dev = dev;
 	hsotg->plat = plat;
 
-	hsotg->clk = clk_get(&pdev->dev, "otg");
+	hsotg->clk = clk_get(dev, "otg");
 	if (IS_ERR(hsotg->clk)) {
 		dev_err(dev, "cannot get otg clock\n");
 		ret = -EINVAL;
 		goto err_mem;
 	}
 
+	hsotg->phy_clk = clk_get(dev, "xusbxti");
+	if (IS_ERR(hsotg->phy_clk)) {
+		dev_err(dev, "cannot get xusbxti clock\n");
+		ret = -EINVAL;
+		goto err_clk;
+	}
+
 	platform_set_drvdata(pdev, hsotg);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(dev, "cannot find register resource 0\n");
 		ret = -EINVAL;
-		goto err_clk;
+		goto err_phy_clk;
 	}
 
 	hsotg->regs_res = request_mem_region(res->start, resource_size(res),
@@ -3278,7 +3215,7 @@ static int __devinit s3c_hsotg_probe(struct platform_device *pdev)
 	if (!hsotg->regs_res) {
 		dev_err(dev, "cannot reserve registers\n");
 		ret = -ENOENT;
-		goto err_clk;
+		goto err_phy_clk;
 	}
 
 	hsotg->regs = ioremap(res->start, resource_size(res));
@@ -3332,10 +3269,8 @@ static int __devinit s3c_hsotg_probe(struct platform_device *pdev)
 	/* reset the system */
 
 	clk_enable(hsotg->clk);
+	clk_enable(hsotg->phy_clk);
 
-	s3c_hsotg_gate(pdev, true);
-
-	s3c_hsotg_otgreset(hsotg);
 	s3c_hsotg_corereset(hsotg);
 	s3c_hsotg_init(hsotg);
 
@@ -3356,6 +3291,8 @@ err_regs:
 err_regs_res:
 	release_resource(hsotg->regs_res);
 	kfree(hsotg->regs_res);
+err_phy_clk:
+	clk_put(hsotg->phy_clk);
 err_clk:
 	clk_put(hsotg->clk);
 err_mem:
@@ -3377,7 +3314,8 @@ static int __devexit s3c_hsotg_remove(struct platform_device *pdev)
 	release_resource(hsotg->regs_res);
 	kfree(hsotg->regs_res);
 
-	s3c_hsotg_gate(pdev, false);
+	clk_disable(hsotg->phy_clk);
+	clk_put(hsotg->phy_clk);
 
 	clk_disable(hsotg->clk);
 	clk_put(hsotg->clk);
