From: jun.nie@linaro.org (Jun Nie)
Date: Sat, 14 Mar 2015 19:49:36 +0800
Subject: [PATCH 01/10] ARM: zx: add basic support of ZTE ZX296702
In-Reply-To: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
References: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
Message-ID: <1426333785-3952-2-git-send-email-jun.nie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic code for ZTE ZX296702 platform.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 arch/arm/Kconfig            |  2 ++
 arch/arm/Makefile           |  1 +
 arch/arm/mach-zx/Kconfig    | 21 +++++++++++++++++++++
 arch/arm/mach-zx/Makefile   |  1 +
 arch/arm/mach-zx/zx296702.c | 20 ++++++++++++++++++++
 5 files changed, 45 insertions(+)
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
index 0000000..6c1628d
--- /dev/null
+++ b/arch/arm/mach-zx/Kconfig
@@ -0,0 +1,21 @@
+config ARCH_ZX
+	bool "ZTE ZX family" if ARCH_MULTI_V7
+	help
+	  Support for ZTE ZX-based family of processors. TV
+	  set-top-box processor is supported. More will be
+	  added soon.
+
+menu "ZTE ZX options"
+	depends on ARCH_ZX
+
+config SOC_ZX296702
+	bool "Enable support for ZX296702 SoC"
+	select ARM_GIC
+	select ARM_GLOBAL_TIMER
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
+	select MIGHT_HAVE_CACHE_L2X0
+	help
+	  Support for ZTE ZX296702 SoC which is a dual core CortexA9MP
+
+endmenu
diff --git a/arch/arm/mach-zx/Makefile b/arch/arm/mach-zx/Makefile
new file mode 100644
index 0000000..7a541c7
--- /dev/null
+++ b/arch/arm/mach-zx/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SOC_ZX296702) += zx296702.o
diff --git a/arch/arm/mach-zx/zx296702.c b/arch/arm/mach-zx/zx296702.c
new file mode 100644
index 0000000..fdd7961
--- /dev/null
+++ b/arch/arm/mach-zx/zx296702.c
@@ -0,0 +1,20 @@
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
+static const char *zx296702_dt_compat[] __initconst = {
+	"zte,zx296702",
+	NULL,
+};
+
+DT_MACHINE_START(ZX, "ZTE ZX296702 (Device Tree)")
+	.dt_compat	= zx296702_dt_compat,
+MACHINE_END
-- 
1.9.1
