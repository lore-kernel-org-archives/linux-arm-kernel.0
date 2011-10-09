From: zoss@devai.org (Zoltan Devai)
Date: Sun,  9 Oct 2011 18:36:09 +0200
Subject: [PATCH 6/9] ARM: SPMP8000: Add pwm driver
In-Reply-To: <1318178172-7965-1-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
Message-ID: <1318178172-7965-7-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/mach-spmp8000/pwm.c |  246 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 246 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-spmp8000/pwm.c

diff --git a/arch/arm/mach-spmp8000/pwm.c b/arch/arm/mach-spmp8000/pwm.c
new file mode 100644
index 0000000..a6418bf
--- /dev/null
+++ b/arch/arm/mach-spmp8000/pwm.c
@@ -0,0 +1,246 @@
+/*
+ * SPMP8000 machines PWM support
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/pwm.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <asm/div64.h>
+
+#include <mach/regs-timer.h>
+
+static DEFINE_MUTEX(pwm_lock);
+static LIST_HEAD(pwm_list);
+
+struct pwm_device {
+	const char	*label;
+	void __iomem	*regbase;
+	unsigned int	use_count;
+	unsigned int	pwm_id;
+	unsigned long	clkrate;
+	struct device	*dev;
+	struct list_head	node;
+};
+
+int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+{
+	unsigned long long c;
+	unsigned long period_cycles, duty_cycles, prescale;
+
+	if (pwm == NULL || period_ns == 0 || duty_ns > period_ns)
+		return -EINVAL;
+
+	c = pwm->clkrate;
+	c = c * period_ns;
+	do_div(c, 1000000000);
+	period_cycles = c;
+
+	prescale = (period_cycles - 1) / 65536;
+
+	if (prescale > 65535)
+		return -EINVAL;
+
+	if (prescale < 1)
+		prescale = 1;
+
+	period_cycles /= prescale;
+
+	if (period_cycles > 65536)
+		return -EINVAL;
+
+	c = (unsigned long long)period_cycles * duty_ns;
+	do_div(c, period_ns);
+	duty_cycles = c;
+
+	dev_dbg(pwm->dev, "period_ns: %d, duty_ns: %d, prescale: %ld,"
+			  " period: %ld, duty: %ld\n",
+			  period_ns, duty_ns, prescale, period_cycles,
+			  duty_cycles);
+
+	writel(prescale - 1, pwm->regbase + SPMP8000_TMRB_PSR);
+	writel(period_cycles, pwm->regbase + SPMP8000_TMRB_LDR);
+	writel(duty_cycles, pwm->regbase + SPMP8000_TMRB_CMP);
+
+	return 0;
+}
+EXPORT_SYMBOL(pwm_config);
+
+int pwm_enable(struct pwm_device *pwm)
+{
+	writel(SPMP8000_TMRB_CTR_TE | SPMP8000_TMRB_CTR_OE |
+		SPMP8000_TMRB_CTR_PWMON | SPMP8000_TMRB_CTR_UD |
+		(1 << SPMP8000_TMRB_CTR_M_SH),
+		pwm->regbase + SPMP8000_TMRB_CTR);
+	return 0;
+}
+EXPORT_SYMBOL(pwm_enable);
+
+void pwm_disable(struct pwm_device *pwm)
+{
+	writel(0, pwm->regbase + SPMP8000_TMRB_CTR);
+}
+EXPORT_SYMBOL(pwm_disable);
+
+struct pwm_device *pwm_request(int pwm_id, const char *label)
+{
+	struct pwm_device *pwm;
+	int found = 0;
+
+	mutex_lock(&pwm_lock);
+
+	list_for_each_entry(pwm, &pwm_list, node) {
+		if (pwm->pwm_id == pwm_id) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (found) {
+		if (pwm->use_count == 0) {
+			pwm->use_count++;
+			pwm->label = label;
+		} else {
+			pwm = ERR_PTR(-EBUSY);
+		}
+	} else {
+		pwm = ERR_PTR(-ENOENT);
+	}
+
+	mutex_unlock(&pwm_lock);
+	return pwm;
+}
+EXPORT_SYMBOL(pwm_request);
+
+void pwm_free(struct pwm_device *pwm)
+{
+	mutex_lock(&pwm_lock);
+
+	if (pwm->use_count) {
+		pwm->use_count--;
+		pwm->label = NULL;
+	} else {
+		pr_warning("PWM device already freed\n");
+	}
+
+	mutex_unlock(&pwm_lock);
+}
+EXPORT_SYMBOL(pwm_free);
+
+static inline void __add_pwm(struct pwm_device *pwm)
+{
+	mutex_lock(&pwm_lock);
+	list_add_tail(&pwm->node, &pwm_list);
+	mutex_unlock(&pwm_lock);
+}
+
+static int __devinit pwm_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const unsigned int *id;
+	struct pwm_device *pwm;
+	void __iomem *base;
+	struct clk *clk;
+
+	id = of_get_property(np, "id", NULL);
+	if (!id) {
+		dev_dbg(&pdev->dev, "No id specified\n");
+		return -ENODEV;
+	}
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		dev_dbg(&pdev->dev, "Can't map registers");
+		return -ENOMEM;
+	}
+
+	clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_dbg(&pdev->dev, "Unable to get pwm device clock");
+		return -ENODEV;
+	}
+
+	pwm = kzalloc(sizeof(struct pwm_device), GFP_KERNEL);
+	if (pwm == NULL) {
+		dev_dbg(&pdev->dev, "failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	pwm->dev = &pdev->dev;
+	pwm->use_count = 0;
+	pwm->pwm_id = *id;
+	pwm->regbase = base;
+	pwm->clkrate = clk_get_rate(clk);
+
+	dev_dbg(&pdev->dev, "register pwm.%d, regbase %p, clkrate: %ld\n",
+		pwm->pwm_id, pwm->regbase, pwm->clkrate);
+
+	dev_info(&pdev->dev, "pwm %d registered\n", pwm->pwm_id);
+
+	__add_pwm(pwm);
+
+	platform_set_drvdata(pdev, pwm);
+	return 0;
+}
+
+static int __devexit pwm_remove(struct platform_device *pdev)
+{
+	struct pwm_device *pwm;
+
+	pwm = platform_get_drvdata(pdev);
+	if (pwm == NULL)
+		return -ENODEV;
+
+	mutex_lock(&pwm_lock);
+	list_del(&pwm->node);
+	mutex_unlock(&pwm_lock);
+
+	kfree(pwm);
+	return 0;
+}
+
+static const __devinitconst struct of_device_id spmp8000_pwm_match[] = {
+	{
+		.compatible = "sunplus,spmp8000-pwm",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, spmp8000_pwm_match);
+
+static struct platform_driver pwm_driver = {
+	.driver		= {
+		.name	= "spmp8000-pwm",
+		.owner	= THIS_MODULE,
+		.of_match_table = spmp8000_pwm_match,
+	},
+	.probe		= pwm_probe,
+	.remove		= __devexit_p(pwm_remove),
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
+MODULE_AUTHOR("Zoltan Devai <zoss@devai.org>");
+MODULE_LICENSE("GPL");
-- 
1.7.4.1
