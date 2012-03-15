From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 15 Mar 2012 21:18:23 +0100
Subject: [PATCH] ARM: davinci: implement DEBUG_LL port choice
Message-ID: <1331842703-4248-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apart from the necessity to do this change for multi-platform kernels
the previous logic depended on the zImage decompressor to write the
physical and virtual address to a magic memory location.
If the decompressor is unused or not correctly configured for the
current machid, the addruart macro was an infinite loop. Moreover
debugging the early zImage code was not possible either.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig.debug                           |   16 ++++++
 arch/arm/mach-davinci/include/mach/debug-macro.S |   58 ++++++++--------------
 arch/arm/mach-davinci/include/mach/hardware.h    |    2 +-
 arch/arm/mach-davinci/include/mach/serial.h      |   10 ----
 arch/arm/mach-davinci/include/mach/uncompress.h  |   25 +++-------
 5 files changed, 44 insertions(+), 67 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index e0d236d..57019be 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -108,6 +108,22 @@ choice
 		bool "Kernel low-level debugging on 9263, 9g45 and cap9"
 		depends on HAVE_AT91_DBGU1
 
+	config DEBUG_DAVINCI_UART0
+		bool "Kernel low-level debugging on Davinci using uart0
+		depends on ARCH_DAVINCI_DM644x
+
+	config DEBUG_DA8XX_UART1
+		bool "Kernel low-level debugging on DA8xx using uart1"
+		depends on ARCH_DAVINCI_DA8XX
+
+	config DEBUG_DA8XX_UART2
+		bool "Kernel low-level debugging on DA8xx using uart2"
+		depends on ARCH_DAVINCI_DA8XX
+
+	config DEBUG_TNETV107X_UART1
+		bool "Kernel low-level debugging on TNETV107x using uart1
+		depends on ARCH_DAVINCI_TNETV107X
+
 	config DEBUG_FOOTBRIDGE_COM1
 		bool "Kernel low-level debugging messages via footbridge 8250 at PCI COM1"
 		depends on FOOTBRIDGE
diff --git a/arch/arm/mach-davinci/include/mach/debug-macro.S b/arch/arm/mach-davinci/include/mach/debug-macro.S
index cf94552..9c08295 100644
--- a/arch/arm/mach-davinci/include/mach/debug-macro.S
+++ b/arch/arm/mach-davinci/include/mach/debug-macro.S
@@ -22,46 +22,28 @@
 
 #define UART_SHIFT	2
 
-		.pushsection .data
-davinci_uart_phys:	.word	0
-davinci_uart_virt:	.word	0
-		.popsection
-
-		.macro addruart, rp, rv, tmp
-
-		/* Use davinci_uart_phys/virt if already configured */
-10:		adr	\rp, 99f		@ get effective addr of 99f
-		ldr	\rv, [\rp]		@ get absolute addr of 99f
-		sub	\rv, \rv, \rp		@ offset between the two
-		ldr	\rp, [\rp, #4]		@ abs addr of omap_uart_phys
-		sub	\tmp, \rp, \rv		@ make it effective
-		ldr	\rp, [\tmp, #0]		@ davinci_uart_phys
-		ldr	\rv, [\tmp, #4]		@ davinci_uart_virt
-		cmp	\rp, #0			@ is port configured?
-		cmpne	\rv, #0
-		bne	100f			@ already configured
-
-		/* Check the debug UART address set in uncompress.h */
-		and	\rp, pc, #0xff000000
-		ldr	\rv, =DAVINCI_UART_INFO_OFS
-		add	\rp, \rp, \rv
-
-		/* Copy uart phys address from decompressor uart info */
-		ldr	\rv, [\rp, #0]
-		str	\rv, [\tmp, #0]
-
-		/* Copy uart virt address from decompressor uart info */
-		ldr	\rv, [\rp, #4]
-		str	\rv, [\tmp, #4]
-
-		b	10b
+#if defined(CONFIG_DEBUG_DAVINCI_UART0)
+#define UART_BASE	DAVINCI_UART0_BASE
+#elif defined(CONFIG_DEBUG_DA8XX_UART0)
+#define UART_BASE	DA8XX_UART0_BASE
+#elif defined(CONFIG_DEBUG_DA8XX_UART1)
+#define UART_BASE	DA8XX_UART1_BASE
+#elif defined(CONFIG_DEBUG_DA8XX_UART2)
+#define UART_BASE	DA8XX_UART2_BASE
+#elif defined(CONFIG_DEBUG_TNETV107X_UART1)
+#define UART_BASE	TNETV107X_UART2_BASE
+#define UART_VIRTBASE	TNETV107X_UART2_VIRT
+#else
+#error "Select a specifc port for DEBUG_LL"
+#endif
 
-		.align
-99:		.word	.
-		.word	davinci_uart_phys
-		.ltorg
+#ifndef UART_VIRTBASE
+#define UART_VIRTBASE IO_ADDRESS(UART_BASE)
+#endif
 
-100:
+		.macro addruart, rp, rv, tmp
+		ldr     \rp, =UART_BASE
+		ldr     \rv, =UART_VIRTBASE
 		.endm
 
 		.macro	senduart,rd,rx
diff --git a/arch/arm/mach-davinci/include/mach/hardware.h b/arch/arm/mach-davinci/include/mach/hardware.h
index 414e0b9..649ddc2 100644
--- a/arch/arm/mach-davinci/include/mach/hardware.h
+++ b/arch/arm/mach-davinci/include/mach/hardware.h
@@ -24,7 +24,7 @@
 /*
  * I/O mapping
  */
-#define IO_PHYS				0x01c00000UL
+#define IO_PHYS				UL(0x01c00000)
 #define IO_OFFSET			0xfd000000 /* Virtual IO = 0xfec00000 */
 #define IO_SIZE				0x00400000
 #define IO_VIRT				(IO_PHYS + IO_OFFSET)
diff --git a/arch/arm/mach-davinci/include/mach/serial.h b/arch/arm/mach-davinci/include/mach/serial.h
index e347d88..46b3cd1 100644
--- a/arch/arm/mach-davinci/include/mach/serial.h
+++ b/arch/arm/mach-davinci/include/mach/serial.h
@@ -15,16 +15,6 @@
 
 #include <mach/hardware.h>
 
-/*
- * Stolen area that contains debug uart physical and virtual addresses.  These
- * addresses are filled in by the uncompress.h code, and are used by the debug
- * macros in debug-macro.S.
- *
- * This area sits just below the page tables (see arch/arm/kernel/head.S).
- * We define it as a relative offset from start of usable RAM.
- */
-#define DAVINCI_UART_INFO_OFS	0x3ff8
-
 #define DAVINCI_UART0_BASE	(IO_PHYS + 0x20000)
 #define DAVINCI_UART1_BASE	(IO_PHYS + 0x20400)
 #define DAVINCI_UART2_BASE	(IO_PHYS + 0x20800)
diff --git a/arch/arm/mach-davinci/include/mach/uncompress.h b/arch/arm/mach-davinci/include/mach/uncompress.h
index 9dc7cf9..25cf227 100644
--- a/arch/arm/mach-davinci/include/mach/uncompress.h
+++ b/arch/arm/mach-davinci/include/mach/uncompress.h
@@ -41,37 +41,25 @@ static inline void flush(void)
 		barrier();
 }
 
-static inline void set_uart_info(u32 phys, void * __iomem virt)
+static inline void set_uart_info(u32 phys)
 {
-	/*
-	 * Get address of some.bss variable and round it down
-	 * a la CONFIG_AUTO_ZRELADDR.
-	 */
-	u32 ram_start = (u32)&uart & 0xf8000000;
-	u32 *uart_info = (u32 *)(ram_start + DAVINCI_UART_INFO_OFS);
-
 	uart = (u32 *)phys;
-	uart_info[0] = phys;
-	uart_info[1] = (u32)virt;
 }
 
-#define _DEBUG_LL_ENTRY(machine, phys, virt)			\
+#define _DEBUG_LL_ENTRY(machine, phys)				\
 	if (machine_is_##machine()) {				\
-		set_uart_info(phys, virt);			\
+		set_uart_info(phys);				\
 		break;						\
 	}
 
 #define DEBUG_LL_DAVINCI(machine, port)				\
-	_DEBUG_LL_ENTRY(machine, DAVINCI_UART##port##_BASE,	\
-			IO_ADDRESS(DAVINCI_UART##port##_BASE))
+	_DEBUG_LL_ENTRY(machine, DAVINCI_UART##port##_BASE)
 
 #define DEBUG_LL_DA8XX(machine, port)				\
-	_DEBUG_LL_ENTRY(machine, DA8XX_UART##port##_BASE,	\
-			IO_ADDRESS(DA8XX_UART##port##_BASE))
+	_DEBUG_LL_ENTRY(machine, DA8XX_UART##port##_BASE)
 
 #define DEBUG_LL_TNETV107X(machine, port)			\
-	_DEBUG_LL_ENTRY(machine, TNETV107X_UART##port##_BASE,	\
-			TNETV107X_UART##port##_VIRT)
+	_DEBUG_LL_ENTRY(machine, TNETV107X_UART##port##_BASE)
 
 static inline void __arch_decomp_setup(unsigned long arch_id)
 {
@@ -96,6 +84,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		DEBUG_LL_DA8XX(davinci_da850_evm,	2);
 		DEBUG_LL_DA8XX(mityomapl138,		1);
 		DEBUG_LL_DA8XX(omapl138_hawkboard,	2);
+		DEBUG_LL_DA8XX(bje_display3_5,		0);
 
 		/* TNETV107x boards */
 		DEBUG_LL_TNETV107X(tnetv107x,		1);
-- 
1.7.9.1
