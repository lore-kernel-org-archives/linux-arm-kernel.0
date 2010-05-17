From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 10:16:56 +0900
Subject: [PATCH v5] ARM: S5PV210: Add Ext interrupt support.
Message-ID: <1274059016-24700-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

Add support for external interrupts on v210.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Pannaga Bhushan <p.bhushan@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig                  |    1 +
 arch/arm/mach-s5pv210/include/mach/irqs.h      |   31 ++--
 arch/arm/mach-s5pv210/include/mach/regs-gpio.h |   46 +++++
 arch/arm/plat-s5p/Kconfig                      |    5 +
 arch/arm/plat-s5p/Makefile                     |    1 +
 arch/arm/plat-s5p/irq-eint.c                   |  216 ++++++++++++++++++++++++
 6 files changed, 282 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/include/mach/regs-gpio.h
 create mode 100644 arch/arm/plat-s5p/irq-eint.c

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index af33a1a..c4c2a7f 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -12,6 +12,7 @@ if ARCH_S5PV210
 config CPU_S5PV210
 	bool
 	select PLAT_S5P
+	select S5P_EXT_INT
 	help
 	  Enable S5PV210 CPU support
 
diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
index 62c5175..42b9b28 100644
--- a/arch/arm/mach-s5pv210/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
@@ -17,22 +17,9 @@
 
 /* VIC0: System, DMA, Timer */
 
-#define IRQ_EINT0		S5P_IRQ_VIC0(0)
-#define IRQ_EINT1		S5P_IRQ_VIC0(1)
-#define IRQ_EINT2		S5P_IRQ_VIC0(2)
-#define IRQ_EINT3		S5P_IRQ_VIC0(3)
-#define IRQ_EINT4		S5P_IRQ_VIC0(4)
-#define IRQ_EINT5		S5P_IRQ_VIC0(5)
-#define IRQ_EINT6		S5P_IRQ_VIC0(6)
-#define IRQ_EINT7		S5P_IRQ_VIC0(7)
-#define IRQ_EINT8		S5P_IRQ_VIC0(8)
-#define IRQ_EINT9		S5P_IRQ_VIC0(9)
-#define IRQ_EINT10		S5P_IRQ_VIC0(10)
-#define IRQ_EINT11		S5P_IRQ_VIC0(11)
-#define IRQ_EINT12		S5P_IRQ_VIC0(12)
-#define IRQ_EINT13		S5P_IRQ_VIC0(13)
-#define IRQ_EINT14		S5P_IRQ_VIC0(14)
-#define IRQ_EINT15		S5P_IRQ_VIC0(15)
+/* Can be used for EINTs 0 to 15 */
+#define IRQ_EINT(x)		((x) + S5P_IRQ_VIC0(0))
+
 #define IRQ_EINT16_31		S5P_IRQ_VIC0(16)
 #define IRQ_BATF		S5P_IRQ_VIC0(17)
 #define IRQ_MDMA		S5P_IRQ_VIC0(18)
@@ -137,10 +124,18 @@
 #define S5P_IRQ_EINT_BASE	(IRQ_VIC_END + 1)
 
 #define S5P_EINT(x)		((x) + S5P_IRQ_EINT_BASE)
-#define IRQ_EINT(x)		S5P_EINT(x)
+/* Can be used for EINTs 16 to 31 */
+#define IRQ_EINT_GRP(x)		S5P_EINT(x)
+
+#define EINT_MODE		S3C_GPIO_SFN(0xf)
 
 /* Set the default NR_IRQS */
 
-#define NR_IRQS 		(IRQ_EINT(31) + 1)
+#define NR_IRQS			(IRQ_EINT_GRP(31) + 1)
+
+#define EINT_GPIO_REG0(x)	S5PV210_GPH0(x)
+#define EINT_GPIO_REG1(x)	S5PV210_GPH1(x)
+#define EINT_GPIO_REG2(x)	S5PV210_GPH2(x)
+#define EINT_GPIO_REG3(x)	S5PV210_GPH3(x)
 
 #endif /* ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-s5pv210/include/mach/regs-gpio.h b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
new file mode 100644
index 0000000..fe16292
--- /dev/null
+++ b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
@@ -0,0 +1,46 @@
+/* linux/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5PV210 - GPIO (including EINT) register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_REGS_GPIO_H
+#define __ASM_ARCH_REGS_GPIO_H __FILE__
+
+#include <mach/map.h>
+
+#define S5PV210_EINT30CON		(S5P_VA_GPIO + 0xE00)
+#define S5P_EINT_CON(x)			(S5PV210_EINT30CON + ((x) * 0x4))
+
+#define S5PV210_EINT30FLTCON0		(S5P_VA_GPIO + 0xE80)
+#define S5P_EINT_FLTCON(x)		(S5PV210_EINT30FLTCON0 + ((x) * 0x4))
+
+#define S5PV210_EINT30MASK		(S5P_VA_GPIO + 0xF00)
+#define S5P_EINT_MASK(x)		(S5PV210_EINT30MASK + ((x) * 0x4))
+
+#define S5PV210_EINT30PEND		(S5P_VA_GPIO + 0xF40)
+#define S5P_EINT_PEND(x)		(S5PV210_EINT30PEND + ((x) * 0x4))
+
+#define eint_offset(irq)	((irq) < IRQ_EINT16_31 ? ((irq) - IRQ_EINT(0)) \
+						: ((irq) - S5P_IRQ_EINT_BASE))
+
+#define eint_irq_to_bit(irq)		(1 << (eint_offset(irq) & 0x7))
+
+#define eint_conf_reg(irq)		((eint_offset(irq)) >> 3)
+#define eint_mask_reg(irq)		((eint_offset(irq)) >> 3)
+#define eint_pend_reg(irq)		((eint_offset(irq)) >> 3)
+
+/* values for S5P_EXTINT0 */
+#define S5P_EXTINT_LOWLEV		(0x00)
+#define S5P_EXTINT_HILEV		(0x01)
+#define S5P_EXTINT_FALLEDGE		(0x02)
+#define S5P_EXTINT_RISEEDGE		(0x03)
+#define S5P_EXTINT_BOTHEDGE		(0x04)
+
+#endif /* __ASM_ARCH_REGS_GPIO_H */
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index d400a6a..7d1fc40 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -23,3 +23,8 @@ config PLAT_S5P
 	select SAMSUNG_IRQ_UART
 	help
 	  Base platform code for Samsung's S5P series SoC.
+
+config S5P_EXT_INT
+	bool
+	help
+	  Use the external interrupts (other than GPIO interrupts.)
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index a7c54b3..25941a5 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -16,4 +16,5 @@ obj-y				+= dev-uart.o
 obj-y				+= cpu.o
 obj-y				+= clock.o
 obj-y				+= irq.o
+obj-$(CONFIG_S5P_EXT_INT)	+= irq-eint.o
 obj-y				+= setup-i2c0.o
diff --git a/arch/arm/plat-s5p/irq-eint.c b/arch/arm/plat-s5p/irq-eint.c
new file mode 100644
index 0000000..484a8fe
--- /dev/null
+++ b/arch/arm/plat-s5p/irq-eint.c
@@ -0,0 +1,216 @@
+/* linux/arch/arm/plat-s5p/irq-eint.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5P - IRQ EINT support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/sysdev.h>
+#include <linux/gpio.h>
+
+#include <asm/bitops.h>
+#include <asm/hardware/vic.h>
+
+#include <plat/regs-irqtype.h>
+
+#include <mach/map.h>
+#include <plat/cpu.h>
+#include <plat/pm.h>
+
+#include <plat/gpio-cfg.h>
+#include <mach/regs-gpio.h>
+
+static inline void s5p_irq_eint_mask(unsigned int irq)
+{
+	u32 mask;
+
+	mask = __raw_readl(S5P_EINT_MASK(eint_mask_reg(irq)));
+	mask |= eint_irq_to_bit(irq);
+	__raw_writel(mask, S5P_EINT_MASK(eint_mask_reg(irq)));
+}
+
+static void s5p_irq_eint_unmask(unsigned int irq)
+{
+	u32 mask;
+
+	mask = __raw_readl(S5P_EINT_MASK(eint_mask_reg(irq)));
+	mask &= ~(eint_irq_to_bit(irq));
+	__raw_writel(mask, S5P_EINT_MASK(eint_mask_reg(irq)));
+}
+
+static inline void s5p_irq_eint_ack(unsigned int irq)
+{
+	__raw_writel(eint_irq_to_bit(irq), S5P_EINT_PEND(eint_pend_reg(irq)));
+}
+
+static void s5p_irq_eint_maskack(unsigned int irq)
+{
+	/* compiler should in-line these */
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
+	switch (type) {
+	case IRQ_TYPE_NONE:
+		printk(KERN_WARNING "No edge setting!\n");
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+		newvalue = S5P_EXTINT_RISEEDGE;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		newvalue = S5P_EXTINT_RISEEDGE;
+		break;
+
+	case IRQ_TYPE_EDGE_BOTH:
+		newvalue = S5P_EXTINT_BOTHEDGE;
+		break;
+
+	case IRQ_TYPE_LEVEL_LOW:
+		newvalue = S5P_EXTINT_LOWLEV;
+		break;
+
+	case IRQ_TYPE_LEVEL_HIGH:
+		newvalue = S5P_EXTINT_HILEV;
+		break;
+
+	default:
+		printk(KERN_ERR "No such irq type %d", type);
+		return -EINVAL;
+	}
+
+	shift = (offs & 0x7) * 4;
+	mask = 0x7 << shift;
+
+	ctrl = __raw_readl(S5P_EINT_CON(eint_conf_reg(irq)));
+	ctrl &= ~mask;
+	ctrl |= newvalue << shift;
+	__raw_writel(ctrl, S5P_EINT_CON(eint_conf_reg(irq)));
+
+	if ((0 <= offs) && (offs < 8))
+		s3c_gpio_cfgpin(EINT_GPIO_REG0(offs & 0x7), EINT_MODE);
+
+	else if ((8 <= offs) && (offs < 16))
+		s3c_gpio_cfgpin(EINT_GPIO_REG1(offs & 0x7), EINT_MODE);
+
+	else if ((16 <= offs) && (offs < 24))
+		s3c_gpio_cfgpin(EINT_GPIO_REG2(offs & 0x7), EINT_MODE);
+
+	else if ((24 <= offs) && (offs < 32))
+		s3c_gpio_cfgpin(EINT_GPIO_REG3(offs & 0x7), EINT_MODE);
+
+	else
+		printk(KERN_ERR "No such irq number %d", offs);
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
+#ifdef CONFIG_PM
+	.set_wake	= s3c_irqext_wake,
+#endif
+};
+
+/* s5p_irq_demux_eint
+ *
+ * This function demuxes the IRQ from the group0 external interrupts,
+ * from IRQ_EINT(16) to IRQ_EINT(31). It is designed to be inlined into
+ * the specific handlers s5p_irq_demux_eintX_Y.
+ */
+static inline void s5p_irq_demux_eint(unsigned int start, unsigned int end)
+{
+	u32 status;
+	u32 mask = __raw_readl(S5P_EINT_MASK((start >> 3)));
+	unsigned int irq;
+
+	status = __raw_readl(S5P_EINT_PEND((start >> 3)));
+	status &= ~mask;
+	status &= (1 << (end - start + 1)) - 1;
+
+	while (status) {
+		irq = fls(status);
+		generic_handle_irq(irq - 1 + IRQ_EINT(start));
+		status &= ~(1 << irq);
+	}
+}
+
+static void s5p_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
+{
+	s5p_irq_demux_eint(16, 23);
+	s5p_irq_demux_eint(24, 31);
+}
+
+static inline void s5p_irq_vic_eint_mask(unsigned int irq)
+{
+	s5p_irq_eint_mask(irq);
+}
+
+static void s5p_irq_vic_eint_unmask(unsigned int irq)
+{
+	s5p_irq_eint_unmask(irq);
+}
+
+static inline void s5p_irq_vic_eint_ack(unsigned int irq)
+{
+	__raw_writel(eint_irq_to_bit(irq), S5P_EINT_PEND(eint_pend_reg(irq)));
+}
+
+static void s5p_irq_vic_eint_maskack(unsigned int irq)
+{
+	s5p_irq_vic_eint_mask(irq);
+	s5p_irq_vic_eint_ack(irq);
+}
+
+static struct irq_chip s5p_irq_vic_eint = {
+	.name		= "s5p_vic_eint",
+	.mask		= s5p_irq_vic_eint_mask,
+	.unmask		= s5p_irq_vic_eint_unmask,
+	.mask_ack	= s5p_irq_vic_eint_maskack,
+	.ack		= s5p_irq_vic_eint_ack,
+	.set_type	= s5p_irq_eint_set_type,
+#ifdef CONFIG_PM
+	.set_wake	= s3c_irqext_wake,
+#endif
+};
+
+int __init s5p_init_irq_eint(void)
+{
+	int irq;
+
+	for (irq = IRQ_EINT(0); irq <= IRQ_EINT(15); irq++)
+		set_irq_chip(irq, &s5p_irq_vic_eint);
+
+	for (irq = IRQ_EINT_GRP(16); irq <= IRQ_EINT_GRP(31); irq++) {
+		set_irq_chip(irq, &s5p_irq_eint);
+		set_irq_handler(irq, handle_level_irq);
+		set_irq_flags(irq, IRQF_VALID);
+	}
+
+	set_irq_chained_handler(IRQ_EINT16_31, s5p_irq_demux_eint16_31);
+	return 0;
+}
+
+arch_initcall(s5p_init_irq_eint);
-- 
1.6.3.3
