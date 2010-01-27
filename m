From: wellsk40@gmail.com (Kevin Wells)
Date: Tue, 26 Jan 2010 16:20:24 -0800
Subject: [PATCH 08/10] ARM: LPC32XX: uncompress output and printascii()
	output functions
Message-ID: <1264551624.6528.11@usb10132>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LPC32XX uncompress output and printascii() output functions


Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
---
  arch/arm/mach-lpc32xx/include/mach/debug-macro.S |   72  
+++++++++++++++++++
  arch/arm/mach-lpc32xx/include/mach/entry-macro.S |   81  
++++++++++++++++++++++
  2 files changed, 153 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/include/mach/debug-macro.S  
b/arch/arm/mach-lpc32xx/include/mach/debug-macro.S
new file mode 100644
index 0000000..641daba
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/debug-macro.S
@@ -0,0 +1,72 @@
+/*
+ * arch/arm/mach-lpc32xx/include/mach/debug-macro.S
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2010 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA   
02111-1307  USA
+ */
+
+#include <mach/hardware.h>
+#include <mach/platform.h>
+
+/*
+ * NOTE: The UART clock for the selected debug out should be enabled
+ * in the bootloader if this functionality is used.
+*/
+
+#ifdef CONFIG_ARCH_LPC32XX_DEBUGO_U3
+#define UARTDB_BASE UART3_BASE
+#endif
+
+#ifdef CONFIG_ARCH_LPC32XX_DEBUGO_U4
+#define UARTDB_BASE UART4_BASE
+#endif
+
+#ifdef CONFIG_ARCH_LPC32XX_DEBUGO_U5
+#define UARTDB_BASE UART5_BASE
+#endif
+
+#ifdef CONFIG_ARCH_LPC32XX_DEBUGO_U6
+#define UARTDB_BASE UART6_BASE
+#endif
+
+	.macro	addruart,rx
+	mrc	p15, 0, \rx, c1, c0
+	tst	\rx, #1				@ MMU enabled?
+	ldr	\rx, =UARTDB_BASE		@ physical
+	beq	1003f
+	ldr	\rx, =io_p2v(UARTDB_BASE)	@ virtual
+1003:
+	.endm
+
+	.macro	senduart,rd,rx
+	str	\rd, [\rx, #0]
+	.endm
+
+	.macro	busyuart,rd,rx
+1002:
+	ldr	\rd, [\rx, #0x14]
+	tst	\rd, #(1 << 6)
+	beq	1002b
+	.endm
+
+	.macro	waituart,rd,rx
+1001:
+	ldr	\rd, [\rx, #0x14]
+	tst	\rd, #(1 << 5)
+	beq	1001b
+	.endm
diff --git a/arch/arm/mach-lpc32xx/include/mach/entry-macro.S  
b/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
new file mode 100644
index 0000000..c0313ae
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
@@ -0,0 +1,81 @@
+/*
+ * arch/arm/mach-lpc32xx/include/mach/entry-macro.S
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2010 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA   
02111-1307  USA
+ */
+
+#include <mach/hardware.h>
+#include <mach/platform.h>
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
+/*
+ * Return IRQ number in irqnr. Also return processor Z flag status in  
CPSR
+ * as set if an interrupt is pending.
+ */
+	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
+	/* Get MIC status first */
+	ldr	\base, =IO_ADDRESS(MIC_BASE)
+	ldr	\irqstat, [\base, #INTC_STAT]
+	and	\irqstat, \irqstat, #0xFFFFFFFC
+	mov	\tmp, #0
+
+	/* Drop through to SIC1 or SIC2 if MIC is not pending */
+	cmp	\irqstat, #0
+	bne	1000f
+
+	/* SIC1 interrupts start at offset 32 */
+	ldr	\base, =IO_ADDRESS(SIC1_BASE)
+	ldr	\irqstat, [\base, #INTC_STAT]
+	mov	\tmp, #32
+
+	/* Drop through to SIC2 if SIC1 is not pending */
+	cmp	\irqstat, #0
+	bne	1000f
+
+	/* SIC2 interrupts start at offset 64 */
+	ldr	\base, =IO_ADDRESS(SIC2_BASE)
+	ldr	\irqstat, [\base, #INTC_STAT]
+	mov	\tmp, #64
+
+	/* Safety check only, exit if no status on MIC, SIC1, SIC2 */
+	cmp	\irqstat, #0
+	beq	1001f
+
+1000:
+	/* Returns an pending interrupt between 0 and 95 */
+	clz	\irqnr, \irqstat
+	rsb	\irqnr, \irqnr, #31
+	add	\irqnr, \irqnr, \tmp
+
+1001:
+	teq	\irqstat, #0
+	.endm
+
+	.macro	irq_prio_table
+	.endm
+
-- 
1.6.6
