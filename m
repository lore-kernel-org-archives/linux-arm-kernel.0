From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 15 Nov 2010 22:36:26 +0800
Subject: [PATCH 02/11] ARM: imx: Add support of interrupt controller ICOLL
In-Reply-To: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
References: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1289831795-4373-3-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MX28 uses Interrupt Collector (ICOLL) as the interrupt
controller. So ICOLL becomes the third interrupt controller
for MXC besides AVIC and TZIC.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/plat-mxc/icoll.c                    |   79 ++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/entry-macro.S |   22 ++++++-
 2 files changed, 97 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/plat-mxc/icoll.c

diff --git a/arch/arm/plat-mxc/icoll.c b/arch/arm/plat-mxc/icoll.c
new file mode 100644
index 0000000..e9a9e42
--- /dev/null
+++ b/arch/arm/plat-mxc/icoll.c
@@ -0,0 +1,79 @@
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
+
+#include <mach/hardware.h>
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
+void __iomem *icoll_base;
+
+static void icoll_ack_irq(unsigned int irq)
+{
+	__raw_writel(0, icoll_base + HW_ICOLL_VECTOR);
+
+	/* ACK current interrupt (level 0) */
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
+static struct irq_chip mxc_icoll_chip = {
+	.ack = icoll_ack_irq,
+	.mask = icoll_mask_irq,
+	.unmask = icoll_unmask_irq,
+};
+
+void __init icoll_init_irq(void __iomem *irqbase)
+{
+	int i;
+
+	icoll_base = irqbase;
+	mxc_irq_base = irqbase;
+	mxc_irq_controller_type = MXC_IRQ_TYPE_ICOLL;
+
+	/* Reset icoll */
+	mxc_reset_block(irqbase + HW_ICOLL_CTRL);
+
+	for (i = 0; i < MXC_INTERNAL_IRQS; i++) {
+		set_irq_chip(i, &mxc_icoll_chip);
+		set_irq_handler(i, handle_level_irq);
+		set_irq_flags(i, IRQF_VALID);
+	}
+}
diff --git a/arch/arm/plat-mxc/include/mach/entry-macro.S b/arch/arm/plat-mxc/include/mach/entry-macro.S
index a7dd008..a66e804 100644
--- a/arch/arm/plat-mxc/include/mach/entry-macro.S
+++ b/arch/arm/plat-mxc/include/mach/entry-macro.S
@@ -1,6 +1,6 @@
 /*
  *  Copyright (C) 2007 Lennert Buytenhek <buytenh@wantstofly.org>
- *  Copyright 2004-2009 Freescale Semiconductor, Inc. All Rights Reserved.
+ *  Copyright 2004-2010 Freescale Semiconductor, Inc. All Rights Reserved.
  */
 
 /*
@@ -73,25 +73,39 @@
 #endif
 	.endm
 
+	.macro	icoll_get_irqnr_and_base, irqnr, irqstat, base, tmp
+	ldr \irqnr, [\base, #0x70]
+	cmp \irqnr, #0x7F
+	moveqs \irqnr, #0
+	.endm
+
 	.macro get_irqnr_and_base, irqnr, irqstat, base, tmp
-#if defined CONFIG_MXC_TZIC && defined CONFIG_MXC_AVIC
+#if defined CONFIG_MXC_TZIC && defined CONFIG_MXC_AVIC && defined CONFIG_MXC_ICOLL
 	ldr	\tmp, =mxc_irq_controller_type
 	ldr	\tmp, [\tmp]
 	cmp	\tmp, #MXC_IRQ_TYPE_AVIC
 	beq	3001f
+	cmp	\tmp, #MXC_IRQ_TYPE_ICOLL
+	beq	3002f
 
 	tzic_get_irqnr_and_base \irqnr, \irqstat, \base, \tmp
-	b	3002f
+	b	3003f
 3001:
 	avic_get_irqnr_and_base \irqnr, \irqstat, \base, \tmp
+	b	3003f
 3002:
+	icoll_get_irqnr_and_base \irqnr, \irqstat, \base, \tmp
+	b	3003f
+3003:
 
 #elif defined CONFIG_MXC_TZIC
 	tzic_get_irqnr_and_base \irqnr, \irqstat, \base, \tmp
 #elif defined CONFIG_MXC_AVIC
 	avic_get_irqnr_and_base \irqnr, \irqstat, \base, \tmp
+#elif defined CONFIG_MXC_ICOLL
+	icoll_get_irqnr_and_base \irqnr, \irqstat, \base, \tmp
 #else
-#error no tzic and no avic?
+#error none of tzic, avic, icoll?
 #endif
 	.endm
 
-- 
1.7.1
