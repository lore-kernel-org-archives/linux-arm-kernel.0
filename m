From: dmitry_eremin@mentor.com (Dmitry Eremin-Solenikov)
Date: Fri,  1 Nov 2013 14:52:11 +0400
Subject: [PATCH 4/4] ARM: sa1100: switch to COMMON_CLK framework
In-Reply-To: <1383303131-29550-1-git-send-email-dmitry_eremin@mentor.com>
References: <1383303131-29550-1-git-send-email-dmitry_eremin@mentor.com>
Message-ID: <1383303131-29550-4-git-send-email-dmitry_eremin@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement common clock framework support for SA-1100.

Signed-off-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
---
 arch/arm/Kconfig               |   2 +-
 arch/arm/mach-sa1100/clock.c   | 100 ----------------------------------
 arch/arm/mach-sa1100/generic.c |   2 +
 drivers/clk/Makefile           |   1 +
 drivers/clk/clk-sa1100.c       | 121 +++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/sa1100.h     |  14 +++++
 6 files changed, 139 insertions(+), 101 deletions(-)
 delete mode 100644 arch/arm/mach-sa1100/clock.c
 create mode 100644 drivers/clk/clk-sa1100.c
 create mode 100644 include/linux/clk/sa1100.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5c86d8a..b28e518 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -686,8 +686,8 @@ config ARCH_SA1100
 	select ARCH_MTD_XIP
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_SPARSEMEM_ENABLE
-	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select COMMON_CLK
 	select CPU_FREQ
 	select CPU_SA1100
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arm/mach-sa1100/clock.c b/arch/arm/mach-sa1100/clock.c
deleted file mode 100644
index 172ebd0..0000000
--- a/arch/arm/mach-sa1100/clock.c
+++ /dev/null
@@ -1,100 +0,0 @@
-/*
- *  linux/arch/arm/mach-sa1100/clock.c
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/list.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/string.h>
-#include <linux/clk.h>
-#include <linux/spinlock.h>
-#include <linux/mutex.h>
-#include <linux/io.h>
-#include <linux/clkdev.h>
-
-#include <mach/hardware.h>
-
-struct clkops {
-	void			(*enable)(struct clk *);
-	void			(*disable)(struct clk *);
-};
-
-struct clk {
-	const struct clkops	*ops;
-	unsigned int		enabled;
-};
-
-#define DEFINE_CLK(_name, _ops)				\
-struct clk clk_##_name = {				\
-		.ops	= _ops,				\
-	}
-
-static DEFINE_SPINLOCK(clocks_lock);
-
-static void clk_gpio27_enable(struct clk *clk)
-{
-	/*
-	 * First, set up the 3.6864MHz clock on GPIO 27 for the SA-1111:
-	 * (SA-1110 Developer's Manual, section 9.1.2.1)
-	 */
-	GAFR |= GPIO_32_768kHz;
-	GPDR |= GPIO_32_768kHz;
-	TUCR = TUCR_3_6864MHz;
-}
-
-static void clk_gpio27_disable(struct clk *clk)
-{
-	TUCR = 0;
-	GPDR &= ~GPIO_32_768kHz;
-	GAFR &= ~GPIO_32_768kHz;
-}
-
-int clk_enable(struct clk *clk)
-{
-	unsigned long flags;
-
-	if (clk) {
-		spin_lock_irqsave(&clocks_lock, flags);
-		if (clk->enabled++ == 0)
-			clk->ops->enable(clk);
-		spin_unlock_irqrestore(&clocks_lock, flags);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
-
-void clk_disable(struct clk *clk)
-{
-	unsigned long flags;
-
-	if (clk) {
-		WARN_ON(clk->enabled == 0);
-		spin_lock_irqsave(&clocks_lock, flags);
-		if (--clk->enabled == 0)
-			clk->ops->disable(clk);
-		spin_unlock_irqrestore(&clocks_lock, flags);
-	}
-}
-EXPORT_SYMBOL(clk_disable);
-
-const struct clkops clk_gpio27_ops = {
-	.enable		= clk_gpio27_enable,
-	.disable	= clk_gpio27_disable,
-};
-
-static DEFINE_CLK(gpio27, &clk_gpio27_ops);
-
-static struct clk_lookup sa11xx_clkregs[] = {
-	CLKDEV_INIT("sa1111.0", NULL, &clk_gpio27),
-	CLKDEV_INIT("sa1100-rtc", NULL, NULL),
-};
-
-static int __init sa11xx_clk_init(void)
-{
-	clkdev_add_table(sa11xx_clkregs, ARRAY_SIZE(sa11xx_clkregs));
-	return 0;
-}
-core_initcall(sa11xx_clk_init);
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index d4ea142..f35dd06 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -20,6 +20,7 @@
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
+#include <linux/clk/sa1100.h>
 
 #include <video/sa1100fb.h>
 
@@ -312,6 +313,7 @@ static struct platform_device *sa11x0_devices[] __initdata = {
 static int __init sa1100_init(void)
 {
 	pm_power_off = sa1100_power_off;
+	sa1100_clocks_init();
 	return platform_add_devices(sa11x0_devices, ARRAY_SIZE(sa11x0_devices));
 }
 
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index fe3121b..0d46402 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_ARCH_MMP)		+= mmp/
 endif
 obj-$(CONFIG_MACH_LOONGSON1)	+= clk-ls1x.o
 obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
+obj-$(CONFIG_ARCH_SA1100)	+= clk-sa1100.o
 obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
 obj-$(CONFIG_ARCH_U8500)	+= ux500/
 obj-$(CONFIG_ARCH_VT8500)	+= clk-vt8500.o
diff --git a/drivers/clk/clk-sa1100.c b/drivers/clk/clk-sa1100.c
new file mode 100644
index 0000000..b79d0f4
--- /dev/null
+++ b/drivers/clk/clk-sa1100.c
@@ -0,0 +1,121 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+
+#include <mach/hardware.h>
+
+enum {
+	osc32k768, osc3M6864,
+	gpio27_3M6864,
+	clk_max,
+};
+
+static struct clk *clks[clk_max];
+
+/*
+ * In reality it is a switch between 32k768 and 3M6864, driven on GPIO27,
+ * if it is enabled by GPIO Alternate function.
+ * However nobody uses 32k768 output (as it seems), so there is no point
+ * implementing it as a switch.
+ */
+static int gpio27_enabled;
+static int clk_gpio27_enable(struct clk_hw *hw)
+{
+	/*
+	 * First, set up the 3.6864MHz clock on GPIO 27 for the SA-1111:
+	 * (SA-1110 Developer's Manual, section 9.1.2.1)
+	 */
+	GAFR |= GPIO_32_768kHz;
+	GPDR |= GPIO_32_768kHz;
+	TUCR = TUCR_3_6864MHz;
+
+	gpio27_enabled = 1;
+	return 0;
+}
+
+static void clk_gpio27_disable(struct clk_hw *hw)
+{
+	gpio27_enabled = 0;
+	TUCR = 0;
+	GPDR &= ~GPIO_32_768kHz;
+	GAFR &= ~GPIO_32_768kHz;
+}
+
+static int clk_gpio27_is_enabled(struct clk_hw *hw)
+{
+	return gpio27_enabled;
+}
+
+static const struct clk_ops clk_gpio27_ops = {
+	.enable = clk_gpio27_enable,
+	.disable = clk_gpio27_disable,
+	.is_enabled = clk_gpio27_is_enabled,
+};
+
+static struct clk *clk_register_gpio27(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags)
+{
+	struct clk_hw *gpio27;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	/* allocate the gpio27 */
+	gpio27 = kzalloc(sizeof(struct clk_hw), GFP_KERNEL);
+	if (!gpio27) {
+		pr_err("%s: could not allocate gpio27d clk\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	init.name = name;
+	init.ops = &clk_gpio27_ops;
+	init.flags = flags | CLK_IS_BASIC;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+
+	/* struct clk_gpio27 assignments */
+	gpio27->init = &init;
+
+	clk = clk_register(dev, gpio27);
+
+	if (IS_ERR(clk))
+		kfree(gpio27);
+
+	return clk;
+}
+
+/* Fixed clocks on sa1100 */
+int __init sa1100_clocks_init(void)
+{
+	int i;
+
+	clks[osc32k768] = clk_register_fixed_rate(NULL, "osc32k768", NULL,
+			CLK_IS_ROOT, 32768);
+	clks[osc3M6864] = clk_register_fixed_rate(NULL, "osc3M6864", NULL,
+			CLK_IS_ROOT, 3686400);
+	clks[gpio27_3M6864] = clk_register_gpio27(NULL, "gpio27_3M6864",
+			"osc3M6864", 0);
+
+	clk_register_clkdev(clks[gpio27_3M6864], NULL, "sa1111.0");
+	clk_register_clkdev(clks[osc32k768], NULL, "sa1100-rtc");
+
+	for (i = 0; i < ARRAY_SIZE(clks); i++)
+		if (IS_ERR(clks[i])) {
+			pr_err("SA1100 clk %d: register failed with %ld\n",
+				i, PTR_ERR(clks[i]));
+			return PTR_ERR(clks[i]);
+		}
+
+	return 0;
+}
diff --git a/include/linux/clk/sa1100.h b/include/linux/clk/sa1100.h
new file mode 100644
index 0000000..497de03
--- /dev/null
+++ b/include/linux/clk/sa1100.h
@@ -0,0 +1,14 @@
+/*
+ * Copyright (C) 2013 Dmitry Eremin-Solenikov
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_CLK_SA1100_H
+#define __LINUX_CLK_SA1100_H
+
+int sa1100_clocks_init(void);
+
+#endif
-- 
1.8.4.rc3
