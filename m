From: denis@eukrea.com (Denis Carikli)
Date: Wed, 27 Nov 2013 16:39:29 +0100
Subject: =?UTF-8?q?=5BPATCH=201/3=5D=20pwm=3A=20Add=20mc13xxx=20pwm=20driver=2E?=
Message-ID: <1385566771-366-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: devicetree at vger.kernel.org
Cc: linux-pwm at vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 .../devicetree/bindings/pwm/fsl,mc13xxx-pwm.txt    |   19 ++
 drivers/mfd/mc13xxx-core.c                         |   11 ++
 drivers/pwm/Kconfig                                |    6 +
 drivers/pwm/Makefile                               |    1 +
 drivers/pwm/pwm-mc13xxx.c                          |  205 ++++++++++++++++++++
 include/linux/mfd/mc13783.h                        |    2 +
 6 files changed, 244 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/fsl,mc13xxx-pwm.txt
 create mode 100644 drivers/pwm/pwm-mc13xxx.c

diff --git a/Documentation/devicetree/bindings/pwm/fsl,mc13xxx-pwm.txt b/Documentation/devicetree/bindings/pwm/fsl,mc13xxx-pwm.txt
new file mode 100644
index 0000000..a1394d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/fsl,mc13xxx-pwm.txt
@@ -0,0 +1,19 @@
+Freescale mc13xxx series PWM drivers.
+
+Supported PWMs:
+mc13892 series
+mc34708 series
+
+Required properties:
+- compatible: "fsl,mc13892-pwm" or "fsl,mc34708-pwm"
+- mfd: phandle to mc13xxx mfd node.
+- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
+  the cells format.
+
+Example:
+
+mc13xxx_pwm: pwm {
+	compatible = "fsl,mc34708-pwm";
+	mfd = <&pmic>;
+	#pwm-cells = <2>;
+};
diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index dbbf8ee..e250f16 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -133,6 +133,8 @@
 
 #define MC13XXX_ADC2		45
 
+struct mc13xxx *mc13xxx_data;
+
 void mc13xxx_lock(struct mc13xxx *mc13xxx)
 {
 	if (!mutex_trylock(&mc13xxx->lock)) {
@@ -639,6 +641,12 @@ static inline int mc13xxx_probe_flags_dt(struct mc13xxx *mc13xxx)
 }
 #endif
 
+struct mc13xxx *get_mc13xxx(void)
+{
+	return mc13xxx_data;
+}
+EXPORT_SYMBOL_GPL(get_mc13xxx);
+
 int mc13xxx_common_init(struct mc13xxx *mc13xxx,
 		struct mc13xxx_platform_data *pdata, int irq)
 {
@@ -706,6 +714,9 @@ err_revision:
 		mc13xxx_add_subdevice(mc13xxx, "%s-pwrbutton");
 	}
 
+	/* Linux will not have to handle more than one mc13xxx pmic. */
+	mc13xxx_data = mc13xxx;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mc13xxx_common_init);
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index eece329..a959ecd 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -100,6 +100,12 @@ config PWM_LPC32XX
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-lpc32xx.
 
+config PWM_MC13XXX
+	tristate "MC13XXX PWM support"
+	depends on MFD_MC13XXX
+	help
+	  Generic PWM framework driver for Freescale MC13XXX pmic.
+
 config PWM_MXS
 	tristate "Freescale MXS PWM support"
 	depends on ARCH_MXS && OF
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 8b754e4..19f67d7 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
 obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
 obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
 obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
+obj-$(CONFIG_PWM_MC13XXX)	+= pwm-mc13xxx.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
 obj-$(CONFIG_PWM_PUV3)		+= pwm-puv3.o
diff --git a/drivers/pwm/pwm-mc13xxx.c b/drivers/pwm/pwm-mc13xxx.c
new file mode 100644
index 0000000..e60e4d8
--- /dev/null
+++ b/drivers/pwm/pwm-mc13xxx.c
@@ -0,0 +1,205 @@
+/*
+ * Copyright 2013 Eukr?a Electromatique <denis@eukrea.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+
+#include <linux/err.h>
+#include <linux/mfd/mc13783.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+
+#define MHz(x) (1000*1000*x)
+
+#define MC13XXX_REG_PWM_CTL		55
+#define MC13XXX_BASE_CLK_FREQ		(MHz(2) / 32)
+#define MC13XXX_PWM1CLKDIV_SHIFT	6
+#define MC13XXX_PWM2DUTY_SHIFT		12
+#define MC13XXX_PWMDUTYDIVISOR		32
+#define MC13XXX_PWMCLKDIVISOR		64
+#define MC13XXX_PWM_REG_SIZE		0x3f
+#define MC13XXX_MIN_PERIOD_NS		(NSEC_PER_SEC / MC13XXX_BASE_CLK_FREQ)
+#define MC13XXX_MAX_PERIOD_NS		(MC13XXX_PWMCLKDIVISOR * MC13XXX_MIN_PERIOD_NS)
+
+struct mc13xxx_pwm_chip {
+	struct pwm_chip pwm_chip;
+	struct mc13xxx *mcdev;
+};
+
+static inline
+struct mc13xxx_pwm_chip *to_mc13xxx_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct mc13xxx_pwm_chip, pwm_chip);
+}
+
+static int pwm_mc13xxx_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			      int duty_ns, int period_ns)
+{
+	struct mc13xxx_pwm_chip *mc13xxx_chip = to_mc13xxx_chip(chip);
+	struct mc13xxx *mcdev = mc13xxx_chip->mcdev;
+	struct device *dev =  mc13xxx_chip->pwm_chip.dev;
+	u32 offset;
+	u32 mask = MC13XXX_PWM_REG_SIZE;
+	u32 val;
+	int ret;
+	int duty_cycle;
+	int min_duty_cycle;
+	int period_cycle;
+	unsigned long period = period_ns;
+
+	dev_dbg(dev, "requested duty_ns=%d and period_ns=%d\n",
+		duty_ns, period_ns);
+
+	/* period */
+	if (period < MC13XXX_MIN_PERIOD_NS) {
+		dev_warn(dev, "period was under the range.\n");
+		period = MC13XXX_MIN_PERIOD_NS;
+	}
+
+	if (period > MC13XXX_MAX_PERIOD_NS) {
+		dev_warn(dev, "period was over the range.\n");
+		period = MC13XXX_MAX_PERIOD_NS;
+	}
+
+	period_cycle = DIV_ROUND_UP(NSEC_PER_SEC, period);
+	period_cycle = DIV_ROUND_UP(MC13XXX_BASE_CLK_FREQ, period_cycle);
+	period_cycle--;
+
+	offset = MC13XXX_REG_PWM_CTL + pwm->hwpwm * MC13XXX_PWM2DUTY_SHIFT +
+		MC13XXX_PWM1CLKDIV_SHIFT;
+
+	mc13xxx_lock(mcdev);
+	ret = mc13xxx_reg_read(mcdev, offset, &val);
+	val &= ~mask;
+	val += (period_cycle & mask);
+	ret = mc13xxx_reg_write(mcdev, offset, val);
+	mc13xxx_unlock(mcdev);
+
+	/* duty cycle */
+	min_duty_cycle = DIV_ROUND_UP(period, 32);
+
+	if (duty_ns < min_duty_cycle) {
+		dev_warn(dev, "duty cycle is under the range.\n");
+		duty_cycle = 0;
+	} else if (duty_ns > period) {
+		dev_warn(dev, "duty cycle is over the range.\n");
+		duty_cycle = 32;
+	} else {
+		duty_cycle = 32 * period;
+		duty_cycle = DIV_ROUND_UP(period, duty_ns);
+		duty_cycle--;
+		duty_cycle = 32 - duty_cycle;
+	}
+
+	offset = MC13XXX_REG_PWM_CTL + pwm->hwpwm * MC13XXX_PWM2DUTY_SHIFT;
+
+	mc13xxx_lock(mcdev);
+	ret = mc13xxx_reg_read(mcdev, offset, &val);
+	val &= ~mask;
+	val += (duty_cycle & mask);
+	ret = mc13xxx_reg_write(mcdev, offset, val);
+	mc13xxx_unlock(mcdev);
+
+	return 0;
+}
+
+static int pwm_mc13xxx_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	/* The hardware doesn't need an enable */
+
+	return 0;
+}
+
+static void pwm_mc13xxx_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	/* The hardware doesn't need a disable */
+}
+
+static const struct pwm_ops pwm_mc13xxx_ops = {
+	.enable		= pwm_mc13xxx_enable,
+	.disable	= pwm_mc13xxx_disable,
+	.config		= pwm_mc13xxx_config,
+	.owner		= THIS_MODULE,
+};
+
+static int pwm_mc13xxx_probe(struct platform_device *pdev)
+{
+	struct mc13xxx_pwm_chip *chip;
+	struct mc13xxx *mcdev;
+	int err;
+
+	mcdev = get_mc13xxx();
+	if (!mcdev) {
+		dev_err(&pdev->dev, "failed to find mc13xxx pmic.\n");
+		return -EINVAL;
+	}
+
+	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
+	if (chip == NULL) {
+		dev_err(&pdev->dev, "failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	chip->pwm_chip.dev = &pdev->dev;
+	chip->pwm_chip.ops = &pwm_mc13xxx_ops;
+	chip->pwm_chip.base = pdev->id;
+	chip->pwm_chip.npwm = 2;
+	chip->mcdev = mcdev;
+
+	err = pwmchip_add(&chip->pwm_chip);
+	if (err < 0)
+		return err;
+
+	platform_set_drvdata(pdev, chip);
+
+	return 0;
+}
+
+static int pwm_mc13xxx_remove(struct platform_device *pdev)
+{
+	struct mc13xxx_pwm_chip *chip = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = pwmchip_remove(&chip->pwm_chip);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id pwm_mc13xxx_of_match[] = {
+	{ .compatible = "fsl,mc13892-pwm" },
+	{ .compatible = "fsl,mc34708-pwm" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, pwm_mc13xxx_of_match);
+#endif
+
+static struct platform_driver pwm_mc13xxx_driver = {
+	.driver		= {
+		.name	= "mc13xxx-pwm",
+		.of_match_table = of_match_ptr(pwm_mc13xxx_of_match),
+		.owner	= THIS_MODULE,
+	},
+	.probe		= pwm_mc13xxx_probe,
+	.remove		= pwm_mc13xxx_remove,
+};
+
+module_platform_driver(pwm_mc13xxx_driver);
+
+MODULE_AUTHOR("Denis Carikli <denis@eukrea.com>");
+MODULE_DESCRIPTION("mc13xxx Pulse Width Modulation Driver");
+MODULE_ALIAS("platform:mc13xxx-pwm");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/mc13783.h b/include/linux/mfd/mc13783.h
index a8eeda7..ec934e8 100644
--- a/include/linux/mfd/mc13783.h
+++ b/include/linux/mfd/mc13783.h
@@ -88,4 +88,6 @@
 #define MC13783_IRQ_AHSSHORT	45
 #define MC13783_NUM_IRQ		MC13XXX_NUM_IRQ
 
+struct mc13xxx *get_mc13xxx(void);
+
 #endif /* ifndef __LINUX_MFD_MC13783_H */
-- 
1.7.9.5
