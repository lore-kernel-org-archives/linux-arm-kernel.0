From: hjk@linutronix.de (Hans J. Koch)
Date: Wed, 26 May 2010 19:47:38 +0200
Subject: [PATCH 1/7 v6] Introduce plat-tcc
In-Reply-To: <20100526174240.GC2006@bluebox.local>
References: <20100526174240.GC2006@bluebox.local>
Message-ID: <20100526174736.GD2006@bluebox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces support for the tcc platform by creating an
arch/arm/plat-tcc and arch/arm/mach-tcc8k directories and adding
basic include files plus Kconfig and Makefile.

Signed-off-by: "Hans J. Koch" <hjk@linutronix.de>
---
 arch/arm/Kconfig                             |   11 +
 arch/arm/Makefile                            |    2 +
 arch/arm/mach-tcc8k/Kconfig                  |    5 +
 arch/arm/plat-tcc/Kconfig                    |   20 +
 arch/arm/plat-tcc/Makefile                   |    3 +
 arch/arm/plat-tcc/include/mach/debug-macro.S |   33 ++
 arch/arm/plat-tcc/include/mach/entry-macro.S |   69 +++
 arch/arm/plat-tcc/include/mach/hardware.h    |   43 ++
 arch/arm/plat-tcc/include/mach/memory.h      |   19 +
 arch/arm/plat-tcc/include/mach/system.h      |   31 +
 arch/arm/plat-tcc/include/mach/tcc8k-regs.h  |  796 ++++++++++++++++++++++++++
 arch/arm/plat-tcc/include/mach/uncompress.h  |   34 ++
 arch/arm/plat-tcc/include/mach/vmalloc.h     |   11 +
 arch/arm/plat-tcc/system.c                   |   26 +
 14 files changed, 1103 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tcc8k/Kconfig
 create mode 100644 arch/arm/plat-tcc/Kconfig
 create mode 100644 arch/arm/plat-tcc/Makefile
 create mode 100644 arch/arm/plat-tcc/include/mach/debug-macro.S
 create mode 100644 arch/arm/plat-tcc/include/mach/entry-macro.S
 create mode 100644 arch/arm/plat-tcc/include/mach/hardware.h
 create mode 100644 arch/arm/plat-tcc/include/mach/memory.h
 create mode 100644 arch/arm/plat-tcc/include/mach/system.h
 create mode 100644 arch/arm/plat-tcc/include/mach/tcc8k-regs.h
 create mode 100644 arch/arm/plat-tcc/include/mach/uncompress.h
 create mode 100644 arch/arm/plat-tcc/include/mach/vmalloc.h
 create mode 100644 arch/arm/plat-tcc/system.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 92622eb..dd7001d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -724,6 +724,15 @@ config ARCH_SHARK
 	  Support for the StrongARM based Digital DNARD machine, also known
 	  as "Shark" (<http://www.shark-linux.de/shark.html>).
 
+config ARCH_TCC_926
+	bool "Telechips TCC ARM926-based systems"
+	select CPU_ARM926T
+	select HAVE_CLK
+	select COMMON_CLKDEV
+	select GENERIC_CLOCKEVENTS
+	help
+	  Support for Telechips TCC ARM926-based systems.
+
 config ARCH_LH7A40X
 	bool "Sharp LH7A40X"
 	select CPU_ARM922T
@@ -888,6 +897,8 @@ source "arch/arm/plat-s3c24xx/Kconfig"
 source "arch/arm/plat-s5p/Kconfig"
 source "arch/arm/plat-s5pc1xx/Kconfig"
 
+source "arch/arm/plat-tcc/Kconfig"
+
 if ARCH_S3C2410
 source "arch/arm/mach-s3c2400/Kconfig"
 source "arch/arm/mach-s3c2410/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index ed820e7..9656799 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -172,6 +172,7 @@ machine-$(CONFIG_ARCH_SHARK)		:= shark
 machine-$(CONFIG_ARCH_SHMOBILE) 	:= shmobile
 machine-$(CONFIG_ARCH_STMP378X)		:= stmp378x
 machine-$(CONFIG_ARCH_STMP37XX)		:= stmp37xx
+machine-$(CONFIG_ARCH_TCC8K)		:= tcc8k
 machine-$(CONFIG_ARCH_U300)		:= u300
 machine-$(CONFIG_ARCH_U8500)		:= ux500
 machine-$(CONFIG_ARCH_VERSATILE)	:= versatile
@@ -192,6 +193,7 @@ plat-$(CONFIG_PLAT_PXA)		:= pxa
 plat-$(CONFIG_PLAT_S3C24XX)	:= s3c24xx samsung
 plat-$(CONFIG_PLAT_S5PC1XX)	:= s5pc1xx samsung
 plat-$(CONFIG_PLAT_S5P)		:= s5p samsung
+plat-$(CONFIG_ARCH_TCC_926)	:= tcc
 
 ifeq ($(CONFIG_ARCH_EBSA110),y)
 # This is what happens if you forget the IOCS16 line.
diff --git a/arch/arm/mach-tcc8k/Kconfig b/arch/arm/mach-tcc8k/Kconfig
new file mode 100644
index 0000000..ec7f71b
--- /dev/null
+++ b/arch/arm/mach-tcc8k/Kconfig
@@ -0,0 +1,5 @@
+if ARCH_TCC8K
+
+comment "TCC8000 systems:"
+
+endif
diff --git a/arch/arm/plat-tcc/Kconfig b/arch/arm/plat-tcc/Kconfig
new file mode 100644
index 0000000..1bf4995
--- /dev/null
+++ b/arch/arm/plat-tcc/Kconfig
@@ -0,0 +1,20 @@
+if ARCH_TCC_926
+
+menu "Telechips ARM926-based CPUs"
+
+choice
+	prompt "Telechips CPU type:"
+	default ARCH_TCC8K
+
+config ARCH_TCC8K
+	bool TCC8000
+	select USB_ARCH_HAS_OHCI
+	help
+	  Support for Telechips TCC8000 systems
+
+endchoice
+
+source "arch/arm/mach-tcc8k/Kconfig"
+
+endmenu
+endif
diff --git a/arch/arm/plat-tcc/Makefile b/arch/arm/plat-tcc/Makefile
new file mode 100644
index 0000000..3f2e4fe
--- /dev/null
+++ b/arch/arm/plat-tcc/Makefile
@@ -0,0 +1,3 @@
+# "Telechips Platform Common Modules"
+
+obj-y := system.o
diff --git a/arch/arm/plat-tcc/include/mach/debug-macro.S b/arch/arm/plat-tcc/include/mach/debug-macro.S
new file mode 100644
index 0000000..9753784
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/debug-macro.S
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 1994-1999 Russell King
+ * Copyright (C) 2008-2009 Telechips
+ * Copyright (C) 2009 Hans J. Koch <hjk@linutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+		.macro	addruart,rx,tmp
+		mrc	p15, 0, \rx, c1, c0
+		tst	\rx, #1			@ MMU enabled?
+		moveq	\rx, #0x90000000	@ physical base address
+		movne	\rx, #0xF1000000	@ virtual base
+		orr	\rx, \rx, #0x00007000	@ UART0
+		.endm
+
+		.macro	senduart,rd,rx
+		strb	\rd, [\rx, #0x44]
+		.endm
+
+		.macro	waituart,rd,rx
+		.endm
+
+		.macro	busyuart,rd,rx
+1001:
+		ldr \rd, [\rx, #0x14]
+		tst \rd, #0x20
+
+		beq 1001b
+		.endm
diff --git a/arch/arm/plat-tcc/include/mach/entry-macro.S b/arch/arm/plat-tcc/include/mach/entry-macro.S
new file mode 100644
index 0000000..6099b6a
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/entry-macro.S
@@ -0,0 +1,69 @@
+/*
+ * include/asm-arm/arch-tcc83x/entry-macro.S
+ *
+ * Author : <linux@telechips.com>
+ * Created: June 10, 2008
+ * Description: Low-level IRQ helper macros for Telechips-based platforms
+ *
+ * Copyright (C) 2008-2009 Telechips
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+
+	.macro	disable_fiq
+	.endm
+
+	.macro  get_irqnr_preamble, base, tmp
+	.endm
+
+	.macro  arch_ret_to_user, tmp1, tmp2
+	.endm
+
+	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
+
+		ldr	\base, =0xF2003000 @ base address of PIC registers
+
+		@@ read MREQ register of PIC0
+
+		mov	\irqnr, #0
+		ldr	\irqstat, [\base, #0x00000014 ]	@ lower 32 interrupts
+		cmp	\irqstat, #0
+		bne	1001f
+
+		@@ read MREQ register of PIC1
+
+		ldr	\irqstat, [\base, #0x00000094]	@ upper 32 interrupts
+		cmp	\irqstat, #0
+		beq	1002f
+		mov	\irqnr, #0x20
+
+1001:
+		movs	\tmp, \irqstat, lsl #16
+		movne	\irqstat, \tmp
+		addeq	\irqnr, \irqnr, #16
+
+		movs	\tmp, \irqstat, lsl #8
+		movne	\irqstat, \tmp
+		addeq	\irqnr, \irqnr, #8
+
+		movs	\tmp, \irqstat, lsl #4
+		movne	\irqstat, \tmp
+		addeq	\irqnr, \irqnr, #4
+
+		movs	\tmp, \irqstat, lsl #2
+		movne	\irqstat, \tmp
+		addeq	\irqnr, \irqnr, #2
+
+		movs	\tmp, \irqstat, lsl #1
+		addeq	\irqnr, \irqnr, #1
+		orrs	\base, \base, #1
+1002:
+		@@ exit here, Z flag unset if IRQ
+
+	.endm
+
diff --git a/arch/arm/plat-tcc/include/mach/hardware.h b/arch/arm/plat-tcc/include/mach/hardware.h
new file mode 100644
index 0000000..e70d126
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/hardware.h
@@ -0,0 +1,43 @@
+/*
+ * Author: RidgeRun, Inc. Greg Lonnon <glonnon@ridgerun.com>
+ * Reorganized for Linux-2.6 by Tony Lindgren <tony@atomide.com>
+ *                          and Dirk Behme <dirk.behme@de.bosch.com>
+ * Rewritten by:    <linux@telechips.com>
+ * Description: Hardware definitions for TCC8300 processors and boards
+ *
+ * Copyright (C) 2001 RidgeRun, Inc.
+ * Copyright (C) 2008-2009 Telechips
+ *
+ * Modifications for mainline (C) 2009 Hans J. Koch <hjk@linutronix.de>
+ *
+ * Licensed under the terms of the GNU Pulic License version 2.
+ */
+
+#ifndef __ASM_ARCH_TCC_HARDWARE_H
+#define __ASM_ARCH_TCC_HARDWARE_H
+
+#include <asm/sizes.h>
+#ifndef __ASSEMBLER__
+#include <asm/types.h>
+#endif
+#include <mach/io.h>
+
+/*
+ * ----------------------------------------------------------------------------
+ * Clocks
+ * ----------------------------------------------------------------------------
+ */
+#define CLKGEN_REG_BASE		0xfffece00
+#define ARM_CKCTL		(CLKGEN_REG_BASE + 0x0)
+#define ARM_IDLECT1		(CLKGEN_REG_BASE + 0x4)
+#define ARM_IDLECT2		(CLKGEN_REG_BASE + 0x8)
+#define ARM_EWUPCT		(CLKGEN_REG_BASE + 0xC)
+#define ARM_RSTCT1		(CLKGEN_REG_BASE + 0x10)
+#define ARM_RSTCT2		(CLKGEN_REG_BASE + 0x14)
+#define ARM_SYSST		(CLKGEN_REG_BASE + 0x18)
+#define ARM_IDLECT3		(CLKGEN_REG_BASE + 0x24)
+
+/* DPLL control registers */
+#define DPLL_CTL		0xfffecf00
+
+#endif	/* __ASM_ARCH_TCC_HARDWARE_H */
diff --git a/arch/arm/plat-tcc/include/mach/memory.h b/arch/arm/plat-tcc/include/mach/memory.h
new file mode 100644
index 0000000..1c3478d
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/memory.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) 1999 ARM Limited
+ * Copyright (C) 2000 RidgeRun, Inc.
+ * Copyright (C) 2008-2009 Telechips
+ * Copyright (C) 2010 Hans J. Koch <hjk@linutronix.de>
+ *
+ * Licensed under the terms of the GPL v2.
+ */
+
+#ifndef __ASM_ARCH_MEMORY_H
+#define __ASM_ARCH_MEMORY_H
+
+/*
+ * Physical DRAM offset.
+ */
+#define PHYS_OFFSET		UL(0x20000000)
+
+#endif
+
diff --git a/arch/arm/plat-tcc/include/mach/system.h b/arch/arm/plat-tcc/include/mach/system.h
new file mode 100644
index 0000000..909e603
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/system.h
@@ -0,0 +1,31 @@
+/*
+ * Author: <linux@telechips.com>
+ * Created: June 10, 2008
+ * Description: LINUX SYSTEM FUNCTIONS for TCC83x
+ *
+ * Copyright (C) 2008-2009 Telechips
+ *
+ * Licensed under the terms of the GPL v2.
+ *
+ */
+
+#ifndef __ASM_ARCH_SYSTEM_H
+#define __ASM_ARCH_SYSTEM_H
+#include <linux/clk.h>
+
+#include <asm/mach-types.h>
+#include <mach/hardware.h>
+
+extern void plat_tcc_reboot(void);
+
+static inline void arch_idle(void)
+{
+	cpu_do_idle();
+}
+
+static inline void arch_reset(char mode, const char *cmd)
+{
+	plat_tcc_reboot();
+}
+
+#endif
diff --git a/arch/arm/plat-tcc/include/mach/tcc8k-regs.h b/arch/arm/plat-tcc/include/mach/tcc8k-regs.h
new file mode 100644
index 0000000..f3243eb
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/tcc8k-regs.h
@@ -0,0 +1,796 @@
+/*
+ * Telechips TCC8000 register definitions
+ *
+ * (C) 2009 Hans J. Koch <hjk@linutronix.de>
+ *
+ * Licensed under the terms of the GPLv2.
+ */
+
+#ifndef TCC8K_REGS_H
+#define TCC8K_REGS_H
+
+#include <linux/types.h>
+
+#define EXT_SDRAM_BASE		0x20000000
+#define INT_SRAM_BASE		0x30000000
+#define INT_SRAM_SIZE		SZ_32K
+#define CS0_BASE		0x40000000
+#define CS1_BASE		0x50000000
+#define CS1_SIZE		SZ_64K
+#define CS2_BASE		0x60000000
+#define CS3_BASE		0x70000000
+#define AHB_PERI_BASE		0x80000000
+#define AHB_PERI_SIZE		SZ_64K
+#define APB0_PERI_BASE		0x90000000
+#define APB0_PERI_SIZE		SZ_128K
+#define APB1_PERI_BASE		0x98000000
+#define APB1_PERI_SIZE		SZ_128K
+#define DATA_TCM_BASE		0xa0000000
+#define DATA_TCM_SIZE		SZ_8K
+#define EXT_MEM_CTRL_BASE	0xf0000000
+#define EXT_MEM_CTRL_SIZE	SZ_4K
+
+#define CS1_BASE_VIRT		0xf7000000
+#define AHB_PERI_BASE_VIRT	0xf4000000
+#define APB0_PERI_BASE_VIRT	0xf1000000
+#define APB1_PERI_BASE_VIRT	0xf2000000
+#define EXT_MEM_CTRL_BASE_VIRT	0xf3000000
+#define INT_SRAM_BASE_VIRT	0xf5000000
+#define DATA_TCM_BASE_VIRT	0xf6000000
+
+#define __REG(x)     (*((volatile u32 *)(x)))
+
+/* USB Device Controller Registers */
+#define UDC_BASE	(AHB_PERI_BASE_VIRT + 0x8000)
+#define UDC_BASE_PHYS	(AHB_PERI_BASE + 0x8000)
+
+#define UDC_IR_OFFS		0x00
+#define UDC_EIR_OFFS		0x04
+#define UDC_EIER_OFFS		0x08
+#define UDC_FAR_OFFS		0x0c
+#define UDC_FNR_OFFS		0x10
+#define UDC_EDR_OFFS		0x14
+#define UDC_RT_OFFS		0x18
+#define UDC_SSR_OFFS		0x1c
+#define UDC_SCR_OFFS		0x20
+#define UDC_EP0SR_OFFS		0x24
+#define UDC_EP0CR_OFFS		0x28
+
+#define UDC_ESR_OFFS		0x2c
+#define UDC_ECR_OFFS		0x30
+#define UDC_BRCR_OFFS		0x34
+#define UDC_BWCR_OFFS		0x38
+#define UDC_MPR_OFFS		0x3c
+#define UDC_DCR_OFFS		0x40
+#define UDC_DTCR_OFFS		0x44
+#define UDC_DFCR_OFFS		0x48
+#define UDC_DTTCR1_OFFS		0x4c
+#define UDC_DTTCR2_OFFS		0x50
+#define UDC_ESR2_OFFS		0x54
+
+#define UDC_SCR2_OFFS		0x58
+#define UDC_EP0BUF_OFFS		0x60
+#define UDC_EP1BUF_OFFS		0x64
+#define UDC_EP2BUF_OFFS		0x68
+#define UDC_EP3BUF_OFFS		0x6c
+#define UDC_PLICR_OFFS		0xa0
+#define UDC_PCR_OFFS		0xa4
+
+#define UDC_UPCR0_OFFS		0xc8
+#define UDC_UPCR1_OFFS		0xcc
+#define UDC_UPCR2_OFFS		0xd0
+#define UDC_UPCR3_OFFS		0xd4
+
+/* Bits in UDC_EIR */
+#define UDC_EIR_EP0I		(1 << 0)
+#define UDC_EIR_EP1I		(1 << 1)
+#define UDC_EIR_EP2I		(1 << 2)
+#define UDC_EIR_EP3I		(1 << 3)
+#define UDC_EIR_EPI_MASK	0x0f
+
+/* Bits in UDC_EIER */
+#define UDC_EIER_EP0IE		(1 << 0)
+#define UDC_EIER_EP1IE		(1 << 1)
+#define UDC_EIER_EP2IE		(1 << 2)
+#define UDC_EIER_EP3IE		(1 << 3)
+
+/* Bits in UDC_FNR */
+#define UDC_FNR_FN_MASK		0x7ff
+#define UDC_FNR_SM		(1 << 13)
+#define UDC_FNR_FTL		(1 << 14)
+
+/* Bits in UDC_SSR */
+#define UDC_SSR_HFRES		(1 << 0)
+#define UDC_SSR_HFSUSP		(1 << 1)
+#define UDC_SSR_HFRM		(1 << 2)
+#define UDC_SSR_SDE		(1 << 3)
+#define UDC_SSR_HSP		(1 << 4)
+#define UDC_SSR_DM		(1 << 5)
+#define UDC_SSR_DP		(1 << 6)
+#define UDC_SSR_TBM		(1 << 7)
+#define UDC_SSR_VBON		(1 << 8)
+#define UDC_SSR_VBOFF		(1 << 9)
+#define UDC_SSR_EOERR		(1 << 10)
+#define UDC_SSR_DCERR		(1 << 11)
+#define UDC_SSR_TCERR		(1 << 12)
+#define UDC_SSR_BSERR		(1 << 13)
+#define UDC_SSR_TMERR		(1 << 14)
+#define UDC_SSR_BAERR		(1 << 15)
+
+/* Bits in UDC_SCR */
+#define UDC_SCR_HRESE		(1 << 0)
+#define UDC_SCR_HSSPE		(1 << 1)
+#define UDC_SCR_RRDE		(1 << 5)
+#define UDC_SCR_SPDEN		(1 << 6)
+#define UDC_SCR_DIEN		(1 << 12)
+
+/* Bits in UDC_EP0SR */
+#define UDC_EP0SR_RSR		(1 << 0)
+#define UDC_EP0SR_TST		(1 << 1)
+#define UDC_EP0SR_SHT		(1 << 4)
+#define UDC_EP0SR_LWO		(1 << 6)
+
+/* Bits in UDC_EP0CR */
+#define UDC_EP0CR_ESS		(1 << 1)
+
+/* Bits in UDC_ESR */
+#define UDC_ESR_RPS		(1 << 0)
+#define UDC_ESR_TPS		(1 << 1)
+#define UDC_ESR_LWO		(1 << 4)
+#define UDC_ESR_FFS		(1 << 6)
+
+/* Bits in UDC_ECR */
+#define UDC_ECR_ESS		(1 << 1)
+#define UDC_ECR_CDP		(1 << 2)
+
+#define UDC_ECR_FLUSH		(1 << 6)
+#define UDC_ECR_DUEN		(1 << 7)
+
+/* Bits in UDC_UPCR0 */
+#define UDC_UPCR0_VBD		(1 << 1)
+#define UDC_UPCR0_VBDS		(1 << 6)
+#define UDC_UPCR0_RCD_12	(0x0 << 9)
+#define UDC_UPCR0_RCD_24	(0x1 << 9)
+#define UDC_UPCR0_RCD_48	(0x2 << 9)
+#define UDC_UPCR0_RCS_EXT	(0x1 << 11)
+#define UDC_UPCR0_RCS_XTAL	(0x0 << 11)
+
+/* Bits in UDC_UPCR1 */
+#define UDC_UPCR1_CDT(x)	((x) << 0)
+#define UDC_UPCR1_OTGT(x)	((x) << 3)
+#define UDC_UPCR1_SQRXT(x)	((x) << 8)
+#define UDC_UPCR1_TXFSLST(x)	((x) << 12)
+
+/* Bits in UDC_UPCR2 */
+#define UDC_UPCR2_TP		(1 << 0)
+#define UDC_UPCR2_TXRT(x)	((x) << 2)
+#define UDC_UPCR2_TXVRT(x)	((x) << 5)
+#define UDC_UPCR2_OPMODE(x)	((x) << 9)
+#define UDC_UPCR2_XCVRSEL(x)	((x) << 12)
+#define UDC_UPCR2_TM		(1 << 14)
+
+/* USB Host Controller registers */
+#define USBH0_BASE	(AHB_PERI_BASE_VIRT + 0xb000)
+#define USBH1_BASE	(AHB_PERI_BASE_VIRT + 0xb800)
+
+#define OHCI_INT_ENABLE_OFFS	0x10
+
+#define RH_DESCRIPTOR_A_OFFS	0x48
+#define RH_DESCRIPTOR_B_OFFS	0x4c
+
+#define USBHTCFG0_OFFS		0x100
+#define USBHHCFG0_OFFS		0x104
+#define USBHHCFG1_OFFS		0x104
+
+/* DMA controller registers */
+#define DMAC0_BASE	(AHB_PERI_BASE + 0x4000)
+#define DMAC1_BASE	(AHB_PERI_BASE + 0xa000)
+#define DMAC2_BASE	(AHB_PERI_BASE + 0x4800)
+#define DMAC3_BASE	(AHB_PERI_BASE + 0xa800)
+
+#define DMAC_CH_OFFSET(ch)	(ch * 0x30)
+
+#define ST_SADR_OFFS		0x00
+#define SPARAM_OFFS		0x04
+#define C_SADR_OFFS		0x0c
+#define ST_DADR_OFFS		0x10
+#define DPARAM_OFFS		0x14
+#define C_DADR_OFFS		0x1c
+#define HCOUNT_OFFS		0x20
+#define CHCTRL_OFFS		0x24
+#define RPTCTRL_OFFS		0x28
+#define EXTREQ_A_OFFS		0x2c
+
+/* Bits in CHCTRL register */
+#define CHCTRL_EN		(1 << 0)
+
+#define CHCTRL_IEN		(1 << 2)
+#define CHCTRL_FLAG		(1 << 3)
+#define CHCTRL_WSIZE8		(0 << 4)
+#define CHCTRL_WSIZE16		(1 << 4)
+#define CHCTRL_WSIZE32		(2 << 4)
+
+#define CHCTRL_BSIZE1		(0 << 6)
+#define CHCTRL_BSIZE2		(1 << 6)
+#define CHCTRL_BSIZE4		(2 << 6)
+#define CHCTRL_BSIZE8		(3 << 6)
+
+#define CHCTRL_TYPE_SINGLE_E	(0 << 8)
+#define CHCTRL_TYPE_HW		(1 << 8)
+#define CHCTRL_TYPE_SW		(2 << 8)
+#define CHCTRL_TYPE_SINGLE_L	(3 << 8)
+
+#define CHCTRL_BST		(1 << 10)
+
+/* Use DMA controller 0, channel 2 for USB */
+#define USB_DMA_BASE		(DMAC0_BASE + DMAC_CH_OFFSET(2))
+
+/* NAND flash controller registers */
+#define NFC_BASE	(AHB_PERI_BASE_VIRT + 0xd000)
+#define NFC_BASE_PHYS	(AHB_PERI_BASE + 0xd000)
+
+#define NFC_CMD_OFFS		0x00
+#define NFC_LADDR_OFFS		0x04
+#define NFC_BADDR_OFFS		0x08
+#define NFC_SADDR_OFFS		0x0c
+#define NFC_WDATA_OFFS		0x10
+#define NFC_LDATA_OFFS		0x20
+#define NFC_SDATA_OFFS		0x40
+#define NFC_CTRL_OFFS		0x50
+#define NFC_PSTART_OFFS		0x54
+#define NFC_RSTART_OFFS		0x58
+#define NFC_DSIZE_OFFS		0x5c
+#define NFC_IREQ_OFFS		0x60
+#define NFC_RST_OFFS		0x64
+#define NFC_CTRL1_OFFS		0x68
+#define NFC_MDATA_OFFS		0x70
+
+#define NFC_WDATA_PHYS_ADDR	(NFC_BASE_PHYS + NFC_WDATA_OFFS)
+
+/* Bits in NFC_CTRL */
+#define NFC_CTRL_BHLD_MASK	(0xf << 0)
+#define NFC_CTRL_BPW_MASK	(0xf << 4)
+#define NFC_CTRL_BSTP_MASK	(0xf << 8)
+#define NFC_CTRL_CADDR_MASK	(0x7 << 12)
+#define NFC_CTRL_CADDR_1	(0x0 << 12)
+#define NFC_CTRL_CADDR_2	(0x1 << 12)
+#define NFC_CTRL_CADDR_3	(0x2 << 12)
+#define NFC_CTRL_CADDR_4	(0x3 << 12)
+#define NFC_CTRL_CADDR_5	(0x4 << 12)
+#define NFC_CTRL_MSK		(1 << 15)
+#define NFC_CTRL_PSIZE256	(0 << 16)
+#define NFC_CTRL_PSIZE512	(1 << 16)
+#define NFC_CTRL_PSIZE1024	(2 << 16)
+#define NFC_CTRL_PSIZE2048	(3 << 16)
+#define NFC_CTRL_PSIZE4096	(4 << 16)
+#define NFC_CTRL_PSIZE_MASK	(7 << 16)
+#define NFC_CTRL_BSIZE1		(0 << 19)
+#define NFC_CTRL_BSIZE2		(1 << 19)
+#define NFC_CTRL_BSIZE4		(2 << 19)
+#define NFC_CTRL_BSIZE8		(3 << 19)
+#define NFC_CTRL_BSIZE_MASK	(3 << 19)
+#define NFC_CTRL_RDY		(1 << 21)
+#define NFC_CTRL_CS0SEL		(1 << 22)
+#define NFC_CTRL_CS1SEL		(1 << 23)
+#define NFC_CTRL_CS2SEL		(1 << 24)
+#define NFC_CTRL_CS3SEL		(1 << 25)
+#define NFC_CTRL_CSMASK		(0xf << 22)
+#define NFC_CTRL_BW		(1 << 26)
+#define NFC_CTRL_FS		(1 << 27)
+#define NFC_CTRL_DEN		(1 << 28)
+#define NFC_CTRL_READ_IEN	(1 << 29)
+#define NFC_CTRL_PROG_IEN	(1 << 30)
+#define NFC_CTRL_RDY_IEN	(1 << 31)
+
+/* Bits in NFC_IREQ */
+#define NFC_IREQ_IRQ0		(1 << 0)
+#define NFC_IREQ_IRQ1		(1 << 1)
+#define NFC_IREQ_IRQ2		(1 << 2)
+
+#define NFC_IREQ_FLAG0		(1 << 4)
+#define NFC_IREQ_FLAG1		(1 << 5)
+#define NFC_IREQ_FLAG2		(1 << 6)
+
+/* MMC controller registers */
+#define MMC0_BASE	(AHB_PERI_BASE_VIRT + 0xe000)
+#define MMC1_BASE	(AHB_PERI_BASE_VIRT + 0xe800)
+
+/* UART base addresses */
+
+#define UART0_BASE	(APB0_PERI_BASE_VIRT + 0x07000)
+#define UART0_BASE_PHYS	(APB0_PERI_BASE + 0x07000)
+#define UART1_BASE	(APB0_PERI_BASE_VIRT + 0x08000)
+#define UART1_BASE_PHYS	(APB0_PERI_BASE + 0x08000)
+#define UART2_BASE	(APB0_PERI_BASE_VIRT + 0x09000)
+#define UART2_BASE_PHYS	(APB0_PERI_BASE + 0x09000)
+#define UART3_BASE	(APB0_PERI_BASE_VIRT + 0x0a000)
+#define UART3_BASE_PHYS	(APB0_PERI_BASE + 0x0a000)
+#define UART4_BASE	(APB0_PERI_BASE_VIRT + 0x15000)
+#define UART4_BASE_PHYS	(APB0_PERI_BASE + 0x15000)
+
+#define UART_BASE	UART0_BASE
+#define UART_BASE_PHYS	UART0_BASE_PHYS
+
+/* ECC controller */
+#define ECC_CTR_BASE	(APB0_PERI_BASE_VIRT + 0xd000)
+
+#define ECC_CTRL_OFFS		0x00
+#define ECC_BASE_OFFS		0x04
+#define ECC_MASK_OFFS		0x08
+#define ECC_CLEAR_OFFS		0x0c
+#define ECC4_0_OFFS		0x10
+#define ECC4_1_OFFS		0x14
+
+#define ECC_EADDR0_OFFS		0x50
+
+#define ECC_ERRNUM_OFFS		0x90
+#define ECC_IREQ_OFFS		0x94
+
+/* Bits in ECC_CTRL */
+#define ECC_CTRL_ECC4_DIEN	(1 << 28)
+#define ECC_CTRL_ECC8_DIEN	(1 << 29)
+#define ECC_CTRL_ECC12_DIEN	(1 << 30)
+#define ECC_CTRL_ECC_DISABLE	0x0
+#define ECC_CTRL_ECC_SLC_ENC	0x8
+#define ECC_CTRL_ECC_SLC_DEC	0x9
+#define ECC_CTRL_ECC4_ENC	0xa
+#define ECC_CTRL_ECC4_DEC	0xb
+#define ECC_CTRL_ECC8_ENC	0xc
+#define ECC_CTRL_ECC8_DEC	0xd
+#define ECC_CTRL_ECC12_ENC	0xe
+#define ECC_CTRL_ECC12_DEC	0xf
+
+/* Bits in ECC_IREQ */
+#define ECC_IREQ_E4DI		(1 << 4)
+
+#define ECC_IREQ_E4DF		(1 << 20)
+#define ECC_IREQ_E4EF		(1 << 21)
+
+/* Interrupt controller */
+
+#define PIC0_BASE	(APB1_PERI_BASE_VIRT + 0x3000)
+#define PIC0_BASE_PHYS	(APB1_PERI_BASE + 0x3000)
+
+#define PIC0_IEN_OFFS		0x00
+#define PIC0_CREQ_OFFS		0x04
+#define PIC0_IREQ_OFFS		0x08
+#define PIC0_IRQSEL_OFFS	0x0c
+#define PIC0_SRC_OFFS		0x10
+#define PIC0_MREQ_OFFS		0x14
+#define PIC0_TSTREQ_OFFS	0x18
+#define PIC0_POL_OFFS		0x1c
+#define PIC0_IRQ_OFFS		0x20
+#define PIC0_FIQ_OFFS		0x24
+#define PIC0_MIRQ_OFFS		0x28
+#define PIC0_MFIQ_OFFS		0x2c
+#define PIC0_TMODE_OFFS		0x30
+#define PIC0_SYNC_OFFS		0x34
+#define PIC0_WKUP_OFFS		0x38
+#define PIC0_TMODEA_OFFS	0x3c
+#define PIC0_INTOEN_OFFS	0x40
+#define PIC0_MEN0_OFFS		0x44
+#define PIC0_MEN_OFFS		0x48
+
+#define PIC0_IEN		__REG(PIC0_BASE + PIC0_IEN_OFFS)
+#define PIC0_IEN_PHYS		__REG(PIC0_BASE_PHYS + PIC0_IEN_OFFS)
+#define PIC0_CREQ		__REG(PIC0_BASE + PIC0_CREQ_OFFS)
+#define PIC0_CREQ_PHYS		__REG(PIC0_BASE_PHYS + PIC0_CREQ_OFFS)
+#define PIC0_IREQ		__REG(PIC0_BASE + PIC0_IREQ_OFFS)
+#define PIC0_IRQSEL		__REG(PIC0_BASE + PIC0_IRQSEL_OFFS)
+#define PIC0_IRQSEL_PHYS	__REG(PIC0_BASE_PHYS + PIC0_IRQSEL_OFFS)
+#define PIC0_SRC		__REG(PIC0_BASE + PIC0_SRC_OFFS)
+#define PIC0_MREQ		__REG(PIC0_BASE + PIC0_MREQ_OFFS)
+#define PIC0_TSTREQ		__REG(PIC0_BASE + PIC0_TSTREQ_OFFS)
+#define PIC0_POL		__REG(PIC0_BASE + PIC0_POL_OFFS)
+#define PIC0_IRQ		__REG(PIC0_BASE + PIC0_IRQ_OFFS)
+#define PIC0_FIQ		__REG(PIC0_BASE + PIC0_FIQ_OFFS)
+#define PIC0_MIRQ		__REG(PIC0_BASE + PIC0_MIRQ_OFFS)
+#define PIC0_MFIQ		__REG(PIC0_BASE + PIC0_MFIQ_OFFS)
+#define PIC0_TMODE		__REG(PIC0_BASE + PIC0_TMODE_OFFS)
+#define PIC0_TMODE_PHYS		__REG(PIC0_BASE_PHYS + PIC0_TMODE_OFFS)
+#define PIC0_SYNC		__REG(PIC0_BASE + PIC0_SYNC_OFFS)
+#define PIC0_WKUP		__REG(PIC0_BASE + PIC0_WKUP_OFFS)
+#define PIC0_TMODEA		__REG(PIC0_BASE + PIC0_TMODEA_OFFS)
+#define PIC0_INTOEN		__REG(PIC0_BASE + PIC0_INTOEN_OFFS)
+#define PIC0_MEN0		__REG(PIC0_BASE + PIC0_MEN0_OFFS)
+#define PIC0_MEN		__REG(PIC0_BASE + PIC0_MEN_OFFS)
+
+#define PIC1_BASE	(APB1_PERI_BASE_VIRT + 0x3080)
+
+#define PIC1_IEN_OFFS		0x00
+#define PIC1_CREQ_OFFS		0x04
+#define PIC1_IREQ_OFFS		0x08
+#define PIC1_IRQSEL_OFFS	0x0c
+#define PIC1_SRC_OFFS		0x10
+#define PIC1_MREQ_OFFS		0x14
+#define PIC1_TSTREQ_OFFS	0x18
+#define PIC1_POL_OFFS		0x1c
+#define PIC1_IRQ_OFFS		0x20
+#define PIC1_FIQ_OFFS		0x24
+#define PIC1_MIRQ_OFFS		0x28
+#define PIC1_MFIQ_OFFS		0x2c
+#define PIC1_TMODE_OFFS		0x30
+#define PIC1_SYNC_OFFS		0x34
+#define PIC1_WKUP_OFFS		0x38
+#define PIC1_TMODEA_OFFS	0x3c
+#define PIC1_INTOEN_OFFS	0x40
+#define PIC1_MEN1_OFFS		0x44
+#define PIC1_MEN_OFFS		0x48
+
+#define PIC1_IEN	__REG(PIC1_BASE + PIC1_IEN_OFFS)
+#define PIC1_CREQ	__REG(PIC1_BASE + PIC1_CREQ_OFFS)
+#define PIC1_IREQ	__REG(PIC1_BASE + PIC1_IREQ_OFFS)
+#define PIC1_IRQSEL	__REG(PIC1_BASE + PIC1_IRQSEL_OFFS)
+#define PIC1_SRC	__REG(PIC1_BASE + PIC1_SRC_OFFS)
+#define PIC1_MREQ	__REG(PIC1_BASE + PIC1_MREQ_OFFS)
+#define PIC1_TSTREQ	__REG(PIC1_BASE + PIC1_TSTREQ_OFFS)
+#define PIC1_POL	__REG(PIC1_BASE + PIC1_POL_OFFS)
+#define PIC1_IRQ	__REG(PIC1_BASE + PIC1_IRQ_OFFS)
+#define PIC1_FIQ	__REG(PIC1_BASE + PIC1_FIQ_OFFS)
+#define PIC1_MIRQ	__REG(PIC1_BASE + PIC1_MIRQ_OFFS)
+#define PIC1_MFIQ	__REG(PIC1_BASE + PIC1_MFIQ_OFFS)
+#define PIC1_TMODE	__REG(PIC1_BASE + PIC1_TMODE_OFFS)
+#define PIC1_SYNC	__REG(PIC1_BASE + PIC1_SYNC_OFFS)
+#define PIC1_WKUP	__REG(PIC1_BASE + PIC1_WKUP_OFFS)
+#define PIC1_TMODEA	__REG(PIC1_BASE + PIC1_TMODEA_OFFS)
+#define PIC1_INTOEN	__REG(PIC1_BASE + PIC1_INTOEN_OFFS)
+#define PIC1_MEN1	__REG(PIC1_BASE + PIC1_MEN1_OFFS)
+#define PIC1_MEN	__REG(PIC1_BASE + PIC1_MEN_OFFS)
+
+/* Timer registers */
+#define TIMER_BASE		(APB1_PERI_BASE_VIRT + 0x4000)
+#define TIMER_BASE_PHYS		(APB1_PERI_BASE + 0x4000)
+
+#define TWDCFG_OFFS		0x70
+
+#define TC32EN_OFFS		0x80
+#define TC32LDV_OFFS		0x84
+#define TC32CMP0_OFFS		0x88
+#define TC32CMP1_OFFS		0x8c
+#define TC32PCNT_OFFS		0x90
+#define TC32MCNT_OFFS		0x94
+#define TC32IRQ_OFFS		0x98
+
+/* Bits in TC32EN */
+#define TC32EN_PRESCALE_MASK	0x00ffffff
+#define TC32EN_ENABLE		(1 << 24)
+#define TC32EN_LOADZERO		(1 << 25)
+#define TC32EN_STOPMODE		(1 << 26)
+#define TC32EN_LDM0		(1 << 28)
+#define TC32EN_LDM1		(1 << 29)
+
+/* Bits in TC32IRQ */
+#define TC32IRQ_MSTAT_MASK	0x0000001f
+#define TC32IRQ_RSTAT_MASK	(0x1f << 8)
+#define TC32IRQ_IRQEN0		(1 << 16)
+#define TC32IRQ_IRQEN1		(1 << 17)
+#define TC32IRQ_IRQEN2		(1 << 18)
+#define TC32IRQ_IRQEN3		(1 << 19)
+#define TC32IRQ_IRQEN4		(1 << 20)
+#define TC32IRQ_RSYNC		(1 << 30)
+#define TC32IRQ_IRQCLR		(1 << 31)
+
+/* GPIO registers */
+#define GPIOPD_BASE		(APB1_PERI_BASE_VIRT + 0x5000)
+
+#define GPIOPD_DAT_OFFS		0x00
+#define GPIOPD_DOE_OFFS		0x04
+#define GPIOPD_FS0_OFFS		0x08
+#define GPIOPD_FS1_OFFS		0x0c
+#define GPIOPD_FS2_OFFS		0x10
+#define GPIOPD_RPU_OFFS		0x30
+#define GPIOPD_RPD_OFFS		0x34
+#define GPIOPD_DV0_OFFS		0x38
+#define GPIOPD_DV1_OFFS		0x3c
+
+#define GPIOPS_BASE		(APB1_PERI_BASE_VIRT + 0x5000)
+
+#define GPIOPS_DAT_OFFS		0x40
+#define GPIOPS_DOE_OFFS		0x44
+#define GPIOPS_FS0_OFFS		0x48
+#define GPIOPS_FS1_OFFS		0x4c
+#define GPIOPS_FS2_OFFS		0x50
+#define GPIOPS_FS3_OFFS		0x54
+#define GPIOPS_RPU_OFFS		0x70
+#define GPIOPS_RPD_OFFS		0x74
+#define GPIOPS_DV0_OFFS		0x78
+#define GPIOPS_DV1_OFFS		0x7c
+
+#define GPIOPS_FS1_SDH0_BITS	0x000000ff
+#define GPIOPS_FS1_SDH1_BITS	0x0000ff00
+
+#define GPIOPU_BASE		(APB1_PERI_BASE_VIRT + 0x5000)
+
+#define GPIOPU_DAT_OFFS		0x80
+#define GPIOPU_DOE_OFFS		0x84
+#define GPIOPU_FS0_OFFS		0x88
+#define GPIOPU_FS1_OFFS		0x8c
+#define GPIOPU_FS2_OFFS		0x90
+#define GPIOPU_RPU_OFFS		0xb0
+#define GPIOPU_RPD_OFFS		0xb4
+#define GPIOPU_DV0_OFFS		0xb8
+#define GPIOPU_DV1_OFFS		0xbc
+
+#define GPIOPU_FS0_TXD0		(1 << 0)
+#define GPIOPU_FS0_RXD0		(1 << 1)
+#define GPIOPU_FS0_CTS0		(1 << 2)
+#define GPIOPU_FS0_RTS0		(1 << 3)
+#define GPIOPU_FS0_TXD1		(1 << 4)
+#define GPIOPU_FS0_RXD1		(1 << 5)
+#define GPIOPU_FS0_CTS1		(1 << 6)
+#define GPIOPU_FS0_RTS1		(1 << 7)
+#define GPIOPU_FS0_TXD2		(1 << 8)
+#define GPIOPU_FS0_RXD2		(1 << 9)
+#define GPIOPU_FS0_CTS2		(1 << 10)
+#define GPIOPU_FS0_RTS2		(1 << 11)
+#define GPIOPU_FS0_TXD3		(1 << 12)
+#define GPIOPU_FS0_RXD3		(1 << 13)
+#define GPIOPU_FS0_CTS3		(1 << 14)
+#define GPIOPU_FS0_RTS3		(1 << 15)
+#define GPIOPU_FS0_TXD4		(1 << 16)
+#define GPIOPU_FS0_RXD4		(1 << 17)
+#define GPIOPU_FS0_CTS4		(1 << 18)
+#define GPIOPU_FS0_RTS4		(1 << 19)
+
+#define GPIOFC_BASE		(APB1_PERI_BASE_VIRT + 0x5000)
+
+#define GPIOFC_DAT_OFFS		0xc0
+#define GPIOFC_DOE_OFFS		0xc4
+#define GPIOFC_FS0_OFFS		0xc8
+#define GPIOFC_FS1_OFFS		0xcc
+#define GPIOFC_FS2_OFFS		0xd0
+#define GPIOFC_FS3_OFFS		0xd4
+#define GPIOFC_RPU_OFFS		0xf0
+#define GPIOFC_RPD_OFFS		0xf4
+#define GPIOFC_DV0_OFFS		0xf8
+#define GPIOFC_DV1_OFFS		0xfc
+
+#define GPIOFD_BASE		(APB1_PERI_BASE_VIRT + 0x5000)
+
+#define GPIOFD_DAT_OFFS		0x100
+#define GPIOFD_DOE_OFFS		0x104
+#define GPIOFD_FS0_OFFS		0x108
+#define GPIOFD_FS1_OFFS		0x10c
+#define GPIOFD_FS2_OFFS		0x110
+#define GPIOFD_RPU_OFFS		0x130
+#define GPIOFD_RPD_OFFS		0x134
+#define GPIOFD_DV0_OFFS		0x138
+#define GPIOFD_DV1_OFFS		0x13c
+
+#define GPIOLC_BASE		(APB1_PERI_BASE_VIRT + 0x5000)
+
+#define GPIOLC_DAT_OFFS		0x140
+#define GPIOLC_DOE_OFFS		0x144
+#define GPIOLC_FS0_OFFS		0x148
+#define GPIOLC_FS1_OFFS		0x14c
+#define GPIOLC_RPU_OFFS		0x170
+#define GPIOLC_RPD_OFFS		0x174
+#define GPIOLC_DV0_OFFS		0x178
+#define GPIOLC_DV1_OFFS		0x17c
+
+#define GPIOLD_BASE		(APB1_PERI_BASE_VIRT + 0x5000)
+
+#define GPIOLD_DAT_OFFS		0x180
+#define GPIOLD_DOE_OFFS		0x184
+#define GPIOLD_FS0_OFFS		0x188
+#define GPIOLD_FS1_OFFS		0x18c
+#define GPIOLD_FS2_OFFS		0x190
+#define GPIOLD_RPU_OFFS		0x1b0
+#define GPIOLD_RPD_OFFS		0x1b4
+#define GPIOLD_DV0_OFFS		0x1b8
+#define GPIOLD_DV1_OFFS		0x1bc
+
+#define GPIOAD_BASE		(APB1_PERI_BASE_VIRT + 0x5000)
+
+#define GPIOAD_DAT_OFFS		0x1c0
+#define GPIOAD_DOE_OFFS		0x1c4
+#define GPIOAD_FS0_OFFS		0x1c8
+#define GPIOAD_RPU_OFFS		0x1f0
+#define GPIOAD_RPD_OFFS		0x1f4
+#define GPIOAD_DV0_OFFS		0x1f8
+#define GPIOAD_DV1_OFFS		0x1fc
+
+#define GPIOXC_BASE		(APB1_PERI_BASE_VIRT + 0x5000)
+
+#define GPIOXC_DAT_OFFS		0x200
+#define GPIOXC_DOE_OFFS		0x204
+#define GPIOXC_FS0_OFFS		0x208
+#define GPIOXC_RPU_OFFS		0x230
+#define GPIOXC_RPD_OFFS		0x234
+#define GPIOXC_DV0_OFFS		0x238
+#define GPIOXC_DV1_OFFS		0x23c
+
+#define GPIOXC_FS0		__REG(GPIOXC_BASE + GPIOXC_FS0_OFFS)
+
+#define GPIOXC_FS0_CS0		(1 << 26)
+#define GPIOXC_FS0_CS1		(1 << 27)
+
+#define GPIOXD_BASE		(APB1_PERI_BASE_VIRT + 0x5000)
+
+#define GPIOXD_DAT_OFFS		0x240
+#define GPIOXD_FS0_OFFS		0x248
+#define GPIOXD_RPU_OFFS		0x270
+#define GPIOXD_RPD_OFFS		0x274
+#define GPIOXD_DV0_OFFS		0x278
+#define GPIOXD_DV1_OFFS		0x27c
+
+#define GPIOPK_BASE		(APB1_PERI_BASE_VIRT + 0x1c000)
+
+#define GPIOPK_RST_OFFS		0x008
+#define GPIOPK_DAT_OFFS		0x100
+#define GPIOPK_DOE_OFFS		0x104
+#define GPIOPK_FS0_OFFS		0x108
+#define GPIOPK_FS1_OFFS		0x10c
+#define GPIOPK_FS2_OFFS		0x110
+#define GPIOPK_IRQST_OFFS	0x210
+#define GPIOPK_IRQEN_OFFS	0x214
+#define GPIOPK_IRQPOL_OFFS	0x218
+#define GPIOPK_IRQTM0_OFFS	0x21c
+#define GPIOPK_IRQTM1_OFFS	0x220
+#define GPIOPK_CTL_OFFS		0x22c
+
+#define PMGPIO_BASE		(APB1_PERI_BASE_VIRT + 0x10000)
+#define BACKUP_RAM_BASE		PMGPIO_BASE
+
+#define PMGPIO_DAT_OFFS		0x800
+#define PMGPIO_DOE_OFFS		0x804
+#define PMGPIO_FS0_OFFS		0x808
+#define PMGPIO_RPU_OFFS		0x810
+#define PMGPIO_RPD_OFFS		0x814
+#define PMGPIO_DV0_OFFS		0x818
+#define PMGPIO_DV1_OFFS		0x81c
+#define PMGPIO_EE0_OFFS		0x820
+#define PMGPIO_EE1_OFFS		0x824
+#define PMGPIO_CTL_OFFS		0x828
+#define PMGPIO_DI_OFFS		0x82c
+#define PMGPIO_STR_OFFS		0x830
+#define PMGPIO_STF_OFFS		0x834
+#define PMGPIO_POL_OFFS		0x838
+#define PMGPIO_APB_OFFS		0x800
+
+/* Clock controller registers */
+#define CKC_BASE		(APB1_PERI_BASE_VIRT + 0x6000)
+#define CKC_BASE_PHYS		(APB1_PERI_BASE + 0x6000)
+
+#define CLKCTRL_OFFS		0x00
+#define PLL0CFG_OFFS		0x04
+#define PLL1CFG_OFFS		0x08
+#define CLKDIVC0_OFFS		0x0c
+
+#define BCLKCTR0_OFFS		0x14
+#define SWRESET0_OFFS		0x18
+
+#define BCLKCTR1_OFFS		0x60
+#define SWRESET1_OFFS		0x64
+#define PWDCTL_OFFS		0x68
+#define PLL2CFG_OFFS		0x6c
+#define CLKDIVC1_OFFS		0x70
+
+#define ACLKREF_OFFS		0x80
+#define ACLKI2C_OFFS		0x84
+#define ACLKSPI0_OFFS		0x88
+#define ACLKSPI1_OFFS		0x8c
+#define ACLKUART0_OFFS		0x90
+#define ACLKUART1_OFFS		0x94
+#define ACLKUART2_OFFS		0x98
+#define ACLKUART3_OFFS		0x9c
+#define ACLKUART4_OFFS		0xa0
+#define ACLKTCT_OFFS		0xa4
+#define ACLKTCX_OFFS		0xa8
+#define ACLKTCZ_OFFS		0xac
+#define ACLKADC_OFFS		0xb0
+#define ACLKDAI0_OFFS		0xb4
+#define ACLKDAI1_OFFS		0xb8
+#define ACLKLCD_OFFS		0xbc
+#define ACLKSPDIF_OFFS		0xc0
+#define ACLKUSBH_OFFS		0xc4
+#define ACLKSDH0_OFFS		0xc8
+#define ACLKSDH1_OFFS		0xcc
+#define ACLKC3DEC_OFFS		0xd0
+#define ACLKEXT_OFFS		0xd4
+#define ACLKCAN0_OFFS		0xd8
+#define ACLKCAN1_OFFS		0xdc
+#define ACLKGSB0_OFFS		0xe0
+#define ACLKGSB1_OFFS		0xe4
+#define ACLKGSB2_OFFS		0xe8
+#define ACLKGSB3_OFFS		0xec
+
+#define PLLxCFG_PD		(1 << 31)
+
+/* CLKCTRL bits */
+#define CLKCTRL_XE		(1 << 31)
+
+/* CLKDIVCx bits */
+#define CLKDIVC0_XTE		(1 << 7)
+#define CLKDIVC0_XE		(1 << 15)
+#define CLKDIVC0_P1E		(1 << 23)
+#define CLKDIVC0_P0E		(1 << 31)
+
+#define CLKDIVC1_P2E		(1 << 7)
+
+/* BCLKCTR0 clock bits */
+#define BCLKCTR0_USBD		(1 << 4)
+#define BCLKCTR0_ECC		(1 << 9)
+#define BCLKCTR0_USBH0		(1 << 11)
+#define BCLKCTR0_NFC		(1 << 16)
+
+/* BCLKCTR1 clock bits */
+#define BCLKCTR1_USBH1		(1 << 20)
+
+/* SWRESET0 bits */
+#define SWRESET0_USBD		(1 << 4)
+#define SWRESET0_USBH0		(1 << 11)
+
+/* SWRESET1 bits */
+#define SWRESET1_USBH1		(1 << 20)
+
+/* System clock sources */
+enum root_clks {
+	CLK_SRC_PLL0 = 0,
+	CLK_SRC_PLL1,
+	CLK_SRC_PLL0DIV,
+	CLK_SRC_PLL1DIV,
+	CLK_SRC_XI,
+	CLK_SRC_XIDIV,
+	CLK_SRC_XTI,
+	CLK_SRC_XTIDIV,
+	CLK_SRC_PLL2,
+	CLK_SRC_PLL2DIV,
+	CLK_SRC_PK0,
+	CLK_SRC_PK1,
+	CLK_SRC_PK2,
+	CLK_SRC_PK3,
+	CLK_SRC_PK4,
+	CLK_SRC_48MHZ
+};
+
+#define CLK_SRC_MASK		0xf
+
+/* Bits in ACLK* registers */
+#define ACLK_EN		(1 << 28)
+#define ACLK_SEL_SHIFT		24
+#define ACLK_SEL_MASK		0x0f000000
+#define ACLK_DIV_MASK		0x00000fff
+
+/* System configuration registers */
+
+#define SCFG_BASE		(APB1_PERI_BASE_VIRT + 0x13000)
+
+#define	BMI_OFFS		0x00
+#define AHBCON0_OFFS		0x04
+#define APBPWE_OFFS		0x08
+#define DTCMWAIT_OFFS		0x0c
+#define ECCSEL_OFFS		0x10
+#define AHBCON1_OFFS		0x14
+#define SDHCFG_OFFS		0x18
+#define REMAP_OFFS		0x20
+#define LCDSIAE_OFFS		0x24
+#define XMCCFG_OFFS		0xe0
+#define IMCCFG_OFFS		0xe4
+
+/* Values for ECCSEL */
+#define ECCSEL_EXTMEM		0x0
+#define ECCSEL_DTCM		0x1
+#define ECCSEL_INT_SRAM		0x2
+#define ECCSEL_AHB		0x3
+
+/* Bits in XMCCFG */
+#define XMCCFG_NFCE		(1 << 1)
+#define XMCCFG_FDXD		(1 << 2)
+
+/* External memory controller registers */
+
+#define EMC_BASE		EXT_MEM_CTRL_BASE
+
+#define SDCFG_OFFS		0x00
+#define SDFSM_OFFS		0x04
+#define MCFG_OFFS		0x08
+
+#define CSCFG0_OFFS		0x10
+#define CSCFG1_OFFS		0x14
+#define CSCFG2_OFFS		0x18
+#define CSCFG3_OFFS		0x1c
+
+#define MCFG_SDEN		(1 << 4)
+
+#endif /* TCC8K_REGS_H */
diff --git a/arch/arm/plat-tcc/include/mach/uncompress.h b/arch/arm/plat-tcc/include/mach/uncompress.h
new file mode 100644
index 0000000..7a3e33a
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/uncompress.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2009 Hans J. Koch <hjk@linutronix.de>
+ *
+ * This file is licensed under the terms of the GPL version 2.
+ */
+
+#include <linux/serial_reg.h>
+#include <linux/types.h>
+
+#include <mach/tcc8k-regs.h>
+
+unsigned int system_rev;
+
+#define ID_MASK			0x7fff
+
+static void putc(int c)
+{
+	u32 *uart_lsr = (u32 *)(UART_BASE_PHYS + (UART_LSR << 2));
+	u32 *uart_tx = (u32 *)(UART_BASE_PHYS + (UART_TX << 2));
+
+	while (!(*uart_lsr & UART_LSR_THRE))
+		barrier();
+	*uart_tx = c;
+}
+
+static inline void flush(void)
+{
+}
+
+/*
+ * nothing to do
+ */
+#define arch_decomp_setup()
+#define arch_decomp_wdog()
diff --git a/arch/arm/plat-tcc/include/mach/vmalloc.h b/arch/arm/plat-tcc/include/mach/vmalloc.h
new file mode 100644
index 0000000..7eb4b3d
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/vmalloc.h
@@ -0,0 +1,11 @@
+/*
+ * Author: <linux@telechips.com>
+ * Created: June 10, 2008
+ *
+ * Copyright (C) 2000 Russell King.
+ * Copyright (C) 2008-2009 Telechips
+ *
+ * Licensed under the terms of the GPL v2.
+ */
+#define VMALLOC_END	0xf0000000UL
+
diff --git a/arch/arm/plat-tcc/system.c b/arch/arm/plat-tcc/system.c
new file mode 100644
index 0000000..4ffa33f
--- /dev/null
+++ b/arch/arm/plat-tcc/system.c
@@ -0,0 +1,26 @@
+/*
+ * System functions for Telechips TCCxxxx SoCs
+ *
+ * Copyright (C) Hans J. Koch <hjk@linutronix.de>
+ *
+ * Licensed under the terms of the GPL v2.
+ *
+ */
+
+#include <linux/io.h>
+
+#include <mach/tcc8k-regs.h>
+
+/* System reboot */
+void plat_tcc_reboot(void)
+{
+	/* Make sure clocks are on */
+	__raw_writel(0xffffffff, CKC_BASE + BCLKCTR0_OFFS);
+
+	/* Enable watchdog reset */
+	__raw_writel(0x49, TIMER_BASE + TWDCFG_OFFS);
+	/* Wait for reset */
+	while(1)
+		;
+}
+
-- 
1.6.3.3
