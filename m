From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 28 Mar 2012 16:33:53 +0200
Subject: [PATCH v5 11/16] pwm: Move PXA PWM driver to PWM framework
In-Reply-To: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1332945238-14897-12-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit moves the PXA PWM driver to the drivers/pwm subdirectory and
converts it to use the new PWM framework.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v5:
- replace __raw_readl()/__raw_writel() by readl()/writel()
- use clk_prepare_enable() and clk_disable_unprepare()

Changes in v3:
- update PWM ops for changes in patch 2

 arch/arm/plat-pxa/Makefile                       |    1 -
 drivers/pwm/Kconfig                              |    9 ++
 drivers/pwm/Makefile                             |    1 +
 arch/arm/plat-pxa/pwm.c => drivers/pwm/pwm-pxa.c |  172 ++++++++--------------
 4 files changed, 68 insertions(+), 115 deletions(-)
 rename arch/arm/plat-pxa/pwm.c => drivers/pwm/pwm-pxa.c (57%)

diff --git a/arch/arm/plat-pxa/Makefile b/arch/arm/plat-pxa/Makefile
index f302d04..af8e484 100644
--- a/arch/arm/plat-pxa/Makefile
+++ b/arch/arm/plat-pxa/Makefile
@@ -8,5 +8,4 @@ obj-$(CONFIG_PXA3xx)		+= mfp.o
 obj-$(CONFIG_PXA95x)		+= mfp.o
 obj-$(CONFIG_ARCH_MMP)		+= mfp.o
 
-obj-$(CONFIG_HAVE_PWM)		+= pwm.o
 obj-$(CONFIG_PXA_SSP)		+= ssp.o
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index eb54042..0ef4f30 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -18,6 +18,15 @@ config PWM_BFIN
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-bfin.
 
+config PWM_PXA
+	tristate "PXA PWM support"
+	depends on ARCH_PXA
+	help
+	  Generic PWM framework driver for PXA.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-pxa.
+
 config PWM_TEGRA
 	tristate "NVIDIA Tegra PWM support"
 	depends on ARCH_TEGRA
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 251b8d2..e859c51 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_PWM)		+= core.o
 obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
+obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
diff --git a/arch/arm/plat-pxa/pwm.c b/drivers/pwm/pwm-pxa.c
similarity index 57%
rename from arch/arm/plat-pxa/pwm.c
rename to drivers/pwm/pwm-pxa.c
index ef32686..d5c6ce5 100644
--- a/arch/arm/plat-pxa/pwm.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -43,33 +43,39 @@ MODULE_DEVICE_TABLE(platform, pwm_id_table);
 #define PWMCR_SD	(1 << 6)
 #define PWMDCR_FD	(1 << 10)
 
-struct pwm_device {
-	struct list_head	node;
-	struct pwm_device	*secondary;
-	struct platform_device	*pdev;
+struct pxa_pwm_chip {
+	struct pwm_chip	chip;
+	struct device	*dev;
 
-	const char	*label;
 	struct clk	*clk;
 	int		clk_enabled;
 	void __iomem	*mmio_base;
-
-	unsigned int	use_count;
-	unsigned int	pwm_id;
 };
 
+static inline struct pxa_pwm_chip *to_pxa_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct pxa_pwm_chip, chip);
+}
+
 /*
  * period_ns = 10^9 * (PRESCALE + 1) * (PV + 1) / PWM_CLK_RATE
  * duty_ns   = 10^9 * (PRESCALE + 1) * DC / PWM_CLK_RATE
  */
-int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+static int pxa_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			  int duty_ns, int period_ns)
 {
+	struct pxa_pwm_chip *pc = to_pxa_pwm_chip(chip);
 	unsigned long long c;
 	unsigned long period_cycles, prescale, pv, dc;
+	unsigned long offset;
+	int rc;
 
-	if (pwm == NULL || period_ns == 0 || duty_ns > period_ns)
+	if (period_ns == 0 || duty_ns > period_ns)
 		return -EINVAL;
 
-	c = clk_get_rate(pwm->clk);
+	offset = pwm->hwpwm ? 0x10 : 0;
+
+	c = clk_get_rate(pc->clk);
 	c = c * period_ns;
 	do_div(c, 1000000000);
 	period_cycles = c;
@@ -90,98 +96,56 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	/* NOTE: the clock to PWM has to be enabled first
 	 * before writing to the registers
 	 */
-	clk_enable(pwm->clk);
-	__raw_writel(prescale, pwm->mmio_base + PWMCR);
-	__raw_writel(dc, pwm->mmio_base + PWMDCR);
-	__raw_writel(pv, pwm->mmio_base + PWMPCR);
-	clk_disable(pwm->clk);
+	rc = clk_prepare_enable(pc->clk);
+	if (rc < 0)
+		return rc;
+
+	writel(prescale, pc->mmio_base + offset + PWMCR);
+	writel(dc, pc->mmio_base + offset + PWMDCR);
+	writel(pv, pc->mmio_base + offset + PWMPCR);
 
+	clk_disable_unprepare(pc->clk);
 	return 0;
 }
-EXPORT_SYMBOL(pwm_config);
 
-int pwm_enable(struct pwm_device *pwm)
+static int pxa_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct pxa_pwm_chip *pc = to_pxa_pwm_chip(chip);
 	int rc = 0;
 
-	if (!pwm->clk_enabled) {
-		rc = clk_enable(pwm->clk);
+	if (!pc->clk_enabled) {
+		rc = clk_prepare_enable(pc->clk);
 		if (!rc)
-			pwm->clk_enabled = 1;
+			pc->clk_enabled++;
 	}
 	return rc;
 }
-EXPORT_SYMBOL(pwm_enable);
 
-void pwm_disable(struct pwm_device *pwm)
+static void pxa_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	if (pwm->clk_enabled) {
-		clk_disable(pwm->clk);
-		pwm->clk_enabled = 0;
-	}
-}
-EXPORT_SYMBOL(pwm_disable);
+	struct pxa_pwm_chip *pc = to_pxa_pwm_chip(chip);
 
-static DEFINE_MUTEX(pwm_lock);
-static LIST_HEAD(pwm_list);
-
-struct pwm_device *pwm_request(int pwm_id, const char *label)
-{
-	struct pwm_device *pwm;
-	int found = 0;
-
-	mutex_lock(&pwm_lock);
-
-	list_for_each_entry(pwm, &pwm_list, node) {
-		if (pwm->pwm_id == pwm_id) {
-			found = 1;
-			break;
-		}
+	if (pc->clk_enabled) {
+		clk_disable_unprepare(pc->clk);
+		pc->clk_enabled--;
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
 
-	if (pwm->use_count) {
-		pwm->use_count--;
-		pwm->label = NULL;
-	} else
-		pr_warning("PWM device already freed\n");
-
-	mutex_unlock(&pwm_lock);
-}
-EXPORT_SYMBOL(pwm_free);
-
-static inline void __add_pwm(struct pwm_device *pwm)
-{
-	mutex_lock(&pwm_lock);
-	list_add_tail(&pwm->node, &pwm_list);
-	mutex_unlock(&pwm_lock);
-}
+static struct pwm_ops pxa_pwm_ops = {
+	.config = pxa_pwm_config,
+	.enable = pxa_pwm_enable,
+	.disable = pxa_pwm_disable,
+	.owner = THIS_MODULE,
+};
 
 static int __devinit pwm_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
-	struct pwm_device *pwm, *secondary = NULL;
+	struct pxa_pwm_chip *pwm;
 	struct resource *r;
 	int ret = 0;
 
-	pwm = kzalloc(sizeof(struct pwm_device), GFP_KERNEL);
+	pwm = kzalloc(sizeof(*pwm), GFP_KERNEL);
 	if (pwm == NULL) {
 		dev_err(&pdev->dev, "failed to allocate memory\n");
 		return -ENOMEM;
@@ -194,9 +158,10 @@ static int __devinit pwm_probe(struct platform_device *pdev)
 	}
 	pwm->clk_enabled = 0;
 
-	pwm->use_count = 0;
-	pwm->pwm_id = PWM_ID_BASE(id->driver_data) + pdev->id;
-	pwm->pdev = pdev;
+	pwm->chip.dev = &pdev->dev;
+	pwm->chip.ops = &pxa_pwm_ops;
+	pwm->chip.base = -1;
+	pwm->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
@@ -219,25 +184,12 @@ static int __devinit pwm_probe(struct platform_device *pdev)
 		goto err_free_mem;
 	}
 
-	if (id->driver_data & HAS_SECONDARY_PWM) {
-		secondary = kzalloc(sizeof(struct pwm_device), GFP_KERNEL);
-		if (secondary == NULL) {
-			ret = -ENOMEM;
-			goto err_free_mem;
-		}
-
-		*secondary = *pwm;
-		pwm->secondary = secondary;
-
-		/* registers for the second PWM has offset of 0x10 */
-		secondary->mmio_base = pwm->mmio_base + 0x10;
-		secondary->pwm_id = pdev->id + 2;
+	ret = pwmchip_add(&pwm->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
+		return ret;
 	}
 
-	__add_pwm(pwm);
-	if (secondary)
-		__add_pwm(secondary);
-
 	platform_set_drvdata(pdev, pwm);
 	return 0;
 
@@ -252,30 +204,22 @@ err_free:
 
 static int __devexit pwm_remove(struct platform_device *pdev)
 {
-	struct pwm_device *pwm;
+	struct pxa_pwm_chip *chip;
 	struct resource *r;
 
-	pwm = platform_get_drvdata(pdev);
-	if (pwm == NULL)
+	chip = platform_get_drvdata(pdev);
+	if (chip == NULL)
 		return -ENODEV;
 
-	mutex_lock(&pwm_lock);
-
-	if (pwm->secondary) {
-		list_del(&pwm->secondary->node);
-		kfree(pwm->secondary);
-	}
+	pwmchip_remove(&chip->chip);
 
-	list_del(&pwm->node);
-	mutex_unlock(&pwm_lock);
-
-	iounmap(pwm->mmio_base);
+	iounmap(chip->mmio_base);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(r->start, resource_size(r));
 
-	clk_put(pwm->clk);
-	kfree(pwm);
+	clk_put(chip->clk);
+	kfree(chip);
 	return 0;
 }
 
-- 
1.7.9.4
