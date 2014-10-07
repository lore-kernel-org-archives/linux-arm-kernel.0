From: linux@rempel-privat.de (Oleksij Rempel)
Date: Tue,  7 Oct 2014 10:55:15 +0200
Subject: [PATCH v3 1/9] ARM: add mach-asm9260
In-Reply-To: <1412672123-16694-1-git-send-email-linux@rempel-privat.de>
References: <1411324904-14881-1-git-send-email-linux@rempel-privat.de>
 <1412672123-16694-1-git-send-email-linux@rempel-privat.de>
Message-ID: <1412672123-16694-2-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

it is low cost (?) SoC targeted for market in China and India which
trying to compete with AT91SAM9G25.

Here is some info:
http://www.alphascale.com/index.asp?ics/615.html

One of products:
http://www.aliexpress.com/store/product/2014-hot-sales-FREE-SHIPPING-new-Purple-core-ARM9-development-board-ASM9260T-SDRAM-power-line/433637_1931495721.html

In some cases this SoC looks similar to iMX23/iMX28. But currently it makes no
sense to merge mach code of this devices. Especially because most differences
are already collected mach-mxs folder.

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 arch/arm/Kconfig               |  2 ++
 arch/arm/Makefile              |  1 +
 arch/arm/mach-asm9260/Kconfig  |  8 ++++++++
 arch/arm/mach-asm9260/Makefile |  1 +
 arch/arm/mach-asm9260/core.c   | 20 ++++++++++++++++++++
 5 files changed, 32 insertions(+)
 create mode 100644 arch/arm/mach-asm9260/Kconfig
 create mode 100644 arch/arm/mach-asm9260/Makefile
 create mode 100644 arch/arm/mach-asm9260/core.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5918d40..87373da 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -968,6 +968,8 @@ source "arch/arm/mach-w90x900/Kconfig"
 
 source "arch/arm/mach-zynq/Kconfig"
 
+source "arch/arm/mach-asm9260/Kconfig"
+
 # Definitions to make life easier
 config ARCH_ACORN
 	bool
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 0ce9d0f..dda8f6d 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -146,6 +146,7 @@ textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
 # Machine directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
 machine-$(CONFIG_ARCH_AT91)		+= at91
+machine-$(CONFIG_MACH_ASM9260)		+= asm9260
 machine-$(CONFIG_ARCH_AXXIA)		+= axxia
 machine-$(CONFIG_ARCH_BCM)		+= bcm
 machine-$(CONFIG_ARCH_BERLIN)		+= berlin
diff --git a/arch/arm/mach-asm9260/Kconfig b/arch/arm/mach-asm9260/Kconfig
new file mode 100644
index 0000000..eef90d9
--- /dev/null
+++ b/arch/arm/mach-asm9260/Kconfig
@@ -0,0 +1,8 @@
+config MACH_ASM9260
+	bool "Alphascale ASM9260"
+	depends on ARCH_MULTI_V5
+	select IRQ_MXS
+	select ASM9260_TIMER
+	select CPU_ARM926T
+	help
+	  Support for Alpascale ASM9260 based platform.
diff --git a/arch/arm/mach-asm9260/Makefile b/arch/arm/mach-asm9260/Makefile
new file mode 100644
index 0000000..3f774e4
--- /dev/null
+++ b/arch/arm/mach-asm9260/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_MACH_ASM9260) += core.o
diff --git a/arch/arm/mach-asm9260/core.c b/arch/arm/mach-asm9260/core.c
new file mode 100644
index 0000000..d1b9006
--- /dev/null
+++ b/arch/arm/mach-asm9260/core.c
@@ -0,0 +1,20 @@
+/*
+ * Copyright (C) 2014 Oleksij Rempel <linux@rempel-privat.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+
+static const char * const asm9260_dt_board_compat[] __initconst = {
+	"alphascale,asm9260",
+	NULL
+};
+
+DT_MACHINE_START(ASM9260, "Alphascale ASM9260 (Device Tree Support)")
+	.dt_compat	= asm9260_dt_board_compat,
+MACHINE_END
-- 
1.9.1
