From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 04 Apr 2013 18:37:01 +0200
Subject: [PATCH v4 04/14] mfd: Add Samsung PWM/timer master driver
In-Reply-To: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
References: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
Message-ID: <1365093431-30621-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds master driver for PWM/timer block available on many
Samsung SoCs providing clocksource and PWM output capabilities.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../devicetree/bindings/pwm/pwm-samsung.txt        |  37 ++
 drivers/clocksource/Kconfig                        |   1 +
 drivers/mfd/Kconfig                                |   3 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/samsung-pwm.c                          | 439 +++++++++++++++++++++
 drivers/pwm/Kconfig                                |   1 +
 include/linux/mfd/samsung-pwm.h                    |  49 +++
 include/linux/platform_data/samsung-pwm.h          |  28 ++
 8 files changed, 559 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-samsung.txt
 create mode 100644 drivers/mfd/samsung-pwm.c
 create mode 100644 include/linux/mfd/samsung-pwm.h
 create mode 100644 include/linux/platform_data/samsung-pwm.h

diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
new file mode 100644
index 0000000..8ed4c11
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
@@ -0,0 +1,37 @@
+* Samsung PWM timers
+
+Samsung SoCs contain PWM timer blocks which can be used for system clock source
+and clock event timers, as well as to drive SoC outputs with PWM signal. Each
+PWM timer block provides 5 PWM channels (not all of them can drive physical
+outputs - see SoC and board manual).
+
+Be aware that this driver supports clock event only on CPU 0. It can
+provide SMP support together with ARM dummy_timer, but only in periodic tick
+mode.
+
+Required properties:
+- compatible : should be one of following:
+    samsung,s3c2410-pwm - for 16-bit timers present on S3C24xx SoCs
+    samsung,s3c6400-pwm - for 32-bit timers present on S3C64xx SoCs
+    samsung,s5p6440-pwm - for 32-bit timers present on S5P64x0 SoCs
+    samsung,s5pc100-pwm - for 32-bit timers present on S5PC100, S5PV210,
+			  Exynos4210, Exynos4x12 and Exynos5250 SoCs
+- reg: base address and size of register area
+- interrupts: list of timer interrupts (one interrupt per timer, starting at
+  timer 0)
+- #pwm-cells: number of cells used for PWM specifier - must be 2
+
+Optional properties:
+- samsung,pwm-outputs: list of PWM channels used as PWM outputs on particular
+    platform - an array of up to 5 elements being indices of PWM channels
+    (from 0 to 4), the order does not matter.
+
+Example:
+	pwm at 7f006000 {
+		compatible = "samsung,s3c6400-pwm";
+		reg = <0x7f006000 0x1000>;
+		interrupt-parent = <&vic0>;
+		interrupts = <23>, <24>, <25>, <27>, <28>;
+		samsung,pwm-outputs = <0>, <1>;
+		#pwm-cells = <2>;
+	}
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index dd20f6a..a69a5b7 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -29,6 +29,7 @@ config SAMSUNG_HRT
 	bool
 	depends on PLAT_SAMSUNG
 	select SAMSUNG_DEV_PWM
+	select MFD_SAMSUNG_PWM
 	help
 	  Use the high resolution timer support on Samsung platforms.
 
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3ab3a11..c25425c 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1015,6 +1015,9 @@ config MFD_PM8XXX_IRQ
 	  This is required to use certain other PM 8xxx features, such as GPIO
 	  and MPP.
 
+config MFD_SAMSUNG_PWM
+	bool
+
 config TPS65911_COMPARATOR
 	tristate
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index b90409c..513d9c9 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -145,6 +145,7 @@ obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
 obj-$(CONFIG_MFD_SEC_CORE)	+= sec-core.o sec-irq.o
 obj-$(CONFIG_MFD_SYSCON)	+= syscon.o
 obj-$(CONFIG_MFD_LM3533)	+= lm3533-core.o lm3533-ctrlbank.o
+obj-$(CONFIG_MFD_SAMSUNG_PWM)	+= samsung-pwm.o
 obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o vexpress-sysreg.o
 obj-$(CONFIG_MFD_RETU)		+= retu-mfd.o
 obj-$(CONFIG_MFD_AS3711)	+= as3711.o
diff --git a/drivers/mfd/samsung-pwm.c b/drivers/mfd/samsung-pwm.c
new file mode 100644
index 0000000..ece426e
--- /dev/null
+++ b/drivers/mfd/samsung-pwm.c
@@ -0,0 +1,439 @@
+/*
+ * Samsung PWM/timers MFD driver
+ *
+ * Copyright (C) 2013 Samsung Electronics Co., Ltd.
+ *
+ * Author: Tomasz Figa <t.figa@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/list.h>
+#include <linux/mfd/samsung-pwm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/platform_data/samsung-pwm.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#define REG_TCFG0			0x00
+#define REG_TCFG1			0x04
+#define REG_TCON			0x08
+
+#define REG_TCNTB(chan)			(0x0c + 12 * (chan))
+#define REG_TCMPB(chan)			(0x10 + 12 * (chan))
+
+#define TCON_START(chan)		(1 << (4 * (chan) + 0))
+#define TCON_MANUALUPDATE(chan)		(1 << (4 * (chan) + 1))
+#define TCON_INVERT(chan)		(1 << (4 * (chan) + 2))
+#define TCON_AUTORELOAD(chan)		(1 << (4 * (chan) + 3))
+
+#define TCFG0_PRESCALER_MASK		0xff
+#define TCFG0_PRESCALER1_SHIFT		8
+
+#define TCFG1_SHIFT(x)	  		((x) * 4)
+#define TCFG1_MUX_MASK	  		0xf
+
+struct samsung_pwm_drvdata {
+	struct samsung_pwm pwm;
+	struct platform_device *pdev;
+	struct resource resource;
+	struct list_head list;
+	spinlock_t slock;
+	unsigned long request_mask;
+};
+
+static LIST_HEAD(pwm_list);
+
+static inline struct samsung_pwm_drvdata *to_drvdata(struct samsung_pwm *pwm)
+{
+	return container_of(pwm, struct samsung_pwm_drvdata, pwm);
+}
+
+void samsung_pwm_start(struct samsung_pwm *pwm,
+					unsigned int channel, bool periodic)
+{
+	struct samsung_pwm_drvdata *drvdata = to_drvdata(pwm);
+	unsigned long flags;
+	u32 reg;
+
+	if (channel > 0)
+		++channel;
+
+	spin_lock_irqsave(&drvdata->slock, flags);
+
+	reg = readl(pwm->base + REG_TCON);
+	reg &= ~TCON_MANUALUPDATE(channel);
+	reg |= TCON_START(channel);
+	if (periodic)
+		reg |= TCON_AUTORELOAD(channel);
+	else
+		reg &= ~TCON_AUTORELOAD(channel);
+	writel(reg, pwm->base + REG_TCON);
+
+	spin_unlock_irqrestore(&drvdata->slock, flags);
+}
+EXPORT_SYMBOL(samsung_pwm_start);
+
+void samsung_pwm_stop(struct samsung_pwm *pwm, unsigned int channel)
+{
+	struct samsung_pwm_drvdata *drvdata = to_drvdata(pwm);
+	unsigned long flags;
+	u32 reg;
+
+	if (channel > 0)
+		++channel;
+
+	spin_lock_irqsave(&drvdata->slock, flags);
+
+	reg = readl(pwm->base + REG_TCON);
+	reg &= ~TCON_START(channel);
+	writel(reg, pwm->base + REG_TCON);
+
+	spin_unlock_irqrestore(&drvdata->slock, flags);
+}
+EXPORT_SYMBOL(samsung_pwm_stop);
+
+void samsung_pwm_setup(struct samsung_pwm *pwm, unsigned int channel,
+							u32 tcmp, u32 tcnt)
+{
+	struct samsung_pwm_drvdata *drvdata = to_drvdata(pwm);
+	unsigned long flags;
+	u32 reg;
+
+	writel(tcnt, pwm->base + REG_TCNTB(channel));
+	writel(tcmp, pwm->base + REG_TCMPB(channel));
+
+	if (channel > 0)
+		++channel;
+
+	spin_lock_irqsave(&drvdata->slock, flags);
+
+	reg = readl(pwm->base + REG_TCON);
+	reg &= ~TCON_START(channel);
+	reg |= TCON_MANUALUPDATE(channel);
+	writel(reg, pwm->base + REG_TCON);
+
+	spin_unlock_irqrestore(&drvdata->slock, flags);
+}
+EXPORT_SYMBOL(samsung_pwm_setup);
+
+void samsung_pwm_set_flags(struct samsung_pwm *pwm,
+					unsigned int channel, u32 pwm_flags)
+{
+	struct samsung_pwm_drvdata *drvdata = to_drvdata(pwm);
+	unsigned long flags;
+	u32 reg;
+
+	if (channel > 0)
+		++channel;
+
+	spin_lock_irqsave(&drvdata->slock, flags);
+
+	reg = readl(pwm->base + REG_TCON);
+
+	if (pwm_flags & SAMSUNG_PWM_INVERT)
+		reg |= TCON_INVERT(channel);
+	else
+		reg &= ~TCON_INVERT(channel);
+
+	writel(reg, pwm->base + REG_TCON);
+
+	spin_unlock_irqrestore(&drvdata->slock, flags);
+}
+EXPORT_SYMBOL(samsung_pwm_set_flags);
+
+void samsung_pwm_set_prescale(struct samsung_pwm *pwm,
+					unsigned int channel, u16 prescale)
+{
+	struct samsung_pwm_drvdata *drvdata = to_drvdata(pwm);
+	unsigned long flags;
+	u8 shift = 0;
+	u32 reg;
+
+	if (channel >= 2)
+		shift = TCFG0_PRESCALER1_SHIFT;
+
+	spin_lock_irqsave(&drvdata->slock, flags);
+
+	reg = readl(pwm->base + REG_TCFG0);
+	reg &= ~(TCFG0_PRESCALER_MASK << shift);
+	reg |= (prescale - 1) << shift;
+	writel(reg, pwm->base + REG_TCFG0);
+
+	spin_unlock_irqrestore(&drvdata->slock, flags);
+}
+EXPORT_SYMBOL(samsung_pwm_set_prescale);
+
+void samsung_pwm_set_divisor(struct samsung_pwm *pwm,
+					unsigned int channel, u8 divisor)
+{
+	struct samsung_pwm_drvdata *drvdata = to_drvdata(pwm);
+	u8 shift = TCFG1_SHIFT(channel);
+	unsigned long flags;
+	u32 reg;
+	u8 bits;
+
+	bits = (fls(divisor) - 1) - pwm->variant.div_base;
+
+	spin_lock_irqsave(&drvdata->slock, flags);
+
+	reg = readl(pwm->base + REG_TCFG1);
+	reg &= ~(TCFG1_MUX_MASK << shift);
+	reg |= bits << shift;
+	writel(reg, pwm->base + REG_TCFG1);
+
+	spin_unlock_irqrestore(&drvdata->slock, flags);
+}
+EXPORT_SYMBOL(samsung_pwm_set_divisor);
+
+int samsung_pwm_request(struct samsung_pwm *pwm, unsigned int channel)
+{
+	struct samsung_pwm_drvdata *drvdata = to_drvdata(pwm);
+
+	if (test_and_set_bit(channel, &drvdata->request_mask))
+		return -EBUSY;
+
+	return 0;
+}
+EXPORT_SYMBOL(samsung_pwm_request);
+
+void samsung_pwm_free(struct samsung_pwm *pwm, unsigned int channel)
+{
+	struct samsung_pwm_drvdata *drvdata = to_drvdata(pwm);
+
+	clear_bit(channel, &drvdata->request_mask);
+}
+EXPORT_SYMBOL(samsung_pwm_free);
+
+#ifdef CONFIG_OF
+static int samsung_pwm_parse_dt(struct samsung_pwm *pwm)
+{
+	struct samsung_pwm_variant *variant = &pwm->variant;
+	struct device_node *np = pwm->of_node;
+	struct property *prop;
+	const __be32 *cur;
+	u32 val;
+	int i;
+
+	for (i = 0; i < SAMSUNG_PWM_NUM; ++i)
+		pwm->irq[i] = irq_of_parse_and_map(np, i);
+
+	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, val) {
+		if (val >= SAMSUNG_PWM_NUM) {
+			pr_warning("%s: invalid channel index in samsung,pwm-outputs property\n",
+								__func__);
+			continue;
+		}
+		variant->output_mask |= 1 << val;
+	}
+
+	return 0;
+}
+
+static const struct samsung_pwm_variant s3c24xx_variant = {
+	.bits		= 16,
+	.div_base	= 1,
+	.has_tint_cstat	= false,
+	.tclk_mask	= (1 << 4),
+};
+
+static const struct samsung_pwm_variant s3c64xx_variant = {
+	.bits		= 32,
+	.div_base	= 0,
+	.has_tint_cstat	= true,
+	.tclk_mask	= (1 << 7) | (1 << 6) | (1 << 5),
+};
+
+static const struct samsung_pwm_variant s5p64x0_variant = {
+	.bits		= 32,
+	.div_base	= 0,
+	.has_tint_cstat	= true,
+	.tclk_mask	= 0,
+};
+
+static const struct samsung_pwm_variant s5p_variant = {
+	.bits		= 32,
+	.div_base	= 0,
+	.has_tint_cstat	= true,
+	.tclk_mask	= (1 << 5),
+};
+
+static const struct of_device_id samsung_pwm_matches[] = {
+	{ .compatible = "samsung,s3c2410-pwm", .data = &s3c24xx_variant, },
+	{ .compatible = "samsung,s3c6400-pwm", .data = &s3c64xx_variant, },
+	{ .compatible = "samsung,s5p6440-pwm", .data = &s5p64x0_variant, },
+	{ .compatible = "samsung,s5pc100-pwm", .data = &s5p_variant, },
+	{},
+};
+
+static struct samsung_pwm_drvdata *samsung_pwm_of_add(struct device_node *np)
+{
+	const struct samsung_pwm_variant *variant;
+	const struct of_device_id *match;
+	struct samsung_pwm_drvdata *pwm;
+	int ret;
+
+	if (!np) {
+		np = of_find_matching_node(NULL, samsung_pwm_matches);
+		if (!np) {
+			pr_err("%s: could not find PWM device\n", __func__);
+			return ERR_PTR(-ENODEV);
+		}
+	}
+
+	match = of_match_node(samsung_pwm_matches, np);
+	if (!match) {
+		pr_err("%s: failed to match given OF node\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+	variant = match->data;
+
+	pwm = kzalloc(sizeof(*pwm), GFP_KERNEL);
+	if (!pwm) {
+		pr_err("%s: could not allocate PWM device struct\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	pwm->pwm.variant = *variant;
+	pwm->pwm.of_node = np;
+	spin_lock_init(&pwm->slock);
+
+	ret = of_address_to_resource(np, 0, &pwm->resource);
+	if (ret < 0) {
+		pr_err("%s: could not get IO resource\n", __func__);
+		goto err_free;
+	}
+
+	ret = samsung_pwm_parse_dt(&pwm->pwm);
+	if (ret < 0) {
+		pr_err("%s: failed to parse device tree node\n", __func__);
+		goto err_free;
+	}
+
+	list_add_tail(&pwm->list, &pwm_list);
+
+	return pwm;
+
+err_free:
+	kfree(pwm);
+
+	return ERR_PTR(ret);
+}
+#else
+static struct samsung_pwm_drvdata *samsung_pwm_of_add(struct device_node *np)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif
+
+static struct samsung_pwm_drvdata *samsung_pwm_add(struct platform_device *pdev)
+{
+	struct samsung_pwm_variant *variant = pdev->dev.platform_data;
+	struct samsung_pwm_drvdata *pwm;
+	struct resource *res;
+	int i;
+
+	if (!variant) {
+		pr_err("%s: no platform data specified\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	pwm = kzalloc(sizeof(*pwm), GFP_KERNEL);
+	if (!pwm) {
+		pr_err("%s: could not allocate PWM device struct\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	pwm->pwm.variant = *variant;
+	pwm->pdev = pdev;
+	spin_lock_init(&pwm->slock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		pr_err("%s: could not get IO resource\n", __func__);
+		kfree(pwm);
+		return ERR_PTR(-EINVAL);
+	}
+	pwm->resource = *res;
+
+	for (i = 0; i < SAMSUNG_PWM_NUM; ++i)
+		pwm->pwm.irq[i] = platform_get_irq(pdev, i);
+
+	list_add_tail(&pwm->list, &pwm_list);
+
+	return pwm;
+}
+
+static struct samsung_pwm_drvdata *samsung_pwm_find(struct platform_device *pdev)
+{
+	struct samsung_pwm_drvdata *pwm;
+	struct device_node *np = NULL;
+
+	list_for_each_entry(pwm, &pwm_list, list) {
+		if (!pdev || pwm->pdev == pdev)
+			return pwm;
+		if (pdev->dev.of_node && pdev->dev.of_node == pwm->pwm.of_node)
+			return pwm;
+	}
+
+	if (pdev) {
+		np = pdev->dev.of_node;
+		if (!np)
+			return samsung_pwm_add(pdev);
+	}
+
+	return samsung_pwm_of_add(np);
+}
+
+struct samsung_pwm *samsung_pwm_get(struct platform_device *pdev)
+{
+	struct samsung_pwm_drvdata *pwm;
+	struct resource *res;
+
+	pwm = samsung_pwm_find(pdev);
+	if (IS_ERR(pwm)) {
+		pr_err("%s: failed to instantiate PWM device\n", __func__);
+		return &pwm->pwm;
+	}
+
+	if (pwm->pwm.base)
+		return &pwm->pwm;
+
+	res = request_mem_region(pwm->resource.start,
+				resource_size(&pwm->resource), "samsung-pwm");
+	if (!res) {
+		pr_err("%s: failed to request IO mem region\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	pwm->pwm.base = ioremap(res->start, resource_size(res));
+	if (!pwm->pwm.base) {
+		pr_err("%s: failed to map PWM registers\n", __func__);
+		release_mem_region(res->start, resource_size(res));
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return &pwm->pwm;
+}
+EXPORT_SYMBOL(samsung_pwm_get);
+
+int samsung_pwm_register(struct platform_device *pdev)
+{
+	struct samsung_pwm_drvdata *pwm;
+
+	pwm = samsung_pwm_add(pdev);
+	if (IS_ERR(pwm))
+		return PTR_ERR(pwm);
+
+	return 0;
+}
+EXPORT_SYMBOL(samsung_pwm_register);
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0e0bfa0..c80070b 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -118,6 +118,7 @@ config PWM_PXA
 config PWM_SAMSUNG
 	tristate "Samsung PWM support"
 	depends on PLAT_SAMSUNG
+	select MFD_SAMSUNG_PWM
 	help
 	  Generic PWM framework driver for Samsung.
 
diff --git a/include/linux/mfd/samsung-pwm.h b/include/linux/mfd/samsung-pwm.h
new file mode 100644
index 0000000..e54456e
--- /dev/null
+++ b/include/linux/mfd/samsung-pwm.h
@@ -0,0 +1,49 @@
+/*
+ * Samsung PWM/timers MFD driver
+ *
+ * Copyright (C) 2013 Samsung Electronics Co., Ltd.
+ *
+ * Author: Tomasz Figa <t.figa@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef MFD_SAMSUNG_PWM_H_
+#define MFD_SAMSUNG_PWM_H_
+
+#include <linux/platform_data/samsung-pwm.h>
+
+#define SAMSUNG_PWM_NUM		5
+
+#define SAMSUNG_PWM_INVERT	(1 << 0)
+
+struct platform_device;
+
+struct samsung_pwm {
+	struct samsung_pwm_variant variant;
+	struct device_node *of_node;
+	void __iomem *base;
+	int irq[SAMSUNG_PWM_NUM];
+};
+
+extern void samsung_pwm_start(struct samsung_pwm *pwm,
+					unsigned int channel, bool periodic);
+extern void samsung_pwm_stop(struct samsung_pwm *pwm, unsigned int channel);
+extern void samsung_pwm_setup(struct samsung_pwm *pwm, unsigned int channel,
+							u32 tcmp, u32 tcnt);
+
+extern void samsung_pwm_set_flags(struct samsung_pwm *pwm,
+					unsigned int channel, u32 flags);
+extern void samsung_pwm_set_prescale(struct samsung_pwm *pwm,
+					unsigned int channel, u16 prescale);
+extern void samsung_pwm_set_divisor(struct samsung_pwm *pwm,
+					unsigned int channel, u8 divisor);
+
+extern int samsung_pwm_request(struct samsung_pwm *pwm, unsigned int channel);
+extern void samsung_pwm_free(struct samsung_pwm *pwm, unsigned int channel);
+
+extern struct samsung_pwm *samsung_pwm_get(struct platform_device *pdev);
+
+#endif
diff --git a/include/linux/platform_data/samsung-pwm.h b/include/linux/platform_data/samsung-pwm.h
new file mode 100644
index 0000000..8c48dbb
--- /dev/null
+++ b/include/linux/platform_data/samsung-pwm.h
@@ -0,0 +1,28 @@
+/*
+ * Samsung PWM/timers driver
+ *
+ * Copyright (C) 2013 Samsung Electronics Co., Ltd.
+ *
+ * Author: Tomasz Figa <t.figa@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef PLATFORM_DATA_SAMSUNG_PWM_H_
+#define PLATFORM_DATA_SAMSUNG_PWM_H_
+
+struct platform_device;
+
+struct samsung_pwm_variant {
+	u8 bits;
+	u8 div_base;
+	u8 tclk_mask;
+	u8 output_mask;
+	bool has_tint_cstat;
+};
+
+extern int samsung_pwm_register(struct platform_device *pdev);
+
+#endif
-- 
1.8.1.5
