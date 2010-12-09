From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 9 Dec 2010 23:12:39 +0800
Subject: [PATCH v3 04/15] ARM: mxs: Add interrupt support
In-Reply-To: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1291907569-8925-4-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Interrupt Collector (ICOLL) support for MXS-based.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
Changes for v3:
 - icoll.c: add #include <linux/io.h> as it's removed from mx23.h
   and mx28.h
 - Change inclusion of hardware.h to mxs.h
 - Move writing to HW_ICOLL_VECTOR from icoll.c icoll_ack_irq()
   into entry-macro.S get_irqnr_and_base
 - icoll.c: add more words into comments for level 0 irq ack
 - mx23 and mx28 share the same icoll base address, so hard-coding
   of the address is ok
 - entry-macro.S: define and use HW_ICOLL_STAT_OFFSET over 0x70

Changes for v2:
 - Get icoll base in get_irqnr_preamble
 - Check the case of single SoC build and use hard-coding address if possible

 arch/arm/mach-mxs/icoll.c                    |   81 ++++++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/entry-macro.S |   41 +++++++++++++
 2 files changed, 122 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/icoll.c
 create mode 100644 arch/arm/mach-mxs/include/mach/entry-macro.S

diff --git a/arch/arm/mach-mxs/icoll.c b/arch/arm/mach-mxs/icoll.c
new file mode 100644
index 0000000..5dd43ba
--- /dev/null
+++ b/arch/arm/mach-mxs/icoll.c
@@ -0,0 +1,81 @@
+/*
+ * Copyright (C) 2009-2010 Freescale Semiconductor, Inc. All Rights Reserved.
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+#include <mach/mxs.h>
+#include <mach/common.h>
+
+#define HW_ICOLL_VECTOR				0x0000
+#define HW_ICOLL_LEVELACK			0x0010
+#define HW_ICOLL_CTRL				0x0020
+#define HW_ICOLL_INTERRUPTn_SET(n)		(0x0124 + (n) * 0x10)
+#define HW_ICOLL_INTERRUPTn_CLR(n)		(0x0128 + (n) * 0x10)
+#define BM_ICOLL_INTERRUPTn_ENABLE		0x00000004
+#define BV_ICOLL_LEVELACK_IRQLEVELACK__LEVEL0	0x1
+
+static void __iomem *icoll_base = MXS_IO_ADDRESS(MXS_ICOLL_BASE_ADDR);
+
+static void icoll_ack_irq(unsigned int irq)
+{
+	/*
+	 * The Interrupt Collector is able to prioritize irqs.
+	 * Currently only level 0 is used. So acking can use
+	 * BV_ICOLL_LEVELACK_IRQLEVELACK__LEVEL0 unconditionally.
+	 */
+	__raw_writel(BV_ICOLL_LEVELACK_IRQLEVELACK__LEVEL0,
+			icoll_base + HW_ICOLL_LEVELACK);
+}
+
+static void icoll_mask_irq(unsigned int irq)
+{
+	__raw_writel(BM_ICOLL_INTERRUPTn_ENABLE,
+			icoll_base + HW_ICOLL_INTERRUPTn_CLR(irq));
+}
+
+static void icoll_unmask_irq(unsigned int irq)
+{
+	__raw_writel(BM_ICOLL_INTERRUPTn_ENABLE,
+			icoll_base + HW_ICOLL_INTERRUPTn_SET(irq));
+}
+
+static struct irq_chip mxs_icoll_chip = {
+	.ack = icoll_ack_irq,
+	.mask = icoll_mask_irq,
+	.unmask = icoll_unmask_irq,
+};
+
+void __init icoll_init_irq(void)
+{
+	int i;
+
+	/*
+	 * Interrupt Collector reset, which initializes the priority
+	 * for each irq to level 0.
+	 */
+	mxs_reset_block(icoll_base + HW_ICOLL_CTRL);
+
+	for (i = 0; i < MXS_INTERNAL_IRQS; i++) {
+		set_irq_chip(i, &mxs_icoll_chip);
+		set_irq_handler(i, handle_level_irq);
+		set_irq_flags(i, IRQF_VALID);
+	}
+}
diff --git a/arch/arm/mach-mxs/include/mach/entry-macro.S b/arch/arm/mach-mxs/include/mach/entry-macro.S
new file mode 100644
index 0000000..2f2a7cf
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/entry-macro.S
@@ -0,0 +1,41 @@
+/*
+ * Low-level IRQ helper macros for Freescale MXS-based
+ *
+ * Copyright (C) 2009-2010 Freescale Semiconductor, Inc. All Rights Reserved.
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <mach/mxs.h>
+
+#define ICOLL_VBASE		MXS_IO_ADDRESS(MXS_ICOLL_BASE_ADDR)
+#define HW_ICOLL_STAT_OFFSET	0x70
+
+	.macro	disable_fiq
+	.endm
+
+	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
+	ldr	\irqnr, [\base, #HW_ICOLL_STAT_OFFSET]
+	cmp	\irqnr, #0x7F
+	strne	\irqnr, [\base]
+	moveqs	\irqnr, #0
+	.endm
+
+	.macro  get_irqnr_preamble, base, tmp
+	ldr	\base, =ICOLL_VBASE
+	.endm
+
+	.macro  arch_ret_to_user, tmp1, tmp2
+	.endm
-- 
1.7.1
