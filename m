From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 28 Mar 2012 16:33:56 +0200
Subject: [PATCH v5 14/16] ARM vt8500: Move vt8500 pwm driver to pwm framework
In-Reply-To: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1332945238-14897-15-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Move the driver to drivers/pwm/ and convert it to use the framework.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Alexey Charkov <alchark@gmail.com>
Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v5:
- adopt patch by Sascha Hauer to move vt8500 driver to PWM framework

 arch/arm/mach-vt8500/Makefile                      |    2 -
 drivers/pwm/Kconfig                                |    9 ++
 drivers/pwm/Makefile                               |    1 +
 .../mach-vt8500/pwm.c => drivers/pwm/pwm-vt8500.c  |  169 +++++++-------------
 4 files changed, 66 insertions(+), 115 deletions(-)
 rename arch/arm/mach-vt8500/pwm.c => drivers/pwm/pwm-vt8500.c (52%)

diff --git a/arch/arm/mach-vt8500/Makefile b/arch/arm/mach-vt8500/Makefile
index 81aedb7..8df9e4a 100644
--- a/arch/arm/mach-vt8500/Makefile
+++ b/arch/arm/mach-vt8500/Makefile
@@ -5,5 +5,3 @@ obj-$(CONFIG_VTWM_VERSION_WM8505) += devices-wm8505.o
 
 obj-$(CONFIG_MACH_BV07) += bv07.o
 obj-$(CONFIG_MACH_WM8505_7IN_NETBOOK) += wm8505_7in.o
-
-obj-$(CONFIG_HAVE_PWM) += pwm.o
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0d9aa92..a93feff 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -55,4 +55,13 @@ config PWM_TEGRA
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-tegra.
 
+config PWM_VT8500
+	tristate "vt8500 pwm support"
+	depends on ARCH_VT8500
+	help
+	  Generic PWM framework driver for vt8500.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-vt8500.
+
 endif
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index a1d87b1..b7c0fcf 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
+obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
diff --git a/arch/arm/mach-vt8500/pwm.c b/drivers/pwm/pwm-vt8500.c
similarity index 52%
rename from arch/arm/mach-vt8500/pwm.c
rename to drivers/pwm/pwm-vt8500.c
index 8ad825e..3db0746 100644
--- a/arch/arm/mach-vt8500/pwm.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -26,21 +26,13 @@
 
 #define VT8500_NR_PWMS 4
 
-static DEFINE_MUTEX(pwm_lock);
-static LIST_HEAD(pwm_list);
-
-struct pwm_device {
-	struct list_head	node;
-	struct platform_device	*pdev;
-
-	const char	*label;
-
-	void __iomem	*regbase;
-
-	unsigned int	use_count;
-	unsigned int	pwm_id;
+struct vt8500_chip {
+	struct pwm_chip chip;
+	void __iomem *base;
 };
 
+#define to_vt8500_chip(chip)	container_of(chip, struct vt8500_chip, chip)
+
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
 static inline void pwm_busy_wait(void __iomem *reg, u8 bitmask)
 {
@@ -53,14 +45,13 @@ static inline void pwm_busy_wait(void __iomem *reg, u8 bitmask)
 			   bitmask);
 }
 
-int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+static int vt8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+		int duty_ns, int period_ns)
 {
+	struct vt8500_chip *vt8500 = to_vt8500_chip(chip);
 	unsigned long long c;
 	unsigned long period_cycles, prescale, pv, dc;
 
-	if (pwm == NULL || period_ns == 0 || duty_ns > period_ns)
-		return -EINVAL;
-
 	c = 25000000/2; /* wild guess --- need to implement clocks */
 	c = c * period_ns;
 	do_div(c, 1000000000);
@@ -80,104 +71,58 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	do_div(c, period_ns);
 	dc = c;
 
-	pwm_busy_wait(pwm->regbase + 0x40 + pwm->pwm_id, (1 << 1));
-	writel(prescale, pwm->regbase + 0x4 + (pwm->pwm_id << 4));
+	pwm_busy_wait(vt8500->base + 0x40 + pwm->hwpwm, (1 << 1));
+	writel(prescale, vt8500->base + 0x4 + (pwm->hwpwm << 4));
 
-	pwm_busy_wait(pwm->regbase + 0x40 + pwm->pwm_id, (1 << 2));
-	writel(pv, pwm->regbase + 0x8 + (pwm->pwm_id << 4));
+	pwm_busy_wait(vt8500->base + 0x40 + pwm->hwpwm, (1 << 2));
+	writel(pv, vt8500->base + 0x8 + (pwm->hwpwm << 4));
 
-	pwm_busy_wait(pwm->regbase + 0x40 + pwm->pwm_id, (1 << 3));
-	writel(dc, pwm->regbase + 0xc + (pwm->pwm_id << 4));
+	pwm_busy_wait(vt8500->base + 0x40 + pwm->hwpwm, (1 << 3));
+	writel(dc, vt8500->base + 0xc + (pwm->hwpwm << 4));
 
 	return 0;
 }
-EXPORT_SYMBOL(pwm_config);
 
-int pwm_enable(struct pwm_device *pwm)
+static int vt8500_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	pwm_busy_wait(pwm->regbase + 0x40 + pwm->pwm_id, (1 << 0));
-	writel(5, pwm->regbase + (pwm->pwm_id << 4));
-	return 0;
-}
-EXPORT_SYMBOL(pwm_enable);
-
-void pwm_disable(struct pwm_device *pwm)
-{
-	pwm_busy_wait(pwm->regbase + 0x40 + pwm->pwm_id, (1 << 0));
-	writel(0, pwm->regbase + (pwm->pwm_id << 4));
-}
-EXPORT_SYMBOL(pwm_disable);
-
-struct pwm_device *pwm_request(int pwm_id, const char *label)
-{
-	struct pwm_device *pwm;
-	int found = 0;
-
-	mutex_lock(&pwm_lock);
+	struct vt8500_chip *vt8500 = to_vt8500_chip(chip);
 
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
-		} else {
-			pwm = ERR_PTR(-EBUSY);
-		}
-	} else {
-		pwm = ERR_PTR(-ENOENT);
-	}
-
-	mutex_unlock(&pwm_lock);
-	return pwm;
+	pwm_busy_wait(vt8500->base + 0x40 + pwm->hwpwm, (1 << 0));
+	writel(5, vt8500->base + (pwm->hwpwm << 4));
+	return 0;
 }
-EXPORT_SYMBOL(pwm_request);
 
-void pwm_free(struct pwm_device *pwm)
+static void vt8500_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	mutex_lock(&pwm_lock);
-
-	if (pwm->use_count) {
-		pwm->use_count--;
-		pwm->label = NULL;
-	} else {
-		pr_warning("PWM device already freed\n");
-	}
+	struct vt8500_chip *vt8500 = to_vt8500_chip(chip);
 
-	mutex_unlock(&pwm_lock);
+	pwm_busy_wait(vt8500->base + 0x40 + pwm->hwpwm, (1 << 0));
+	writel(0, vt8500->base + (pwm->hwpwm << 4));
 }
-EXPORT_SYMBOL(pwm_free);
 
-static inline void __add_pwm(struct pwm_device *pwm)
-{
-	mutex_lock(&pwm_lock);
-	list_add_tail(&pwm->node, &pwm_list);
-	mutex_unlock(&pwm_lock);
-}
+static struct pwm_ops vt8500_pwm_ops = {
+	.enable = vt8500_pwm_enable,
+	.disable = vt8500_pwm_disable,
+	.config = vt8500_pwm_config,
+	.owner = THIS_MODULE,
+};
 
 static int __devinit pwm_probe(struct platform_device *pdev)
 {
-	struct pwm_device *pwms;
+	struct vt8500_chip *chip;
 	struct resource *r;
-	int ret = 0;
-	int i;
+	int ret;
 
-	pwms = kzalloc(sizeof(struct pwm_device) * VT8500_NR_PWMS, GFP_KERNEL);
-	if (pwms == NULL) {
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+	if (chip == NULL) {
 		dev_err(&pdev->dev, "failed to allocate memory\n");
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < VT8500_NR_PWMS; i++) {
-		pwms[i].use_count = 0;
-		pwms[i].pwm_id = i;
-		pwms[i].pdev = pdev;
-	}
+	chip->chip.dev = &pdev->dev;
+	chip->chip.ops = &vt8500_pwm_ops;
+	chip->chip.base = -1;
+	chip->chip.npwm = VT8500_NR_PWMS;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
@@ -193,51 +138,49 @@ static int __devinit pwm_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
-	pwms[0].regbase = ioremap(r->start, resource_size(r));
-	if (pwms[0].regbase == NULL) {
+	chip->base = ioremap(r->start, resource_size(r));
+	if (chip->base == NULL) {
 		dev_err(&pdev->dev, "failed to ioremap() registers\n");
 		ret = -ENODEV;
 		goto err_free_mem;
 	}
 
-	for (i = 1; i < VT8500_NR_PWMS; i++)
-		pwms[i].regbase = pwms[0].regbase;
-
-	for (i = 0; i < VT8500_NR_PWMS; i++)
-		__add_pwm(&pwms[i]);
+	ret = pwmchip_add(&chip->chip);
+	if (ret < 0)
+		goto err_unmap;
 
-	platform_set_drvdata(pdev, pwms);
-	return 0;
+	platform_set_drvdata(pdev, chip);
+	return ret;
 
+err_unmap:
+	iounmap(chip->base);
 err_free_mem:
 	release_mem_region(r->start, resource_size(r));
 err_free:
-	kfree(pwms);
+	kfree(chip);
 	return ret;
 }
 
 static int __devexit pwm_remove(struct platform_device *pdev)
 {
-	struct pwm_device *pwms;
+	struct vt8500_chip *chip;
 	struct resource *r;
-	int i;
+	int err;
 
-	pwms = platform_get_drvdata(pdev);
-	if (pwms == NULL)
+	chip = platform_get_drvdata(pdev);
+	if (chip == NULL)
 		return -ENODEV;
 
-	mutex_lock(&pwm_lock);
-
-	for (i = 0; i < VT8500_NR_PWMS; i++)
-		list_del(&pwms[i].node);
-	mutex_unlock(&pwm_lock);
+	err = pwmchip_remove(&chip->chip);
+	if (err < 0)
+		return err;
 
-	iounmap(pwms[0].regbase);
+	iounmap(chip->base);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(r->start, resource_size(r));
 
-	kfree(pwms);
+	kfree(chip);
 	return 0;
 }
 
-- 
1.7.9.4
