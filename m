From: phorton@bitbox.co.uk (Peter Horton)
Date: Mon, 6 Dec 2010 11:37:38 +0000
Subject: [PATCH] mx51: support FIQ on TZIC, revised
Message-ID: <20101206113738.GA29621@tuatara.localnet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for FIQ on mx51 TZIC

TZIC changes tested with FIQ audio on an mx51 board

AVIC changes build with mx3_defconfig, not tested

Signed-off-by: Peter Horton <phorton@bitbox.co.uk>

---

Patch is against Sascha's "for-next" tree

 arch/arm/plat-mxc/Makefile                   |    2 +-
 arch/arm/plat-mxc/avic.c                     |   32 ++++++++------
 arch/arm/plat-mxc/include/mach/entry-macro.S |   14 +++---
 arch/arm/plat-mxc/irq-common.c               |   60 ++++++++++++++++++++++++++
 arch/arm/plat-mxc/irq-common.h               |   29 ++++++++++++
 arch/arm/plat-mxc/tzic.c                     |   46 +++++++++++++++++---
 6 files changed, 155 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm/plat-mxc/irq-common.c
 create mode 100644 arch/arm/plat-mxc/irq-common.h

diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index 6aee27e..2f1b990 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := clock.o gpio.o time.o devices.o cpu.o system.o
+obj-y := clock.o gpio.o time.o devices.o cpu.o system.o irq-common.o
 
 # MX51 uses the TZIC interrupt controller, older platforms use AVIC
 obj-$(CONFIG_MXC_TZIC) += tzic.o
diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
index 7331f2a..9a4e8a2 100644
--- a/arch/arm/plat-mxc/avic.c
+++ b/arch/arm/plat-mxc/avic.c
@@ -24,6 +24,8 @@
 #include <asm/mach/irq.h>
 #include <mach/hardware.h>
 
+#include "irq-common.h"
+
 #define AVIC_INTCNTL		0x00	/* int control reg */
 #define AVIC_NIMASK		0x04	/* int mask reg */
 #define AVIC_INTENNUM		0x08	/* int enable number reg */
@@ -46,9 +48,9 @@
 
 void __iomem *avic_base;
 
-int imx_irq_set_priority(unsigned char irq, unsigned char prio)
-{
 #ifdef CONFIG_MXC_IRQ_PRIOR
+static int avic_irq_set_priority(unsigned char irq, unsigned char prio)
+{
 	unsigned int temp;
 	unsigned int mask = 0x0F << irq % 8 * 4;
 
@@ -62,14 +64,11 @@ int imx_irq_set_priority(unsigned char irq, unsigned char prio)
 	__raw_writel(temp, avic_base + AVIC_NIPRIORITY(irq / 8));
 
 	return 0;
-#else
-	return -ENOSYS;
-#endif
 }
-EXPORT_SYMBOL(imx_irq_set_priority);
+#endif
 
 #ifdef CONFIG_FIQ
-int mxc_set_irq_fiq(unsigned int irq, unsigned int type)
+static int avic_set_irq_fiq(unsigned int irq, unsigned int type)
 {
 	unsigned int irqt;
 
@@ -87,7 +86,6 @@ int mxc_set_irq_fiq(unsigned int irq, unsigned int type)
 
 	return 0;
 }
-EXPORT_SYMBOL(mxc_set_irq_fiq);
 #endif /* CONFIG_FIQ */
 
 /* Disable interrupt number "irq" in the AVIC */
@@ -102,10 +100,18 @@ static void mxc_unmask_irq(unsigned int irq)
 	__raw_writel(irq, avic_base + AVIC_INTENNUM);
 }
 
-static struct irq_chip mxc_avic_chip = {
-	.ack = mxc_mask_irq,
-	.mask = mxc_mask_irq,
-	.unmask = mxc_unmask_irq,
+static struct mxc_irq_chip mxc_avic_chip = {
+	.base = {
+		.ack = mxc_mask_irq,
+		.mask = mxc_mask_irq,
+		.unmask = mxc_unmask_irq,
+	},
+#ifdef CONFIG_MXC_IRQ_PRIOR
+	.set_priority = avic_irq_set_priority,
+#endif
+#ifdef CONFIG_FIQ
+	.set_irq_fiq = avic_set_irq_fiq,
+#endif
 };
 
 /*
@@ -133,7 +139,7 @@ void __init mxc_init_irq(void __iomem *irqbase)
 	__raw_writel(0, avic_base + AVIC_INTTYPEH);
 	__raw_writel(0, avic_base + AVIC_INTTYPEL);
 	for (i = 0; i < MXC_INTERNAL_IRQS; i++) {
-		set_irq_chip(i, &mxc_avic_chip);
+		set_irq_chip(i, &mxc_avic_chip.base);
 		set_irq_handler(i, handle_level_irq);
 		set_irq_flags(i, IRQF_VALID);
 	}
diff --git a/arch/arm/plat-mxc/include/mach/entry-macro.S b/arch/arm/plat-mxc/include/mach/entry-macro.S
index aeb0869..bd9bb97 100644
--- a/arch/arm/plat-mxc/include/mach/entry-macro.S
+++ b/arch/arm/plat-mxc/include/mach/entry-macro.S
@@ -54,15 +54,15 @@
 #elif defined CONFIG_MXC_TZIC
 	@ Load offset & priority of the highest priority
 	@ interrupt pending.
+	@ 0x080 is INTSEC0 register
 	@ 0xD80 is HIPND0 register
 	mov     \irqnr, #0
-	mov     \irqstat, #0x0D80
-1000:
-	ldr     \tmp,   [\irqstat, \base]
-	cmp     \tmp, #0
-	bne     1001f
-	addeq   \irqnr, \irqnr, #32
-	addeq   \irqstat, \irqstat, #4
+1000:	add	\irqstat, \base, \irqnr, lsr #3
+	ldr	\tmp, [\irqstat, #0xd80]
+	ldr	\irqstat, [\irqstat, #0x080]
+	ands	\tmp, \tmp, \irqstat
+	bne	1001f
+	add	\irqnr, \irqnr, #32
 	cmp     \irqnr, #128
 	blo     1000b
 	b       2001f
diff --git a/arch/arm/plat-mxc/irq-common.c b/arch/arm/plat-mxc/irq-common.c
new file mode 100644
index 0000000..0c799ac
--- /dev/null
+++ b/arch/arm/plat-mxc/irq-common.c
@@ -0,0 +1,60 @@
+/*
+ * Copyright (C) BitBox Ltd 2010
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA  02110-1301, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/irq.h>
+
+#include "irq-common.h"
+
+int imx_irq_set_priority(unsigned char irq, unsigned char prio)
+{
+	struct mxc_irq_chip *chip;
+	struct irq_chip *base;
+	int ret;
+
+	ret = -ENOSYS;
+
+	base = get_irq_chip(irq);
+	if (base) {
+		chip = container_of(base, struct mxc_irq_chip, base);
+		if (chip->set_priority)
+			ret = chip->set_priority(irq, prio);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(imx_irq_set_priority);
+
+int mxc_set_irq_fiq(unsigned int irq, unsigned int type)
+{
+	struct mxc_irq_chip *chip;
+	struct irq_chip *base;
+	int ret;
+
+	ret = -ENOSYS;
+
+	base = get_irq_chip(irq);
+	if (base) {
+		chip = container_of(base, struct mxc_irq_chip, base);
+		if (chip->set_irq_fiq)
+			ret = chip->set_irq_fiq(irq, type);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(mxc_set_irq_fiq);
diff --git a/arch/arm/plat-mxc/irq-common.h b/arch/arm/plat-mxc/irq-common.h
new file mode 100644
index 0000000..7203543
--- /dev/null
+++ b/arch/arm/plat-mxc/irq-common.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) BitBox Ltd 2010
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA  02110-1301, USA.
+ */
+
+#ifndef __PLAT_MXC_IRQ_COMMON_H__
+#define __PLAT_MXC_IRQ_COMMON_H__
+
+struct mxc_irq_chip
+{
+	struct irq_chip	base;
+	int (*set_priority)(unsigned char irq, unsigned char prio);
+	int (*set_irq_fiq)(unsigned int irq, unsigned int type);
+};
+
+#endif
diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
index 3703ab2..e69ed8a 100644
--- a/arch/arm/plat-mxc/tzic.c
+++ b/arch/arm/plat-mxc/tzic.c
@@ -21,6 +21,8 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 
+#include "irq-common.h"
+
 /*
  *****************************************
  * TZIC Registers                        *
@@ -47,6 +49,25 @@
 
 void __iomem *tzic_base; /* Used as irq controller base in entry-macro.S */
 
+#ifdef CONFIG_FIQ
+static int tzic_set_irq_fiq(unsigned int irq, unsigned int type)
+{
+	unsigned int index, mask, value;
+
+	index = irq >> 5;
+	if (unlikely(index >= 4))
+		return -EINVAL;
+	mask = 1U << (irq & 0x1F);
+
+	value = __raw_readl(tzic_base + TZIC_INTSEC0(index)) | mask;
+	if (type)
+		value &= ~mask;
+	__raw_writel(value, tzic_base + TZIC_INTSEC0(index));
+
+	return 0;
+}
+#endif
+
 /**
  * tzic_mask_irq() - Disable interrupt number "irq" in the TZIC
  *
@@ -104,12 +125,17 @@ static int tzic_set_wake_irq(unsigned int irq, unsigned int enable)
 	return 0;
 }
 
-static struct irq_chip mxc_tzic_chip = {
-	.name = "MXC_TZIC",
-	.ack = tzic_mask_irq,
-	.mask = tzic_mask_irq,
-	.unmask = tzic_unmask_irq,
-	.set_wake = tzic_set_wake_irq,
+static struct mxc_irq_chip mxc_tzic_chip = {
+	.base = {
+		.name = "MXC_TZIC",
+		.ack = tzic_mask_irq,
+		.mask = tzic_mask_irq,
+		.unmask = tzic_unmask_irq,
+		.set_wake = tzic_set_wake_irq,
+	},
+#ifdef CONFIG_FIQ
+	.set_irq_fiq = tzic_set_irq_fiq,
+#endif
 };
 
 /*
@@ -141,10 +167,16 @@ void __init tzic_init_irq(void __iomem *irqbase)
 	/* all IRQ no FIQ Warning :: No selection */
 
 	for (i = 0; i < MXC_INTERNAL_IRQS; i++) {
-		set_irq_chip(i, &mxc_tzic_chip);
+		set_irq_chip(i, &mxc_tzic_chip.base);
 		set_irq_handler(i, handle_level_irq);
 		set_irq_flags(i, IRQF_VALID);
 	}
+
+#ifdef CONFIG_FIQ
+	/* Initialize FIQ */
+	init_FIQ();
+#endif
+
 	pr_info("TrustZone Interrupt Controller (TZIC) initialized\n");
 }
 
-- 
1.7.2.3
