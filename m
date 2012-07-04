From: will.deacon@arm.com (Will Deacon)
Date: Wed,  4 Jul 2012 16:01:15 +0100
Subject: [PATCH 1/2] ARM: vexpress: add debug UARTs to DEBUG_LL kconfig choice
Message-ID: <1341414076-20895-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Austin <jonathan.austin@arm.com>

The current vexpress code attempts to autodetect the debug UART based on
some fragile probing of the memory map. If this fails, we may take an
abort attempting to access a device that doesn't exist.

This patch avoids probing the various possible UART locations on the
different Versatile Express motherboards and instead adds entries into
the DEBUG_LL kconfig choice for the two possible memory maps.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig.debug                            |   16 ++++++++++
 arch/arm/mach-vexpress/include/mach/debug-macro.S |   34 ++++++++-------------
 2 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 01a1341..b343f60 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -345,6 +345,22 @@ choice
 		  For more details about semihosting, please see
 		  chapter 8 of DUI0203I_rvct_developer_guide.pdf from ARM Ltd.
 
+	config DEBUG_VEXPRESS_CA9X4_UART
+		bool "Kernel low-level debugging messages via CA9X4 UART"
+		depends on ARCH_VEXPRESS_CA9X4
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to UART0 of the Versatile Express motherboards
+		  that pre-date the RS1 memory map.
+
+	config DEBUG_VEXPRESS_RS1_UART
+		bool "Kernel low-level debugging messages via RS1 UART"
+		depends on ARCH_VEXPRESS_DT
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to UART0 of the Versatile Express motherboards
+		  with the RS1 memory map.
+
 endchoice
 
 config EARLY_PRINTK
diff --git a/arch/arm/mach-vexpress/include/mach/debug-macro.S b/arch/arm/mach-vexpress/include/mach/debug-macro.S
index fa82247..f25a024 100644
--- a/arch/arm/mach-vexpress/include/mach/debug-macro.S
+++ b/arch/arm/mach-vexpress/include/mach/debug-macro.S
@@ -10,34 +10,26 @@
  * published by the Free Software Foundation.
  */
 
+#ifdef CONFIG_DEBUG_VEXPRESS_CA9X4_UART
 #define DEBUG_LL_PHYS_BASE		0x10000000
 #define DEBUG_LL_UART_OFFSET		0x00009000
+#endif
 
-#define DEBUG_LL_PHYS_BASE_RS1		0x1c000000
-#define DEBUG_LL_UART_OFFSET_RS1	0x00090000
+#ifdef CONFIG_DEBUG_VEXPRESS_RS1_UART
+#define DEBUG_LL_PHYS_BASE		0x1c000000
+#define DEBUG_LL_UART_OFFSET		0x00090000
+#endif
 
 #define DEBUG_LL_VIRT_BASE		0xf8000000
 
-		.macro	addruart,rp,rv,tmp
-
-		@ Make an educated guess regarding the memory map:
-		@ - the original A9 core tile, which has MPCore peripherals
-		@   located at 0x1e000000, should use UART at 0x10009000
-		@ - all other (RS1 complaint) tiles use UART mapped
-		@   at 0x1c090000
-		mrc	p15, 4, \tmp, c15, c0, 0
-		cmp	\tmp, #0x1e000000
-
-		@ Original memory map
-		moveq	\rp, #DEBUG_LL_UART_OFFSET
-		orreq	\rv, \rp, #DEBUG_LL_VIRT_BASE
-		orreq	\rp, \rp, #DEBUG_LL_PHYS_BASE
-
-		@ RS1 memory map
-		movne	\rp, #DEBUG_LL_UART_OFFSET_RS1
-		orrne	\rv, \rp, #DEBUG_LL_VIRT_BASE
-		orrne	\rp, \rp, #DEBUG_LL_PHYS_BASE_RS1
+#ifndef DEBUG_LL_UART_OFFSET
+#error "Unknown vexpress UART offset"
+#endif
 
+		.macro	addruart,rp,rv,tmp
+		mov	\rp, #DEBUG_LL_UART_OFFSET
+		orr	\rv, \rp, #DEBUG_LL_VIRT_BASE
+		orr	\rp, \rp, #DEBUG_LL_PHYS_BASE
 		.endm
 
 #include <asm/hardware/debug-pl01x.S>
-- 
1.7.4.1
