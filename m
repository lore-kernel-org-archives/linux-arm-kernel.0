From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon,  6 Feb 2012 16:19:41 +0100
Subject: [PATCH v2 06/10] pwm: Add NVIDIA Tegra SoC support
In-Reply-To: <1328541585-24642-1-git-send-email-thierry.reding@avionic-design.de>
References: <1328541585-24642-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1328541585-24642-7-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds a generic PWM framework driver for the PWFM controller
found on NVIDIA Tegra SoCs. The driver is based on code from the
Chromium kernel tree and was originally written by Gary King (NVIDIA)
and later modified by Simon Que (Chromium).

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v2:
  - set pwm_chip.dev field
  - rename clk_enb to enable
  - introduce NUM_PWM macro instead of hard-coding the number of PWM
    devices
  - update comment in tegra_pwm_config
  - fix coding-style for multi-line comments
  - use module_platform_driver
  - change license to GPL

 drivers/pwm/Kconfig     |   10 ++
 drivers/pwm/Makefile    |    1 +
 drivers/pwm/pwm-tegra.c |  266 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 277 insertions(+), 0 deletions(-)
 create mode 100644 drivers/pwm/pwm-tegra.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 93c1052..bda6f23 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -9,4 +9,14 @@ menuconfig PWM
 
 if PWM
 
+config PWM_TEGRA
+	tristate "NVIDIA Tegra PWM support"
+	depends on ARCH_TEGRA
+	help
+	  Generic PWM framework driver for the PWFM controller found on NVIDIA
+	  Tegra SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-tegra.
+
 endif
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 3469c3d..12300f5 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_PWM)		+= core.o
+obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
new file mode 100644
index 0000000..87ee350
--- /dev/null
+++ b/drivers/pwm/pwm-tegra.c
@@ -0,0 +1,266 @@
+/*
+ * drivers/pwm/pwm-tegra.c
+ *
+ * Tegra pulse-width-modulation controller driver
+ *
+ * Copyright (c) 2010, NVIDIA Corporation.
+ * Based on arch/arm/plat-mxc/pwm.c by Sascha Hauer <s.hauer@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pwm.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define PWM_ENABLE	(1 << 31)
+#define PWM_DUTY_WIDTH	8
+#define PWM_DUTY_SHIFT	16
+#define PWM_SCALE_WIDTH	13
+#define PWM_SCALE_SHIFT	0
+
+#define NUM_PWM 4
+
+struct tegra_pwm_chip {
+	struct pwm_chip		chip;
+	struct device		*dev;
+
+	struct clk		*clk;
+
+	int			enable[NUM_PWM];
+	void __iomem		*mmio_base;
+};
+
+static inline struct tegra_pwm_chip *to_tegra_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct tegra_pwm_chip, chip);
+}
+
+static inline int pwm_writel(struct tegra_pwm_chip *chip, unsigned int pwm,
+		unsigned long val)
+{
+	unsigned long offset = pwm << 4;
+	int rc;
+
+	rc = clk_enable(chip->clk);
+	if (WARN_ON(rc))
+		return rc;
+
+	writel(val, chip->mmio_base + offset);
+	clk_disable(chip->clk);
+
+	return 0;
+}
+
+static int tegra_pwm_config(struct pwm_chip *chip, unsigned int pwm,
+		int duty_ns, int period_ns)
+{
+	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
+	unsigned int num = pwm - chip->base;
+	unsigned long long c;
+	unsigned long rate, hz;
+	u32 val = 0;
+
+	/*
+	 * Convert from duty_ns / period_ns to a fixed number of duty
+	 * ticks per (1 << PWM_DUTY_WIDTH) cycles.
+	 */
+	c = duty_ns * ((1 << PWM_DUTY_WIDTH) - 1);
+	do_div(c, period_ns);
+
+	val = (u32)c << PWM_DUTY_SHIFT;
+
+	/*
+	 * Compute the prescaler value for which (1 << PWM_DUTY_WIDTH)
+	 * cycles@the PWM clock rate will take period_ns nanoseconds.
+	 */
+	rate = clk_get_rate(pc->clk) >> PWM_DUTY_WIDTH;
+	hz = 1000000000ul / period_ns;
+
+	rate = (rate + (hz / 2)) / hz;
+
+	/*
+	 * Since the actual PWM divider is the register's frequency divider
+	 * field minus 1, we need to decrement to get the correct value to
+	 * write to the register.
+	 */
+	if (rate > 0)
+		rate--;
+
+	/*
+	 * Make sure that the rate will fit in the register's frequency
+	 * divider field.
+	 */
+	if (rate >> PWM_SCALE_WIDTH)
+		return -EINVAL;
+
+	val |= (rate << PWM_SCALE_SHIFT);
+
+	/* If the PWM channel is enabled, keep it enabled */
+	if (pc->enable[num])
+		val |= PWM_ENABLE;
+
+	return pwm_writel(pc, num, val);
+}
+
+static int tegra_pwm_enable(struct pwm_chip *chip, unsigned int pwm)
+{
+	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
+	unsigned int num = pwm - chip->base;
+	int rc = 0;
+
+	if (!pc->enable[num]) {
+		rc = clk_enable(pc->clk);
+		if (!rc) {
+			unsigned long offset = num << 4;
+			u32 val;
+
+			val = readl(pc->mmio_base + offset);
+			val |= PWM_ENABLE;
+			writel(val, pc->mmio_base + offset);
+
+			pc->enable[num] = 1;
+		}
+	}
+
+	return 0;
+}
+
+static void tegra_pwm_disable(struct pwm_chip *chip, unsigned int pwm)
+{
+	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
+	unsigned int num = pwm - chip->base;
+
+	if (pc->enable[num]) {
+		unsigned long offset = num << 4;
+		u32 val;
+
+		val = readl(pc->mmio_base + offset);
+		val &= ~PWM_ENABLE;
+		writel(val, pc->mmio_base + offset);
+
+		clk_disable(pc->clk);
+		pc->enable[num] = 0;
+	}
+}
+
+static struct pwm_ops tegra_pwm_ops = {
+	.config = tegra_pwm_config,
+	.enable = tegra_pwm_enable,
+	.disable = tegra_pwm_disable,
+	.owner = THIS_MODULE,
+};
+
+static int tegra_pwm_probe(struct platform_device *pdev)
+{
+	struct tegra_pwm_chip *pwm;
+	struct resource *r;
+	int ret;
+
+	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm) {
+		dev_err(&pdev->dev, "failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	pwm->dev = &pdev->dev;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		dev_err(&pdev->dev, "no memory resources defined\n");
+		return -ENODEV;
+	}
+
+	r = devm_request_mem_region(&pdev->dev, r->start, resource_size(r),
+			pdev->name);
+	if (!r) {
+		dev_err(&pdev->dev, "failed to request memory\n");
+		return -EBUSY;
+	}
+
+	pwm->mmio_base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
+	if (!pwm->mmio_base) {
+		dev_err(&pdev->dev, "failed to ioremap() region\n");
+		return -ENODEV;
+	}
+
+	platform_set_drvdata(pdev, pwm);
+
+	pwm->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(pwm->clk))
+		return PTR_ERR(pwm->clk);
+
+	pwm->chip.dev = &pdev->dev;
+	pwm->chip.ops = &tegra_pwm_ops;
+	pwm->chip.base = -1;
+	pwm->chip.npwm = NUM_PWM;
+
+	ret = pwmchip_add(&pwm->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
+		clk_put(pwm->clk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __devexit tegra_pwm_remove(struct platform_device *pdev)
+{
+	struct tegra_pwm_chip *pwm = platform_get_drvdata(pdev);
+	int i;
+
+	if (WARN_ON(!pwm))
+		return -ENODEV;
+
+	pwmchip_remove(&pwm->chip);
+
+	for (i = 0; i < NUM_PWM; i++) {
+		pwm_writel(pwm, i, 0);
+
+		if (pwm->enable[i])
+			clk_disable(pwm->clk);
+	}
+
+	clk_put(pwm->clk);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static struct of_device_id tegra_pwm_of_match[] = {
+	{ .compatible = "nvidia,tegra20-pwm" },
+	{ }
+};
+#endif
+
+static struct platform_driver tegra_pwm_driver = {
+	.driver		= {
+		.name		= "tegra-pwm",
+		.of_match_table	= of_match_ptr(tegra_pwm_of_match),
+	},
+	.probe		= tegra_pwm_probe,
+	.remove		= __devexit_p(tegra_pwm_remove),
+};
+
+module_platform_driver(tegra_pwm_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("NVIDIA Corporation");
-- 
1.7.9
