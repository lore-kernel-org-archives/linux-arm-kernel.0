From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 10 Apr 2012 17:06:33 +0200
Subject: [PATCH v6 10/17] pwm: Move Blackfin PWM driver to PWM framework
In-Reply-To: <1334070400-25013-1-git-send-email-thierry.reding@avionic-design.de>
References: <1334070400-25013-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1334070400-25013-11-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit moves the Blackfin PWM driver to the drivers/pwm sub-
directory and converts it to register with the new PWM framework.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 arch/blackfin/Kconfig                              |   10 --
 arch/blackfin/kernel/Makefile                      |    1 -
 drivers/pwm/Kconfig                                |    9 ++
 drivers/pwm/Makefile                               |    1 +
 .../kernel/pwm.c => drivers/pwm/pwm-bfin.c         |  138 ++++++++++++++------
 5 files changed, 111 insertions(+), 48 deletions(-)
 rename arch/blackfin/kernel/pwm.c => drivers/pwm/pwm-bfin.c (26%)

diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig
index 373a690..128357e 100644
--- a/arch/blackfin/Kconfig
+++ b/arch/blackfin/Kconfig
@@ -950,16 +950,6 @@ config BFIN_GPTIMERS
 	  To compile this driver as a module, choose M here: the module
 	  will be called gptimers.
 
-config HAVE_PWM
-	tristate "Enable PWM API support"
-	depends on BFIN_GPTIMERS
-	help
-	  Enable support for the Pulse Width Modulation framework (as
-	  found in linux/pwm.h).
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called pwm.
-
 choice
 	prompt "Uncached DMA region"
 	default DMA_UNCACHED_1M
diff --git a/arch/blackfin/kernel/Makefile b/arch/blackfin/kernel/Makefile
index 9a0d6d7..00fef32 100644
--- a/arch/blackfin/kernel/Makefile
+++ b/arch/blackfin/kernel/Makefile
@@ -21,7 +21,6 @@ obj-$(CONFIG_FUNCTION_TRACER)        += ftrace-entry.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)  += ftrace.o
 CFLAGS_REMOVE_ftrace.o = -pg
 
-obj-$(CONFIG_HAVE_PWM)               += pwm.o
 obj-$(CONFIG_IPIPE)                  += ipipe.o
 obj-$(CONFIG_BFIN_GPTIMERS)          += gptimers.o
 obj-$(CONFIG_CPLB_INFO)              += cplbinfo.o
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index bda6f23..eb54042 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -9,6 +9,15 @@ menuconfig PWM
 
 if PWM
 
+config PWM_BFIN
+	tristate "Blackfin PWM support"
+	depends on BFIN_GPTIMERS
+	help
+	  Generic PWM framework driver for Blackfin.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-bfin.
+
 config PWM_TEGRA
 	tristate "NVIDIA Tegra PWM support"
 	depends on ARCH_TEGRA
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 12300f5..251b8d2 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_PWM)		+= core.o
+obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
diff --git a/arch/blackfin/kernel/pwm.c b/drivers/pwm/pwm-bfin.c
similarity index 26%
rename from arch/blackfin/kernel/pwm.c
rename to drivers/pwm/pwm-bfin.c
index 33f5942..a0c6bf9 100644
--- a/arch/blackfin/kernel/pwm.c
+++ b/drivers/pwm/pwm-bfin.c
@@ -7,14 +7,18 @@
  */
 
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
 
 #include <asm/gptimers.h>
 #include <asm/portmux.h>
 
-struct pwm_device {
-	unsigned id;
+struct bfin_pwm_chip {
+	struct pwm_chip chip;
+};
+
+struct bfin_pwm {
 	unsigned short pin;
 };
 
@@ -23,44 +27,45 @@ static const unsigned short pwm_to_gptimer_per[] = {
 	P_TMR6, P_TMR7, P_TMR8, P_TMR9, P_TMR10, P_TMR11,
 };
 
-struct pwm_device *pwm_request(int pwm_id, const char *label)
+static int bfin_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct pwm_device *pwm;
+	struct bfin_pwm *priv;
 	int ret;
 
-	/* XXX: pwm_id really should be unsigned */
-	if (pwm_id < 0)
-		return NULL;
+	if (pwm->hwpwm >= ARRAY_SIZE(pwm_to_gptimer_per))
+		return -EINVAL;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
 
-	pwm = kzalloc(sizeof(*pwm), GFP_KERNEL);
-	if (!pwm)
-		return pwm;
+	priv->pin = pwm_to_gptimer_per[pwm->hwpwm];
 
-	pwm->id = pwm_id;
-	if (pwm->id >= ARRAY_SIZE(pwm_to_gptimer_per))
-		goto err;
+	ret = peripheral_request(priv->pin, NULL);
+	if (ret) {
+		kfree(priv);
+		return ret;
+	}
 
-	pwm->pin = pwm_to_gptimer_per[pwm->id];
-	ret = peripheral_request(pwm->pin, label);
-	if (ret)
-		goto err;
+	pwm_set_chip_data(pwm, priv);
 
-	return pwm;
- err:
-	kfree(pwm);
-	return NULL;
+	return 0;
 }
-EXPORT_SYMBOL(pwm_request);
 
-void pwm_free(struct pwm_device *pwm)
+static void bfin_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	peripheral_free(pwm->pin);
-	kfree(pwm);
+	struct bfin_pwm *priv = pwm_get_chip_data(pwm);
+
+	if (priv) {
+		peripheral_free(priv->pin);
+		kfree(priv);
+	}
 }
-EXPORT_SYMBOL(pwm_free);
 
-int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+static int bfin_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+		int duty_ns, int period_ns)
 {
+	struct bfin_pwm *priv = pwm_get_chip_data(pwm);
 	unsigned long period, duty;
 	unsigned long long val;
 
@@ -78,23 +83,82 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	if (duty >= period)
 		duty = period - 1;
 
-	set_gptimer_config(pwm->id, TIMER_MODE_PWM | TIMER_PERIOD_CNT);
-	set_gptimer_pwidth(pwm->id, duty);
-	set_gptimer_period(pwm->id, period);
+	set_gptimer_config(priv->pin, TIMER_MODE_PWM | TIMER_PERIOD_CNT);
+	set_gptimer_pwidth(priv->pin, duty);
+	set_gptimer_period(priv->pin, period);
 
 	return 0;
 }
-EXPORT_SYMBOL(pwm_config);
 
-int pwm_enable(struct pwm_device *pwm)
+static int bfin_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	enable_gptimer(pwm->id);
+	struct bfin_pwm *priv = pwm_get_chip_data(pwm);
+
+	enable_gptimer(priv->pin);
+
 	return 0;
 }
-EXPORT_SYMBOL(pwm_enable);
 
-void pwm_disable(struct pwm_device *pwm)
+static void bfin_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	disable_gptimer(pwm->id);
+	struct bfin_pwm *priv = pwm_get_chip_data(pwm);
+
+	disable_gptimer(priv->pin);
 }
-EXPORT_SYMBOL(pwm_disable);
+
+static struct pwm_ops bfin_pwm_ops = {
+	.request = bfin_pwm_request,
+	.free = bfin_pwm_free,
+	.config = bfin_pwm_config,
+	.enable = bfin_pwm_enable,
+	.disable = bfin_pwm_disable,
+	.owner = THIS_MODULE,
+};
+
+static int bfin_pwm_probe(struct platform_device *pdev)
+{
+	struct bfin_pwm_chip *pwm;
+	int ret;
+
+	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm) {
+		dev_err(&pdev->dev, "failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(pdev, pwm);
+
+	pwm->chip.dev = &pdev->dev;
+	pwm->chip.ops = &bfin_pwm_ops;
+	pwm->chip.base = -1;
+	pwm->chip.npwm = 12;
+
+	ret = pwmchip_add(&pwm->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __devexit bfin_pwm_remove(struct platform_device *pdev)
+{
+	struct bfin_pwm_chip *pwm = platform_get_drvdata(pdev);
+
+	pwmchip_remove(&pwm->chip);
+
+	return 0;
+}
+
+static struct platform_driver bfin_pwm_driver = {
+	.driver = {
+		.name = "bfin-pwm",
+	},
+	.probe = bfin_pwm_probe,
+	.remove = __devexit_p(bfin_pwm_remove),
+};
+
+module_platform_driver(bfin_pwm_driver);
+
+MODULE_LICENSE("GPL");
-- 
1.7.9.6
