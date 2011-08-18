From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Thu, 18 Aug 2011 17:50:47 -0400
Subject: [PATCH 1/5] ARM: davinci: da850,
	omapl138: introduce shared da850 reference components
In-Reply-To: <cover.1313702401.git.bengardiner@nanometrics.ca>
References: <cover.1313702401.git.bengardiner@nanometrics.ca>
Message-ID: <6650d6c73c2f5a8c4825c91cd8940fe88e46ba03.1313702401.git.bengardiner@nanometrics.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several of the pieces of the da850 evm reference design board support in
board-da850-evm.c are re-used by the other da850/omapl138 boards. Examples
are boot_params, map_io, preferred-serial-console, davinci_uart_config's
enabled_uarts to name a few.

Introduce an object file to contain these shared pieces for re-use by the
other da850/omapl138 boards. Kick it off with sharing the machine map_io which
before this change was repeated in each of board-da850-evm.c,
board-mityomapl138.c and board-omapl138-hawk.c. Since these machines are all
included in the da8xx_omapl_defconfig, there is benefit to sharing a definition
here.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
Reviewed-by: James Nuss <jamesnuss@nanometrics.ca>
---
 arch/arm/mach-davinci/Makefile                     |    3 ++-
 arch/arm/mach-davinci/board-da850-evm.c            |    8 ++------
 arch/arm/mach-davinci/board-mityomapl138.c         |    8 ++------
 arch/arm/mach-davinci/board-omapl138-hawk.c        |    8 ++------
 arch/arm/mach-davinci/da850-reference.c            |   15 +++++++++++++++
 .../mach-davinci/include/mach/da850-reference.h    |   14 ++++++++++++++
 6 files changed, 37 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/mach-davinci/da850-reference.c
 create mode 100644 arch/arm/mach-davinci/include/mach/da850-reference.h

diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index 0b87a1c..9a01441 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -15,7 +15,8 @@ obj-$(CONFIG_ARCH_DAVINCI_DM355)        += dm355.o devices.o
 obj-$(CONFIG_ARCH_DAVINCI_DM646x)       += dm646x.o devices.o
 obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= dm365.o devices.o
 obj-$(CONFIG_ARCH_DAVINCI_DA830)        += da830.o devices-da8xx.o
-obj-$(CONFIG_ARCH_DAVINCI_DA850)        += da850.o devices-da8xx.o
+obj-$(CONFIG_ARCH_DAVINCI_DA850)        += da850.o devices-da8xx.o\
+					da850-reference.o
 obj-$(CONFIG_ARCH_DAVINCI_TNETV107X)    += tnetv107x.o devices-tnetv107x.o
 obj-$(CONFIG_ARCH_DAVINCI_TNETV107X)    += gpio-tnetv107x.o
 
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 3d2c0d7..3ee12f3 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -37,6 +37,7 @@
 
 #include <mach/cp_intc.h>
 #include <mach/da8xx.h>
+#include <mach/da850-reference.h>
 #include <mach/nand.h>
 #include <mach/mux.h>
 #include <mach/aemif.h>
@@ -1257,14 +1258,9 @@ static int __init da850_evm_console_init(void)
 console_initcall(da850_evm_console_init);
 #endif
 
-static void __init da850_evm_map_io(void)
-{
-	da850_init();
-}
-
 MACHINE_START(DAVINCI_DA850_EVM, "DaVinci DA850/OMAP-L138/AM18x EVM")
 	.boot_params	= (DA8XX_DDR_BASE + 0x100),
-	.map_io		= da850_evm_map_io,
+	.map_io		= da850_reference_map_io,
 	.init_irq	= cp_intc_init,
 	.timer		= &davinci_timer,
 	.init_machine	= da850_evm_init,
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 606a6f2..c256858 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -25,6 +25,7 @@
 #include <mach/common.h>
 #include <mach/cp_intc.h>
 #include <mach/da8xx.h>
+#include <mach/da850-reference.h>
 #include <mach/nand.h>
 #include <mach/mux.h>
 #include <mach/spi.h>
@@ -559,14 +560,9 @@ static int __init mityomapl138_console_init(void)
 console_initcall(mityomapl138_console_init);
 #endif
 
-static void __init mityomapl138_map_io(void)
-{
-	da850_init();
-}
-
 MACHINE_START(MITYOMAPL138, "MityDSP-L138/MityARM-1808")
 	.boot_params	= (DA8XX_DDR_BASE + 0x100),
-	.map_io		= mityomapl138_map_io,
+	.map_io		= da850_reference_map_io,
 	.init_irq	= cp_intc_init,
 	.timer		= &davinci_timer,
 	.init_machine	= mityomapl138_init,
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 67c38d0..5d556cf 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -19,6 +19,7 @@
 
 #include <mach/cp_intc.h>
 #include <mach/da8xx.h>
+#include <mach/da850-reference.h>
 #include <mach/mux.h>
 
 #define HAWKBOARD_PHY_ID		"0:07"
@@ -332,14 +333,9 @@ static int __init omapl138_hawk_console_init(void)
 console_initcall(omapl138_hawk_console_init);
 #endif
 
-static void __init omapl138_hawk_map_io(void)
-{
-	da850_init();
-}
-
 MACHINE_START(OMAPL138_HAWKBOARD, "AM18x/OMAP-L138 Hawkboard")
 	.boot_params	= (DA8XX_DDR_BASE + 0x100),
-	.map_io		= omapl138_hawk_map_io,
+	.map_io		= da850_reference_map_io,
 	.init_irq	= cp_intc_init,
 	.timer		= &davinci_timer,
 	.init_machine	= omapl138_hawk_init,
diff --git a/arch/arm/mach-davinci/da850-reference.c b/arch/arm/mach-davinci/da850-reference.c
new file mode 100644
index 0000000..67b327b
--- /dev/null
+++ b/arch/arm/mach-davinci/da850-reference.c
@@ -0,0 +1,15 @@
+/*
+ * TI DA850/OMAP-L138 reusable elements of the da850 reference design.
+ *
+ * Copyright (C) 2011 Nanometrics Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <mach/da8xx.h>
+
+void __init da850_reference_map_io(void)
+{
+	da850_init();
+}
diff --git a/arch/arm/mach-davinci/include/mach/da850-reference.h b/arch/arm/mach-davinci/include/mach/da850-reference.h
new file mode 100644
index 0000000..d3beb13
--- /dev/null
+++ b/arch/arm/mach-davinci/include/mach/da850-reference.h
@@ -0,0 +1,14 @@
+/* Defines for the reusable elements of the da850 reference design.
+ *
+ * Copyright 2011 (c) Nanometrics Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef __ASM_ARCH_DAVINCI_DA850_REFERENCE_H
+#define __ASM_ARCH_DAVINCI_DA850_REFERENCE_H
+
+void __init da850_reference_map_io(void);
+
+#endif /* __ASM_ARCH_DAVINCI_DA850_REFERENCE_H */
-- 
1.7.4.1
