From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 15 Jul 2011 12:11:34 +0530
Subject: [PATCH] ARM: S5P64X0: External Interrupt Support
Message-ID: <1310712094-19831-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add external interrupt support for S5P64X0. The external interrupts
supported are 0 to 15.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-s5p64x0/Makefile                 |    1 +
 arch/arm/mach-s5p64x0/include/mach/regs-gpio.h |    6 +
 arch/arm/mach-s5p64x0/irq-eint.c               |  185 ++++++++++++++++++++++++
 3 files changed, 192 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5p64x0/irq-eint.c

diff --git a/arch/arm/mach-s5p64x0/Makefile b/arch/arm/mach-s5p64x0/Makefile
index ae6bf6f..30f34f0 100644
--- a/arch/arm/mach-s5p64x0/Makefile
+++ b/arch/arm/mach-s5p64x0/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_ARCH_S5P64X0)	+= cpu.o init.o clock.o dma.o gpiolib.o
 obj-$(CONFIG_ARCH_S5P64X0)	+= setup-i2c0.o
 obj-$(CONFIG_CPU_S5P6440)	+= clock-s5p6440.o
 obj-$(CONFIG_CPU_S5P6450)	+= clock-s5p6450.o
+obj-y				+= irq-eint.o
 
 # machine support
 
diff --git a/arch/arm/mach-s5p64x0/include/mach/regs-gpio.h b/arch/arm/mach-s5p64x0/include/mach/regs-gpio.h
index 0953ef6..de005ac 100644
--- a/arch/arm/mach-s5p64x0/include/mach/regs-gpio.h
+++ b/arch/arm/mach-s5p64x0/include/mach/regs-gpio.h
@@ -34,4 +34,10 @@
 #define S5P6450_GPQ_BASE		(S5P_VA_GPIO + 0x0180)
 #define S5P6450_GPS_BASE		(S5P_VA_GPIO + 0x0300)
 
+/* External interrupt control registers for group0 */
+
+#define S5P64X0_EINT0CON0		(S5P_VA_GPIO + 0x900)
+#define S5P64X0_EINT0MASK		(S5P_VA_GPIO + 0x920)
+#define S5P64X0_EINT0PEND		(S5P_VA_GPIO + 0x924)
+
 #endif /* __ASM_ARCH_REGS_GPIO_H */
diff --git a/arch/arm/mach-s5p64x0/irq-eint.c b/arch/arm/mach-s5p64x0/irq-eint.c
new file mode 100644
index 0000000..cfaf599
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/irq-eint.c
@@ -0,0 +1,185 @@
+/* arch/arm/mach-s5p64x0/irq-eint.c
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd
+ *		http://www.samsung.com/
+ *
+ * Based on linux/arch/arm/mach-s3c64xx/irq-eint.c
+ *
+ * S5P64X0 - Interrupt handling for External Interrupts.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+#include <plat/regs-irqtype.h>
+#include <plat/gpio-cfg.h>
+
+#include <mach/regs-gpio.h>
+#include <mach/regs-clock.h>
+
+#define eint_offset(irq)	((irq) - IRQ_EINT(0))
+#define eint_irq_to_bit(irq)	((u32)(1 << eint_offset(irq)))
+
+static inline void s5p64x0_irq_eint_mask(struct irq_data *data)
+{
+	u32 mask;
+
+	mask = __raw_readl(S5P64X0_EINT0MASK);
+	mask |= (u32)data->chip_data;
+	__raw_writel(mask, S5P64X0_EINT0MASK);
+}
+
+static void s5p64x0_irq_eint_unmask(struct irq_data *data)
+{
+	u32 mask;
+
+	mask = __raw_readl(S5P64X0_EINT0MASK);
+	mask &= ~((u32)data->chip_data);
+	__raw_writel(mask, S5P64X0_EINT0MASK);
+}
+
+static inline void s5p64x0_irq_eint_ack(struct irq_data *data)
+{
+	__raw_writel((u32)data->chip_data, S5P64X0_EINT0PEND);
+}
+
+static void s5p64x0_irq_eint_maskack(struct irq_data *data)
+{
+	/* compiler should in-line these */
+	s5p64x0_irq_eint_mask(data);
+	s5p64x0_irq_eint_ack(data);
+}
+
+static int s5p64x0_irq_eint_set_type(struct irq_data *data, unsigned int type)
+{
+	int offs = eint_offset(data->irq);
+	int shift;
+	u32 ctrl, mask;
+	u32 newvalue = 0;
+	unsigned int id;
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
+		return -1;
+	}
+
+	shift = (offs / 2) * 4;
+	mask = 0x7 << shift;
+
+	ctrl = __raw_readl(S5P64X0_EINT0CON0) & ~mask;
+	ctrl |= newvalue << shift;
+	__raw_writel(ctrl, S5P64X0_EINT0CON0);
+
+	id = __raw_readl(S5P64X0_SYS_ID) & 0xFF000;
+
+	if (id == 0x50000)
+		s3c_gpio_cfgpin(S5P6450_GPN(offs), S3C_GPIO_SFN(2));
+	else
+		s3c_gpio_cfgpin(S5P6440_GPN(offs), S3C_GPIO_SFN(2));
+
+	return 0;
+}
+
+static struct irq_chip s5p64x0_irq_eint = {
+	.name		= "s5p64x0-eint",
+	.irq_mask	= s5p64x0_irq_eint_mask,
+	.irq_unmask	= s5p64x0_irq_eint_unmask,
+	.irq_mask_ack	= s5p64x0_irq_eint_maskack,
+	.irq_ack	= s5p64x0_irq_eint_ack,
+	.irq_set_type	= s5p64x0_irq_eint_set_type,
+};
+
+/*
+ * s5p64x0_irq_demux_eint
+ *
+ * This function demuxes the IRQ from the group0 external interrupts,
+ * from IRQ_EINT(0) to IRQ_EINT(15). It is designed to be inlined into
+ * the specific handlers s5p64x0_irq_demux_eintX_Y.
+ */
+static inline void s5p64x0_irq_demux_eint(unsigned int start, unsigned int end)
+{
+	u32 status = __raw_readl(S5P64X0_EINT0PEND);
+	u32 mask = __raw_readl(S5P64X0_EINT0MASK);
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
+static void s5p64x0_irq_demux_eint0_3(unsigned int irq, struct irq_desc *desc)
+{
+	s5p64x0_irq_demux_eint(0, 3);
+}
+
+static void s5p64x0_irq_demux_eint4_11(unsigned int irq, struct irq_desc *desc)
+{
+	s5p64x0_irq_demux_eint(4, 11);
+}
+
+static void s5p64x0_irq_demux_eint12_15(unsigned int irq,
+					struct irq_desc *desc)
+{
+	s5p64x0_irq_demux_eint(12, 15);
+}
+
+static int __init s5p64x0_init_irq_eint(void)
+{
+	int irq;
+
+	for (irq = IRQ_EINT(0); irq <= IRQ_EINT(15); irq++) {
+		irq_set_chip_and_handler(irq, &s5p64x0_irq_eint,
+					 handle_level_irq);
+		irq_set_chip_data(irq, (void *)eint_irq_to_bit(irq));
+		set_irq_flags(irq, IRQF_VALID);
+	}
+
+	irq_set_chained_handler(IRQ_EINT0_3, s5p64x0_irq_demux_eint0_3);
+	irq_set_chained_handler(IRQ_EINT4_11, s5p64x0_irq_demux_eint4_11);
+	irq_set_chained_handler(IRQ_EINT12_15, s5p64x0_irq_demux_eint12_15);
+
+	return 0;
+}
+
+arch_initcall(s5p64x0_init_irq_eint);
-- 
1.7.4.4
