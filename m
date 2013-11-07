From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu,  7 Nov 2013 16:41:26 +0800
Subject: [PATCH v11 1/6] ARM: hi3xxx: add board support with device tree
In-Reply-To: <1383813691-31587-1-git-send-email-haojian.zhuang@linaro.org>
References: <1383813691-31587-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1383813691-31587-2-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add board support with device tree for Hisilicon Hi3620 SoC platform.

Changelog:
v11:
1. Add comments for iotable.

v10:
1. Add .map_io() & debug_ll_io_init() back. Since debug_ll_io_init() is
only called if .map_io() isn't assigned. Use .map_io() to setup static
IO mapping that is used in clock driver.

v3:
1. Remove .map_io() in DT machine descriptor. Since debug_ll_io_init()
is called by default.
2. Remove .init_machine() in DT machine descriptor. Since
of_platform_populate() is called by default in DT mode.

v2:
1. Remove .init_irq() in DT machine descriptor. Since irqchip_init()
is called by default in DT mode.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 .../bindings/arm/hisilicon/hisilicon.txt           | 10 ++++
 arch/arm/Kconfig                                   |  2 +
 arch/arm/Makefile                                  |  1 +
 arch/arm/mach-hi3xxx/Kconfig                       | 12 +++++
 arch/arm/mach-hi3xxx/Makefile                      |  5 ++
 arch/arm/mach-hi3xxx/hi3xxx.c                      | 60 ++++++++++++++++++++++
 6 files changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
 create mode 100644 arch/arm/mach-hi3xxx/Kconfig
 create mode 100644 arch/arm/mach-hi3xxx/Makefile
 create mode 100644 arch/arm/mach-hi3xxx/hi3xxx.c

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
new file mode 100644
index 0000000..3be60c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -0,0 +1,10 @@
+Hisilicon Platforms Device Tree Bindings
+----------------------------------------------------
+
+Hi3716 Development Board
+Required root node properties:
+	- compatible = "hisilicon,hi3716-dkb";
+
+Hi4511 Board
+Required root node properties:
+	- compatible = "hisilicon,hi3620-hi4511";
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3f7714d..0118443 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -946,6 +946,8 @@ source "arch/arm/mach-footbridge/Kconfig"
 
 source "arch/arm/mach-gemini/Kconfig"
 
+source "arch/arm/mach-hi3xxx/Kconfig"
+
 source "arch/arm/mach-highbank/Kconfig"
 
 source "arch/arm/mach-integrator/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a37a50f..23fb0b0 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -155,6 +155,7 @@ machine-$(CONFIG_ARCH_EBSA110)		+= ebsa110
 machine-$(CONFIG_ARCH_EP93XX)		+= ep93xx
 machine-$(CONFIG_ARCH_EXYNOS)		+= exynos
 machine-$(CONFIG_ARCH_GEMINI)		+= gemini
+machine-$(CONFIG_ARCH_HI3xxx)		+= hi3xxx
 machine-$(CONFIG_ARCH_HIGHBANK)		+= highbank
 machine-$(CONFIG_ARCH_INTEGRATOR)	+= integrator
 machine-$(CONFIG_ARCH_IOP13XX)		+= iop13xx
diff --git a/arch/arm/mach-hi3xxx/Kconfig b/arch/arm/mach-hi3xxx/Kconfig
new file mode 100644
index 0000000..68bd26c
--- /dev/null
+++ b/arch/arm/mach-hi3xxx/Kconfig
@@ -0,0 +1,12 @@
+config ARCH_HI3xxx
+	bool "Hisilicon Hi36xx/Hi37xx family" if ARCH_MULTI_V7
+	select ARM_AMBA
+	select ARM_GIC
+	select ARM_TIMER_SP804
+	select CACHE_L2X0
+	select CLKSRC_OF
+	select GENERIC_CLOCKEVENTS
+	select PINCTRL
+	select PINCTRL_SINGLE
+	help
+	  Support for Hisilicon Hi36xx/Hi37xx processor family
diff --git a/arch/arm/mach-hi3xxx/Makefile b/arch/arm/mach-hi3xxx/Makefile
new file mode 100644
index 0000000..d68ebb3
--- /dev/null
+++ b/arch/arm/mach-hi3xxx/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for Hisilicon Hi36xx/Hi37xx processors line
+#
+
+obj-y	+= hi3xxx.o
diff --git a/arch/arm/mach-hi3xxx/hi3xxx.c b/arch/arm/mach-hi3xxx/hi3xxx.c
new file mode 100644
index 0000000..925af13
--- /dev/null
+++ b/arch/arm/mach-hi3xxx/hi3xxx.c
@@ -0,0 +1,60 @@
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
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+#include <linux/irqchip.h>
+#include <linux/of_platform.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+/*
+ * This table is only for optimization. Since ioremap() could always share
+ * the same mapping if it's defined as static IO mapping.
+ *
+ * Without this table, system could also work. The cost is some virtual address
+ * spaces wasted since ioremap() may be called multi times for the same
+ * IO space.
+ */
+static struct map_desc hi3620_io_desc[] __initdata = {
+	{
+		.pfn		= __phys_to_pfn(0xfc802000),
+		.virtual	= 0xfe802000,
+		.length		= 0x1000,
+		.type		= MT_DEVICE,
+	},
+};
+
+static void __init hi3620_map_io(void)
+{
+	debug_ll_io_init();
+	iotable_init(hi3620_io_desc, ARRAY_SIZE(hi3620_io_desc));
+}
+
+static void __init hi3xxx_timer_init(void)
+{
+	of_clk_init(NULL);
+	clocksource_of_init();
+}
+
+static const char *hi3xxx_compat[] __initdata = {
+	"hisilicon,hi3620-hi4511",
+	NULL,
+};
+
+DT_MACHINE_START(HI3620, "Hisilicon Hi3620 (Flattened Device Tree)")
+	.map_io		= hi3620_map_io,
+	.init_time	= hi3xxx_timer_init,
+	.dt_compat	= hi3xxx_compat,
+MACHINE_END
-- 
1.8.3.2
