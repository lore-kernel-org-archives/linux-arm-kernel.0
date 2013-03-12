From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Mar 2013 01:08:38 +0800
Subject: [PATCH v2 09/14] ARM: hs: add board support with device tree
In-Reply-To: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1363108124-17484-10-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add board support with device tree for Hisilicon Hi36xx/Hi37xx platform.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/Kconfig              |    2 ++
 arch/arm/Makefile             |    1 +
 arch/arm/mach-hi3xxx/Kconfig  |   13 ++++++++++++
 arch/arm/mach-hi3xxx/Makefile |    5 +++++
 arch/arm/mach-hi3xxx/hi3xxx.c |   45 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 66 insertions(+)
 create mode 100644 arch/arm/mach-hi3xxx/Kconfig
 create mode 100644 arch/arm/mach-hi3xxx/Makefile
 create mode 100644 arch/arm/mach-hi3xxx/hi3xxx.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 10d7e2c..11ef3ea 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1060,6 +1060,8 @@ source "arch/arm/mach-gemini/Kconfig"
 
 source "arch/arm/mach-h720x/Kconfig"
 
+source "arch/arm/mach-hi3xxx/Kconfig"
+
 source "arch/arm/mach-highbank/Kconfig"
 
 source "arch/arm/mach-integrator/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index ee4605f..4b0de9e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -148,6 +148,7 @@ machine-$(CONFIG_ARCH_EBSA110)		+= ebsa110
 machine-$(CONFIG_ARCH_EP93XX)		+= ep93xx
 machine-$(CONFIG_ARCH_GEMINI)		+= gemini
 machine-$(CONFIG_ARCH_H720X)		+= h720x
+machine-$(CONFIG_ARCH_HI3xxx)		+= hi3xxx
 machine-$(CONFIG_ARCH_HIGHBANK)		+= highbank
 machine-$(CONFIG_ARCH_INTEGRATOR)	+= integrator
 machine-$(CONFIG_ARCH_IOP13XX)		+= iop13xx
diff --git a/arch/arm/mach-hi3xxx/Kconfig b/arch/arm/mach-hi3xxx/Kconfig
new file mode 100644
index 0000000..a991dee
--- /dev/null
+++ b/arch/arm/mach-hi3xxx/Kconfig
@@ -0,0 +1,13 @@
+config ARCH_HI3xxx
+	bool "Hisilicon Hi36xx/Hi37xx family" if ARCH_MULTI_V7
+	select ARM_AMBA
+	select ARM_GIC
+	select CACHE_L2X0
+	select CACHE_PL310
+	select CLKSRC_OF
+	select PINCTRL
+	select PINCTRL_SINGLE
+	select SERIAL_AMBA_PL011
+	select SERIAL_AMBA_PL011_CONSOLE
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
index 0000000..f93f8b9
--- /dev/null
+++ b/arch/arm/mach-hi3xxx/hi3xxx.c
@@ -0,0 +1,45 @@
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
+#include <linux/clocksource.h>
+#include <linux/irqchip.h>
+#include <linux/of_platform.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+extern void __init hs_init_clocks(void);
+static void __init hi3xxx_timer_init(void)
+{
+	hs_init_clocks();
+	clocksource_of_init();
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
+DT_MACHINE_START(HI3xxx, "Hisilicon Hi36xx/Hi37xx (Flattened Device Tree)")
+	/* Maintainer: Haojian Zhuang <haojian.zhuang@linaro.org> */
+	.map_io		= debug_ll_io_init,
+	.init_irq	= irqchip_init,
+	.init_time	= hi3xxx_timer_init,
+	.init_machine	= hs_init,
+	.dt_compat	= hs_compat,
+MACHINE_END
-- 
1.7.10.4
