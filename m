From: robherring2@gmail.com (Rob Herring)
Date: Thu,  6 Sep 2012 15:12:44 -0500
Subject: [PATCH 01/12] ARM: move debug macros to common location
In-Reply-To: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346962375-26163-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Based on suggestion by Russell King, create a common location for debug
macros and select the included debug macro file using config option.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/Kconfig.debug          |    5 +++
 arch/arm/include/debug/icedcc.S |   90 +++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/debug.S         |   87 ++-----------------------------------
 arch/arm/kernel/head.S          |    4 +-
 4 files changed, 100 insertions(+), 86 deletions(-)
 create mode 100644 arch/arm/include/debug/icedcc.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index f15f82b..4f9760b 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -373,6 +373,11 @@ choice
 
 endchoice
 
+config DEBUG_LL_INCLUDE
+	string
+	default "debug/icedcc.S" if DEBUG_ICEDCC
+	default "mach/debug-macro.S"
+
 config EARLY_PRINTK
 	bool "Early printk"
 	depends on DEBUG_LL
diff --git a/arch/arm/include/debug/icedcc.S b/arch/arm/include/debug/icedcc.S
new file mode 100644
index 0000000..43afcb0
--- /dev/null
+++ b/arch/arm/include/debug/icedcc.S
@@ -0,0 +1,90 @@
+/*
+ *  arch/arm/include/debug/icedcc.S
+ *
+ *  Copyright (C) 1994-1999 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+		@@ debug using ARM EmbeddedICE DCC channel
+
+		.macro	addruart, rp, rv, tmp
+		.endm
+
+#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K) || defined(CONFIG_CPU_V7)
+
+		.macro	senduart, rd, rx
+		mcr	p14, 0, \rd, c0, c5, 0
+		.endm
+
+		.macro	busyuart, rd, rx
+1001:
+		mrc	p14, 0, \rx, c0, c1, 0
+		tst	\rx, #0x20000000
+		beq	1001b
+		.endm
+
+		.macro	waituart, rd, rx
+		mov	\rd, #0x2000000
+1001:
+		subs	\rd, \rd, #1
+		bmi	1002f
+		mrc	p14, 0, \rx, c0, c1, 0
+		tst	\rx, #0x20000000
+		bne	1001b
+1002:
+		.endm
+
+#elif defined(CONFIG_CPU_XSCALE)
+
+		.macro	senduart, rd, rx
+		mcr	p14, 0, \rd, c8, c0, 0
+		.endm
+
+		.macro	busyuart, rd, rx
+1001:
+		mrc	p14, 0, \rx, c14, c0, 0
+		tst	\rx, #0x10000000
+		beq	1001b
+		.endm
+
+		.macro	waituart, rd, rx
+		mov	\rd, #0x10000000
+1001:
+		subs	\rd, \rd, #1
+		bmi	1002f
+		mrc	p14, 0, \rx, c14, c0, 0
+		tst	\rx, #0x10000000
+		bne	1001b
+1002:
+		.endm
+
+#else
+
+		.macro	senduart, rd, rx
+		mcr	p14, 0, \rd, c1, c0, 0
+		.endm
+
+		.macro	busyuart, rd, rx
+1001:
+		mrc	p14, 0, \rx, c0, c0, 0
+		tst	\rx, #2
+		beq	1001b
+
+		.endm
+
+		.macro	waituart, rd, rx
+		mov	\rd, #0x2000000
+1001:
+		subs	\rd, \rd, #1
+		bmi	1002f
+		mrc	p14, 0, \rx, c0, c0, 0
+		tst	\rx, #2
+		bne	1001b
+1002:
+		.endm
+
+#endif	/* CONFIG_CPU_V6 */
diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
index c45522c..66f711b 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -20,90 +20,9 @@
  * references to these in a production kernel!
  */
 
-#if defined(CONFIG_DEBUG_ICEDCC)
-		@@ debug using ARM EmbeddedICE DCC channel
-
-		.macro	addruart, rp, rv, tmp
-		.endm
-
-#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K) || defined(CONFIG_CPU_V7)
-
-		.macro	senduart, rd, rx
-		mcr	p14, 0, \rd, c0, c5, 0
-		.endm
-
-		.macro	busyuart, rd, rx
-1001:
-		mrc	p14, 0, \rx, c0, c1, 0
-		tst	\rx, #0x20000000
-		beq	1001b
-		.endm
-
-		.macro	waituart, rd, rx
-		mov	\rd, #0x2000000
-1001:
-		subs	\rd, \rd, #1
-		bmi	1002f
-		mrc	p14, 0, \rx, c0, c1, 0
-		tst	\rx, #0x20000000
-		bne	1001b
-1002:
-		.endm
-
-#elif defined(CONFIG_CPU_XSCALE)
-
-		.macro	senduart, rd, rx
-		mcr	p14, 0, \rd, c8, c0, 0
-		.endm
-
-		.macro	busyuart, rd, rx
-1001:
-		mrc	p14, 0, \rx, c14, c0, 0
-		tst	\rx, #0x10000000
-		beq	1001b
-		.endm
-
-		.macro	waituart, rd, rx
-		mov	\rd, #0x10000000
-1001:
-		subs	\rd, \rd, #1
-		bmi	1002f
-		mrc	p14, 0, \rx, c14, c0, 0
-		tst	\rx, #0x10000000
-		bne	1001b
-1002:
-		.endm
-
-#else
-
-		.macro	senduart, rd, rx
-		mcr	p14, 0, \rd, c1, c0, 0
-		.endm
-
-		.macro	busyuart, rd, rx
-1001:
-		mrc	p14, 0, \rx, c0, c0, 0
-		tst	\rx, #2
-		beq	1001b
-
-		.endm
-
-		.macro	waituart, rd, rx
-		mov	\rd, #0x2000000
-1001:
-		subs	\rd, \rd, #1
-		bmi	1002f
-		mrc	p14, 0, \rx, c0, c0, 0
-		tst	\rx, #2
-		bne	1001b
-1002:
-		.endm
-
-#endif	/* CONFIG_CPU_V6 */
-
-#elif !defined(CONFIG_DEBUG_SEMIHOSTING)
-#include <mach/debug-macro.S>
-#endif	/* CONFIG_DEBUG_ICEDCC */
+#if !defined(CONFIG_DEBUG_SEMIHOSTING)
+#include CONFIG_DEBUG_LL_INCLUDE
+#endif
 
 #ifdef CONFIG_MMU
 		.macro	addruart_current, rx, tmp1, tmp2
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 3db960e..9874d07 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -23,8 +23,8 @@
 #include <asm/thread_info.h>
 #include <asm/pgtable.h>
 
-#ifdef CONFIG_DEBUG_LL
-#include <mach/debug-macro.S>
+#if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_SEMIHOSTING)
+#include CONFIG_DEBUG_LL_INCLUDE
 #endif
 
 /*
-- 
1.7.9.5
