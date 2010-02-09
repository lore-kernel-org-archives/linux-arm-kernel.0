From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Mon,  8 Feb 2010 16:11:23 -0800
Subject: [PATCH 02/14] ARM: LPC32XX: Debug and IRQ macros
In-Reply-To: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1265674295-23996-3-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Debug (printascii) and IRQ handler macros for the LPC32XX
architecture

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/include/mach/debug-macro.S |   54 ++++++++++++++++++++++
 arch/arm/mach-lpc32xx/include/mach/entry-macro.S |   47 +++++++++++++++++++
 2 files changed, 101 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/include/mach/debug-macro.S b/arch/arm/mach-lpc32xx/include/mach/debug-macro.S
new file mode 100644
index 0000000..cd62e2f
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/debug-macro.S
@@ -0,0 +1,54 @@
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
+ */
+
+#include <mach/hardware.h>
+#include <mach/platform.h>
+
+#define LPC32XX_UART_DLL_FIFO_OFS	0x00
+#define LPC32XX_UART_LSR_OFS		0x14
+
+/*
+ * Debug output is hardcoded to standard UART 5
+*/
+
+	.macro	addruart,rx
+	mrc	p15, 0, \rx, c1, c0
+	tst	\rx, #1				@ MMU enabled?
+	ldr	\rx, =LPC32XX_UART5_BASE	@ physical
+	beq	1003f
+	ldr	\rx, =IO_ADDRESS(LPC32XX_UART5_BASE) @ virtual
+1003:
+	.endm
+
+	.macro	senduart,rd,rx
+	str	\rd, [\rx, #LPC32XX_UART_DLL_FIFO_OFS]
+	.endm
+
+	.macro	busyuart,rd,rx
+1002:
+	ldr	\rd, [\rx, #LPC32XX_UART_LSR_OFS]
+	tst	\rd, #(1 << 6)
+	beq	1002b
+	.endm
+
+	.macro	waituart,rd,rx
+1001:
+	ldr	\rd, [\rx, #LPC32XX_UART_LSR_OFS]
+	tst	\rd, #(1 << 5)
+	beq	1001b
+	.endm
diff --git a/arch/arm/mach-lpc32xx/include/mach/entry-macro.S b/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
new file mode 100644
index 0000000..870227c
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
@@ -0,0 +1,47 @@
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
+ */
+
+#include <mach/hardware.h>
+#include <mach/platform.h>
+
+#define LPC32XX_INTC_MASKED_STATUS_OFS	0x8
+
+	.macro	disable_fiq
+	.endm
+
+	.macro  get_irqnr_preamble, base, tmp
+	ldr	\base, =IO_ADDRESS(LPC32XX_MIC_BASE)
+	.endm
+
+	.macro  arch_ret_to_user, tmp1, tmp2
+	.endm
+
+/*
+ * Return IRQ number in irqnr. Also return processor Z flag status in CPSR
+ * as set if an interrupt is pending.
+ */
+	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
+	ldr	\irqstat, [\base, #LPC32XX_INTC_MASKED_STATUS_OFS]
+	clz	\irqnr, \irqstat
+	rsb	\irqnr, \irqnr, #31
+	teq	\irqstat, #0
+	.endm
+
+	.macro	irq_prio_table
+	.endm
+
-- 
1.6.6
