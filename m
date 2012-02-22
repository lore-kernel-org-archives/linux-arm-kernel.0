From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 22 Feb 2012 16:17:20 +0100
Subject: [PATCH v3 09/10] pwm: Add PXA support
In-Reply-To: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1329923841-32017-10-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v3:
  - update PWM ops for changes in patch 2

 arch/arm/plat-pxa/Makefile |    1 -
 arch/arm/plat-pxa/pwm.c    |  304 --------------------------------------------
 drivers/pwm/Kconfig        |    9 ++
 drivers/pwm/Makefile       |    1 +
 drivers/pwm/pwm-pxa.c      |  244 +++++++++++++++++++++++++++++++++++
 5 files changed, 254 insertions(+), 305 deletions(-)
 delete mode 100644 arch/arm/plat-pxa/pwm.c
 create mode 100644 drivers/pwm/pwm-pxa.c

diff --git a/arch/arm/plat-pxa/Makefile b/arch/arm/plat-pxa/Makefile
index f302d04..af8e484 100644
--- a/arch/arm/plat-pxa/Makefile
+++ b/arch/arm/plat-pxa/Makefile
@@ -8,5 +8,4 @@ obj-$(CONFIG_PXA3xx)		+= mfp.o
 obj-$(CONFIG_PXA95x)		+= mfp.o
 obj-$(CONFIG_ARCH_MMP)		+= mfp.o
 
-obj-$(CONFIG_HAVE_PWM)		+= pwm.o
 obj-$(CONFIG_PXA_SSP)		+= ssp.o
diff --git a/arch/arm/plat-pxa/pwm.c b/arch/arm/plat-pxa/pwm.c
deleted file mode 100644
index ef32686..0000000
--- a/arch/arm/plat-pxa/pwm.c
+++ /dev/null
@@ -1,304 +0,0 @@
-/*
- * linux/arch/arm/mach-pxa/pwm.c
- *
- * simple driver for PWM (Pulse Width Modulator) controller
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * 2008-02-13	initial version
- * 		eric miao <eric.miao@marvell.com>
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/pwm.h>
-
-#include <asm/div64.h>
-
-#define HAS_SECONDARY_PWM	0x10
-#define PWM_ID_BASE(d)		((d) & 0xf)
-
-static const struct platform_device_id pwm_id_table[] = {
-	/*   PWM    has_secondary_pwm? */
-	{ "pxa25x-pwm", 0 },
-	{ "pxa27x-pwm", 0 | HAS_SECONDARY_PWM },
-	{ "pxa168-pwm", 1 },
-	{ "pxa910-pwm", 1 },
-	{ },
-};
-MODULE_DEVICE_TABLE(platform, pwm_id_table);
-
-/* PWM registers and bits definitions */
-#define PWMCR		(0x00)
-#define PWMDCR		(0x04)
-#define PWMPCR		(0x08)
-
-#define PWMCR_SD	(1 << 6)
-#define PWMDCR_FD	(1 << 10)
-
-struct pwm_device {
-	struct list_head	node;
-	struct pwm_device	*secondary;
-	struct platform_device	*pdev;
-
-	const char	*label;
-	struct clk	*clk;
-	int		clk_enabled;
-	void __iomem	*mmio_base;
-
-	unsigned int	use_count;
-	unsigned int	pwm_id;
-};
-
-/*
- * period_ns = 10^9 * (PRESCALE + 1) * (PV + 1) / PWM_CLK_RATE
- * duty_ns   = 10^9 * (PRESCALE + 1) * DC / PWM_CLK_RATE
- */
-int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
-{
-	unsigned long long c;
-	unsigned long period_cycles, prescale, pv, dc;
-
-	if (pwm == NULL || period_ns == 0 || duty_ns > period_ns)
-		return -EINVAL;
-
-	c = clk_get_rate(pwm->clk);
-	c = c * period_ns;
-	do_div(c, 1000000000);
-	period_cycles = c;
-
-	if (period_cycles < 1)
-		period_cycles = 1;
-	prescale = (period_cycles - 1) / 1024;
-	pv = period_cycles / (prescale + 1) - 1;
-
-	if (prescale > 63)
-		return -EINVAL;
-
-	if (duty_ns == period_ns)
-		dc = PWMDCR_FD;
-	else
-		dc = (pv + 1) * duty_ns / period_ns;
-
-	/* NOTE: the clock to PWM has to be enabled first
-	 * before writing to the registers
-	 */
-	clk_enable(pwm->clk);
-	__raw_writel(prescale, pwm->mmio_base + PWMCR);
-	__raw_writel(dc, pwm->mmio_base + PWMDCR);
-	__raw_writel(pv, pwm->mmio_base + PWMPCR);
-	clk_disable(pwm->clk);
-
-	return 0;
-}
-EXPORT_SYMBOL(pwm_config);
-
-int pwm_enable(struct pwm_device *pwm)
-{
-	int rc = 0;
-
-	if (!pwm->clk_enabled) {
-		rc = clk_enable(pwm->clk);
-		if (!rc)
-			pwm->clk_enabled = 1;
-	}
-	return rc;
-}
-EXPORT_SYMBOL(pwm_enable);
-
-void pwm_disable(struct pwm_device *pwm)
-{
-	if (pwm->clk_enabled) {
-		clk_disable(pwm->clk);
-		pwm->clk_enabled = 0;
-	}
-}
-EXPORT_SYMBOL(pwm_disable);
-
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
-	}
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
-}
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
-
-static int __devinit pwm_probe(struct platform_device *pdev)
-{
-	const struct platform_device_id *id = platform_get_device_id(pdev);
-	struct pwm_device *pwm, *secondary = NULL;
-	struct resource *r;
-	int ret = 0;
-
-	pwm = kzalloc(sizeof(struct pwm_device), GFP_KERNEL);
-	if (pwm == NULL) {
-		dev_err(&pdev->dev, "failed to allocate memory\n");
-		return -ENOMEM;
-	}
-
-	pwm->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(pwm->clk)) {
-		ret = PTR_ERR(pwm->clk);
-		goto err_free;
-	}
-	pwm->clk_enabled = 0;
-
-	pwm->use_count = 0;
-	pwm->pwm_id = PWM_ID_BASE(id->driver_data) + pdev->id;
-	pwm->pdev = pdev;
-
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (r == NULL) {
-		dev_err(&pdev->dev, "no memory resource defined\n");
-		ret = -ENODEV;
-		goto err_free_clk;
-	}
-
-	r = request_mem_region(r->start, resource_size(r), pdev->name);
-	if (r == NULL) {
-		dev_err(&pdev->dev, "failed to request memory resource\n");
-		ret = -EBUSY;
-		goto err_free_clk;
-	}
-
-	pwm->mmio_base = ioremap(r->start, resource_size(r));
-	if (pwm->mmio_base == NULL) {
-		dev_err(&pdev->dev, "failed to ioremap() registers\n");
-		ret = -ENODEV;
-		goto err_free_mem;
-	}
-
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
-	}
-
-	__add_pwm(pwm);
-	if (secondary)
-		__add_pwm(secondary);
-
-	platform_set_drvdata(pdev, pwm);
-	return 0;
-
-err_free_mem:
-	release_mem_region(r->start, resource_size(r));
-err_free_clk:
-	clk_put(pwm->clk);
-err_free:
-	kfree(pwm);
-	return ret;
-}
-
-static int __devexit pwm_remove(struct platform_device *pdev)
-{
-	struct pwm_device *pwm;
-	struct resource *r;
-
-	pwm = platform_get_drvdata(pdev);
-	if (pwm == NULL)
-		return -ENODEV;
-
-	mutex_lock(&pwm_lock);
-
-	if (pwm->secondary) {
-		list_del(&pwm->secondary->node);
-		kfree(pwm->secondary);
-	}
-
-	list_del(&pwm->node);
-	mutex_unlock(&pwm_lock);
-
-	iounmap(pwm->mmio_base);
-
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(r->start, resource_size(r));
-
-	clk_put(pwm->clk);
-	kfree(pwm);
-	return 0;
-}
-
-static struct platform_driver pwm_driver = {
-	.driver		= {
-		.name	= "pxa25x-pwm",
-		.owner	= THIS_MODULE,
-	},
-	.probe		= pwm_probe,
-	.remove		= __devexit_p(pwm_remove),
-	.id_table	= pwm_id_table,
-};
-
-static int __init pwm_init(void)
-{
-	return platform_driver_register(&pwm_driver);
-}
-arch_initcall(pwm_init);
-
-static void __exit pwm_exit(void)
-{
-	platform_driver_unregister(&pwm_driver);
-}
-module_exit(pwm_exit);
-
-MODULE_LICENSE("GPL v2");
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
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
new file mode 100644
index 0000000..0f3ef5c
--- /dev/null
+++ b/drivers/pwm/pwm-pxa.c
@@ -0,0 +1,244 @@
+/*
+ * linux/arch/arm/mach-pxa/pwm.c
+ *
+ * simple driver for PWM (Pulse Width Modulator) controller
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * 2008-02-13	initial version
+ * 		eric miao <eric.miao@marvell.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/pwm.h>
+
+#include <asm/div64.h>
+
+#define HAS_SECONDARY_PWM	0x10
+#define PWM_ID_BASE(d)		((d) & 0xf)
+
+static const struct platform_device_id pwm_id_table[] = {
+	/*   PWM    has_secondary_pwm? */
+	{ "pxa25x-pwm", 0 },
+	{ "pxa27x-pwm", 0 | HAS_SECONDARY_PWM },
+	{ "pxa168-pwm", 1 },
+	{ "pxa910-pwm", 1 },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, pwm_id_table);
+
+/* PWM registers and bits definitions */
+#define PWMCR		(0x00)
+#define PWMDCR		(0x04)
+#define PWMPCR		(0x08)
+
+#define PWMCR_SD	(1 << 6)
+#define PWMDCR_FD	(1 << 10)
+
+struct pxa_pwm_chip {
+	struct pwm_chip	chip;
+	struct device	*dev;
+
+	struct clk	*clk;
+	int		clk_enabled;
+	void __iomem	*mmio_base;
+};
+
+static inline struct pxa_pwm_chip *to_pxa_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct pxa_pwm_chip, chip);
+}
+
+/*
+ * period_ns = 10^9 * (PRESCALE + 1) * (PV + 1) / PWM_CLK_RATE
+ * duty_ns   = 10^9 * (PRESCALE + 1) * DC / PWM_CLK_RATE
+ */
+static int pxa_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			  int duty_ns, int period_ns)
+{
+	struct pxa_pwm_chip *pc = to_pxa_pwm_chip(chip);
+	unsigned long long c;
+	unsigned long period_cycles, prescale, pv, dc;
+	unsigned long offset;
+
+	if (period_ns == 0 || duty_ns > period_ns)
+		return -EINVAL;
+
+	offset = pwm->hwpwm ? 0x10 : 0;
+
+	c = clk_get_rate(pc->clk);
+	c = c * period_ns;
+	do_div(c, 1000000000);
+	period_cycles = c;
+
+	if (period_cycles < 1)
+		period_cycles = 1;
+	prescale = (period_cycles - 1) / 1024;
+	pv = period_cycles / (prescale + 1) - 1;
+
+	if (prescale > 63)
+		return -EINVAL;
+
+	if (duty_ns == period_ns)
+		dc = PWMDCR_FD;
+	else
+		dc = (pv + 1) * duty_ns / period_ns;
+
+	/* NOTE: the clock to PWM has to be enabled first
+	 * before writing to the registers
+	 */
+	clk_enable(pc->clk);
+	__raw_writel(prescale, pc->mmio_base + offset + PWMCR);
+	__raw_writel(dc, pc->mmio_base + offset + PWMDCR);
+	__raw_writel(pv, pc->mmio_base + offset + PWMPCR);
+	clk_disable(pc->clk);
+
+	return 0;
+}
+
+static int pxa_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pxa_pwm_chip *pc = to_pxa_pwm_chip(chip);
+	int rc = 0;
+
+	if (!pc->clk_enabled) {
+		rc = clk_enable(pc->clk);
+		if (!rc)
+			pc->clk_enabled++;
+	}
+	return rc;
+}
+
+static void pxa_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pxa_pwm_chip *pc = to_pxa_pwm_chip(chip);
+
+	if (pc->clk_enabled) {
+		clk_disable(pc->clk);
+		pc->clk_enabled--;
+	}
+}
+
+static struct pwm_ops pxa_pwm_ops = {
+	.config = pxa_pwm_config,
+	.enable = pxa_pwm_enable,
+	.disable = pxa_pwm_disable,
+	.owner = THIS_MODULE,
+};
+
+static int __devinit pwm_probe(struct platform_device *pdev)
+{
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+	struct pxa_pwm_chip *pwm;
+	struct resource *r;
+	int ret = 0;
+
+	pwm = kzalloc(sizeof(*pwm), GFP_KERNEL);
+	if (pwm == NULL) {
+		dev_err(&pdev->dev, "failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	pwm->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(pwm->clk)) {
+		ret = PTR_ERR(pwm->clk);
+		goto err_free;
+	}
+	pwm->clk_enabled = 0;
+
+	pwm->chip.dev = &pdev->dev;
+	pwm->chip.ops = &pxa_pwm_ops;
+	pwm->chip.base = -1;
+	pwm->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (r == NULL) {
+		dev_err(&pdev->dev, "no memory resource defined\n");
+		ret = -ENODEV;
+		goto err_free_clk;
+	}
+
+	r = request_mem_region(r->start, resource_size(r), pdev->name);
+	if (r == NULL) {
+		dev_err(&pdev->dev, "failed to request memory resource\n");
+		ret = -EBUSY;
+		goto err_free_clk;
+	}
+
+	pwm->mmio_base = ioremap(r->start, resource_size(r));
+	if (pwm->mmio_base == NULL) {
+		dev_err(&pdev->dev, "failed to ioremap() registers\n");
+		ret = -ENODEV;
+		goto err_free_mem;
+	}
+
+	ret = pwmchip_add(&pwm->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, pwm);
+	return 0;
+
+err_free_mem:
+	release_mem_region(r->start, resource_size(r));
+err_free_clk:
+	clk_put(pwm->clk);
+err_free:
+	kfree(pwm);
+	return ret;
+}
+
+static int __devexit pwm_remove(struct platform_device *pdev)
+{
+	struct pxa_pwm_chip *chip;
+	struct resource *r;
+
+	chip = platform_get_drvdata(pdev);
+	if (chip == NULL)
+		return -ENODEV;
+
+	pwmchip_remove(&chip->chip);
+
+	iounmap(chip->mmio_base);
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(r->start, resource_size(r));
+
+	clk_put(chip->clk);
+	kfree(chip);
+	return 0;
+}
+
+static struct platform_driver pwm_driver = {
+	.driver		= {
+		.name	= "pxa25x-pwm",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= pwm_probe,
+	.remove		= __devexit_p(pwm_remove),
+	.id_table	= pwm_id_table,
+};
+
+static int __init pwm_init(void)
+{
+	return platform_driver_register(&pwm_driver);
+}
+arch_initcall(pwm_init);
+
+static void __exit pwm_exit(void)
+{
+	platform_driver_unregister(&pwm_driver);
+}
+module_exit(pwm_exit);
+
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.1
