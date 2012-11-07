From: alban.bedel@avionic-design.de (Alban Bedel)
Date: Wed,  7 Nov 2012 17:30:28 +0100
Subject: [PATCH] pwm: lpc32xx - Add a driver for the motor PWM
Message-ID: <1352305828-25298-1-git-send-email-alban.bedel@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
---
 .../devicetree/bindings/pwm/lpc32xx-motor-pwm.txt  |   24 ++
 arch/arm/boot/dts/lpc32xx.dtsi                     |    7 +
 drivers/pwm/Kconfig                                |   10 +
 drivers/pwm/Makefile                               |    1 +
 drivers/pwm/pwm-lpc32xx-motor.c                    |  230 ++++++++++++++++++++
 5 files changed, 272 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/lpc32xx-motor-pwm.txt
 create mode 100644 drivers/pwm/pwm-lpc32xx-motor.c

diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-motor-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc32xx-motor-pwm.txt
new file mode 100644
index 0000000..e19b0a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/lpc32xx-motor-pwm.txt
@@ -0,0 +1,24 @@
+LPC32XX Motor PWM controller
+
+The LPC32xx motor PWMs have two output pin, A and B, with B=!A.
+Per default the output A should be used, if the output B is used the
+PWM polarity should be inverted using the linux,polarity property.
+
+Required properties:
+- compatible: should be "nxp,lpc3220-motor-pwm"
+- reg: physical base address and length of the controller's registers
+
+Optional properites:
+- linux,polarity: Bit mask of the polarity to use for each output,
+      a bit set to 0 indicate the default polarity, a bit set to 1
+      indicate an inverted polarity. In other word this set if output
+      A or output B has the correct polarity.
+
+Examples:
+
+mpwm at 400e8000 {
+	compatible = "nxp,lpc3220-motor-pwm";
+	reg = <0x400E8000 0x78>;
+	linux,polarity = 5; /* Use outputs B0, A1 and B2 */
+	#pwm-cells = <2>;
+};
diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index ef0fdc7..a1e6a9b 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -182,6 +182,13 @@
 				pnx,timeout = <0x64>;
 			};
 
+			mpwm: mpwm at 400E8000 {
+				compatible = "nxp,lpc3220-motor-pwm";
+				reg = <0x400E8000 0x78>;
+				status = "disabled";
+				#pwm-cells = <2>;
+			};
+
 			i2cusb: i2c at 31020300 {
 				compatible = "nxp,pnx-i2c";
 				reg = <0x31020300 0x100>;
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 90c5c73..90fc167 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -57,6 +57,16 @@ config PWM_LPC32XX
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-lpc32xx.
 
+config PWM_LPC32XX_MOTOR
+	tristate "LPC32XX Motor PWM support"
+	depends on ARCH_LPC32XX
+	help
+	  Generic PWM framework driver for LPC32XX motor PWM. The LPC32XX SOC
+	  has one motor PWM controllers.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-motor-lpc32xx.
+
 config PWM_MXS
 	tristate "Freescale MXS PWM support"
 	depends on ARCH_MXS && OF
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index e4b2c89..510bad8 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_PWM)		+= core.o
 obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
 obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
 obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
+obj-$(CONFIG_PWM_LPC32XX_MOTOR)	+= pwm-lpc32xx-motor.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
diff --git a/drivers/pwm/pwm-lpc32xx-motor.c b/drivers/pwm/pwm-lpc32xx-motor.c
new file mode 100644
index 0000000..e1b4d46
--- /dev/null
+++ b/drivers/pwm/pwm-lpc32xx-motor.c
@@ -0,0 +1,230 @@
+/*
+ * Copyright 2012 Alban Bedel <alban.bedel@avionic-design.de>
+ *
+ * Based on pwm-lpc32xx.c from Alexandre Pereira da Silva
+ * <aletes.xgr@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+
+struct lpc32xx_motor_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	spinlock_t lock;
+	unsigned int clk_enabled;
+	unsigned int pins;
+	void __iomem *base;
+};
+
+#define to_lpc32xx_motor_pwm_chip(_chip) \
+	container_of(_chip, struct lpc32xx_motor_pwm_chip, chip)
+
+/* Register mapping for MCPWM modules */
+#define LPC32XX_MCPWM_MCCON		0x00
+#define LPC32XX_MCPWM_MCCON_SET		0x04
+#define LPC32XX_MCPWM_MCCON_CLR		0x08
+#define LPC32XX_MCPWM_MCCAPCON		0x0C
+#define LPC32XX_MCPWM_MCCAPCON_SET	0x10
+#define LPC32XX_MCPWM_MCCAPCON_CLR	0x14
+#define LPC32XX_MCPWM_MCLIM0		0x24
+#define LPC32XX_MCPWM_MCLIM1		0x28
+#define LPC32XX_MCPWM_MCLIM2		0x2C
+#define LPC32XX_MCPWM_MCMAT0		0x30
+#define LPC32XX_MCPWM_MCMAT1		0x34
+#define LPC32XX_MCPWM_MCMAT2		0x38
+#define LPC32XX_MCPWM_MCINTEN_CLR	0x58
+
+#define LPC32XX_MCPWM_COUNT		3
+
+#define PWM_EN_MASK(pwm)		BIT(0 + (pwm)->hwpwm*8)
+#define MCLIM_REG_OFFSET(pwm)		(LPC32XX_MCPWM_MCLIM0 + (pwm)->hwpwm*4)
+#define MCMAT_REG_OFFSET(pwm)		(LPC32XX_MCPWM_MCMAT0 + (pwm)->hwpwm*4)
+
+static int lpc32xx_motor_pwm_enable_clock(
+	struct lpc32xx_motor_pwm_chip *lpc32xx)
+{
+	int err = 0;
+	spin_lock(&lpc32xx->lock);
+	if (lpc32xx->clk_enabled == 0)
+		err = clk_enable(lpc32xx->clk);
+	lpc32xx->clk_enabled += 1;
+	spin_unlock(&lpc32xx->lock);
+	return err;
+}
+
+static void lpc32xx_motor_pwm_disable_clock(
+	struct lpc32xx_motor_pwm_chip *lpc32xx)
+{
+	spin_lock(&lpc32xx->lock);
+	if (lpc32xx->clk_enabled > 0) {
+		lpc32xx->clk_enabled -= 1;
+		if (lpc32xx->clk_enabled == 0)
+			clk_disable(lpc32xx->clk);
+	}
+	spin_unlock(&lpc32xx->lock);
+}
+
+static int lpc32xx_motor_pwm_config(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    int duty_ns, int period_ns)
+{
+	struct lpc32xx_motor_pwm_chip *lpc32xx =
+		to_lpc32xx_motor_pwm_chip(chip);
+	u64 rate, per, duty;
+	int err = 0;
+
+	/* The clock is needed to access the registers */
+	err = lpc32xx_motor_pwm_enable_clock(lpc32xx);
+	if (err)
+		return err;
+
+	/* Calculate period */
+	rate = clk_get_rate(lpc32xx->clk);
+	per  = (u64)period_ns * rate;
+	duty = (u64)duty_ns * rate;
+	do_div(per,  1000000000);
+	do_div(duty, 1000000000);
+
+	/* Write to limit register -> period */
+	__raw_writel(per, lpc32xx->base + MCLIM_REG_OFFSET(pwm));
+
+	/* Write to match register -> duty */
+	__raw_writel(per - duty, lpc32xx->base + MCMAT_REG_OFFSET(pwm));
+
+	/* Disable the clock now that we are done */
+	lpc32xx_motor_pwm_disable_clock(lpc32xx);
+	return 0;
+}
+
+static int lpc32xx_motor_pwm_enable(struct pwm_chip *chip,
+				    struct pwm_device *pwm)
+{
+	struct lpc32xx_motor_pwm_chip *lpc32xx =
+		to_lpc32xx_motor_pwm_chip(chip);
+	int err;
+
+	err = lpc32xx_motor_pwm_enable_clock(lpc32xx);
+	if (err)
+		return err;
+
+	__raw_writel(PWM_EN_MASK(pwm), lpc32xx->base + LPC32XX_MCPWM_MCCON_SET);
+
+	return 0;
+}
+
+static void lpc32xx_motor_pwm_disable(struct pwm_chip *chip,
+				      struct pwm_device *pwm)
+{
+	struct lpc32xx_motor_pwm_chip *lpc32xx =
+		to_lpc32xx_motor_pwm_chip(chip);
+
+	__raw_writel(PWM_EN_MASK(pwm), lpc32xx->base + LPC32XX_MCPWM_MCCON_CLR);
+
+	lpc32xx_motor_pwm_disable_clock(lpc32xx);
+}
+
+static const struct pwm_ops lpc32xx_motor_pwm_ops = {
+	.config = lpc32xx_motor_pwm_config,
+	.enable = lpc32xx_motor_pwm_enable,
+	.disable = lpc32xx_motor_pwm_disable,
+	.owner = THIS_MODULE,
+};
+
+static int lpc32xx_motor_pwm_probe(struct platform_device *pdev)
+{
+	struct lpc32xx_motor_pwm_chip *lpc32xx;
+	struct resource *res;
+	int ret;
+
+	lpc32xx = devm_kzalloc(&pdev->dev, sizeof(*lpc32xx), GFP_KERNEL);
+	if (!lpc32xx)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	lpc32xx->base = devm_request_and_ioremap(&pdev->dev, res);
+	if (!lpc32xx->base)
+		return -EADDRNOTAVAIL;
+
+	lpc32xx->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(lpc32xx->clk))
+		return PTR_ERR(lpc32xx->clk);
+
+	spin_lock_init(&lpc32xx->lock);
+
+	/* Configure the pins polarity */
+	ret = of_property_read_u32(pdev->dev.of_node, "linux,polarity",
+				   &lpc32xx->pins);
+	if (!ret) {
+		u32 set = 0, clr = 0;
+		int i;
+		for (i = 0 ; i < LPC32XX_MCPWM_COUNT ; i += 1)
+			if (lpc32xx->pins & BIT(i))
+				set |= BIT(2 + i*8);
+			else
+				clr |= BIT(2 + i*8);
+		__raw_writel(set, lpc32xx->base + LPC32XX_MCPWM_MCCON_SET);
+		__raw_writel(clr, lpc32xx->base + LPC32XX_MCPWM_MCCON_CLR);
+	}
+
+	lpc32xx->chip.dev = &pdev->dev;
+	lpc32xx->chip.ops = &lpc32xx_motor_pwm_ops;
+	lpc32xx->chip.npwm = LPC32XX_MCPWM_COUNT;
+	lpc32xx->chip.base = -1;
+
+	ret = pwmchip_add(&lpc32xx->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to add PWM chip, error %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, lpc32xx);
+
+	return 0;
+}
+
+static int __devexit lpc32xx_motor_pwm_remove(struct platform_device *pdev)
+{
+	struct lpc32xx_motor_pwm_chip *lpc32xx = platform_get_drvdata(pdev);
+
+	clk_disable(lpc32xx->clk);
+	return pwmchip_remove(&lpc32xx->chip);
+}
+
+static const struct of_device_id lpc32xx_motor_pwm_dt_ids[] __devinitconst = {
+	{ .compatible = "nxp,lpc3220-motor-pwm", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, lpc32xx_motor_pwm_dt_ids);
+
+static struct platform_driver lpc32xx_motor_pwm_driver = {
+	.driver = {
+		.name = "lpc32xx-motor-pwm",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(lpc32xx_motor_pwm_dt_ids),
+	},
+	.probe = lpc32xx_motor_pwm_probe,
+	.remove = __devexit_p(lpc32xx_motor_pwm_remove),
+};
+module_platform_driver(lpc32xx_motor_pwm_driver);
+
+MODULE_ALIAS("platform:lpc32xx-motor-pwm");
+MODULE_AUTHOR("Alban Bedel <alban.bedel@avionic-design.de>");
+MODULE_DESCRIPTION("LPC32XX Motor PWM Driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.0.4
