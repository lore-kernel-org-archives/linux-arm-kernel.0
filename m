From: jun.nie@linaro.org (Jun Nie)
Date: Fri, 27 Mar 2015 21:52:30 +0800
Subject: [PATCH v2 1/7] ARM: zx: add basic support for ZTE ZX296702
In-Reply-To: <1427464356-20112-1-git-send-email-jun.nie@linaro.org>
References: <1427464356-20112-1-git-send-email-jun.nie@linaro.org>
Message-ID: <1427464356-20112-2-git-send-email-jun.nie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic code for ZTE ZX296702 platform.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 arch/arm/Kconfig            |  2 ++
 arch/arm/Makefile           |  1 +
 arch/arm/mach-zx/Kconfig    | 18 ++++++++++++++++++
 arch/arm/mach-zx/Makefile   |  1 +
 arch/arm/mach-zx/zx296702.c | 31 +++++++++++++++++++++++++++++++
 5 files changed, 53 insertions(+)
 create mode 100644 arch/arm/mach-zx/Kconfig
 create mode 100644 arch/arm/mach-zx/Makefile
 create mode 100644 arch/arm/mach-zx/zx296702.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9f1f09a..7516833 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -967,6 +967,8 @@ source "arch/arm/mach-vt8500/Kconfig"
 
 source "arch/arm/mach-w90x900/Kconfig"
 
+source "arch/arm/mach-zx/Kconfig"
+
 source "arch/arm/mach-zynq/Kconfig"
 
 # Definitions to make life easier
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 7f99cd6..33b1588 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -204,6 +204,7 @@ machine-$(CONFIG_ARCH_VERSATILE)	+= versatile
 machine-$(CONFIG_ARCH_VEXPRESS)		+= vexpress
 machine-$(CONFIG_ARCH_VT8500)		+= vt8500
 machine-$(CONFIG_ARCH_W90X900)		+= w90x900
+machine-$(CONFIG_ARCH_ZX)		+= zx
 machine-$(CONFIG_ARCH_ZYNQ)		+= zynq
 machine-$(CONFIG_PLAT_SPEAR)		+= spear
 
diff --git a/arch/arm/mach-zx/Kconfig b/arch/arm/mach-zx/Kconfig
new file mode 100644
index 0000000..8bd4eb7
--- /dev/null
+++ b/arch/arm/mach-zx/Kconfig
@@ -0,0 +1,18 @@
+menuconfig ARCH_ZX
+	bool "ZTE ZX family" if ARCH_MULTI_V7
+	help
+	  Support for ZTE ZX-based family of processors. TV
+	  set-top-box processor is supported. More will be
+	  added soon.
+
+if ARCH_ZX
+
+config SOC_ZX296702
+	bool "Enable support for ZX296702 SoC"
+	select ARM_GIC
+	select ARM_GLOBAL_TIMER
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
+	help
+	  Support for ZTE ZX296702 SoC which is a dual core CortexA9MP
+endif
diff --git a/arch/arm/mach-zx/Makefile b/arch/arm/mach-zx/Makefile
new file mode 100644
index 0000000..7a541c7
--- /dev/null
+++ b/arch/arm/mach-zx/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SOC_ZX296702) += zx296702.o
diff --git a/arch/arm/mach-zx/zx296702.c b/arch/arm/mach-zx/zx296702.c
new file mode 100644
index 0000000..b6e5dc2
--- /dev/null
+++ b/arch/arm/mach-zx/zx296702.c
@@ -0,0 +1,31 @@
+/*
+ * Copyright 2014 Linaro Ltd.
+ * Copyright (C) 2014 ZTE Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
+static const char *zx296702_dt_compat[] __initconst = {
+	"zte,zx296702",
+	NULL,
+};
+
+static void __init zx296702_init_machine(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+DT_MACHINE_START(ZX, "ZTE ZX296702 (Device Tree)")
+	.init_machine   = zx296702_init_machine,
+	.dt_compat	= zx296702_dt_compat,
+	.l2c_aux_val    = 0x30400000,
+	.l2c_aux_mask   = 0xfeffffff,
+MACHINE_END
-- 
1.9.1
