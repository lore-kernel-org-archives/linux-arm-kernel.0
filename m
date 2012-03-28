From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 28 Mar 2012 16:33:54 +0200
Subject: [PATCH v5 12/16] ARM i.MX: Move i.MX pwm driver to pwm framework
In-Reply-To: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1332945238-14897-13-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Move the driver to drivers/pwm/ and convert it to use the framework.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v5:
- adopt patch by Sascha Hauer to move i.MX driver to PWM framework
- rename to imx_pwm internally

 arch/arm/plat-mxc/Kconfig                        |    6 -
 arch/arm/plat-mxc/Makefile                       |    1 -
 drivers/pwm/Kconfig                              |    9 ++
 drivers/pwm/Makefile                             |    1 +
 arch/arm/plat-mxc/pwm.c => drivers/pwm/pwm-imx.c |  182 +++++++++-------------
 5 files changed, 81 insertions(+), 118 deletions(-)
 rename arch/arm/plat-mxc/pwm.c => drivers/pwm/pwm-imx.c (58%)

diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index c722f9c..baf9064 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -47,12 +47,6 @@ config MXC_TZIC
 config MXC_AVIC
 	bool
 
-config MXC_PWM
-	tristate "Enable PWM driver"
-	select HAVE_PWM
-	help
-	  Enable support for the i.MX PWM controller(s).
-
 config MXC_DEBUG_BOARD
 	bool "Enable MXC debug board(for 3-stack)"
 	help
diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index e81290c..46ba8de 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_MXC_AVIC) += avic.o
 obj-$(CONFIG_IMX_HAVE_IOMUX_V1) += iomux-v1.o
 obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
 obj-$(CONFIG_IRAM_ALLOC) += iram_alloc.o
-obj-$(CONFIG_MXC_PWM)  += pwm.o
 obj-$(CONFIG_MXC_ULPI) += ulpi.o
 obj-$(CONFIG_MXC_USE_EPIT) += epit.o
 obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0ef4f30..a9a9715 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -18,6 +18,15 @@ config PWM_BFIN
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-bfin.
 
+config PWM_IMX
+	tristate "i.MX pwm support"
+	depends on ARCH_MXC
+	help
+	  Generic PWM framework driver for i.MX.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-imx.
+
 config PWM_PXA
 	tristate "PXA PWM support"
 	depends on ARCH_PXA
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index e859c51..3dd1b83 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_PWM)		+= core.o
 obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
+obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
diff --git a/arch/arm/plat-mxc/pwm.c b/drivers/pwm/pwm-imx.c
similarity index 58%
rename from arch/arm/plat-mxc/pwm.c
rename to drivers/pwm/pwm-imx.c
index c0cab22..ef9c51b 100644
--- a/arch/arm/plat-mxc/pwm.c
+++ b/drivers/pwm/pwm-imx.c
@@ -39,33 +39,28 @@
 #define MX3_PWMCR_CLKSRC_IPG      (1 << 16)
 #define MX3_PWMCR_EN              (1 << 0)
 
-
-
-struct pwm_device {
-	struct list_head	node;
-	struct platform_device *pdev;
-
-	const char	*label;
+struct imx_chip {
 	struct clk	*clk;
 
 	int		clk_enabled;
 	void __iomem	*mmio_base;
 
-	unsigned int	use_count;
-	unsigned int	pwm_id;
+	struct pwm_chip	chip;
 };
 
-int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+#define to_imx_chip(chip)	container_of(chip, struct imx_chip, chip)
+
+static int imx_pwm_config(struct pwm_chip *chip,
+		struct pwm_device *pwm, int duty_ns, int period_ns)
 {
-	if (pwm == NULL || period_ns == 0 || duty_ns > period_ns)
-		return -EINVAL;
+	struct imx_chip *imx = to_imx_chip(chip);
 
 	if (!(cpu_is_mx1() || cpu_is_mx21())) {
 		unsigned long long c;
 		unsigned long period_cycles, duty_cycles, prescale;
 		u32 cr;
 
-		c = clk_get_rate(pwm->clk);
+		c = clk_get_rate(imx->clk);
 		c = c * period_ns;
 		do_div(c, 1000000000);
 		period_cycles = c;
@@ -86,8 +81,8 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 		else
 			period_cycles = 0;
 
-		writel(duty_cycles, pwm->mmio_base + MX3_PWMSAR);
-		writel(period_cycles, pwm->mmio_base + MX3_PWMPR);
+		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+		writel(period_cycles, imx->mmio_base + MX3_PWMPR);
 
 		cr = MX3_PWMCR_PRESCALER(prescale) |
 			MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
@@ -98,7 +93,7 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 		else
 			cr |= MX3_PWMCR_CLKSRC_IPG_HIGH;
 
-		writel(cr, pwm->mmio_base + MX3_PWMCR);
+		writel(cr, imx->mmio_base + MX3_PWMCR);
 	} else if (cpu_is_mx1() || cpu_is_mx21()) {
 		/* The PWM subsystem allows for exact frequencies. However,
 		 * I cannot connect a scope on my device to the PWM line and
@@ -116,110 +111,72 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 		 * both the prescaler (/1 .. /128) and then by CLKSEL
 		 * (/2 .. /16).
 		 */
-		u32 max = readl(pwm->mmio_base + MX1_PWMP);
+		u32 max = readl(imx->mmio_base + MX1_PWMP);
 		u32 p = max * duty_ns / period_ns;
-		writel(max - p, pwm->mmio_base + MX1_PWMS);
+		writel(max - p, imx->mmio_base + MX1_PWMS);
 	} else {
 		BUG();
 	}
 
 	return 0;
 }
-EXPORT_SYMBOL(pwm_config);
 
-int pwm_enable(struct pwm_device *pwm)
+static int imx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct imx_chip *imx = to_imx_chip(chip);
 	int rc = 0;
 
-	if (!pwm->clk_enabled) {
-		rc = clk_prepare_enable(pwm->clk);
+	if (!imx->clk_enabled) {
+		rc = clk_prepare_enable(imx->clk);
 		if (!rc)
-			pwm->clk_enabled = 1;
+			imx->clk_enabled = 1;
 	}
 	return rc;
 }
-EXPORT_SYMBOL(pwm_enable);
-
-void pwm_disable(struct pwm_device *pwm)
-{
-	writel(0, pwm->mmio_base + MX3_PWMCR);
-
-	if (pwm->clk_enabled) {
-		clk_disable_unprepare(pwm->clk);
-		pwm->clk_enabled = 0;
-	}
-}
-EXPORT_SYMBOL(pwm_disable);
-
-static DEFINE_MUTEX(pwm_lock);
-static LIST_HEAD(pwm_list);
 
-struct pwm_device *pwm_request(int pwm_id, const char *label)
+static void imx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct pwm_device *pwm;
-	int found = 0;
+	struct imx_chip *imx = to_imx_chip(chip);
 
-	mutex_lock(&pwm_lock);
+	writel(0, imx->mmio_base + MX3_PWMCR);
 
-	list_for_each_entry(pwm, &pwm_list, node) {
-		if (pwm->pwm_id == pwm_id) {
-			found = 1;
-			break;
-		}
+	if (imx->clk_enabled) {
+		clk_disable_unprepare(imx->clk);
+		imx->clk_enabled = 0;
 	}
-
-	if (found) {
-		if (pwm->use_count == 0) {
-			pwm->use_count++;
-			pwm->label = label;
-		} else
-			pwm = ERR_PTR(-EBUSY);
-	} else
-		pwm = ERR_PTR(-ENOENT);
-
-	mutex_unlock(&pwm_lock);
-	return pwm;
 }
-EXPORT_SYMBOL(pwm_request);
-
-void pwm_free(struct pwm_device *pwm)
-{
-	mutex_lock(&pwm_lock);
-
-	if (pwm->use_count) {
-		pwm->use_count--;
-		pwm->label = NULL;
-	} else
-		pr_warning("PWM device already freed\n");
 
-	mutex_unlock(&pwm_lock);
-}
-EXPORT_SYMBOL(pwm_free);
+static struct pwm_ops imx_pwm_ops = {
+	.enable = imx_pwm_enable,
+	.disable = imx_pwm_disable,
+	.config = imx_pwm_config,
+	.owner = THIS_MODULE,
+};
 
-static int __devinit mxc_pwm_probe(struct platform_device *pdev)
+static int __devinit imx_pwm_probe(struct platform_device *pdev)
 {
-	struct pwm_device *pwm;
+	struct imx_chip *imx;
 	struct resource *r;
 	int ret = 0;
 
-	pwm = kzalloc(sizeof(struct pwm_device), GFP_KERNEL);
-	if (pwm == NULL) {
+	imx = kzalloc(sizeof(*imx), GFP_KERNEL);
+	if (imx == NULL) {
 		dev_err(&pdev->dev, "failed to allocate memory\n");
 		return -ENOMEM;
 	}
 
-	pwm->clk = clk_get(&pdev->dev, "pwm");
+	imx->clk = clk_get(&pdev->dev, "pwm");
 
-	if (IS_ERR(pwm->clk)) {
-		ret = PTR_ERR(pwm->clk);
+	if (IS_ERR(imx->clk)) {
+		ret = PTR_ERR(imx->clk);
 		goto err_free;
 	}
 
-	pwm->clk_enabled = 0;
+	imx->chip.ops = &imx_pwm_ops;
+	imx->chip.base = -1;
+	imx->chip.npwm = 1;
 
-	pwm->use_count = 0;
-	pwm->pwm_id = pdev->id;
-	pwm->pdev = pdev;
+	imx->clk_enabled = 0;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
@@ -235,72 +192,75 @@ static int __devinit mxc_pwm_probe(struct platform_device *pdev)
 		goto err_free_clk;
 	}
 
-	pwm->mmio_base = ioremap(r->start, resource_size(r));
-	if (pwm->mmio_base == NULL) {
+	imx->mmio_base = ioremap(r->start, resource_size(r));
+	if (imx->mmio_base == NULL) {
 		dev_err(&pdev->dev, "failed to ioremap() registers\n");
 		ret = -ENODEV;
 		goto err_free_mem;
 	}
 
-	mutex_lock(&pwm_lock);
-	list_add_tail(&pwm->node, &pwm_list);
-	mutex_unlock(&pwm_lock);
+	ret = pwmchip_add(&imx->chip);
+	if (ret)
+		goto err_iounmap;
 
-	platform_set_drvdata(pdev, pwm);
+	platform_set_drvdata(pdev, imx);
 	return 0;
 
+err_iounmap:
+	iounmap(imx->mmio_base);
 err_free_mem:
 	release_mem_region(r->start, resource_size(r));
 err_free_clk:
-	clk_put(pwm->clk);
+	clk_put(imx->clk);
 err_free:
-	kfree(pwm);
+	kfree(imx);
 	return ret;
 }
 
-static int __devexit mxc_pwm_remove(struct platform_device *pdev)
+static int __devexit imx_pwm_remove(struct platform_device *pdev)
 {
-	struct pwm_device *pwm;
+	struct imx_chip *imx;
 	struct resource *r;
+	int ret;
 
-	pwm = platform_get_drvdata(pdev);
-	if (pwm == NULL)
+	imx = platform_get_drvdata(pdev);
+	if (imx == NULL)
 		return -ENODEV;
 
-	mutex_lock(&pwm_lock);
-	list_del(&pwm->node);
-	mutex_unlock(&pwm_lock);
+	ret = pwmchip_remove(&imx->chip);
+	if (ret)
+		return ret;
 
-	iounmap(pwm->mmio_base);
+	iounmap(imx->mmio_base);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(r->start, resource_size(r));
 
-	clk_put(pwm->clk);
+	clk_put(imx->clk);
 
-	kfree(pwm);
+	kfree(imx);
 	return 0;
 }
 
-static struct platform_driver mxc_pwm_driver = {
+static struct platform_driver imx_pwm_driver = {
 	.driver		= {
 		.name	= "mxc_pwm",
 	},
-	.probe		= mxc_pwm_probe,
-	.remove		= __devexit_p(mxc_pwm_remove),
+	.probe		= imx_pwm_probe,
+	.remove		= __devexit_p(imx_pwm_remove),
 };
 
-static int __init mxc_pwm_init(void)
+static int __init imx_pwm_init(void)
 {
-	return platform_driver_register(&mxc_pwm_driver);
+	return platform_driver_register(&imx_pwm_driver);
 }
-arch_initcall(mxc_pwm_init);
+arch_initcall(imx_pwm_init);
 
-static void __exit mxc_pwm_exit(void)
+static void __exit imx_pwm_exit(void)
 {
-	platform_driver_unregister(&mxc_pwm_driver);
+	platform_driver_unregister(&imx_pwm_driver);
 }
-module_exit(mxc_pwm_exit);
+module_exit(imx_pwm_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
-- 
1.7.9.4
