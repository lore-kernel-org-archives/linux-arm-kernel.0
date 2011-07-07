From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Jul 2011 15:21:06 +0200
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <20110707123707.GN8286@n2100.arm.linux.org.uk>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<201107071343.03591.arnd@arndb.de>
	<20110707123707.GN8286@n2100.arm.linux.org.uk>
Message-ID: <201107071521.07070.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 July 2011, Russell King - ARM Linux wrote:
> On Thu, Jul 07, 2011 at 01:43:03PM +0200, Arnd Bergmann wrote:

> > Good point. I'm not planning to change the initial xilinx code, since
> > it's already in the tree, but I'd like to apply the patch below
> > to make it do the same as prima2 in this regard.
> > John, can you ack this patch?
> 
> How similar are prima2 and zynq after this patch and a diff between
> their two subdirectories?  Are there any differences which can be
> eliminated?  Is there any commonality which can be factored out from
> the two?  Should the two be occupying separate mach directories?
> 
> I think this is something we need to pay attention to now.

Right. Both platforms currently contain setup code for l2x0, which
we can remove after Rob Herring's patch gets in. This is all I can
see in the actual source files, everything else is really setting
up the individual hardware.

The majority of the prima2 code is now the clock setup, which will
get changed again once we have the common clock framework. I assume
that most of the code in there becomes obselete at that point, but
intentionally stayed out of the whole clk discussion.

The sys_timer implementation is still present in both, but completely
distinct as far as I can tell. I think the long-term plan is to move
those to drivers/clocksource.

What's left then are basically the headers. There is significant
room for consolidation there, and I think most of them have been
looked at by people before or are currently being worked on.
Below is the complete diff between the headers of the two platforms
as they are being proposed now.

	Arnd

---

 clkdev.h      |   27 ++++++++++++++++++++++-----
 debug-macro.S |   53 ++++++++++++++++++++++++++++++-----------------------
 entry-macro.S |   43 ++++++++++++++++++++++---------------------
 hardware.h    |   17 ++++++++++-------
 io.h          |   33 +++++++++++++++++++++++++--------
 irqs.h        |   24 ++++++++++++++----------
 map.h         |   16 ----------------
 memory.h      |   27 ++++++++++++++-------------
 system.h      |   23 +++++++++++------------
 timex.h       |   19 ++++++++++++++-----
 uart.h        |   32 +++++++++++++++++---------------
 uncompress.h  |   49 ++++++++++++++++++++++++++++++-------------------
 vmalloc.h     |   20 +++++++++++++-------
 zynq_soc.h    |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 14 files changed, 270 insertions(+), 161 deletions(-)

diff -urN arch/arm/mach-prima2/include/mach/clkdev.h arch/arm/mach-zynq/include/mach/clkdev.h
--- arch/arm/mach-prima2/include/mach/clkdev.h	2011-07-07 13:21:41.000000000 +0000
+++ arch/arm/mach-zynq/include/mach/clkdev.h	2011-07-07 13:22:07.000000000 +0000
@@ -1,13 +1,30 @@
 /*
- * arch/arm/mach-prima2/include/mach/clkdev.h
+ * arch/arm/mach-zynq/include/mach/clkdev.h
  *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *  Copyright (C) 2011 Xilinx, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
- * Licensed under GPLv2 or later.
  */
 
-#ifndef __MACH_CLKDEV_H
-#define __MACH_CLKDEV_H
+#ifndef __MACH_CLKDEV_H__
+#define __MACH_CLKDEV_H__
+
+#include <plat/clock.h>
+
+struct clk {
+	unsigned long		rate;
+	const struct clk_ops	*ops;
+	const struct icst_params *params;
+	void __iomem		*vcoreg;
+};
 
 #define __clk_get(clk) ({ 1; })
 #define __clk_put(clk) do { } while (0)
diff -urN arch/arm/mach-prima2/include/mach/debug-macro.S arch/arm/mach-zynq/include/mach/debug-macro.S
--- arch/arm/mach-prima2/include/mach/debug-macro.S	2011-07-07 13:21:41.000000000 +0000
+++ arch/arm/mach-zynq/include/mach/debug-macro.S	2011-07-07 13:22:07.000000000 +0000
@@ -1,29 +1,36 @@
-/*
- * arch/arm/mach-prima2/include/mach/debug-macro.S
+/* arch/arm/mach-zynq/include/mach/debug-macro.S
  *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ * Debugging macro include header
  *
- * Licensed under GPLv2 or later.
+ *  Copyright (C) 2011 Xilinx
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
-#include <mach/hardware.h>
+#include <mach/zynq_soc.h>
 #include <mach/uart.h>
 
-	.macro	addruart, rp, rv
-	ldr	\rp, =SIRFSOC_UART1_PA_BASE		@ physical
-	ldr	\rv, =SIRFSOC_UART1_VA_BASE		@ virtual
-	.endm
-
-	.macro	senduart,rd,rx
-	str	\rd, [\rx, #SIRFSOC_UART_TXFIFO_DATA]
-	.endm
-
-	.macro	busyuart,rd,rx
-	.endm
-
-	.macro	waituart,rd,rx
-1001:	ldr	\rd, [\rx, #SIRFSOC_UART_TXFIFO_STATUS]
-	tst	\rd, #SIRFSOC_UART1_TXFIFO_EMPTY
-	beq	1001b
-	.endm
-
+		.macro	addruart, rp, rv
+		ldr	\rp, =LL_UART_PADDR	@ physical
+		ldr	\rv, =LL_UART_VADDR	@ virtual
+		.endm
+
+		.macro	senduart,rd,rx
+		str	\rd, [\rx, #UART_FIFO_OFFSET]	@ TXDATA
+		.endm
+
+		.macro	waituart,rd,rx
+		.endm
+
+		.macro	busyuart,rd,rx
+1002:		ldr	\rd, [\rx, #UART_SR_OFFSET]	@ get status register
+		tst	\rd, #UART_SR_TXFULL		@
+		bne	1002b			@ wait if FIFO is full
+		.endm
diff -urN arch/arm/mach-prima2/include/mach/entry-macro.S arch/arm/mach-zynq/include/mach/entry-macro.S
--- arch/arm/mach-prima2/include/mach/entry-macro.S	2011-07-07 13:21:41.000000000 +0000
+++ arch/arm/mach-zynq/include/mach/entry-macro.S	2011-07-07 13:22:07.000000000 +0000
@@ -1,29 +1,30 @@
 /*
- * arch/arm/mach-prima2/include/mach/entry-macro.S
+ * arch/arm/mach-zynq/include/mach/entry-macro.S
  *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ * Low-level IRQ helper macros
  *
- * Licensed under GPLv2 or later.
+ *  Copyright (C) 2011 Xilinx
+ *
+ * based on arch/plat-mxc/include/mach/entry-macro.S
+ *
+ *  Copyright (C) 2007 Lennert Buytenhek <buytenh@wantstofly.org>
+ *  Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
 #include <mach/hardware.h>
+#include <asm/hardware/entry-macro-gic.S>
 
-#define SIRFSOC_INT_ID 0x38
-
-	.macro  get_irqnr_preamble, base, tmp
-	ldr     \base, =sirfsoc_intc_base
-	ldr     \base, [\base]
-	.endm
-
-	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-	ldr \irqnr, [\base, #SIRFSOC_INT_ID]	@ Get the highest priority irq
-	cmp \irqnr, #0x40			@ the irq num can't be larger than 0x3f
-	movges \irqnr, #0
-	.endm
-
-	.macro  disable_fiq
-	.endm
-
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
+		.macro  disable_fiq
+		.endm
 
+		.macro  arch_ret_to_user, tmp1, tmp2
+		.endm
diff -urN arch/arm/mach-prima2/include/mach/hardware.h arch/arm/mach-zynq/include/mach/hardware.h
--- arch/arm/mach-prima2/include/mach/hardware.h	2011-07-07 13:21:41.000000000 +0000
+++ arch/arm/mach-zynq/include/mach/hardware.h	2011-07-07 13:22:07.000000000 +0000
@@ -1,15 +1,18 @@
-/*
- * arch/arm/mach-prima2/include/mach/hardware.h
+/* arch/arm/mach-zynq/include/mach/hardware.h
  *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *  Copyright (C) 2011 Xilinx
  *
- * Licensed under GPLv2 or later.
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
 #ifndef __MACH_HARDWARE_H__
 #define __MACH_HARDWARE_H__
 
-#include <asm/sizes.h>
-#include <mach/map.h>
-
 #endif
diff -urN arch/arm/mach-prima2/include/mach/io.h arch/arm/mach-zynq/include/mach/io.h
--- arch/arm/mach-prima2/include/mach/io.h	2011-07-07 13:21:41.000000000 +0000
+++ arch/arm/mach-zynq/include/mach/io.h	2011-07-07 13:22:07.000000000 +0000
@@ -1,16 +1,33 @@
-/*
- * arch/arm/mach-prima2/include/mach/io.h
+/* arch/arm/mach-zynq/include/mach/io.h
  *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *  Copyright (C) 2011 Xilinx
  *
- * Licensed under GPLv2 or later.
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
-#ifndef __MACH_PRIMA2_IO_H
-#define __MACH_PRIMA2_IO_H
+#ifndef __MACH_IO_H__
+#define __MACH_IO_H__
+
+/* Allow IO space to be anywhere in the memory */
+
+#define IO_SPACE_LIMIT 0xffff
 
-#define IO_SPACE_LIMIT ((resource_size_t)0)
+/* IO address mapping macros, nothing special at this time but required */
+
+#ifdef __ASSEMBLER__
+#define IOMEM(x)		(x)
+#else
+#define IOMEM(x)		((void __force __iomem *)(x))
+#endif
 
-#define __mem_pci(a)            (a)
+#define __io(a)			__typesafe_io(a)
+#define __mem_pci(a)		(a)
 
 #endif
diff -urN arch/arm/mach-prima2/include/mach/irqs.h arch/arm/mach-zynq/include/mach/irqs.h
--- arch/arm/mach-prima2/include/mach/irqs.h	2011-07-07 13:21:41.000000000 +0000
+++ arch/arm/mach-zynq/include/mach/irqs.h	2011-07-07 13:22:07.000000000 +0000
@@ -1,17 +1,21 @@
-/*
- * arch/arm/mach-prima2/include/mach/irqs.h
+/* arch/arm/mach-zynq/include/mach/irqs.h
  *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *  Copyright (C) 2011 Xilinx
  *
- * Licensed under GPLv2 or later.
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
-#ifndef __ASM_ARCH_IRQS_H
-#define __ASM_ARCH_IRQS_H
-
-#define SIRFSOC_INTENAL_IRQ_START  0
-#define SIRFSOC_INTENAL_IRQ_END    59
+#ifndef __MACH_IRQS_H
+#define __MACH_IRQS_H
 
-#define NR_IRQS	220
+#define ARCH_NR_GPIOS	118
+#define NR_IRQS		(128 + ARCH_NR_GPIOS)
 
 #endif
diff -urN arch/arm/mach-prima2/include/mach/map.h arch/arm/mach-zynq/include/mach/map.h
--- arch/arm/mach-prima2/include/mach/map.h	2011-07-07 13:21:41.000000000 +0000
+++ arch/arm/mach-zynq/include/mach/map.h	1970-01-01 00:00:00.000000000 +0000
@@ -1,16 +0,0 @@
-/*
- * memory & I/O static mapping definitions for CSR SiRFprimaII
- *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
- *
- * Licensed under GPLv2 or later.
- */
-
-#ifndef __MACH_PRIMA2_MAP_H__
-#define __MACH_PRIMA2_MAP_H__
-
-#include <mach/vmalloc.h>
-
-#define SIRFSOC_VA(x)			(VMALLOC_END + ((x) & 0x00FFF000))
-
-#endif
diff -urN arch/arm/mach-prima2/include/mach/memory.h arch/arm/mach-zynq/include/mach/memory.h
--- arch/arm/mach-prima2/include/mach/memory.h	2011-07-07 13:21:41.000000000 +0000
+++ arch/arm/mach-zynq/include/mach/memory.h	2011-07-07 13:22:07.000000000 +0000
@@ -1,21 +1,22 @@
-/*
- * arch/arm/mach-prima2/include/mach/memory.h
+/* arch/arm/mach-zynq/include/mach/memory.h
  *
- * Copyright (c) 2010 ??? 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *  Copyright (C) 2011 Xilinx
  *
- * Licensed under GPLv2 or later.
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
+#ifndef __MACH_MEMORY_H__
+#define __MACH_MEMORY_H__
 
-#define PLAT_PHYS_OFFSET        UL(0x00000000)
+#include <asm/sizes.h>
 
-/*
- * Restrict DMA-able region to workaround silicon limitation.
- * The limitation restricts buffers available for DMA to SD/MMC
- * hardware to be below 256MB
- */
-#define ARM_DMA_ZONE_SIZE	(SZ_256M)
+#define PLAT_PHYS_OFFSET	UL(0x0)
 
 #endif
diff -urN arch/arm/mach-prima2/include/mach/system.h arch/arm/mach-zynq/include/mach/system.h
--- arch/arm/mach-prima2/include/mach/system.h	2011-07-07 13:21:41.000000000 +0000
+++ arch/arm/mach-zynq/include/mach/system.h	2011-07-07 13:22:07.000000000 +0000
@@ -1,21 +1,20 @@
-/*
- * arch/arm/mach-prima2/include/mach/system.h
+/* arch/arm/mach-zynq/include/mach/system.h
  *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *  Copyright (C) 2011 Xilinx
  *
- * Licensed under GPLv2 or later.
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
 #ifndef __MACH_SYSTEM_H__
 #define __MACH_SYSTEM_H__
 
-#include <linux/bitops.h>
-#include <mach/hardware.h>
-
-#define SIRFSOC_SYS_RST_BIT  BIT(31)
-
-extern void __iomem *sirfsoc_rstc_base;
-
 static inline void arch_idle(void)
 {
 	cpu_do_idle();
@@ -23,7 +22,7 @@
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	writel(SIRFSOC_SYS_RST_BIT, sirfsoc_rstc_base);
+	/* Add architecture specific reset processing here */
 }
 
 #endif
diff -urN arch/arm/mach-prima2/include/mach/timex.h arch/arm/mach-zynq/include/mach/timex.h
--- arch/arm/mach-prima2/include/mach/timex.h	2011-07-07 13:21:41.000000000 +0000
+++ arch/arm/mach-zynq/include/mach/timex.h	2011-07-07 13:22:07.000000000 +0000
@@ -1,14 +1,23 @@
-/*
- * arch/arm/mach-prima2/include/mach/timex.h
+/* arch/arm/mach-zynq/include/mach/timex.h
  *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *  Copyright (C) 2011 Xilinx
  *
- * Licensed under GPLv2 or later.
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
 #ifndef __MACH_TIMEX_H__
 #define __MACH_TIMEX_H__
 
-#define CLOCK_TICK_RATE  1000000
+/* the following is needed for the system to build but will be removed
+   in the future, the value is not important but won't hurt
+*/
+#define CLOCK_TICK_RATE	(100 * HZ)
 
 #endif
diff -urN arch/arm/mach-prima2/include/mach/uart.h arch/arm/mach-zynq/include/mach/uart.h
--- arch/arm/mach-prima2/include/mach/uart.h	2011-07-07 13:21:41.000000000 +0000
+++ arch/arm/mach-zynq/include/mach/uart.h	2011-07-07 13:22:07.000000000 +0000
@@ -1,23 +1,25 @@
-/*
- * arch/arm/mach-prima2/include/mach/uart.h
+/* arch/arm/mach-zynq/include/mach/uart.h
  *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *  Copyright (C) 2011 Xilinx
  *
- * Licensed under GPLv2 or later.
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
-#ifndef __MACH_PRIMA2_SIRFSOC_UART_H
-#define __MACH_PRIMA2_SIRFSOC_UART_H
-
-/* UART-1: used as serial debug port */
-#define SIRFSOC_UART1_PA_BASE		0xb0060000
-#define SIRFSOC_UART1_VA_BASE		SIRFSOC_VA(0x060000)
-#define SIRFSOC_UART1_SIZE		SZ_4K
+#ifndef __MACH_UART_H__
+#define __MACH_UART_H__
 
-#define SIRFSOC_UART_TXFIFO_STATUS	0x0114
-#define SIRFSOC_UART_TXFIFO_DATA	0x0118
+#define UART_CR_OFFSET		0x00  /* Control Register [8:0] */
+#define UART_SR_OFFSET		0x2C  /* Channel Status [11:0] */
+#define UART_FIFO_OFFSET	0x30  /* FIFO [15:0] or [7:0] */
 
-#define SIRFSOC_UART1_TXFIFO_FULL                       (1 << 5)
-#define SIRFSOC_UART1_TXFIFO_EMPTY			(1 << 6)
+#define UART_SR_TXFULL		0x00000010	/* TX FIFO full */
+#define UART_SR_TXEMPTY		0x00000008	/* TX FIFO empty */
 
 #endif
diff -urN arch/arm/mach-prima2/include/mach/uncompress.h arch/arm/mach-zynq/include/mach/uncompress.h
--- arch/arm/mach-prima2/include/mach/uncompress.h	2011-07-07 13:21:41.000000000 +0000
+++ arch/arm/mach-zynq/include/mach/uncompress.h	2011-07-07 13:22:07.000000000 +0000
@@ -1,40 +1,51 @@
-/*
- * arch/arm/mach-prima2/include/mach/uncompress.h
+/* arch/arm/mach-zynq/include/mach/uncompress.h
  *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *  Copyright (C) 2011 Xilinx
  *
- * Licensed under GPLv2 or later.
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
+#ifndef __MACH_UNCOMPRESS_H__
+#define __MACH_UNCOMPRESS_H__
 
 #include <linux/io.h>
-#include <mach/hardware.h>
+#include <asm/processor.h>
+#include <mach/zynq_soc.h>
 #include <mach/uart.h>
 
 void arch_decomp_setup(void)
 {
 }
 
-#define arch_decomp_wdog()
-
-static __inline__ void putc(char c)
+static inline void flush(void)
 {
 	/*
-	 * during kernel decompression, all mappings are flat:
-	 *  virt_addr == phys_addr
+	 * Wait while the FIFO is not empty
 	 */
-	while (__raw_readl(SIRFSOC_UART1_PA_BASE + SIRFSOC_UART_TXFIFO_STATUS)
-		& SIRFSOC_UART1_TXFIFO_FULL)
-		barrier();
-
-	__raw_writel(c, SIRFSOC_UART1_PA_BASE + SIRFSOC_UART_TXFIFO_DATA);
+	while (!(__raw_readl(IOMEM(LL_UART_PADDR + UART_SR_OFFSET)) &
+		UART_SR_TXEMPTY))
+		cpu_relax();
 }
 
-static inline void flush(void)
+#define arch_decomp_wdog()
+
+static void putc(char ch)
 {
+	/*
+	 * Wait for room in the FIFO, then write the char into the FIFO
+	 */
+	while (__raw_readl(IOMEM(LL_UART_PADDR + UART_SR_OFFSET)) &
+		UART_SR_TXFULL)
+		cpu_relax();
+
+	__raw_writel(ch, IOMEM(LL_UART_PADDR + UART_FIFO_OFFSET));
 }
 
 #endif
-
diff -urN arch/arm/mach-prima2/include/mach/vmalloc.h arch/arm/mach-zynq/include/mach/vmalloc.h
--- arch/arm/mach-prima2/include/mach/vmalloc.h	2011-07-07 13:21:41.000000000 +0000
+++ arch/arm/mach-zynq/include/mach/vmalloc.h	2011-07-07 13:22:07.000000000 +0000
@@ -1,14 +1,20 @@
-/*
- * arch/arm/ach-prima2/include/mach/vmalloc.h
+/* arch/arm/mach-zynq/include/mach/vmalloc.h
  *
- * Copyright (c) 2010 ??? 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *  Copyright (C) 2011 Xilinx
  *
- * Licensed under GPLv2 or later.
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
-#ifndef __MACH_VMALLOC_H
-#define __MACH_VMALLOC_H
+#ifndef __MACH_VMALLOC_H__
+#define __MACH_VMALLOC_H__
 
-#define VMALLOC_END	0xFEC00000
+#define VMALLOC_END       0xE0000000UL
 
 #endif
diff -urN arch/arm/mach-prima2/include/mach/zynq_soc.h arch/arm/mach-zynq/include/mach/zynq_soc.h
--- arch/arm/mach-prima2/include/mach/zynq_soc.h	1970-01-01 00:00:00.000000000 +0000
+++ arch/arm/mach-zynq/include/mach/zynq_soc.h	2011-07-07 13:22:07.000000000 +0000
@@ -0,0 +1,48 @@
+/* arch/arm/mach-zynq/include/mach/zynq_soc.h
+ *
+ *  Copyright (C) 2011 Xilinx
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __MACH_XILINX_SOC_H__
+#define __MACH_XILINX_SOC_H__
+
+#define PERIPHERAL_CLOCK_RATE		2500000
+
+/* For now, all mappings are flat (physical = virtual)
+ */
+#define UART0_PHYS			0xE0000000
+#define UART0_VIRT			UART0_PHYS
+
+#define TTC0_PHYS			0xF8001000
+#define TTC0_VIRT			TTC0_PHYS
+
+#define PL310_L2CC_PHYS			0xF8F02000
+#define PL310_L2CC_VIRT			PL310_L2CC_PHYS
+
+#define SCU_PERIPH_PHYS			0xF8F00000
+#define SCU_PERIPH_VIRT			SCU_PERIPH_PHYS
+
+/* The following are intended for the devices that are mapped early */
+
+#define TTC0_BASE			IOMEM(TTC0_VIRT)
+#define SCU_PERIPH_BASE			IOMEM(SCU_PERIPH_VIRT)
+#define SCU_GIC_CPU_BASE		(SCU_PERIPH_BASE + 0x100)
+#define SCU_GIC_DIST_BASE		(SCU_PERIPH_BASE + 0x1000)
+#define PL310_L2CC_BASE			IOMEM(PL310_L2CC_VIRT)
+
+/*
+ * Mandatory for CONFIG_LL_DEBUG, UART is mapped virtual = physical
+ */
+#define LL_UART_PADDR	UART0_PHYS
+#define LL_UART_VADDR	UART0_VIRT
+
+#endif
