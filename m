From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 28 Feb 2013 15:19:22 +0800
Subject: [PATCH 3/7] ARM: hs: add board support with device tree
In-Reply-To: <1362035966-17628-1-git-send-email-haojian.zhuang@linaro.org>
References: <1362035966-17628-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1362035966-17628-3-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add board support with device tree for Hisilicon Hi36xx/Hi37xx platform.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/Kconfig          |    2 ++
 arch/arm/Makefile         |    1 +
 arch/arm/mach-hs/Kconfig  |   23 +++++++++++++
 arch/arm/mach-hs/Makefile |    5 +++
 arch/arm/mach-hs/hs-dt.c  |   83 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 114 insertions(+)
 create mode 100644 arch/arm/mach-hs/Kconfig
 create mode 100644 arch/arm/mach-hs/Makefile
 create mode 100644 arch/arm/mach-hs/hs-dt.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index dedf02b..dfe70aa 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1055,6 +1055,8 @@ source "arch/arm/mach-h720x/Kconfig"
 
 source "arch/arm/mach-highbank/Kconfig"
 
+source "arch/arm/mach-hs/Kconfig"
+
 source "arch/arm/mach-integrator/Kconfig"
 
 source "arch/arm/mach-iop32x/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index ee4605f..08a913b 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -149,6 +149,7 @@ machine-$(CONFIG_ARCH_EP93XX)		+= ep93xx
 machine-$(CONFIG_ARCH_GEMINI)		+= gemini
 machine-$(CONFIG_ARCH_H720X)		+= h720x
 machine-$(CONFIG_ARCH_HIGHBANK)		+= highbank
+machine-$(CONFIG_ARCH_HS)		+= hs
 machine-$(CONFIG_ARCH_INTEGRATOR)	+= integrator
 machine-$(CONFIG_ARCH_IOP13XX)		+= iop13xx
 machine-$(CONFIG_ARCH_IOP32X)		+= iop32x
diff --git a/arch/arm/mach-hs/Kconfig b/arch/arm/mach-hs/Kconfig
new file mode 100644
index 0000000..491c6da
--- /dev/null
+++ b/arch/arm/mach-hs/Kconfig
@@ -0,0 +1,23 @@
+config ARCH_HS
+	bool "Hisilicon Hi36xx/Hi37xx family" if ARCH_MULTI_V7
+	select ARM_AMBA
+	select ARM_GIC
+	select CACHE_L2X0
+	select CACHE_PL310
+	select PINCTRL
+	select PINCTRL_SINGLE
+	select SERIAL_AMBA_PL011
+	select SERIAL_AMBA_PL011_CONSOLE
+	help
+	  Support for Hisilicon Hi36xx/Hi37xx processor family
+
+if ARCH_HS
+
+config MACH_HS_DT
+	bool "Hisilicon Development Board"
+	default y
+	help
+	  Say 'Y' here if you want to support the Hisilicon Development
+	  Board. 
+
+endif
diff --git a/arch/arm/mach-hs/Makefile b/arch/arm/mach-hs/Makefile
new file mode 100644
index 0000000..d79ecb5
--- /dev/null
+++ b/arch/arm/mach-hs/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for Hisilicon Hi36xx/Hi37xx processors line
+#
+
+obj-$(CONFIG_MACH_HS_DT)	+= hs-dt.o
diff --git a/arch/arm/mach-hs/hs-dt.c b/arch/arm/mach-hs/hs-dt.c
new file mode 100644
index 0000000..813ebb0
--- /dev/null
+++ b/arch/arm/mach-hs/hs-dt.c
@@ -0,0 +1,83 @@
+/*
+ * (Hisilicon's Hi36xx/Hi37xx SoC based) flattened device tree enabled machine
+ *
+ * Copyright (c) 2012-2013 Hisilicon Ltd.
+ * Copyright (c) 2012-2013 Linaro Ltd.
+ *
+ * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/irqchip.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+
+#include <asm/hardware/arm_timer.h>
+#include <asm/hardware/timer-sp.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/time.h>
+
+static struct of_device_id hs_timer_match[] __initdata = {
+	{ .compatible = "arm,sp804", },
+	{}
+};
+
+static struct clk_lookup sp804_lookup = {
+	.dev_id	= "sp804",
+	.clk	= NULL,
+};
+
+extern void __init hs_init_clocks(void);
+static void __init hs_timer_init(void)
+{
+	struct device_node *node = NULL;
+	void __iomem *base;
+	int irq;
+
+	hs_init_clocks();
+
+	node = of_find_matching_node(NULL, hs_timer_match);
+	WARN_ON(!node);
+	if (!node) {
+		pr_err("Failed to find sp804 timer\n");
+		return;
+	}
+	base = of_iomap(node, 0);
+	WARN_ON(!base);
+
+	/* timer0 is used as clock event, and timer1 is clock source. */
+	irq = irq_of_parse_and_map(node, 0);
+	WARN_ON(!irq);
+
+	sp804_lookup.clk = of_clk_get(node, 0);
+	clkdev_add(&sp804_lookup);
+
+	sp804_clocksource_and_sched_clock_init(base + TIMER_2_BASE, "timer1");
+	sp804_clockevents_init(base, irq, "timer0");
+}
+
+static void __init hs_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char *hs_compat[] __initdata = {
+	"hisilicon,hi3620-hi4511",
+	NULL,
+};
+
+DT_MACHINE_START(HS_DT, "Hisilicon Hi36xx/Hi37xx (Flattened Device Tree)")
+	/* Maintainer: Haojian Zhuang <haojian.zhuang@linaro.org> */
+	.map_io		= debug_ll_io_init,
+	.init_irq	= irqchip_init,
+	.init_time	= hs_timer_init,
+	.init_machine	= hs_init,
+	.dt_compat	= hs_compat,
+MACHINE_END
-- 
1.7.10.4
