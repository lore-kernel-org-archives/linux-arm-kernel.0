From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 30 Jun 2016 17:42:39 -0700
Subject: [PATCH] ARM: brcmstb: Add earlyprintk support using run-time checks
Message-ID: <1467333764-2900-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SUN_TOP_CTRL_FAMILY_ID is at a fixed absolute address for all of our supported
chips, so utilize its value to determine what the UARTA base address should be.

Since the code is called both during decompressor when the MMU is off, and
after the MMU has been turned on, and we want to do the lookup only
once, we use the same technique as tegra.S and have a shared storage
location between the decompressor and the kernel.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/Kconfig.debug           |   7 +-
 arch/arm/include/debug/brcmstb.S | 145 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-bcm/brcmstb.c      |  16 +++++
 3 files changed, 163 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/include/debug/brcmstb.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 19a3dcf5eb2e..260a973ab87d 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -168,7 +168,6 @@ choice
 	config DEBUG_BRCMSTB_UART
 		bool "Use BRCMSTB UART for low-level debug"
 		depends on ARCH_BRCMSTB
-		select DEBUG_UART_8250
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the first serial port on these devices.
@@ -1408,6 +1407,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/zynq.S" if DEBUG_ZYNQ_UART0 || DEBUG_ZYNQ_UART1
 	default "debug/bcm63xx.S" if DEBUG_BCM63XX_UART
 	default "debug/digicolor.S" if DEBUG_DIGICOLOR_UA0
+	default "debug/brcmstb.S" if DEBUG_BRCMSTB_UART
 	default "mach/debug-macro.S"
 
 # Compatibility options for PL01x
@@ -1498,7 +1498,6 @@ config DEBUG_UART_PHYS
 	default 0xe6e60000 if DEBUG_RCAR_GEN2_SCIF0
 	default 0xe8008000 if DEBUG_R7S72100_SCIF2
 	default 0xf0000be0 if ARCH_EBSA110
-	default 0xf040ab00 if DEBUG_BRCMSTB_UART
 	default 0xf1012000 if DEBUG_MVEBU_UART0_ALTERNATE
 	default 0xf1012100 if DEBUG_MVEBU_UART1_ALTERNATE
 	default 0xf7fc9000 if DEBUG_BERLIN_UART
@@ -1574,7 +1573,6 @@ config DEBUG_UART_VIRT
 	default 0xfb002000 if DEBUG_CNS3XXX
 	default 0xfb009000 if DEBUG_REALVIEW_STD_PORT
 	default 0xfb10c000 if DEBUG_REALVIEW_PB1176_PORT
-	default 0xfc40ab00 if DEBUG_BRCMSTB_UART
 	default 0xfc705000 if DEBUG_ZTE_ZX
 	default 0xfcfe8600 if DEBUG_BCM63XX_UART
 	default 0xfd000000 if DEBUG_SPEAR3XX || DEBUG_SPEAR13XX
@@ -1646,8 +1644,7 @@ config DEBUG_UART_8250_WORD
 		DEBUG_ALPINE_UART0 || \
 		DEBUG_DAVINCI_DMx_UART0 || DEBUG_DAVINCI_DA8XX_UART1 || \
 		DEBUG_DAVINCI_DA8XX_UART2 || \
-		DEBUG_BCM_KONA_UART || DEBUG_RK32_UART2 || \
-		DEBUG_BRCMSTB_UART
+		DEBUG_BCM_KONA_UART || DEBUG_RK32_UART2
 
 config DEBUG_UART_8250_PALMCHIP
 	bool "8250 UART is Palmchip BK-310x"
diff --git a/arch/arm/include/debug/brcmstb.S b/arch/arm/include/debug/brcmstb.S
new file mode 100644
index 000000000000..bb27ef349a04
--- /dev/null
+++ b/arch/arm/include/debug/brcmstb.S
@@ -0,0 +1,145 @@
+/*
+ * Copyright (C) 2016 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/serial_reg.h>
+
+/* Physical register offset and virtual register offset */
+#define REG_PHYS_BASE		0xf0000000
+#define REG_VIRT_BASE		0xfc000000
+#define REG_PHYS_ADDR(x)	((x) + REG_PHYS_BASE)
+
+/* Product id can be read from here */
+#define SUN_TOP_CTRL_BASE	REG_PHYS_ADDR(0x404000)
+
+#define UARTA_3390		REG_PHYS_ADDR(0x40a900)
+#define UARTA_7250		REG_PHYS_ADDR(0x40b400)
+#define UARTA_7268		REG_PHYS_ADDR(0x40c000)
+#define UARTA_7271		UARTA_7268
+#define UARTA_7364		REG_PHYS_ADDR(0x40b000)
+#define UARTA_7366		UARTA_7364
+#define UARTA_74371		REG_PHYS_ADDR(0x406b00)
+#define UARTA_7439		REG_PHYS_ADDR(0x40a900)
+#define UARTA_7445		REG_PHYS_ADDR(0x40ab00)
+
+#define UART_SHIFT		2
+
+#define checkuart(rp, rv, family_id, family) \
+		/* Load family id */ \
+		ldr	rp, =family_id ; \
+		/* Compare SUN_TOP_CTRL value against it */ \
+		cmp	rp, rv ; \
+		/* Passed test, load address */ \
+		ldreq	rp, =UARTA_##family ; \
+		/* Jump to save UART address */ \
+		beq	91f
+
+		.macro  addruart, rp, rv, tmp
+		adr	\rp, 99f		@ actual addr of 99f
+		ldr	\rv, [\rp]		@ linked addr is stored there
+		sub	\rv, \rv, \rp		@ offset between the two
+		ldr	\rp, [\rp, #4]		@ linked brcmstb_uart_config
+		sub	\tmp, \rp, \rv		@ actual brcmstb_uart_config
+		ldr	\rp, [\tmp]		@ Load brcmstb_uart_config
+		cmp	\rp, #1			@ needs initialization?
+		bne	100f			@ no; go load the addresses
+		mov	\rv, #0			@ yes; record init is done
+		str	\rv, [\tmp]
+
+		/* Check SUN_TOP_CTRL base */
+		ldr	\rp, =SUN_TOP_CTRL_BASE	@ load SUN_TOP_CTRL PA
+		ldr	\rv, [\rp, #0]		@ get register contents
+		and	\rv, \rv, #0xffffff00	@ strip revision bits [7:0]
+
+		/* Chip specific detection starts here */
+20:		checkuart(\rp, \rv, 0x33900000, 3390)
+21:		checkuart(\rp, \rv, 0x72500000, 7250)
+22:		checkuart(\rp, \rv, 0x72680000, 7268)
+23:		checkuart(\rp, \rv, 0x72710000, 7271)
+24:		checkuart(\rp, \rv, 0x73640000, 7364)
+25:		checkuart(\rp, \rv, 0x73660000, 7366)
+26:		checkuart(\rp, \rv, 0x07437100, 74371)
+27:		checkuart(\rp, \rv, 0x74390000, 7439)
+28:		checkuart(\rp, \rv, 0x74450000, 7445)
+
+		/* No valid UART found */
+90:		mov	\rp, #0
+		/* fall through */
+
+		/* Record whichever UART we chose */
+91:		str	\rp, [\tmp, #4]		@ Store in brcmstb_uart_phys
+		cmp	\rp, #0			@ Valid UART address?
+		bne	92f			@ Yes, go process it
+		str	\rp, [\tmp, #8]		@ Store 0 in brcmstb_uart_virt
+		b	100f			@ Done
+92:		and	\rv, \rp, #0xffffff	@ offset within 1MB section
+		add	\rv, \rv, #REG_VIRT_BASE
+		str	\rv, [\tmp, #8]		@ Store in brcmstb_uart_virt
+		b	100f
+
+		.align
+99:		.word	.
+		.word	brcmstb_uart_config
+		.ltorg
+
+		/* Load previously selected UART address */
+100:		ldr	\rp, [\tmp, #4]		@ Load brcmstb_uart_phys
+		ldr	\rv, [\tmp, #8]		@ Load brcmstb_uart_virt
+		.endm
+
+		.macro	store, rd, rx:vararg
+		str	\rd, \rx
+		.endm
+
+		.macro	load, rd, rx:vararg
+		ldr	\rd, \rx
+		.endm
+
+		.macro	senduart,rd,rx
+		store	\rd, [\rx, #UART_TX << UART_SHIFT]
+		.endm
+
+		.macro	busyuart,rd,rx
+1002:		load	\rd, [\rx, #UART_LSR << UART_SHIFT]
+		and	\rd, \rd, #UART_LSR_TEMT | UART_LSR_THRE
+		teq	\rd, #UART_LSR_TEMT | UART_LSR_THRE
+		bne	1002b
+		.endm
+
+		.macro	waituart,rd,rx
+		.endm
+
+/*
+ * Storage for the state maintained by the macros above.
+ *
+ * In the kernel proper, this data is located in arch/arm/mach-bcm/brcmstb.c.
+ * That's because this header is included from multiple files, and we only
+ * want a single copy of the data. In particular, the UART probing code above
+ * assumes it's running using physical addresses. This is true when this file
+ * is included from head.o, but not when included from debug.o. So we need
+ * to share the probe results between the two copies, rather than having
+ * to re-run the probing again later.
+ *
+ * In the decompressor, we put the symbol/storage right here, since common.c
+ * isn't included in the decompressor build. This symbol gets put in .text
+ * even though it's really data, since .data is discarded from the
+ * decompressor. Luckily, .text is writeable in the decompressor, unless
+ * CONFIG_ZBOOT_ROM. That dependency is handled in arch/arm/Kconfig.debug.
+ */
+#if defined(ZIMAGE)
+brcmstb_uart_config:
+	/* Debug UART initialization required */
+	.word 1
+	/* Debug UART physical address */
+	.word 0
+	/* Debug UART virtual address */
+	.word 0
+#endif
diff --git a/arch/arm/mach-bcm/brcmstb.c b/arch/arm/mach-bcm/brcmstb.c
index 99a67cfb7c0d..07e3a86c6466 100644
--- a/arch/arm/mach-bcm/brcmstb.c
+++ b/arch/arm/mach-bcm/brcmstb.c
@@ -19,6 +19,22 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+/*
+ * Storage for debug-macro.S's state.
+ *
+ * This must be in .data not .bss so that it gets initialized each time the
+ * kernel is loaded. The data is declared here rather than debug-macro.S so
+ * that multiple inclusions of debug-macro.S point at the same data.
+ */
+u32 brcmstb_uart_config[3] = {
+	/* Debug UART initialization required */
+	1,
+	/* Debug UART physical address */
+	0,
+	/* Debug UART virtual address */
+	0,
+};
+
 static void __init brcmstb_init_irq(void)
 {
 	irqchip_init();
-- 
2.7.4
