From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 15 Mar 2012 10:04:37 +0100
Subject: [PATCH 3/3] ARM vt8500: Move vt8500 pwm driver to pwm framework
In-Reply-To: <1331802277-12477-1-git-send-email-s.hauer@pengutronix.de>
References: <1331802277-12477-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1331802277-12477-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the driver to drivers/pwm/ and convert it to use the framework.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Alexey Charkov <alchark@gmail.com>
---
 arch/arm/mach-vt8500/Makefile                      |    2 -
 drivers/pwm/Kconfig                                |    9 ++
 drivers/pwm/Makefile                               |    3 +
 .../mach-vt8500/pwm.c => drivers/pwm/pwm-vt8500.c  |  124 +++++++-------------
 4 files changed, 56 insertions(+), 82 deletions(-)
 rename arch/arm/mach-vt8500/pwm.c => drivers/pwm/pwm-vt8500.c (64%)

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
index 2d613e0..fe745b0 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -4,3 +4,6 @@ obj-$(CONFIG_PWM_IMX)		+= imx-pwm.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= samsung-pwm.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
+obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
+obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
+obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
diff --git a/arch/arm/mach-vt8500/pwm.c b/drivers/pwm/pwm-vt8500.c
similarity index 64%
rename from arch/arm/mach-vt8500/pwm.c
rename to drivers/pwm/pwm-vt8500.c
index 8ad825e..6ebea33 100644
--- a/arch/arm/mach-vt8500/pwm.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -26,10 +26,7 @@
 
 #define VT8500_NR_PWMS 4
 
-static DEFINE_MUTEX(pwm_lock);
-static LIST_HEAD(pwm_list);
-
-struct pwm_device {
+struct vt8500_pwm_device {
 	struct list_head	node;
 	struct platform_device	*pdev;
 
@@ -39,8 +36,11 @@ struct pwm_device {
 
 	unsigned int	use_count;
 	unsigned int	pwm_id;
+	struct pwm_chip	chip;
 };
 
+#define to_vt8500_pwm_device(chip)	container_of(chip, struct vt8500_pwm_device, chip)
+
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
 static inline void pwm_busy_wait(void __iomem *reg, u8 bitmask)
 {
@@ -53,12 +53,14 @@ static inline void pwm_busy_wait(void __iomem *reg, u8 bitmask)
 			   bitmask);
 }
 
-int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+static int vt8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+		int duty_ns, int period_ns)
 {
+	struct vt8500_pwm_device *vt8500_pwm = to_vt8500_pwm_device(chip);
 	unsigned long long c;
 	unsigned long period_cycles, prescale, pv, dc;
 
-	if (pwm == NULL || period_ns == 0 || duty_ns > period_ns)
+	if (vt8500_pwm == NULL || period_ns == 0 || duty_ns > period_ns)
 		return -EINVAL;
 
 	c = 25000000/2; /* wild guess --- need to implement clocks */
@@ -80,94 +82,50 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	do_div(c, period_ns);
 	dc = c;
 
-	pwm_busy_wait(pwm->regbase + 0x40 + pwm->pwm_id, (1 << 1));
-	writel(prescale, pwm->regbase + 0x4 + (pwm->pwm_id << 4));
+	pwm_busy_wait(vt8500_pwm->regbase + 0x40 + vt8500_pwm->pwm_id, (1 << 1));
+	writel(prescale, vt8500_pwm->regbase + 0x4 + (vt8500_pwm->pwm_id << 4));
 
-	pwm_busy_wait(pwm->regbase + 0x40 + pwm->pwm_id, (1 << 2));
-	writel(pv, pwm->regbase + 0x8 + (pwm->pwm_id << 4));
+	pwm_busy_wait(vt8500_pwm->regbase + 0x40 + vt8500_pwm->pwm_id, (1 << 2));
+	writel(pv, vt8500_pwm->regbase + 0x8 + (vt8500_pwm->pwm_id << 4));
 
-	pwm_busy_wait(pwm->regbase + 0x40 + pwm->pwm_id, (1 << 3));
-	writel(dc, pwm->regbase + 0xc + (pwm->pwm_id << 4));
+	pwm_busy_wait(vt8500_pwm->regbase + 0x40 + vt8500_pwm->pwm_id, (1 << 3));
+	writel(dc, vt8500_pwm->regbase + 0xc + (vt8500_pwm->pwm_id << 4));
 
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
+	struct vt8500_pwm_device *vt8500_pwm = to_vt8500_pwm_device(chip);
 
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
-		} else {
-			pwm = ERR_PTR(-EBUSY);
-		}
-	} else {
-		pwm = ERR_PTR(-ENOENT);
-	}
-
-	mutex_unlock(&pwm_lock);
-	return pwm;
+	pwm_busy_wait(vt8500_pwm->regbase + 0x40 + vt8500_pwm->pwm_id, (1 << 0));
+	writel(5, vt8500_pwm->regbase + (vt8500_pwm->pwm_id << 4));
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
+	struct vt8500_pwm_device *vt8500_pwm = to_vt8500_pwm_device(chip);
 
-	mutex_unlock(&pwm_lock);
+	pwm_busy_wait(vt8500_pwm->regbase + 0x40 + vt8500_pwm->pwm_id, (1 << 0));
+	writel(0, vt8500_pwm->regbase + (vt8500_pwm->pwm_id << 4));
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
+	struct vt8500_pwm_device *pwms;
 	struct resource *r;
 	int ret = 0;
 	int i;
 
-	pwms = kzalloc(sizeof(struct pwm_device) * VT8500_NR_PWMS, GFP_KERNEL);
+	pwms = kzalloc(sizeof(*pwms) * VT8500_NR_PWMS, GFP_KERNEL);
 	if (pwms == NULL) {
 		dev_err(&pdev->dev, "failed to allocate memory\n");
 		return -ENOMEM;
@@ -177,6 +135,7 @@ static int __devinit pwm_probe(struct platform_device *pdev)
 		pwms[i].use_count = 0;
 		pwms[i].pwm_id = i;
 		pwms[i].pdev = pdev;
+		pwms[i].chip.ops = &vt8500_pwm_ops;
 	}
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -203,12 +162,20 @@ static int __devinit pwm_probe(struct platform_device *pdev)
 	for (i = 1; i < VT8500_NR_PWMS; i++)
 		pwms[i].regbase = pwms[0].regbase;
 
-	for (i = 0; i < VT8500_NR_PWMS; i++)
-		__add_pwm(&pwms[i]);
+	for (i = 0; i < VT8500_NR_PWMS; i++) {
+		ret = pwmchip_add(&pwms[i].chip);
+		if (ret)
+			goto err_unregister;
+	}
 
 	platform_set_drvdata(pdev, pwms);
 	return 0;
 
+err_unregister:
+	while (i) {
+		i--;
+		pwmchip_remove(&pwms[i].chip);
+	}
 err_free_mem:
 	release_mem_region(r->start, resource_size(r));
 err_free:
@@ -218,7 +185,7 @@ err_free:
 
 static int __devexit pwm_remove(struct platform_device *pdev)
 {
-	struct pwm_device *pwms;
+	struct vt8500_pwm_device *pwms;
 	struct resource *r;
 	int i;
 
@@ -226,11 +193,8 @@ static int __devexit pwm_remove(struct platform_device *pdev)
 	if (pwms == NULL)
 		return -ENODEV;
 
-	mutex_lock(&pwm_lock);
-
 	for (i = 0; i < VT8500_NR_PWMS; i++)
-		list_del(&pwms[i].node);
-	mutex_unlock(&pwm_lock);
+		pwmchip_remove(&pwms[i].chip);
 
 	iounmap(pwms[0].regbase);
 
-- 
1.7.9.1
