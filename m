From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 15 Mar 2012 10:04:36 +0100
Subject: [PATCH 2/3] ARM Samsung: Move s3c pwm driver to pwm framework
In-Reply-To: <1331802277-12477-1-git-send-email-s.hauer@pengutronix.de>
References: <1331802277-12477-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1331802277-12477-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the driver to drivers/pwm/ and convert it to use the framework.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-samsung/Makefile                     |    4 -
 drivers/pwm/Kconfig                                |    9 +
 drivers/pwm/Makefile                               |    1 +
 .../pwm.c => drivers/pwm/pwm-samsung.c             |  215 ++++++++------------
 4 files changed, 91 insertions(+), 138 deletions(-)
 rename arch/arm/plat-samsung/pwm.c => drivers/pwm/pwm-samsung.c (61%)

diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 6012366..f09a7cf 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -50,7 +50,3 @@ obj-$(CONFIG_SAMSUNG_WAKEMASK)	+= wakeup-mask.o
 # PD support
 
 obj-$(CONFIG_SAMSUNG_PD)	+= pd.o
-
-# PWM support
-
-obj-$(CONFIG_HAVE_PWM)		+= pwm.o
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a9a9715..0d9aa92 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -36,6 +36,15 @@ config PWM_PXA
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-pxa.
 
+config PWM_SAMSUNG
+	tristate "Samsung pwm support"
+	depends on PLAT_SAMSUNG
+	help
+	  Generic PWM framework driver for Samsung.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-samsung.
+
 config PWM_TEGRA
 	tristate "NVIDIA Tegra PWM support"
 	depends on ARCH_TEGRA
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index fc7571e..2d613e0 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -2,4 +2,5 @@ obj-$(CONFIG_PWM)		+= core.o
 obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
 obj-$(CONFIG_PWM_IMX)		+= imx-pwm.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
+obj-$(CONFIG_PWM_SAMSUNG)	+= samsung-pwm.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
diff --git a/arch/arm/plat-samsung/pwm.c b/drivers/pwm/pwm-samsung.c
similarity index 61%
rename from arch/arm/plat-samsung/pwm.c
rename to drivers/pwm/pwm-samsung.c
index c559d84..5640ba3 100644
--- a/arch/arm/plat-samsung/pwm.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -24,7 +24,7 @@
 
 #include <plat/regs-timer.h>
 
-struct pwm_device {
+struct s3c_pwm_device {
 	struct list_head	 list;
 	struct platform_device	*pdev;
 
@@ -37,110 +37,62 @@ struct pwm_device {
 
 	unsigned char		 tcon_base;
 	unsigned char		 running;
-	unsigned char		 use_count;
 	unsigned char		 pwm_id;
+	struct pwm_chip chip;
 };
 
+#define to_s3c_pwm_device(chip)	container_of(chip, struct s3c_pwm_device, chip)
+
 #define pwm_dbg(_pwm, msg...) dev_dbg(&(_pwm)->pdev->dev, msg)
 
 static struct clk *clk_scaler[2];
 
-static inline int pwm_is_tdiv(struct pwm_device *pwm)
+static inline int pwm_is_tdiv(struct s3c_pwm_device *pwm)
 {
 	return clk_get_parent(pwm->clk) == pwm->clk_div;
 }
 
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
-	list_for_each_entry(pwm, &pwm_list, list) {
-		if (pwm->pwm_id == pwm_id) {
-			found = 1;
-			break;
-		}
-	}
-
-	if (found) {
-		if (pwm->use_count == 0) {
-			pwm->use_count = 1;
-			pwm->label = label;
-		} else
-			pwm = ERR_PTR(-EBUSY);
-	} else
-		pwm = ERR_PTR(-ENOENT);
-
-	mutex_unlock(&pwm_lock);
-	return pwm;
-}
-
-EXPORT_SYMBOL(pwm_request);
-
-
-void pwm_free(struct pwm_device *pwm)
-{
-	mutex_lock(&pwm_lock);
-
-	if (pwm->use_count) {
-		pwm->use_count--;
-		pwm->label = NULL;
-	} else
-		printk(KERN_ERR "PWM%d device already freed\n", pwm->pwm_id);
-
-	mutex_unlock(&pwm_lock);
-}
-
-EXPORT_SYMBOL(pwm_free);
-
 #define pwm_tcon_start(pwm) (1 << (pwm->tcon_base + 0))
 #define pwm_tcon_invert(pwm) (1 << (pwm->tcon_base + 2))
 #define pwm_tcon_autoreload(pwm) (1 << (pwm->tcon_base + 3))
 #define pwm_tcon_manulupdate(pwm) (1 << (pwm->tcon_base + 1))
 
-int pwm_enable(struct pwm_device *pwm)
+static int s3c_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct s3c_pwm_device *s3c_pwm = to_s3c_pwm_device(chip);
 	unsigned long flags;
 	unsigned long tcon;
 
 	local_irq_save(flags);
 
 	tcon = __raw_readl(S3C2410_TCON);
-	tcon |= pwm_tcon_start(pwm);
+	tcon |= pwm_tcon_start(s3c_pwm);
 	__raw_writel(tcon, S3C2410_TCON);
 
 	local_irq_restore(flags);
 
-	pwm->running = 1;
+	s3c_pwm->running = 1;
 	return 0;
 }
 
-EXPORT_SYMBOL(pwm_enable);
-
-void pwm_disable(struct pwm_device *pwm)
+static void s3c_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct s3c_pwm_device *s3c_pwm = to_s3c_pwm_device(chip);
 	unsigned long flags;
 	unsigned long tcon;
 
 	local_irq_save(flags);
 
 	tcon = __raw_readl(S3C2410_TCON);
-	tcon &= ~pwm_tcon_start(pwm);
+	tcon &= ~pwm_tcon_start(s3c_pwm);
 	__raw_writel(tcon, S3C2410_TCON);
 
 	local_irq_restore(flags);
 
-	pwm->running = 0;
+	s3c_pwm->running = 0;
 }
 
-EXPORT_SYMBOL(pwm_disable);
-
-static unsigned long pwm_calc_tin(struct pwm_device *pwm, unsigned long freq)
+static unsigned long pwm_calc_tin(struct s3c_pwm_device *pwm, unsigned long freq)
 {
 	unsigned long tin_parent_rate;
 	unsigned int div;
@@ -158,8 +110,10 @@ static unsigned long pwm_calc_tin(struct pwm_device *pwm, unsigned long freq)
 
 #define NS_IN_HZ (1000000000UL)
 
-int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+static int s3c_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+		int duty_ns, int period_ns)
 {
+	struct s3c_pwm_device *s3c_pwm = to_s3c_pwm_device(chip);
 	unsigned long tin_rate;
 	unsigned long tin_ns;
 	unsigned long period;
@@ -178,38 +132,38 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	if (duty_ns > period_ns)
 		return -EINVAL;
 
-	if (period_ns == pwm->period_ns &&
-	    duty_ns == pwm->duty_ns)
+	if (period_ns == s3c_pwm->period_ns &&
+	    duty_ns == s3c_pwm->duty_ns)
 		return 0;
 
 	/* The TCMP and TCNT can be read without a lock, they're not
 	 * shared between the timers. */
 
-	tcmp = __raw_readl(S3C2410_TCMPB(pwm->pwm_id));
-	tcnt = __raw_readl(S3C2410_TCNTB(pwm->pwm_id));
+	tcmp = __raw_readl(S3C2410_TCMPB(s3c_pwm->pwm_id));
+	tcnt = __raw_readl(S3C2410_TCNTB(s3c_pwm->pwm_id));
 
 	period = NS_IN_HZ / period_ns;
 
-	pwm_dbg(pwm, "duty_ns=%d, period_ns=%d (%lu)\n",
+	pwm_dbg(s3c_pwm, "duty_ns=%d, period_ns=%d (%lu)\n",
 		duty_ns, period_ns, period);
 
 	/* Check to see if we are changing the clock rate of the PWM */
 
-	if (pwm->period_ns != period_ns) {
-		if (pwm_is_tdiv(pwm)) {
-			tin_rate = pwm_calc_tin(pwm, period);
-			clk_set_rate(pwm->clk_div, tin_rate);
+	if (s3c_pwm->period_ns != period_ns) {
+		if (pwm_is_tdiv(s3c_pwm)) {
+			tin_rate = pwm_calc_tin(s3c_pwm, period);
+			clk_set_rate(s3c_pwm->clk_div, tin_rate);
 		} else
-			tin_rate = clk_get_rate(pwm->clk);
+			tin_rate = clk_get_rate(s3c_pwm->clk);
 
-		pwm->period_ns = period_ns;
+		s3c_pwm->period_ns = period_ns;
 
-		pwm_dbg(pwm, "tin_rate=%lu\n", tin_rate);
+		pwm_dbg(s3c_pwm, "tin_rate=%lu\n", tin_rate);
 
 		tin_ns = NS_IN_HZ / tin_rate;
 		tcnt = period_ns / tin_ns;
 	} else
-		tin_ns = NS_IN_HZ / clk_get_rate(pwm->clk);
+		tin_ns = NS_IN_HZ / clk_get_rate(s3c_pwm->clk);
 
 	/* Note, counters count down */
 
@@ -220,7 +174,7 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	if (tcmp == tcnt)
 		tcmp--;
 
-	pwm_dbg(pwm, "tin_ns=%lu, tcmp=%ld/%lu\n", tin_ns, tcmp, tcnt);
+	pwm_dbg(s3c_pwm, "tin_ns=%lu, tcmp=%ld/%lu\n", tin_ns, tcmp, tcnt);
 
 	if (tcmp < 0)
 		tcmp = 0;
@@ -229,15 +183,15 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 
 	local_irq_save(flags);
 
-	__raw_writel(tcmp, S3C2410_TCMPB(pwm->pwm_id));
-	__raw_writel(tcnt, S3C2410_TCNTB(pwm->pwm_id));
+	__raw_writel(tcmp, S3C2410_TCMPB(s3c_pwm->pwm_id));
+	__raw_writel(tcnt, S3C2410_TCNTB(s3c_pwm->pwm_id));
 
 	tcon = __raw_readl(S3C2410_TCON);
-	tcon |= pwm_tcon_manulupdate(pwm);
-	tcon |= pwm_tcon_autoreload(pwm);
+	tcon |= pwm_tcon_manulupdate(s3c_pwm);
+	tcon |= pwm_tcon_autoreload(s3c_pwm);
 	__raw_writel(tcon, S3C2410_TCON);
 
-	tcon &= ~pwm_tcon_manulupdate(pwm);
+	tcon &= ~pwm_tcon_manulupdate(s3c_pwm);
 	__raw_writel(tcon, S3C2410_TCON);
 
 	local_irq_restore(flags);
@@ -245,24 +199,17 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	return 0;
 }
 
-EXPORT_SYMBOL(pwm_config);
-
-static int pwm_register(struct pwm_device *pwm)
-{
-	pwm->duty_ns = -1;
-	pwm->period_ns = -1;
-
-	mutex_lock(&pwm_lock);
-	list_add_tail(&pwm->list, &pwm_list);
-	mutex_unlock(&pwm_lock);
-
-	return 0;
-}
+static struct pwm_ops s3c_pwm_ops = {
+	.enable = s3c_pwm_enable,
+	.disable = s3c_pwm_disable,
+	.config = s3c_pwm_config,
+	.owner = THIS_MODULE,
+};
 
 static int s3c_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct pwm_device *pwm;
+	struct s3c_pwm_device *s3c_pwm;
 	unsigned long flags;
 	unsigned long tcon;
 	unsigned int id = pdev->id;
@@ -273,83 +220,83 @@ static int s3c_pwm_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	pwm = kzalloc(sizeof(struct pwm_device), GFP_KERNEL);
-	if (pwm == NULL) {
+	s3c_pwm = kzalloc(sizeof(*s3c_pwm), GFP_KERNEL);
+	if (s3c_pwm == NULL) {
 		dev_err(dev, "failed to allocate pwm_device\n");
 		return -ENOMEM;
 	}
 
-	pwm->pdev = pdev;
-	pwm->pwm_id = id;
-
 	/* calculate base of control bits in TCON */
-	pwm->tcon_base = id == 0 ? 0 : (id * 4) + 4;
+	s3c_pwm->tcon_base = id == 0 ? 0 : (id * 4) + 4;
+	s3c_pwm->chip.ops = &s3c_pwm_ops;
 
-	pwm->clk = clk_get(dev, "pwm-tin");
-	if (IS_ERR(pwm->clk)) {
+	s3c_pwm->clk = clk_get(dev, "pwm-tin");
+	if (IS_ERR(s3c_pwm->clk)) {
 		dev_err(dev, "failed to get pwm tin clk\n");
-		ret = PTR_ERR(pwm->clk);
+		ret = PTR_ERR(s3c_pwm->clk);
 		goto err_alloc;
 	}
 
-	pwm->clk_div = clk_get(dev, "pwm-tdiv");
-	if (IS_ERR(pwm->clk_div)) {
+	s3c_pwm->clk_div = clk_get(dev, "pwm-tdiv");
+	if (IS_ERR(s3c_pwm->clk_div)) {
 		dev_err(dev, "failed to get pwm tdiv clk\n");
-		ret = PTR_ERR(pwm->clk_div);
+		ret = PTR_ERR(s3c_pwm->clk_div);
 		goto err_clk_tin;
 	}
 
-	clk_enable(pwm->clk);
-	clk_enable(pwm->clk_div);
+	clk_enable(s3c_pwm->clk);
+	clk_enable(s3c_pwm->clk_div);
 
 	local_irq_save(flags);
 
 	tcon = __raw_readl(S3C2410_TCON);
-	tcon |= pwm_tcon_invert(pwm);
+	tcon |= pwm_tcon_invert(s3c_pwm);
 	__raw_writel(tcon, S3C2410_TCON);
 
 	local_irq_restore(flags);
 
 
-	ret = pwm_register(pwm);
+	ret = pwmchip_add(&s3c_pwm->chip);
 	if (ret) {
 		dev_err(dev, "failed to register pwm\n");
 		goto err_clk_tdiv;
 	}
 
-	pwm_dbg(pwm, "config bits %02x\n",
-		(__raw_readl(S3C2410_TCON) >> pwm->tcon_base) & 0x0f);
+	pwm_dbg(s3c_pwm, "config bits %02x\n",
+		(__raw_readl(S3C2410_TCON) >> s3c_pwm->tcon_base) & 0x0f);
 
 	dev_info(dev, "tin at %lu, tdiv at %lu, tin=%sclk, base %d\n",
-		 clk_get_rate(pwm->clk),
-		 clk_get_rate(pwm->clk_div),
-		 pwm_is_tdiv(pwm) ? "div" : "ext", pwm->tcon_base);
+		 clk_get_rate(s3c_pwm->clk),
+		 clk_get_rate(s3c_pwm->clk_div),
+		 pwm_is_tdiv(s3c_pwm) ? "div" : "ext", s3c_pwm->tcon_base);
 
-	platform_set_drvdata(pdev, pwm);
+	platform_set_drvdata(pdev, s3c_pwm);
 	return 0;
 
  err_clk_tdiv:
-	clk_disable(pwm->clk_div);
-	clk_disable(pwm->clk);
-	clk_put(pwm->clk_div);
+	clk_disable(s3c_pwm->clk_div);
+	clk_disable(s3c_pwm->clk);
+	clk_put(s3c_pwm->clk_div);
 
  err_clk_tin:
-	clk_put(pwm->clk);
+	clk_put(s3c_pwm->clk);
 
  err_alloc:
-	kfree(pwm);
+	kfree(s3c_pwm);
 	return ret;
 }
 
 static int __devexit s3c_pwm_remove(struct platform_device *pdev)
 {
-	struct pwm_device *pwm = platform_get_drvdata(pdev);
+	struct s3c_pwm_device *s3c_pwm = platform_get_drvdata(pdev);
+
+	pwmchip_remove(&s3c_pwm->chip);
 
-	clk_disable(pwm->clk_div);
-	clk_disable(pwm->clk);
-	clk_put(pwm->clk_div);
-	clk_put(pwm->clk);
-	kfree(pwm);
+	clk_disable(s3c_pwm->clk_div);
+	clk_disable(s3c_pwm->clk);
+	clk_put(s3c_pwm->clk_div);
+	clk_put(s3c_pwm->clk);
+	kfree(s3c_pwm);
 
 	return 0;
 }
@@ -357,26 +304,26 @@ static int __devexit s3c_pwm_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int s3c_pwm_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	struct pwm_device *pwm = platform_get_drvdata(pdev);
+	struct s3c_pwm_device *s3c_pwm = platform_get_drvdata(pdev);
 
 	/* No one preserve these values during suspend so reset them
 	 * Otherwise driver leaves PWM unconfigured if same values
 	 * passed to pwm_config
 	 */
-	pwm->period_ns = 0;
-	pwm->duty_ns = 0;
+	s3c_pwm->period_ns = 0;
+	s3c_pwm->duty_ns = 0;
 
 	return 0;
 }
 
 static int s3c_pwm_resume(struct platform_device *pdev)
 {
-	struct pwm_device *pwm = platform_get_drvdata(pdev);
+	struct s3c_pwm_device *s3c_pwmwm = platform_get_drvdata(pdev);
 	unsigned long tcon;
 
 	/* Restore invertion */
 	tcon = __raw_readl(S3C2410_TCON);
-	tcon |= pwm_tcon_invert(pwm);
+	tcon |= pwm_tcon_invert(s3c_pwmwm);
 	__raw_writel(tcon, S3C2410_TCON);
 
 	return 0;
-- 
1.7.9.1
