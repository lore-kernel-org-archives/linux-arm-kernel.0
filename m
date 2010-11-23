From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 23 Nov 2010 10:06:11 +0000
Subject: [RFC PATCH 10/13] picoxcell: add chained GPIO IRQ handlers
In-Reply-To: <1290506774-17895-1-git-send-email-jamie@jamieiles.com>
References: <1290506774-17895-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1290506774-17895-11-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 8 bits of port A on the ARM GPIO of all devices are capable of
generating interrupts. Provide chained handlers so that these pins can
be used as interrupts and the sensitivity and polarity can be set.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/include/mach/gpio.h |    2 +
 arch/arm/mach-picoxcell/picoxcell_core.c    |   41 +++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-picoxcell/include/mach/gpio.h b/arch/arm/mach-picoxcell/include/mach/gpio.h
index ce55c3d..8955e20 100644
--- a/arch/arm/mach-picoxcell/include/mach/gpio.h
+++ b/arch/arm/mach-picoxcell/include/mach/gpio.h
@@ -152,6 +152,8 @@ enum {
 
 #ifdef __KERNEL__
 
+extern struct irq_chip armgpio_irqchip;
+
 static inline int gpio_get_value(unsigned gpio)
 {
 	return __gpio_get_value(gpio);
diff --git a/arch/arm/mach-picoxcell/picoxcell_core.c b/arch/arm/mach-picoxcell/picoxcell_core.c
index 8c1195b..8386c83 100644
--- a/arch/arm/mach-picoxcell/picoxcell_core.c
+++ b/arch/arm/mach-picoxcell/picoxcell_core.c
@@ -25,6 +25,19 @@
 #include "picoxcell_core.h"
 #include "soc.h"
 
+static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned real_irq = (irq - IRQ_GPIO0 + __IRQ_GPIO0);
+	struct irq_desc *real_desc = irq_desc + real_irq;
+	/*
+	 * We have 8 GPIO pins that can generate interrupts and each one has
+	 * it's own interrupt bit in the VIC. All we need to do is do a
+	 * one-to-one translation from the virtual IRQ number to the real one
+	 * and call the handler.
+	 */
+	desc_handle_irq(real_irq, real_desc);
+}
+
 struct picoxcell_soc *picoxcell_get_soc(void)
 {
 	unsigned long device_id = readl(IO_ADDRESS(PICOXCELL_AXI2CFG_BASE +
@@ -37,6 +50,11 @@ struct picoxcell_soc *picoxcell_get_soc(void)
 
 void __init picoxcell_init_irq(void)
 {
+#define GPIO_INT_EN_REG	    IO_ADDRESS(PICOXCELL_GPIO_BASE + \
+				       GPIO_INT_EN_REG_OFFSET)
+#define GPIO_EOI_REG	    IO_ADDRESS(PICOXCELL_GPIO_BASE + \
+				       GPIO_PORT_A_EOI_REG_OFFSET)
+	unsigned i;
 	u32 vic0_resume_sources =
 		(1 << (IRQ_AXI2PICO8 & 31)) |
 		(1 << (IRQ_EMAC & 31)) |
@@ -45,6 +63,29 @@ void __init picoxcell_init_irq(void)
 	vic_init(IO_ADDRESS(PICOXCELL_VIC0_BASE), 32, 0xFFFFFFFE,
 		 vic0_resume_sources);
 	vic_init(IO_ADDRESS(PICOXCELL_VIC1_BASE), 0, 0x7FF, 0);
+
+	/*
+	 * We want to enable/disable interrupts for the GPIO pins through the
+	 * GPIO block itself. To do this we install a chained handler. If a
+	 * user requests one of the __IRQ_GPIOn interrupts then the GPIO block
+	 * won't get configured.  We provide these interrupts below as virtual
+	 * ones that will configure the GPIO block and enable the source in
+	 * the VIC.
+	 *
+	 * The chained handler simply converts from the virtual IRQ handler to
+	 * the real interrupt source and calls the GPIO IRQ handler.
+	 */
+	writel(0, GPIO_INT_EN_REG);
+	writel(~0, GPIO_EOI_REG);
+	for (i = IRQ_GPIO0; i <= IRQ_GPIO7; ++i) {
+		set_irq_chip(i, &armgpio_irqchip);
+		set_irq_handler(i, handle_level_irq);
+		irq_desc[i].status |= IRQ_LEVEL;
+		set_irq_flags(i, IRQF_VALID);
+	}
+
+	for (i = __IRQ_GPIO0; i <= __IRQ_GPIO7; ++i)
+		set_irq_chained_handler(i, gpio_irq_handler);
 }
 
 static const char *picoxcell_get_partname(void)
-- 
1.7.2.3
