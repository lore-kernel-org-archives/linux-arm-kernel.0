From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 11 Jul 2012 17:21:47 +0100
Subject: [PATCH v2] ARM: vexpress: Config option for early printk console
In-Reply-To: <1342013791-19516-10-git-send-email-pawel.moll@arm.com>
References: <1342013791-19516-10-git-send-email-pawel.moll@arm.com>
Message-ID: <1342023707-9645-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Versatile Express platform can be used in different configurations,
the console UART used by early printk may be located at different
addresses in the address space.

This patch makes it possible to select the base address of a PL011
UART to be used as a console output in the kernel configuration.
The default behaviour is still the heuristic detecting memory map
on Cortex-A core tiles.

The zImage decompressor will use the same configuration values
or print out nothing if DEBUG_LL is not enabled.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/Kconfig.debug                            |   26 +++++++++++++
 arch/arm/mach-vexpress/include/mach/debug-macro.S |   41 +++++++++++++++++++++
 arch/arm/mach-vexpress/include/mach/uncompress.h  |   14 +++++++
 3 files changed, 81 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 01a1341..a03b5a7 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -310,6 +310,32 @@ choice
 		  The uncompressor code port configuration is now handled
 		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
 
+	config DEBUG_VEXPRESS_UART0_DETECT
+		bool "Autodetect UART0 on Versatile Express Cortex-A core tiles"
+		depends on ARCH_VEXPRESS && CPU_CP15_MMU
+		help
+		  This option enables a simple heuristic which tries to determine
+		  the motherboard's memory map variant (original or RS1) and then
+		  choose the relevant UART0 base address.
+
+		  Note that this will only work with standard A-class core tiles,
+		  and may fail with non-standard SMM or custom software models.
+
+	config DEBUG_VEXPRESS_UART0_CA9
+		bool "Use PL011 UART0 at 0x10009000 (V2P-CA9 core tile)"
+		depends on ARCH_VEXPRESS
+		help
+		  This option selects UART0 at 0x10009000. Except for custom models,
+		  this applies only to the V2P-CA9 tile.
+
+	config DEBUG_VEXPRESS_UART0_RS1
+		bool "Use PL011 UART0 at 0x1c090000 (RS1 complaint tiles)"
+		depends on ARCH_VEXPRESS
+		help
+		  This option selects UART0 at 0x1c090000. This applies to most
+		  of the tiles using the RS1 memory map, including all new A-class
+		  core tiles, FPGA-based SMMs and software models.
+
 	config DEBUG_LL_UART_NONE
 		bool "No low-level debugging UART"
 		help
diff --git a/arch/arm/mach-vexpress/include/mach/debug-macro.S b/arch/arm/mach-vexpress/include/mach/debug-macro.S
index fa82247..9f509f5 100644
--- a/arch/arm/mach-vexpress/include/mach/debug-macro.S
+++ b/arch/arm/mach-vexpress/include/mach/debug-macro.S
@@ -18,6 +18,8 @@
 
 #define DEBUG_LL_VIRT_BASE		0xf8000000
 
+#if defined(CONFIG_DEBUG_VEXPRESS_UART0_DETECT)
+
 		.macro	addruart,rp,rv,tmp
 
 		@ Make an educated guess regarding the memory map:
@@ -41,3 +43,42 @@
 		.endm
 
 #include <asm/hardware/debug-pl01x.S>
+
+#elif defined(CONFIG_DEBUG_VEXPRESS_UART0_CA9)
+
+		.macro	addruart,rp,rv,tmp
+		mov	\rp, #DEBUG_LL_UART_OFFSET
+		orr	\rv, \rp, #DEBUG_LL_VIRT_BASE
+		orr	\rp, \rp, #DEBUG_LL_PHYS_BASE
+		.endm
+
+#include <asm/hardware/debug-pl01x.S>
+
+#elif defined(CONFIG_DEBUG_VEXPRESS_UART0_RS1)
+
+		.macro	addruart,rp,rv,tmp
+		mov	\rp, #DEBUG_LL_UART_OFFSET_RS1
+		orr	\rv, \rp, #DEBUG_LL_VIRT_BASE
+		orr	\rp, \rp, #DEBUG_LL_PHYS_BASE_RS1
+		.endm
+
+#include <asm/hardware/debug-pl01x.S>
+
+#else /* CONFIG_DEBUG_LL_UART_NONE */
+
+		.macro	addruart, rp, rv, tmp
+		/* Safe dummy values */
+		mov	\rp, #0
+		mov	\rv, #DEBUG_LL_VIRT_BASE
+		.endm
+
+		.macro	senduart,rd,rx
+		.endm
+
+		.macro	waituart,rd,rx
+		.endm
+
+		.macro	busyuart,rd,rx
+		.endm
+
+#endif
diff --git a/arch/arm/mach-vexpress/include/mach/uncompress.h b/arch/arm/mach-vexpress/include/mach/uncompress.h
index 7dab559..1e472eb 100644
--- a/arch/arm/mach-vexpress/include/mach/uncompress.h
+++ b/arch/arm/mach-vexpress/include/mach/uncompress.h
@@ -27,6 +27,7 @@
 
 static unsigned long get_uart_base(void)
 {
+#if defined(CONFIG_DEBUG_VEXPRESS_UART0_DETECT)
 	unsigned long mpcore_periph;
 
 	/*
@@ -42,6 +43,13 @@ static unsigned long get_uart_base(void)
 		return UART_BASE;
 	else
 		return UART_BASE_RS1;
+#elif defined(CONFIG_DEBUG_VEXPRESS_UART0_CA9)
+	return UART_BASE;
+#elif defined(CONFIG_DEBUG_VEXPRESS_UART0_RS1)
+	return UART_BASE_RS1;
+#else
+	return 0;
+#endif
 }
 
 /*
@@ -51,6 +59,9 @@ static inline void putc(int c)
 {
 	unsigned long base = get_uart_base();
 
+	if (!base)
+		return;
+
 	while (AMBA_UART_FR(base) & (1 << 5))
 		barrier();
 
@@ -61,6 +72,9 @@ static inline void flush(void)
 {
 	unsigned long base = get_uart_base();
 
+	if (!base)
+		return;
+
 	while (AMBA_UART_FR(base) & (1 << 3))
 		barrier();
 }
-- 
1.7.9.5
