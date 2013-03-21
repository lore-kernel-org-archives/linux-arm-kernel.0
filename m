From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 21 Mar 2013 12:49:08 +0100
Subject: [PATCH 1/6] ARM: ux500: move debugmacro to debug includes
In-Reply-To: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1363866553-15054-2-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This moves the Ux500 debug macro to the debug headers to
make way for multiplatform support.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig.debug                         |  8 ++++++
 arch/arm/include/debug/ux500.S                 | 39 ++++++++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/debug-macro.S | 39 --------------------------
 3 files changed, 47 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm/include/debug/ux500.S
 delete mode 100644 arch/arm/mach-ux500/include/mach/debug-macro.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index acdddda..a7b6f8b 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -414,6 +414,13 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the uart1 port on SiRFmarco devices.
 
+	config DEBUG_UX500_UART
+		depends on ARCH_U8500
+		bool "Use Ux500 UART for low-level debug"
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Ux500 based platforms.
+
 	config DEBUG_VEXPRESS_UART0_DETECT
 		bool "Autodetect UART0 on Versatile Express Cortex-A core tiles"
 		depends on ARCH_VEXPRESS && CPU_CP15_MMU
@@ -598,6 +605,7 @@ config DEBUG_LL_INCLUDE
 		DEBUG_VEXPRESS_UART0_CA9 || DEBUG_VEXPRESS_UART0_RS1
 	default "debug/vt8500.S" if DEBUG_VT8500_UART0
 	default "debug/tegra.S" if DEBUG_TEGRA_UART
+	default "debug/ux500.S" if DEBUG_UX500_UART
 	default "debug/zynq.S" if DEBUG_ZYNQ_UART0 || DEBUG_ZYNQ_UART1
 	default "mach/debug-macro.S"
 
diff --git a/arch/arm/include/debug/ux500.S b/arch/arm/include/debug/ux500.S
new file mode 100644
index 0000000..6703522
--- /dev/null
+++ b/arch/arm/include/debug/ux500.S
@@ -0,0 +1,39 @@
+/*
+ * Debugging macro include header
+ *
+ *  Copyright (C) 2009 ST-Ericsson
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <mach/hardware.h>
+
+#if CONFIG_UX500_DEBUG_UART > 2
+#error Invalid Ux500 debug UART
+#endif
+
+/*
+ * DEBUG_LL only works if only one SOC is built in.  We don't use #else below
+ * in order to get "__UX500_UART redefined" warnings if more than one SOC is
+ * built, so that there's some hint during the build that something is wrong.
+ */
+
+#ifdef CONFIG_UX500_SOC_DB8500
+#define __UX500_UART(n)	U8500_UART##n##_BASE
+#endif
+
+#ifndef __UX500_UART
+#error Unknown SOC
+#endif
+
+#define UX500_UART(n)	__UX500_UART(n)
+#define UART_BASE	UX500_UART(CONFIG_UX500_DEBUG_UART)
+
+	.macro	addruart, rp, rv, tmp
+	ldr	\rp, =UART_BASE				@ no, physical address
+	ldr	\rv, =IO_ADDRESS(UART_BASE)		@ yes, virtual address
+	.endm
+
+#include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-ux500/include/mach/debug-macro.S b/arch/arm/mach-ux500/include/mach/debug-macro.S
deleted file mode 100644
index 6703522..0000000
--- a/arch/arm/mach-ux500/include/mach/debug-macro.S
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * Debugging macro include header
- *
- *  Copyright (C) 2009 ST-Ericsson
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-#include <mach/hardware.h>
-
-#if CONFIG_UX500_DEBUG_UART > 2
-#error Invalid Ux500 debug UART
-#endif
-
-/*
- * DEBUG_LL only works if only one SOC is built in.  We don't use #else below
- * in order to get "__UX500_UART redefined" warnings if more than one SOC is
- * built, so that there's some hint during the build that something is wrong.
- */
-
-#ifdef CONFIG_UX500_SOC_DB8500
-#define __UX500_UART(n)	U8500_UART##n##_BASE
-#endif
-
-#ifndef __UX500_UART
-#error Unknown SOC
-#endif
-
-#define UX500_UART(n)	__UX500_UART(n)
-#define UART_BASE	UX500_UART(CONFIG_UX500_DEBUG_UART)
-
-	.macro	addruart, rp, rv, tmp
-	ldr	\rp, =UART_BASE				@ no, physical address
-	ldr	\rv, =IO_ADDRESS(UART_BASE)		@ yes, virtual address
-	.endm
-
-#include <asm/hardware/debug-pl01x.S>
-- 
1.7.11.3
