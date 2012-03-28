From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 28 Mar 2012 16:33:55 +0200
Subject: [PATCH v5 13/16] ARM Samsung: Move s3c pwm driver to pwm framework
In-Reply-To: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1332945238-14897-14-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Move the driver to drivers/pwm/ and convert it to use the framework.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v5:
- adopt patch by Sascha Hauer to move s3c driver to PWM framework
- This driver could use some cleanups and rework to actually take advantage
  of the multiple PWM devices per PWM chip feature. Currently, information
  about the controlling timers is passed via platform resources but is not
  used. Perhaps the corresponding information can be passed in a better way
  via platform data?

 arch/arm/plat-samsung/Makefile                     |    4 -
 drivers/pwm/Kconfig                                |    9 +
 drivers/pwm/Makefile                               |    1 +
 .../pwm.c => drivers/pwm/pwm-samsung.c             |  228 ++++++++------------
 4 files changed, 97 insertions(+), 145 deletions(-)
 rename arch/arm/plat-samsung/pwm.c => drivers/pwm/pwm-samsung.c (58%)

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
index 3dd1b83..a1d87b1 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -2,4 +2,5 @@ obj-$(CONFIG_PWM)		+= core.o
 obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
 obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
+obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
diff --git a/arch/arm/plat-samsung/pwm.c b/drivers/pwm/pwm-samsung.c
similarity index 58%
rename from arch/arm/plat-samsung/pwm.c
rename to drivers/pwm/pwm-samsung.c
index c559d84..631edf0 100644
--- a/arch/arm/plat-samsung/pwm.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -24,8 +24,7 @@
 
 #include <plat/regs-timer.h>
 
-struct pwm_device {
-	struct list_head	 list;
+struct s3c_chip {
 	struct platform_device	*pdev;
 
 	struct clk		*clk_div;
@@ -36,117 +35,65 @@ struct pwm_device {
 	unsigned int		 duty_ns;
 
 	unsigned char		 tcon_base;
-	unsigned char		 running;
-	unsigned char		 use_count;
 	unsigned char		 pwm_id;
+	struct pwm_chip		 chip;
 };
 
+#define to_s3c_chip(chip)	container_of(chip, struct s3c_chip, chip)
+
 #define pwm_dbg(_pwm, msg...) dev_dbg(&(_pwm)->pdev->dev, msg)
 
 static struct clk *clk_scaler[2];
 
-static inline int pwm_is_tdiv(struct pwm_device *pwm)
-{
-	return clk_get_parent(pwm->clk) == pwm->clk_div;
-}
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
+static inline int pwm_is_tdiv(struct s3c_chip *chip)
 {
-	mutex_lock(&pwm_lock);
-
-	if (pwm->use_count) {
-		pwm->use_count--;
-		pwm->label = NULL;
-	} else
-		printk(KERN_ERR "PWM%d device already freed\n", pwm->pwm_id);
-
-	mutex_unlock(&pwm_lock);
+	return clk_get_parent(chip->clk) == chip->clk_div;
 }
 
-EXPORT_SYMBOL(pwm_free);
-
 #define pwm_tcon_start(pwm) (1 << (pwm->tcon_base + 0))
 #define pwm_tcon_invert(pwm) (1 << (pwm->tcon_base + 2))
 #define pwm_tcon_autoreload(pwm) (1 << (pwm->tcon_base + 3))
 #define pwm_tcon_manulupdate(pwm) (1 << (pwm->tcon_base + 1))
 
-int pwm_enable(struct pwm_device *pwm)
+static int s3c_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct s3c_chip *s3c = to_s3c_chip(chip);
 	unsigned long flags;
 	unsigned long tcon;
 
 	local_irq_save(flags);
 
 	tcon = __raw_readl(S3C2410_TCON);
-	tcon |= pwm_tcon_start(pwm);
+	tcon |= pwm_tcon_start(s3c);
 	__raw_writel(tcon, S3C2410_TCON);
 
 	local_irq_restore(flags);
 
-	pwm->running = 1;
 	return 0;
 }
 
-EXPORT_SYMBOL(pwm_enable);
-
-void pwm_disable(struct pwm_device *pwm)
+static void s3c_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct s3c_chip *s3c = to_s3c_chip(chip);
 	unsigned long flags;
 	unsigned long tcon;
 
 	local_irq_save(flags);
 
 	tcon = __raw_readl(S3C2410_TCON);
-	tcon &= ~pwm_tcon_start(pwm);
+	tcon &= ~pwm_tcon_start(s3c);
 	__raw_writel(tcon, S3C2410_TCON);
 
 	local_irq_restore(flags);
-
-	pwm->running = 0;
 }
 
-EXPORT_SYMBOL(pwm_disable);
-
-static unsigned long pwm_calc_tin(struct pwm_device *pwm, unsigned long freq)
+static unsigned long pwm_calc_tin(struct s3c_chip *s3c, unsigned long freq)
 {
 	unsigned long tin_parent_rate;
 	unsigned int div;
 
-	tin_parent_rate = clk_get_rate(clk_get_parent(pwm->clk_div));
-	pwm_dbg(pwm, "tin parent at %lu\n", tin_parent_rate);
+	tin_parent_rate = clk_get_rate(clk_get_parent(s3c->clk_div));
+	pwm_dbg(s3c, "tin parent at %lu\n", tin_parent_rate);
 
 	for (div = 2; div <= 16; div *= 2) {
 		if ((tin_parent_rate / (div << 16)) < freq)
@@ -158,8 +105,10 @@ static unsigned long pwm_calc_tin(struct pwm_device *pwm, unsigned long freq)
 
 #define NS_IN_HZ (1000000000UL)
 
-int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+static int s3c_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+		int duty_ns, int period_ns)
 {
+	struct s3c_chip *s3c = to_s3c_chip(chip);
 	unsigned long tin_rate;
 	unsigned long tin_ns;
 	unsigned long period;
@@ -178,38 +127,38 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	if (duty_ns > period_ns)
 		return -EINVAL;
 
-	if (period_ns == pwm->period_ns &&
-	    duty_ns == pwm->duty_ns)
+	if (period_ns == s3c->period_ns &&
+	    duty_ns == s3c->duty_ns)
 		return 0;
 
 	/* The TCMP and TCNT can be read without a lock, they're not
 	 * shared between the timers. */
 
-	tcmp = __raw_readl(S3C2410_TCMPB(pwm->pwm_id));
-	tcnt = __raw_readl(S3C2410_TCNTB(pwm->pwm_id));
+	tcmp = __raw_readl(S3C2410_TCMPB(s3c->pwm_id));
+	tcnt = __raw_readl(S3C2410_TCNTB(s3c->pwm_id));
 
 	period = NS_IN_HZ / period_ns;
 
-	pwm_dbg(pwm, "duty_ns=%d, period_ns=%d (%lu)\n",
+	pwm_dbg(s3c, "duty_ns=%d, period_ns=%d (%lu)\n",
 		duty_ns, period_ns, period);
 
 	/* Check to see if we are changing the clock rate of the PWM */
 
-	if (pwm->period_ns != period_ns) {
-		if (pwm_is_tdiv(pwm)) {
-			tin_rate = pwm_calc_tin(pwm, period);
-			clk_set_rate(pwm->clk_div, tin_rate);
+	if (s3c->period_ns != period_ns) {
+		if (pwm_is_tdiv(s3c)) {
+			tin_rate = pwm_calc_tin(s3c, period);
+			clk_set_rate(s3c->clk_div, tin_rate);
 		} else
-			tin_rate = clk_get_rate(pwm->clk);
+			tin_rate = clk_get_rate(s3c->clk);
 
-		pwm->period_ns = period_ns;
+		s3c->period_ns = period_ns;
 
-		pwm_dbg(pwm, "tin_rate=%lu\n", tin_rate);
+		pwm_dbg(s3c, "tin_rate=%lu\n", tin_rate);
 
 		tin_ns = NS_IN_HZ / tin_rate;
 		tcnt = period_ns / tin_ns;
 	} else
-		tin_ns = NS_IN_HZ / clk_get_rate(pwm->clk);
+		tin_ns = NS_IN_HZ / clk_get_rate(s3c->clk);
 
 	/* Note, counters count down */
 
@@ -220,7 +169,7 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	if (tcmp == tcnt)
 		tcmp--;
 
-	pwm_dbg(pwm, "tin_ns=%lu, tcmp=%ld/%lu\n", tin_ns, tcmp, tcnt);
+	pwm_dbg(s3c, "tin_ns=%lu, tcmp=%ld/%lu\n", tin_ns, tcmp, tcnt);
 
 	if (tcmp < 0)
 		tcmp = 0;
@@ -229,15 +178,15 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 
 	local_irq_save(flags);
 
-	__raw_writel(tcmp, S3C2410_TCMPB(pwm->pwm_id));
-	__raw_writel(tcnt, S3C2410_TCNTB(pwm->pwm_id));
+	__raw_writel(tcmp, S3C2410_TCMPB(s3c->pwm_id));
+	__raw_writel(tcnt, S3C2410_TCNTB(s3c->pwm_id));
 
 	tcon = __raw_readl(S3C2410_TCON);
-	tcon |= pwm_tcon_manulupdate(pwm);
-	tcon |= pwm_tcon_autoreload(pwm);
+	tcon |= pwm_tcon_manulupdate(s3c);
+	tcon |= pwm_tcon_autoreload(s3c);
 	__raw_writel(tcon, S3C2410_TCON);
 
-	tcon &= ~pwm_tcon_manulupdate(pwm);
+	tcon &= ~pwm_tcon_manulupdate(s3c);
 	__raw_writel(tcon, S3C2410_TCON);
 
 	local_irq_restore(flags);
@@ -245,24 +194,17 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
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
+	struct s3c_chip *s3c;
 	unsigned long flags;
 	unsigned long tcon;
 	unsigned int id = pdev->id;
@@ -273,83 +215,87 @@ static int s3c_pwm_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	pwm = kzalloc(sizeof(struct pwm_device), GFP_KERNEL);
-	if (pwm == NULL) {
+	s3c = kzalloc(sizeof(*s3c), GFP_KERNEL);
+	if (s3c == NULL) {
 		dev_err(dev, "failed to allocate pwm_device\n");
 		return -ENOMEM;
 	}
 
-	pwm->pdev = pdev;
-	pwm->pwm_id = id;
-
 	/* calculate base of control bits in TCON */
-	pwm->tcon_base = id == 0 ? 0 : (id * 4) + 4;
+	s3c->tcon_base = id == 0 ? 0 : (id * 4) + 4;
+	s3c->chip.ops = &s3c_pwm_ops;
+	s3c->chip.base = -1;
+	s3c->chip.npwm = 1;
 
-	pwm->clk = clk_get(dev, "pwm-tin");
-	if (IS_ERR(pwm->clk)) {
+	s3c->clk = clk_get(dev, "pwm-tin");
+	if (IS_ERR(s3c->clk)) {
 		dev_err(dev, "failed to get pwm tin clk\n");
-		ret = PTR_ERR(pwm->clk);
+		ret = PTR_ERR(s3c->clk);
 		goto err_alloc;
 	}
 
-	pwm->clk_div = clk_get(dev, "pwm-tdiv");
-	if (IS_ERR(pwm->clk_div)) {
+	s3c->clk_div = clk_get(dev, "pwm-tdiv");
+	if (IS_ERR(s3c->clk_div)) {
 		dev_err(dev, "failed to get pwm tdiv clk\n");
-		ret = PTR_ERR(pwm->clk_div);
+		ret = PTR_ERR(s3c->clk_div);
 		goto err_clk_tin;
 	}
 
-	clk_enable(pwm->clk);
-	clk_enable(pwm->clk_div);
+	clk_enable(s3c->clk);
+	clk_enable(s3c->clk_div);
 
 	local_irq_save(flags);
 
 	tcon = __raw_readl(S3C2410_TCON);
-	tcon |= pwm_tcon_invert(pwm);
+	tcon |= pwm_tcon_invert(s3c);
 	__raw_writel(tcon, S3C2410_TCON);
 
 	local_irq_restore(flags);
 
-
-	ret = pwm_register(pwm);
+	ret = pwmchip_add(&s3c->chip);
 	if (ret) {
 		dev_err(dev, "failed to register pwm\n");
 		goto err_clk_tdiv;
 	}
 
-	pwm_dbg(pwm, "config bits %02x\n",
-		(__raw_readl(S3C2410_TCON) >> pwm->tcon_base) & 0x0f);
+	pwm_dbg(s3c, "config bits %02x\n",
+		(__raw_readl(S3C2410_TCON) >> s3c->tcon_base) & 0x0f);
 
 	dev_info(dev, "tin at %lu, tdiv at %lu, tin=%sclk, base %d\n",
-		 clk_get_rate(pwm->clk),
-		 clk_get_rate(pwm->clk_div),
-		 pwm_is_tdiv(pwm) ? "div" : "ext", pwm->tcon_base);
+		 clk_get_rate(s3c->clk),
+		 clk_get_rate(s3c->clk_div),
+		 pwm_is_tdiv(s3c) ? "div" : "ext", s3c->tcon_base);
 
-	platform_set_drvdata(pdev, pwm);
+	platform_set_drvdata(pdev, s3c);
 	return 0;
 
  err_clk_tdiv:
-	clk_disable(pwm->clk_div);
-	clk_disable(pwm->clk);
-	clk_put(pwm->clk_div);
+	clk_disable(s3c->clk_div);
+	clk_disable(s3c->clk);
+	clk_put(s3c->clk_div);
 
  err_clk_tin:
-	clk_put(pwm->clk);
+	clk_put(s3c->clk);
 
  err_alloc:
-	kfree(pwm);
+	kfree(s3c);
 	return ret;
 }
 
 static int __devexit s3c_pwm_remove(struct platform_device *pdev)
 {
-	struct pwm_device *pwm = platform_get_drvdata(pdev);
+	struct s3c_chip *s3c = platform_get_drvdata(pdev);
+	int err;
+
+	err = pwmchip_remove(&s3c->chip);
+	if (err < 0)
+		return err;
 
-	clk_disable(pwm->clk_div);
-	clk_disable(pwm->clk);
-	clk_put(pwm->clk_div);
-	clk_put(pwm->clk);
-	kfree(pwm);
+	clk_disable(s3c->clk_div);
+	clk_disable(s3c->clk);
+	clk_put(s3c->clk_div);
+	clk_put(s3c->clk);
+	kfree(s3c);
 
 	return 0;
 }
@@ -357,26 +303,26 @@ static int __devexit s3c_pwm_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int s3c_pwm_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	struct pwm_device *pwm = platform_get_drvdata(pdev);
+	struct s3c_chip *s3c = platform_get_drvdata(pdev);
 
 	/* No one preserve these values during suspend so reset them
 	 * Otherwise driver leaves PWM unconfigured if same values
 	 * passed to pwm_config
 	 */
-	pwm->period_ns = 0;
-	pwm->duty_ns = 0;
+	s3c->period_ns = 0;
+	s3c->duty_ns = 0;
 
 	return 0;
 }
 
 static int s3c_pwm_resume(struct platform_device *pdev)
 {
-	struct pwm_device *pwm = platform_get_drvdata(pdev);
+	struct s3c_chip *s3c = platform_get_drvdata(pdev);
 	unsigned long tcon;
 
 	/* Restore invertion */
 	tcon = __raw_readl(S3C2410_TCON);
-	tcon |= pwm_tcon_invert(pwm);
+	tcon |= pwm_tcon_invert(s3c);
 	__raw_writel(tcon, S3C2410_TCON);
 
 	return 0;
-- 
1.7.9.4
