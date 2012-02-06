From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon,  6 Feb 2012 16:19:43 +0100
Subject: [PATCH v2 08/10] pwm: Add Blackfin support
In-Reply-To: <1328541585-24642-1-git-send-email-thierry.reding@avionic-design.de>
References: <1328541585-24642-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1328541585-24642-9-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 arch/blackfin/Kconfig         |   10 ---
 arch/blackfin/kernel/Makefile |    1 -
 arch/blackfin/kernel/pwm.c    |  100 -------------------------
 drivers/pwm/Kconfig           |    9 ++
 drivers/pwm/Makefile          |    1 +
 drivers/pwm/pwm-bfin.c        |  164 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 174 insertions(+), 111 deletions(-)
 delete mode 100644 arch/blackfin/kernel/pwm.c
 create mode 100644 drivers/pwm/pwm-bfin.c

diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig
index abe5a9e..3f23fd3 100644
--- a/arch/blackfin/Kconfig
+++ b/arch/blackfin/Kconfig
@@ -949,16 +949,6 @@ config BFIN_GPTIMERS
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
index 1f88edd..03f60a6 100644
--- a/arch/blackfin/kernel/Makefile
+++ b/arch/blackfin/kernel/Makefile
@@ -21,7 +21,6 @@ obj-$(CONFIG_FUNCTION_TRACER)        += ftrace-entry.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)  += ftrace.o
 CFLAGS_REMOVE_ftrace.o = -pg
 
-obj-$(CONFIG_HAVE_PWM)               += pwm.o
 obj-$(CONFIG_IPIPE)                  += ipipe.o
 obj-$(CONFIG_BFIN_GPTIMERS)          += gptimers.o
 obj-$(CONFIG_CPLB_INFO)              += cplbinfo.o
diff --git a/arch/blackfin/kernel/pwm.c b/arch/blackfin/kernel/pwm.c
deleted file mode 100644
index 33f5942..0000000
--- a/arch/blackfin/kernel/pwm.c
+++ /dev/null
@@ -1,100 +0,0 @@
-/*
- * Blackfin Pulse Width Modulation (PWM) core
- *
- * Copyright (c) 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
- */
-
-#include <linux/module.h>
-#include <linux/pwm.h>
-#include <linux/slab.h>
-
-#include <asm/gptimers.h>
-#include <asm/portmux.h>
-
-struct pwm_device {
-	unsigned id;
-	unsigned short pin;
-};
-
-static const unsigned short pwm_to_gptimer_per[] = {
-	P_TMR0, P_TMR1, P_TMR2, P_TMR3, P_TMR4, P_TMR5,
-	P_TMR6, P_TMR7, P_TMR8, P_TMR9, P_TMR10, P_TMR11,
-};
-
-struct pwm_device *pwm_request(int pwm_id, const char *label)
-{
-	struct pwm_device *pwm;
-	int ret;
-
-	/* XXX: pwm_id really should be unsigned */
-	if (pwm_id < 0)
-		return NULL;
-
-	pwm = kzalloc(sizeof(*pwm), GFP_KERNEL);
-	if (!pwm)
-		return pwm;
-
-	pwm->id = pwm_id;
-	if (pwm->id >= ARRAY_SIZE(pwm_to_gptimer_per))
-		goto err;
-
-	pwm->pin = pwm_to_gptimer_per[pwm->id];
-	ret = peripheral_request(pwm->pin, label);
-	if (ret)
-		goto err;
-
-	return pwm;
- err:
-	kfree(pwm);
-	return NULL;
-}
-EXPORT_SYMBOL(pwm_request);
-
-void pwm_free(struct pwm_device *pwm)
-{
-	peripheral_free(pwm->pin);
-	kfree(pwm);
-}
-EXPORT_SYMBOL(pwm_free);
-
-int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
-{
-	unsigned long period, duty;
-	unsigned long long val;
-
-	if (duty_ns < 0 || duty_ns > period_ns)
-		return -EINVAL;
-
-	val = (unsigned long long)get_sclk() * period_ns;
-	do_div(val, NSEC_PER_SEC);
-	period = val;
-
-	val = (unsigned long long)period * duty_ns;
-	do_div(val, period_ns);
-	duty = period - val;
-
-	if (duty >= period)
-		duty = period - 1;
-
-	set_gptimer_config(pwm->id, TIMER_MODE_PWM | TIMER_PERIOD_CNT);
-	set_gptimer_pwidth(pwm->id, duty);
-	set_gptimer_period(pwm->id, period);
-
-	return 0;
-}
-EXPORT_SYMBOL(pwm_config);
-
-int pwm_enable(struct pwm_device *pwm)
-{
-	enable_gptimer(pwm->id);
-	return 0;
-}
-EXPORT_SYMBOL(pwm_enable);
-
-void pwm_disable(struct pwm_device *pwm)
-{
-	disable_gptimer(pwm->id);
-}
-EXPORT_SYMBOL(pwm_disable);
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
diff --git a/drivers/pwm/pwm-bfin.c b/drivers/pwm/pwm-bfin.c
new file mode 100644
index 0000000..accfa86
--- /dev/null
+++ b/drivers/pwm/pwm-bfin.c
@@ -0,0 +1,164 @@
+/*
+ * Blackfin Pulse Width Modulation (PWM) core
+ *
+ * Copyright (c) 2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+
+#include <asm/gptimers.h>
+#include <asm/portmux.h>
+
+struct bfin_pwm_chip {
+	struct pwm_chip chip;
+};
+
+struct bfin_pwm {
+	unsigned short pin;
+};
+
+static const unsigned short pwm_to_gptimer_per[] = {
+	P_TMR0, P_TMR1, P_TMR2, P_TMR3, P_TMR4, P_TMR5,
+	P_TMR6, P_TMR7, P_TMR8, P_TMR9, P_TMR10, P_TMR11,
+};
+
+static int bfin_pwm_request(struct pwm_chip *chip, unsigned int pwm)
+{
+	struct bfin_pwm *priv;
+	int ret;
+
+	if (pwm >= ARRAY_SIZE(pwm_to_gptimer_per))
+		return -EINVAL;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pin = pwm_to_gptimer_per[pwm];
+
+	ret = peripheral_request(priv->pin, NULL);
+	if (ret) {
+		kfree(priv);
+		return ret;
+	}
+
+	pwm_set_chip_data(pwm, priv);
+
+	return 0;
+}
+
+static void bfin_pwm_free(struct pwm_chip *chip, unsigned int pwm)
+{
+	struct bfin_pwm *priv = pwm_get_chip_data(pwm);
+
+	if (priv) {
+		peripheral_free(priv->pin);
+		kfree(priv);
+	}
+}
+
+static int bfin_pwm_config(struct pwm_chip *chip, unsigned int pwm,
+		int duty_ns, int period_ns)
+{
+	unsigned int num = pwm - chip->base;
+	unsigned long period, duty;
+	unsigned long long val;
+
+	if (duty_ns < 0 || duty_ns > period_ns)
+		return -EINVAL;
+
+	val = (unsigned long long)get_sclk() * period_ns;
+	do_div(val, NSEC_PER_SEC);
+	period = val;
+
+	val = (unsigned long long)period * duty_ns;
+	do_div(val, period_ns);
+	duty = period - val;
+
+	if (duty >= period)
+		duty = period - 1;
+
+	set_gptimer_config(num, TIMER_MODE_PWM | TIMER_PERIOD_CNT);
+	set_gptimer_pwidth(num, duty);
+	set_gptimer_period(num, period);
+
+	return 0;
+}
+
+static int bfin_pwm_enable(struct pwm_chip *chip, unsigned int pwm)
+{
+	unsigned int num = pwm - chip->base;
+
+	enable_gptimer(num);
+
+	return 0;
+}
+
+static void bfin_pwm_disable(struct pwm_chip *chip, unsigned int pwm)
+{
+	unsigned int num = pwm - chip->base;
+
+	disable_gptimer(num);
+}
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
1.7.9
