From: ben-linux@fluff.org (Ben Dooks)
Date: Fri,  8 Jan 2010 02:37:01 +0000
Subject: [PATCH] ARM: SAMSUNG: Move IRQ VIC timer handling out to common
	header files
In-Reply-To: <1262918223-26529-1-git-send-email-ben-linux@fluff.org>
References: <1262918223-26529-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1262918223-26529-5-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the VIC based timer interrupt handling out of plat-s3c64xx and
into plat-samsung to be re-used for other systems. This also reduces
the code size as we now have a common init routine and use the irq_desc
to store the interrupt number of the timer.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c64xx/Kconfig                      |    1 +
 arch/arm/plat-s3c64xx/irq.c                        |   90 ++------------------
 arch/arm/plat-samsung/Kconfig                      |    7 ++
 arch/arm/plat-samsung/Makefile                     |    2 +
 arch/arm/plat-samsung/include/plat/irq-vic-timer.h |   13 +++
 arch/arm/plat-samsung/irq-vic-timer.c              |   86 +++++++++++++++++++
 6 files changed, 116 insertions(+), 83 deletions(-)
 create mode 100644 arch/arm/plat-samsung/include/plat/irq-vic-timer.h
 create mode 100644 arch/arm/plat-samsung/irq-vic-timer.c

diff --git a/arch/arm/plat-s3c64xx/Kconfig b/arch/arm/plat-s3c64xx/Kconfig
index bec1224..02d716f 100644
--- a/arch/arm/plat-s3c64xx/Kconfig
+++ b/arch/arm/plat-s3c64xx/Kconfig
@@ -14,6 +14,7 @@ config PLAT_S3C64XX
 	select NO_IOPORT
 	select ARCH_REQUIRE_GPIOLIB
 	select SAMSUNG_CLKSRC
+	select SAMSUNG_IRQ_VIC_TIMER
 	select S3C_GPIO_TRACK
 	select S3C_GPIO_PULL_UPDOWN
 	select S3C_GPIO_CFG_S3C24XX
diff --git a/arch/arm/plat-s3c64xx/irq.c b/arch/arm/plat-s3c64xx/irq.c
index 8dc5b6d..8b69bca 100644
--- a/arch/arm/plat-s3c64xx/irq.c
+++ b/arch/arm/plat-s3c64xx/irq.c
@@ -21,78 +21,10 @@
 #include <asm/hardware/vic.h>
 
 #include <mach/map.h>
+#include <plat/irq-vic-timer.h>
 #include <plat/regs-serial.h>
-#include <plat/regs-timer.h>
 #include <plat/cpu.h>
 
-/* Timer interrupt handling */
-
-static void s3c_irq_demux_timer(unsigned int base_irq, unsigned int sub_irq)
-{
-	generic_handle_irq(sub_irq);
-}
-
-static void s3c_irq_demux_timer0(unsigned int irq, struct irq_desc *desc)
-{
-	s3c_irq_demux_timer(irq, IRQ_TIMER0);
-}
-
-static void s3c_irq_demux_timer1(unsigned int irq, struct irq_desc *desc)
-{
-	s3c_irq_demux_timer(irq, IRQ_TIMER1);
-}
-
-static void s3c_irq_demux_timer2(unsigned int irq, struct irq_desc *desc)
-{
-	s3c_irq_demux_timer(irq, IRQ_TIMER2);
-}
-
-static void s3c_irq_demux_timer3(unsigned int irq, struct irq_desc *desc)
-{
-	s3c_irq_demux_timer(irq, IRQ_TIMER3);
-}
-
-static void s3c_irq_demux_timer4(unsigned int irq, struct irq_desc *desc)
-{
-	s3c_irq_demux_timer(irq, IRQ_TIMER4);
-}
-
-/* We assume the IRQ_TIMER0..IRQ_TIMER4 range is continuous. */
-
-static void s3c_irq_timer_mask(unsigned int irq)
-{
-	u32 reg = __raw_readl(S3C64XX_TINT_CSTAT);
-
-	reg &= 0x1f;  /* mask out pending interrupts */
-	reg &= ~(1 << (irq - IRQ_TIMER0));
-	__raw_writel(reg, S3C64XX_TINT_CSTAT);
-}
-
-static void s3c_irq_timer_unmask(unsigned int irq)
-{
-	u32 reg = __raw_readl(S3C64XX_TINT_CSTAT);
-
-	reg &= 0x1f;  /* mask out pending interrupts */
-	reg |= 1 << (irq - IRQ_TIMER0);
-	__raw_writel(reg, S3C64XX_TINT_CSTAT);
-}
-
-static void s3c_irq_timer_ack(unsigned int irq)
-{
-	u32 reg = __raw_readl(S3C64XX_TINT_CSTAT);
-
-	reg &= 0x1f;
-	reg |= (1 << 5) << (irq - IRQ_TIMER0);
-	__raw_writel(reg, S3C64XX_TINT_CSTAT);
-}
-
-static struct irq_chip s3c_irq_timer = {
-	.name		= "s3c-timer",
-	.mask		= s3c_irq_timer_mask,
-	.unmask		= s3c_irq_timer_unmask,
-	.ack		= s3c_irq_timer_ack,
-};
-
 struct uart_irq {
 	void __iomem	*regs;
 	unsigned int	 base_irq;
@@ -227,7 +159,7 @@ static void __init s3c64xx_uart_irq(struct uart_irq *uirq)
 
 void __init s3c64xx_init_irq(u32 vic0_valid, u32 vic1_valid)
 {
-	int uart, irq;
+	int uart;
 
 	printk(KERN_DEBUG "%s: initialising interrupts\n", __func__);
 
@@ -237,20 +169,12 @@ void __init s3c64xx_init_irq(u32 vic0_valid, u32 vic1_valid)
 
 	/* add the timer sub-irqs */
 
-	set_irq_chained_handler(IRQ_TIMER0_VIC, s3c_irq_demux_timer0);
-	set_irq_chained_handler(IRQ_TIMER1_VIC, s3c_irq_demux_timer1);
-	set_irq_chained_handler(IRQ_TIMER2_VIC, s3c_irq_demux_timer2);
-	set_irq_chained_handler(IRQ_TIMER3_VIC, s3c_irq_demux_timer3);
-	set_irq_chained_handler(IRQ_TIMER4_VIC, s3c_irq_demux_timer4);
-
-	for (irq = IRQ_TIMER0; irq <= IRQ_TIMER4; irq++) {
-		set_irq_chip(irq, &s3c_irq_timer);
-		set_irq_handler(irq, handle_level_irq);
-		set_irq_flags(irq, IRQF_VALID);
-	}
+	s3c_init_vic_timer_irq(IRQ_TIMER0_VIC, IRQ_TIMER0);
+	s3c_init_vic_timer_irq(IRQ_TIMER1_VIC, IRQ_TIMER1);
+	s3c_init_vic_timer_irq(IRQ_TIMER2_VIC, IRQ_TIMER2);
+	s3c_init_vic_timer_irq(IRQ_TIMER3_VIC, IRQ_TIMER3);
+	s3c_init_vic_timer_irq(IRQ_TIMER4_VIC, IRQ_TIMER4);
 
 	for (uart = 0; uart < ARRAY_SIZE(uart_irqs); uart++)
 		s3c64xx_uart_irq(&uart_irqs[uart]);
 }
-
-
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 9e7daf2..cedecd8 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -19,6 +19,13 @@ config SAMSUNG_CLKSRC
 	  Select the clock code for the clksrc implementation
 	  used by newer systems such as the S3C64XX.
 
+# options for IRQ support
+
+config SAMSUNG_IRQ_VIC_TIMER
+       bool
+       help
+         Internal configuration to build the VIC timer interrupt code.
+
 # options for gpio configuration support
 
 config S3C_GPIO_CFG_S3C24XX
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 2c01437..aa048c7 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -17,6 +17,8 @@ obj-y				+= gpio-config.o
 
 obj-$(CONFIG_SAMSUNG_CLKSRC)	+= clock-clksrc.o
 
+obj-$(CONFIG_SAMSUNG_IRQ_VIC_TIMER) += irq-vic-timer.o
+
 # devices
 
 obj-$(CONFIG_S3C_DEV_HSMMC)	+= dev-hsmmc.o
diff --git a/arch/arm/plat-samsung/include/plat/irq-vic-timer.h b/arch/arm/plat-samsung/include/plat/irq-vic-timer.h
new file mode 100644
index 0000000..a90b534
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/irq-vic-timer.h
@@ -0,0 +1,13 @@
+/* arch/arm/plat-samsung/include/plat/irq-vic-timer.h
+ *
+ * Copyright (c) 2010 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * Header file for Samsung SoC IRQ VIC timer
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+extern void s3c_init_vic_timer_irq(unsigned int vic, unsigned int timer);
diff --git a/arch/arm/plat-samsung/irq-vic-timer.c b/arch/arm/plat-samsung/irq-vic-timer.c
new file mode 100644
index 0000000..0270519
--- /dev/null
+++ b/arch/arm/plat-samsung/irq-vic-timer.c
@@ -0,0 +1,86 @@
+/* arch/arm/plat-samsung/irq-vic-timer.c
+ *	originally part of arch/arm/plat-s3c64xx/irq.c
+ *
+ * Copyright 2008 Openmoko, Inc.
+ * Copyright 2008 Simtec Electronics
+ *      Ben Dooks <ben@simtec.co.uk>
+ *      http://armlinux.simtec.co.uk/
+ *
+ * S3C64XX - Interrupt handling
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+#include <mach/map.h>
+#include <plat/irq-vic-timer.h>
+#include <plat/regs-timer.h>
+
+static void s3c_irq_demux_vic_timer(unsigned int irq, struct irq_desc *desc)
+{
+	generic_handle_irq((int)desc->handler_data);
+}
+
+/* We assume the IRQ_TIMER0..IRQ_TIMER4 range is continuous. */
+
+static void s3c_irq_timer_mask(unsigned int irq)
+{
+	u32 reg = __raw_readl(S3C64XX_TINT_CSTAT);
+
+	reg &= 0x1f;  /* mask out pending interrupts */
+	reg &= ~(1 << (irq - IRQ_TIMER0));
+	__raw_writel(reg, S3C64XX_TINT_CSTAT);
+}
+
+static void s3c_irq_timer_unmask(unsigned int irq)
+{
+	u32 reg = __raw_readl(S3C64XX_TINT_CSTAT);
+
+	reg &= 0x1f;  /* mask out pending interrupts */
+	reg |= 1 << (irq - IRQ_TIMER0);
+	__raw_writel(reg, S3C64XX_TINT_CSTAT);
+}
+
+static void s3c_irq_timer_ack(unsigned int irq)
+{
+	u32 reg = __raw_readl(S3C64XX_TINT_CSTAT);
+
+	reg &= 0x1f;
+	reg |= (1 << 5) << (irq - IRQ_TIMER0);
+	__raw_writel(reg, S3C64XX_TINT_CSTAT);
+}
+
+static struct irq_chip s3c_irq_timer = {
+	.name		= "s3c-timer",
+	.mask		= s3c_irq_timer_mask,
+	.unmask		= s3c_irq_timer_unmask,
+	.ack		= s3c_irq_timer_ack,
+};
+
+/**
+ * s3c_init_vic_timer_irq() - initialise timer irq chanined off VIC.\
+ * @parent_irq: The parent IRQ on the VIC for the timer.
+ * @timer_irq: The IRQ to be used for the timer.
+ *
+ * Register the necessary IRQ chaining and support for the timer IRQs
+ * chained of the VIC.
+ */
+void __init s3c_init_vic_timer_irq(unsigned int parent_irq,
+				   unsigned int timer_irq)
+{
+	struct irq_desc *desc = irq_to_desc(parent_irq);
+
+	set_irq_chained_handler(parent_irq, s3c_irq_demux_vic_timer);
+
+	set_irq_chip(timer_irq, &s3c_irq_timer);
+	set_irq_handler(timer_irq, handle_level_irq);
+	set_irq_flags(timer_irq, IRQF_VALID);
+
+	desc->handler_data = (void *)timer_irq;
+}
-- 
1.6.0.4
