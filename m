From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Fri,  5 Feb 2010 08:26:10 -0800
Subject: [PATCHv3 1/7] mxc: TrustZone interrupt controller (TZIC) for
	Freescale i.MX5 family
In-Reply-To: <cover.1265385421.git.amit.kucheria@canonical.com>
References: <cover.1265385421.git.amit.kucheria@canonical.com>
Message-ID: <367110fafb57f7340bbffec9b394ed2fa6e89da5.1265385421.git.amit.kucheria@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Freescale i.MX51 processor uses a new interrupt controller. Add
driver for TrustZone Interrupt Controller

Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
---
 arch/arm/plat-mxc/Kconfig                    |    8 ++
 arch/arm/plat-mxc/Makefile                   |    3 +
 arch/arm/plat-mxc/include/mach/common.h      |    1 +
 arch/arm/plat-mxc/include/mach/entry-macro.S |   34 +++++-
 arch/arm/plat-mxc/include/mach/irqs.h        |    6 +-
 arch/arm/plat-mxc/tzic.c                     |  172 ++++++++++++++++++++++++++
 6 files changed, 222 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/plat-mxc/tzic.c

diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 8b0a1ee..59558c4 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -62,6 +62,14 @@ config MXC_IRQ_PRIOR
 	  requirements for timing.
 	  Say N here, unless you have a specialized requirement.
 
+config MXC_TZIC
+	bool "Enable TrustZone Interrupt Controller"
+	depends on ARCH_MX51
+	help
+	  This will be automatically selected for all processors
+	  containing this interrupt controller.
+	  Say N here only if you are really sure.
+
 config MXC_PWM
 	tristate "Enable PWM driver"
 	depends on ARCH_MXC
diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index 996cbac..0202ad9 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -5,6 +5,9 @@
 # Common support
 obj-y := irq.o clock.o gpio.o time.o devices.o cpu.o system.o
 
+# MX51 uses the TZIC interrupt controller, older platforms use AVIC (irq.o)
+obj-$(CONFIG_MXC_TZIC) += tzic.o
+
 obj-$(CONFIG_ARCH_MX1) += iomux-mx1-mx2.o dma-mx1-mx2.o
 obj-$(CONFIG_ARCH_MX2) += iomux-mx1-mx2.o dma-mx1-mx2.o
 obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 286cb9b..49f1a4a 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -22,6 +22,7 @@ extern void mx31_map_io(void);
 extern void mx35_map_io(void);
 extern void mxc91231_map_io(void);
 extern void mxc_init_irq(void __iomem *);
+extern void tzic_init_irq(void __iomem *);
 extern void mx1_init_irq(void);
 extern void mx21_init_irq(void);
 extern void mx25_init_irq(void);
diff --git a/arch/arm/plat-mxc/include/mach/entry-macro.S b/arch/arm/plat-mxc/include/mach/entry-macro.S
index 7cf290e..aeb0869 100644
--- a/arch/arm/plat-mxc/include/mach/entry-macro.S
+++ b/arch/arm/plat-mxc/include/mach/entry-macro.S
@@ -1,6 +1,6 @@
 /*
  *  Copyright (C) 2007 Lennert Buytenhek <buytenh@wantstofly.org>
- *  Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ *  Copyright 2004-2009 Freescale Semiconductor, Inc. All Rights Reserved.
  */
 
 /*
@@ -18,11 +18,16 @@
 	.endm
 
 	.macro  get_irqnr_preamble, base, tmp
+#ifndef CONFIG_MXC_TZIC
 	ldr	\base, =avic_base
 	ldr	\base, [\base]
 #ifdef CONFIG_MXC_IRQ_PRIOR
 	ldr	r4, [\base, #AVIC_NIMASK]
 #endif
+#elif defined CONFIG_MXC_TZIC
+	ldr	\base, =tzic_base
+	ldr	\base, [\base]
+#endif /* CONFIG_MXC_TZIC */
 	.endm
 
 	.macro  arch_ret_to_user, tmp1, tmp2
@@ -32,6 +37,7 @@
 	@ and returns its number in irqnr
 	@ and returns if an interrupt occured in irqstat
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
+#ifndef CONFIG_MXC_TZIC
 	@ Load offset & priority of the highest priority
 	@ interrupt pending from AVIC_NIVECSR
 	ldr	\irqstat, [\base, #0x40]
@@ -45,6 +51,32 @@
 	strne	\tmp, [\base, #AVIC_NIMASK]
 	streq	r4, [\base, #AVIC_NIMASK]
 #endif
+#elif defined CONFIG_MXC_TZIC
+	@ Load offset & priority of the highest priority
+	@ interrupt pending.
+	@ 0xD80 is HIPND0 register
+	mov     \irqnr, #0
+	mov     \irqstat, #0x0D80
+1000:
+	ldr     \tmp,   [\irqstat, \base]
+	cmp     \tmp, #0
+	bne     1001f
+	addeq   \irqnr, \irqnr, #32
+	addeq   \irqstat, \irqstat, #4
+	cmp     \irqnr, #128
+	blo     1000b
+	b       2001f
+1001:	mov     \irqstat, #1
+1002:	tst     \tmp, \irqstat
+	bne     2002f
+	movs    \tmp, \tmp, lsr #1
+	addne   \irqnr, \irqnr, #1
+	bne     1002b
+2001:
+	mov  \irqnr, #0
+2002:
+	movs \irqnr, \irqnr
+#endif
 	.endm
 
 	@ irq priority table (not used)
diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index ead9d59..4c51083 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -12,9 +12,13 @@
 #define __ASM_ARCH_MXC_IRQS_H__
 
 /*
- * So far all i.MX SoCs have 64 internal interrupts
+ * SoCs with TZIC interrupt controller have 128 IRQs, those with AVIC have 64
  */
+#ifdef CONFIG_MXC_TZIC
+#define MXC_INTERNAL_IRQS	128
+#else
 #define MXC_INTERNAL_IRQS	64
+#endif
 
 #define MXC_GPIO_IRQ_START	MXC_INTERNAL_IRQS
 
diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
new file mode 100644
index 0000000..afa6709
--- /dev/null
+++ b/arch/arm/plat-mxc/tzic.c
@@ -0,0 +1,172 @@
+/*
+ * Copyright 2004-2009 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+
+#include <asm/mach/irq.h>
+
+#include <mach/hardware.h>
+
+/*
+ *****************************************
+ * TZIC Registers                        *
+ *****************************************
+ */
+
+#define TZIC_INTCNTL	0x0000	/* Control register */
+#define TZIC_INTTYPE	0x0004	/* Controller Type register */
+#define TZIC_IMPID	0x0008	/* Distributor Implementer Identification */
+#define TZIC_PRIOMASK	0x000C	/* Priority Mask Reg */
+#define TZIC_SYNCCTRL	0x0010	/* Synchronizer Control register */
+#define TZIC_DSMINT	0x0014	/* DSM interrupt Holdoffregister */
+#define TZIC_INTSEC0(i)	(0x0080 + ((i) << 2)) /* Interrupt Security Reg 0 */
+#define TZIC_ENSET0(i)	(0x0100 + ((i) << 2)) /* Enable Set Reg 0 */
+#define TZIC_ENCLEAR0(i) (0x0180 + ((i) << 2)) /* Enable Clear Reg 0 */
+#define TZIC_SRCSET0	0x0200	/* Source Set Register 0 */
+#define TZIC_SRCCLAR0	0x0280	/* Source Clear Register 0 */
+#define TZIC_PRIORITY0	0x0400	/* Priority Register 0 */
+#define TZIC_PND0	0x0D00	/* Pending Register 0 */
+#define TZIC_HIPND0	0x0D80	/* High Priority Pending Register */
+#define TZIC_WAKEUP0(i)	(0x0E00 + ((i) << 2))	/* Wakeup Config Register */
+#define TZIC_SWINT	0x0F00	/* Software Interrupt Rigger Register */
+#define TZIC_ID0	0x0FD0	/* Indentification Register 0 */
+
+void __iomem *tzic_base; /* Used as irq controller base in entry-macro.S */
+
+/**
+ * tzic_mask_irq() - Disable interrupt number "irq" in the TZIC
+ *
+ * @param  irq          interrupt source number
+ */
+static void tzic_mask_irq(unsigned int irq)
+{
+	int index, off;
+
+	index = irq >> 5;
+	off = irq & 0x1F;
+	__raw_writel(1 << off, tzic_base + TZIC_ENCLEAR0(index));
+}
+
+/**
+ * tzic_unmask_irq() - Enable interrupt number "irq" in the TZIC
+ *
+ * @param  irq          interrupt source number
+ */
+static void tzic_unmask_irq(unsigned int irq)
+{
+	int index, off;
+
+	index = irq >> 5;
+	off = irq & 0x1F;
+	__raw_writel(1 << off, tzic_base + TZIC_ENSET0(index));
+}
+
+static unsigned int wakeup_intr[4];
+
+/**
+ * tzic_set_wake_irq() - Set interrupt number "irq" in the TZIC as a wake-up source.
+ *
+ * @param  irq          interrupt source number
+ * @param  enable       enable as wake-up if equal to non-zero
+ * 			disble as wake-up if equal to zero
+ *
+ * @return       This function returns 0 on success.
+ */
+static int tzic_set_wake_irq(unsigned int irq, unsigned int enable)
+{
+	unsigned int index, off;
+
+	index = irq >> 5;
+	off = irq & 0x1F;
+
+	if (index > 3)
+		return -EINVAL;
+
+	if (enable)
+		wakeup_intr[index] |= (1 << off);
+	else
+		wakeup_intr[index] &= ~(1 << off);
+
+	return 0;
+}
+
+static struct irq_chip mxc_tzic_chip = {
+	.name = "MXC_TZIC",
+	.ack = tzic_mask_irq,
+	.mask = tzic_mask_irq,
+	.unmask = tzic_unmask_irq,
+	.set_wake = tzic_set_wake_irq,
+};
+
+/*
+ * This function initializes the TZIC hardware and disables all the
+ * interrupts. It registers the interrupt enable and disable functions
+ * to the kernel for each interrupt source.
+ */
+void __init tzic_init_irq(void __iomem *irqbase)
+{
+	int i;
+
+	tzic_base = irqbase;
+	/* put the TZIC into the reset value with
+	 * all interrupts disabled
+	 */
+	i = __raw_readl(tzic_base + TZIC_INTCNTL);
+
+	__raw_writel(0x80010001, tzic_base + TZIC_INTCNTL);
+	__raw_writel(0x1f, tzic_base + TZIC_PRIOMASK);
+	__raw_writel(0x02, tzic_base + TZIC_SYNCCTRL);
+
+	for (i = 0; i < 4; i++)
+		__raw_writel(0xFFFFFFFF, tzic_base + TZIC_INTSEC0(i));
+
+	/* disable all interrupts */
+	for (i = 0; i < 4; i++)
+		__raw_writel(0xFFFFFFFF, tzic_base + TZIC_ENCLEAR0(i));
+
+	/* all IRQ no FIQ Warning :: No selection */
+
+	for (i = 0; i < MXC_INTERNAL_IRQS; i++) {
+		set_irq_chip(i, &mxc_tzic_chip);
+		set_irq_handler(i, handle_level_irq);
+		set_irq_flags(i, IRQF_VALID);
+	}
+
+	pr_info("TrustZone Interrupt Controller (TZIC) initialized\n");
+}
+
+/**
+ * tzic_enable_wake() - enable wakeup interrupt
+ *
+ * @param is_idle		1 if called in idle loop (ENSET0 register);
+ *				0 to be used when called from low power entry
+ * @return			0 if successful; non-zero otherwise
+ */
+int tzic_enable_wake(int is_idle)
+{
+	unsigned int i, v;
+
+	__raw_writel(1, tzic_base + TZIC_DSMINT);
+	if (unlikely(__raw_readl(tzic_base + TZIC_DSMINT) == 0))
+		return -EAGAIN;
+
+	for (i = 0; i < 4; i++) {
+		v = is_idle ? __raw_readl(TZIC_ENSET0(i)) : wakeup_intr[i];
+		__raw_writel(v, TZIC_WAKEUP0(i));
+	}
+
+	return 0;
+}
-- 
1.6.3.3
