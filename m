From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 25 May 2010 09:24:15 +0900
Subject: [PATCH v2] ARM: S5P6440: Add External Interrupt support
Message-ID: <1274747055-12276-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

Add external interrupt support for S5P6440. The external interrupts
supported as 0 to 15.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Changes since v1:

1. Removed unused include files.
2. Fix incorrect return values.

 arch/arm/mach-s5p6440/Makefile   |    2 +-
 arch/arm/mach-s5p6440/irq-eint.c |  164 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 165 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-s5p6440/irq-eint.c

diff --git a/arch/arm/mach-s5p6440/Makefile b/arch/arm/mach-s5p6440/Makefile
index be3c53a..f1bc1e0 100644
--- a/arch/arm/mach-s5p6440/Makefile
+++ b/arch/arm/mach-s5p6440/Makefile
@@ -12,7 +12,7 @@ obj-				:=
 
 # Core support for S5P6440 system
 
-obj-$(CONFIG_CPU_S5P6440)	+= cpu.o init.o clock.o gpio.o dma.o
+obj-$(CONFIG_CPU_S5P6440)	+= cpu.o init.o clock.o gpio.o dma.o irq-eint.o
 obj-$(CONFIG_CPU_S5P6440)	+= setup-i2c0.o
 
 # machine support
diff --git a/arch/arm/mach-s5p6440/irq-eint.c b/arch/arm/mach-s5p6440/irq-eint.c
new file mode 100644
index 0000000..93310ae
--- /dev/null
+++ b/arch/arm/mach-s5p6440/irq-eint.c
@@ -0,0 +1,164 @@
+/* arch/arm/mach-s5p6440/irq-eint.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd
+ *		http://www.samsung.com/
+ *
+ * Based on linux/arch/arm/mach-s3c6410/irq-eint.c
+ *
+ * S5P6440 - Interrupt handling for External Interrupts.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+#include <plat/regs-irqtype.h>
+#include <mach/regs-gpio.h>
+#include <plat/gpio-cfg.h>
+
+#define eint_offset(irq)	((irq) - IRQ_EINT(0))
+#define eint_irq_to_bit(irq)	(1 << eint_offset(irq))
+
+static inline void s5p_irq_eint_mask(unsigned int irq)
+{
+	u32 mask =  __raw_readl(S5P6440_EINT0MASK);
+
+	mask |= eint_irq_to_bit(irq);
+	__raw_writel(mask, S5P6440_EINT0MASK);
+}
+
+static void s5p_irq_eint_unmask(unsigned int irq)
+{
+	u32 mask = __raw_readl(S5P6440_EINT0MASK);
+
+	mask &= ~eint_irq_to_bit(irq);
+	__raw_writel(mask, S5P6440_EINT0MASK);
+}
+
+static inline void s5p_irq_eint_ack(unsigned int irq)
+{
+	__raw_writel(eint_irq_to_bit(irq), S5P6440_EINT0PEND);
+}
+
+static void s5p_irq_eint_maskack(unsigned int irq)
+{
+	s5p_irq_eint_mask(irq);
+	s5p_irq_eint_ack(irq);
+}
+
+static int s5p_irq_eint_set_type(unsigned int irq, unsigned int type)
+{
+	int offs = eint_offset(irq);
+	int shift;
+	u32 ctrl, mask;
+	u32 newvalue = 0;
+
+	if (offs > 15)
+		return -EINVAL;
+
+	switch (type) {
+	case IRQ_TYPE_NONE:
+		printk(KERN_WARNING "No edge setting!\n");
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+		newvalue = S3C2410_EXTINT_RISEEDGE;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		newvalue = S3C2410_EXTINT_FALLEDGE;
+		break;
+
+	case IRQ_TYPE_EDGE_BOTH:
+		newvalue = S3C2410_EXTINT_BOTHEDGE;
+		break;
+
+	case IRQ_TYPE_LEVEL_LOW:
+		newvalue = S3C2410_EXTINT_LOWLEV;
+		break;
+
+	case IRQ_TYPE_LEVEL_HIGH:
+		newvalue = S3C2410_EXTINT_HILEV;
+		break;
+
+	default:
+		printk(KERN_ERR "No such irq type %d", type);
+		return -EINVAL;
+	}
+
+	shift = (offs / 2) * 4;
+	mask = 0x7 << shift;
+
+	ctrl = __raw_readl(S5P6440_EINT0CON0) & ~mask;
+	ctrl |= newvalue << shift;
+	__raw_writel(ctrl, S5P6440_EINT0CON0);
+
+	s3c_gpio_cfgpin(S5P6440_GPN(offs), S3C_GPIO_SFN(2));
+
+	return 0;
+}
+
+static struct irq_chip s5p_irq_eint = {
+	.name		= "s5p-eint",
+	.mask		= s5p_irq_eint_mask,
+	.unmask		= s5p_irq_eint_unmask,
+	.mask_ack	= s5p_irq_eint_maskack,
+	.ack		= s5p_irq_eint_ack,
+	.set_type	= s5p_irq_eint_set_type,
+};
+
+static inline void s5p_irq_demux_eint(unsigned int start, unsigned int end)
+{
+	u32 status = __raw_readl(S5P6440_EINT0PEND);
+	u32 mask = __raw_readl(S5P6440_EINT0MASK);
+	unsigned int irq;
+
+	status &= ~mask;
+	status >>= start;
+	status &= (1 << (end - start + 1)) - 1;
+
+	for (irq = IRQ_EINT(start); irq <= IRQ_EINT(end); irq++) {
+		if (status & 1)
+			generic_handle_irq(irq);
+
+		status >>= 1;
+	}
+}
+
+static void s5p_irq_demux_eint0_3(unsigned int irq, struct irq_desc *desc)
+{
+	s5p_irq_demux_eint(0, 3);
+}
+
+static void s5p_irq_demux_eint4_11(unsigned int irq, struct irq_desc *desc)
+{
+	s5p_irq_demux_eint(4, 11);
+}
+
+static void s5p_irq_demux_eint12_15(unsigned int irq, struct irq_desc *desc)
+{
+	s5p_irq_demux_eint(12, 15);
+}
+
+static int __init s5p6440_init_irq_eint(void)
+{
+	int irq;
+
+	for (irq = IRQ_EINT(0); irq <= IRQ_EINT(15); irq++) {
+		set_irq_chip(irq, &s5p_irq_eint);
+		set_irq_handler(irq, handle_level_irq);
+		set_irq_flags(irq, IRQF_VALID);
+	}
+
+	set_irq_chained_handler(IRQ_EINT0_3, s5p_irq_demux_eint0_3);
+	set_irq_chained_handler(IRQ_EINT4_11, s5p_irq_demux_eint4_11);
+	set_irq_chained_handler(IRQ_EINT12_15, s5p_irq_demux_eint12_15);
+
+	return 0;
+}
+
+arch_initcall(s5p6440_init_irq_eint);
-- 
1.6.3.3
