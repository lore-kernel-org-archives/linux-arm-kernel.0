From: ben-linux@fluff.org (Ben Dooks)
Date: Fri,  8 Jan 2010 02:37:02 +0000
Subject: [PATCH] ARM: SAMSUNG: Move IRQ UART handling for newer devices to
	plat-samsung
In-Reply-To: <1262918223-26529-1-git-send-email-ben-linux@fluff.org>
References: <1262918223-26529-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1262918223-26529-6-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the handling for the UART interrupts out of the s3c64xx specific
code and into plat-samsung so that it can be used by all implementations
that need it.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c64xx/Kconfig                 |    1 +
 arch/arm/plat-s3c64xx/irq.c                   |  117 +--------------------
 arch/arm/plat-samsung/Kconfig                 |    5 +
 arch/arm/plat-samsung/Makefile                |    1 +
 arch/arm/plat-samsung/include/plat/irq-uart.h |   20 ++++
 arch/arm/plat-samsung/irq-uart.c              |  143 +++++++++++++++++++++++++
 6 files changed, 173 insertions(+), 114 deletions(-)
 create mode 100644 arch/arm/plat-samsung/include/plat/irq-uart.h
 create mode 100644 arch/arm/plat-samsung/irq-uart.c

diff --git a/arch/arm/plat-s3c64xx/Kconfig b/arch/arm/plat-s3c64xx/Kconfig
index 02d716f..0fba1f9 100644
--- a/arch/arm/plat-s3c64xx/Kconfig
+++ b/arch/arm/plat-s3c64xx/Kconfig
@@ -15,6 +15,7 @@ config PLAT_S3C64XX
 	select ARCH_REQUIRE_GPIOLIB
 	select SAMSUNG_CLKSRC
 	select SAMSUNG_IRQ_VIC_TIMER
+	select SAMSUNG_IRQ_UART
 	select S3C_GPIO_TRACK
 	select S3C_GPIO_PULL_UPDOWN
 	select S3C_GPIO_CFG_S3C24XX
diff --git a/arch/arm/plat-s3c64xx/irq.c b/arch/arm/plat-s3c64xx/irq.c
index 8b69bca..b98451e 100644
--- a/arch/arm/plat-s3c64xx/irq.c
+++ b/arch/arm/plat-s3c64xx/irq.c
@@ -22,19 +22,10 @@
 
 #include <mach/map.h>
 #include <plat/irq-vic-timer.h>
-#include <plat/regs-serial.h>
+#include <plat/irq-uart.h>
 #include <plat/cpu.h>
 
-struct uart_irq {
-	void __iomem	*regs;
-	unsigned int	 base_irq;
-	unsigned int	 parent_irq;
-};
-
-/* Note, we make use of the fact that the parent IRQs, IRQ_UART[0..3]
- * are consecutive when looking up the interrupt in the demux routines.
- */
-static struct uart_irq uart_irqs[] = {
+static struct s3c_uart_irq uart_irqs[] = {
 	[0] = {
 		.regs		= S3C_VA_UART0,
 		.base_irq	= IRQ_S3CUART_BASE0,
@@ -57,110 +48,9 @@ static struct uart_irq uart_irqs[] = {
 	},
 };
 
-static inline void __iomem *s3c_irq_uart_base(unsigned int irq)
-{
-	struct uart_irq *uirq = get_irq_chip_data(irq);
-	return uirq->regs;
-}
-
-static inline unsigned int s3c_irq_uart_bit(unsigned int irq)
-{
-	return irq & 3;
-}
-
-/* UART interrupt registers, not worth adding to seperate include header */
-
-static void s3c_irq_uart_mask(unsigned int irq)
-{
-	void __iomem *regs = s3c_irq_uart_base(irq);
-	unsigned int bit = s3c_irq_uart_bit(irq);
-	u32 reg;
-
-	reg = __raw_readl(regs + S3C64XX_UINTM);
-	reg |= (1 << bit);
-	__raw_writel(reg, regs + S3C64XX_UINTM);
-}
-
-static void s3c_irq_uart_maskack(unsigned int irq)
-{
-	void __iomem *regs = s3c_irq_uart_base(irq);
-	unsigned int bit = s3c_irq_uart_bit(irq);
-	u32 reg;
-
-	reg = __raw_readl(regs + S3C64XX_UINTM);
-	reg |= (1 << bit);
-	__raw_writel(reg, regs + S3C64XX_UINTM);
-	__raw_writel(1 << bit, regs + S3C64XX_UINTP);
-}
-
-static void s3c_irq_uart_unmask(unsigned int irq)
-{
-	void __iomem *regs = s3c_irq_uart_base(irq);
-	unsigned int bit = s3c_irq_uart_bit(irq);
-	u32 reg;
-
-	reg = __raw_readl(regs + S3C64XX_UINTM);
-	reg &= ~(1 << bit);
-	__raw_writel(reg, regs + S3C64XX_UINTM);
-}
-
-static void s3c_irq_uart_ack(unsigned int irq)
-{
-	void __iomem *regs = s3c_irq_uart_base(irq);
-	unsigned int bit = s3c_irq_uart_bit(irq);
-
-	__raw_writel(1 << bit, regs + S3C64XX_UINTP);
-}
-
-static void s3c_irq_demux_uart(unsigned int irq, struct irq_desc *desc)
-{
-	struct uart_irq *uirq = &uart_irqs[irq - IRQ_UART0];
-	u32 pend = __raw_readl(uirq->regs + S3C64XX_UINTP);
-	int base = uirq->base_irq;
-
-	if (pend & (1 << 0))
-		generic_handle_irq(base);
-	if (pend & (1 << 1))
-		generic_handle_irq(base + 1);
-	if (pend & (1 << 2))
-		generic_handle_irq(base + 2);
-	if (pend & (1 << 3))
-		generic_handle_irq(base + 3);
-}
-
-static struct irq_chip s3c_irq_uart = {
-	.name		= "s3c-uart",
-	.mask		= s3c_irq_uart_mask,
-	.unmask		= s3c_irq_uart_unmask,
-	.mask_ack	= s3c_irq_uart_maskack,
-	.ack		= s3c_irq_uart_ack,
-};
-
-static void __init s3c64xx_uart_irq(struct uart_irq *uirq)
-{
-	void __iomem *reg_base = uirq->regs;
-	unsigned int irq;
-	int offs;
-
-	/* mask all interrupts at the start. */
-	__raw_writel(0xf, reg_base + S3C64XX_UINTM);
-
-	for (offs = 0; offs < 3; offs++) {
-		irq = uirq->base_irq + offs;
-
-		set_irq_chip(irq, &s3c_irq_uart);
-		set_irq_chip_data(irq, uirq);
-		set_irq_handler(irq, handle_level_irq);
-		set_irq_flags(irq, IRQF_VALID);
-	}
-
-	set_irq_chained_handler(uirq->parent_irq, s3c_irq_demux_uart);
-}
 
 void __init s3c64xx_init_irq(u32 vic0_valid, u32 vic1_valid)
 {
-	int uart;
-
 	printk(KERN_DEBUG "%s: initialising interrupts\n", __func__);
 
 	/* initialise the pair of VICs */
@@ -175,6 +65,5 @@ void __init s3c64xx_init_irq(u32 vic0_valid, u32 vic1_valid)
 	s3c_init_vic_timer_irq(IRQ_TIMER3_VIC, IRQ_TIMER3);
 	s3c_init_vic_timer_irq(IRQ_TIMER4_VIC, IRQ_TIMER4);
 
-	for (uart = 0; uart < ARRAY_SIZE(uart_irqs); uart++)
-		s3c64xx_uart_irq(&uart_irqs[uart]);
+	s3c_init_uart_irqs(uart_irqs, ARRAY_SIZE(uart_irqs));
 }
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index cedecd8..900b463 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -26,6 +26,11 @@ config SAMSUNG_IRQ_VIC_TIMER
        help
          Internal configuration to build the VIC timer interrupt code.
 
+config SAMSUNG_IRQ_UART
+       bool
+       help
+         Internal configuration to build the IRQ UART demux code.
+
 # options for gpio configuration support
 
 config S3C_GPIO_CFG_S3C24XX
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index aa048c7..aeb7e12 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -17,6 +17,7 @@ obj-y				+= gpio-config.o
 
 obj-$(CONFIG_SAMSUNG_CLKSRC)	+= clock-clksrc.o
 
+obj-$(CONFIG_SAMSUNG_IRQ_UART)	+= irq-uart.o
 obj-$(CONFIG_SAMSUNG_IRQ_VIC_TIMER) += irq-vic-timer.o
 
 # devices
diff --git a/arch/arm/plat-samsung/include/plat/irq-uart.h b/arch/arm/plat-samsung/include/plat/irq-uart.h
new file mode 100644
index 0000000..a9331e4
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/irq-uart.h
@@ -0,0 +1,20 @@
+/* arch/arm/plat-samsung/include/plat/irq-uart.h
+ *
+ * Copyright (c) 2010 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * Header file for Samsung SoC UART IRQ demux for S3C64XX and later
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+struct s3c_uart_irq {
+	void __iomem	*regs;
+	unsigned int	 base_irq;
+	unsigned int	 parent_irq;
+};
+
+extern void s3c_init_uart_irqs(struct s3c_uart_irq *irq, unsigned int nr_irqs);
+
diff --git a/arch/arm/plat-samsung/irq-uart.c b/arch/arm/plat-samsung/irq-uart.c
new file mode 100644
index 0000000..4f8c102
--- /dev/null
+++ b/arch/arm/plat-samsung/irq-uart.c
@@ -0,0 +1,143 @@
+/* arch/arm/plat-samsung/irq-uart.c
+ *	originally part of arch/arm/plat-s3c64xx/irq.c
+ *
+ * Copyright 2008 Openmoko, Inc.
+ * Copyright 2008 Simtec Electronics
+ *      Ben Dooks <ben@simtec.co.uk>
+ *      http://armlinux.simtec.co.uk/
+ *
+ * Samsung- UART Interrupt handling
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/serial_core.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+#include <mach/map.h>
+#include <plat/irq-uart.h>
+#include <plat/regs-serial.h>
+#include <plat/cpu.h>
+
+/* Note, we make use of the fact that the parent IRQs, IRQ_UART[0..3]
+ * are consecutive when looking up the interrupt in the demux routines.
+ */
+
+static inline void __iomem *s3c_irq_uart_base(unsigned int irq)
+{
+	struct s3c_uart_irq *uirq = get_irq_chip_data(irq);
+	return uirq->regs;
+}
+
+static inline unsigned int s3c_irq_uart_bit(unsigned int irq)
+{
+	return irq & 3;
+}
+
+static void s3c_irq_uart_mask(unsigned int irq)
+{
+	void __iomem *regs = s3c_irq_uart_base(irq);
+	unsigned int bit = s3c_irq_uart_bit(irq);
+	u32 reg;
+
+	reg = __raw_readl(regs + S3C64XX_UINTM);
+	reg |= (1 << bit);
+	__raw_writel(reg, regs + S3C64XX_UINTM);
+}
+
+static void s3c_irq_uart_maskack(unsigned int irq)
+{
+	void __iomem *regs = s3c_irq_uart_base(irq);
+	unsigned int bit = s3c_irq_uart_bit(irq);
+	u32 reg;
+
+	reg = __raw_readl(regs + S3C64XX_UINTM);
+	reg |= (1 << bit);
+	__raw_writel(reg, regs + S3C64XX_UINTM);
+	__raw_writel(1 << bit, regs + S3C64XX_UINTP);
+}
+
+static void s3c_irq_uart_unmask(unsigned int irq)
+{
+	void __iomem *regs = s3c_irq_uart_base(irq);
+	unsigned int bit = s3c_irq_uart_bit(irq);
+	u32 reg;
+
+	reg = __raw_readl(regs + S3C64XX_UINTM);
+	reg &= ~(1 << bit);
+	__raw_writel(reg, regs + S3C64XX_UINTM);
+}
+
+static void s3c_irq_uart_ack(unsigned int irq)
+{
+	void __iomem *regs = s3c_irq_uart_base(irq);
+	unsigned int bit = s3c_irq_uart_bit(irq);
+
+	__raw_writel(1 << bit, regs + S3C64XX_UINTP);
+}
+
+static void s3c_irq_demux_uart(unsigned int irq, struct irq_desc *desc)
+{
+	struct s3c_uart_irq *uirq = desc->handler_data;
+	u32 pend = __raw_readl(uirq->regs + S3C64XX_UINTP);
+	int base = uirq->base_irq;
+
+	if (pend & (1 << 0))
+		generic_handle_irq(base);
+	if (pend & (1 << 1))
+		generic_handle_irq(base + 1);
+	if (pend & (1 << 2))
+		generic_handle_irq(base + 2);
+	if (pend & (1 << 3))
+		generic_handle_irq(base + 3);
+}
+
+static struct irq_chip s3c_irq_uart = {
+	.name		= "s3c-uart",
+	.mask		= s3c_irq_uart_mask,
+	.unmask		= s3c_irq_uart_unmask,
+	.mask_ack	= s3c_irq_uart_maskack,
+	.ack		= s3c_irq_uart_ack,
+};
+
+static void __init s3c_init_uart_irq(struct s3c_uart_irq *uirq)
+{
+	struct irq_desc *desc = irq_to_desc(uirq->parent_irq);
+	void __iomem *reg_base = uirq->regs;
+	unsigned int irq;
+	int offs;
+
+	/* mask all interrupts at the start. */
+	__raw_writel(0xf, reg_base + S3C64XX_UINTM);
+
+	for (offs = 0; offs < 3; offs++) {
+		irq = uirq->base_irq + offs;
+
+		set_irq_chip(irq, &s3c_irq_uart);
+		set_irq_chip_data(irq, uirq);
+		set_irq_handler(irq, handle_level_irq);
+		set_irq_flags(irq, IRQF_VALID);
+	}
+
+	desc->handler_data = uirq;
+	set_irq_chained_handler(uirq->parent_irq, s3c_irq_demux_uart);
+}
+
+/**
+ * s3c_init_uart_irqs() - initialise UART IRQs and the necessary demuxing
+ * @irq: The interrupt data for registering
+ * @nr_irqs: The number of interrupt descriptions in @irq.
+ *
+ * Register the UART interrupts specified by @irq including the demuxing
+ * routines. This supports the S3C6400 and newer style of devices.
+ */
+void __init s3c_init_uart_irqs(struct s3c_uart_irq *irq, unsigned int nr_irqs)
+{
+	for (; nr_irqs > 0; nr_irqs--, irq++)
+		s3c_init_uart_irq(irq);
+}
-- 
1.6.0.4
