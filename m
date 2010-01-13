From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 12 Jan 2010 17:04:35 -0700
Subject: [PATCH] ep93xx: move gpio interrupt support to gpio.c
Message-ID: <201001121704.35262.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ep93xx: move gpio interrupt support to gpio.c

The GPIO support in core.c handles the interrupt support for GPIO
ports A, B, and F. The gpiolib implementation in gpio.c needs to
access the function ep93xx_gpio_int_mask when a gpio pin is made
an output and ep93xx_gpio_update_int_params in order to update
the registers.

Moving this support from core.c to gpio.c allows making the two
functions static. It also keeps all the GPIO handling together in one
file.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 41064bd..0a75718 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -137,236 +137,16 @@ struct sys_timer ep93xx_timer = {
 
 
 /*************************************************************************
- * GPIO handling for EP93xx
- *************************************************************************/
-static unsigned char gpio_int_unmasked[3];
-static unsigned char gpio_int_enabled[3];
-static unsigned char gpio_int_type1[3];
-static unsigned char gpio_int_type2[3];
-static unsigned char gpio_int_debounce[3];
-
-/* Port ordering is: A B F */
-static const u8 int_type1_register_offset[3]	= { 0x90, 0xac, 0x4c };
-static const u8 int_type2_register_offset[3]	= { 0x94, 0xb0, 0x50 };
-static const u8 eoi_register_offset[3]		= { 0x98, 0xb4, 0x54 };
-static const u8 int_en_register_offset[3]	= { 0x9c, 0xb8, 0x58 };
-static const u8 int_debounce_register_offset[3]	= { 0xa8, 0xc4, 0x64 };
-
-void ep93xx_gpio_update_int_params(unsigned port)
-{
-	BUG_ON(port > 2);
-
-	__raw_writeb(0, EP93XX_GPIO_REG(int_en_register_offset[port]));
-
-	__raw_writeb(gpio_int_type2[port],
-		EP93XX_GPIO_REG(int_type2_register_offset[port]));
-
-	__raw_writeb(gpio_int_type1[port],
-		EP93XX_GPIO_REG(int_type1_register_offset[port]));
-
-	__raw_writeb(gpio_int_unmasked[port] & gpio_int_enabled[port],
-		EP93XX_GPIO_REG(int_en_register_offset[port]));
-}
-
-void ep93xx_gpio_int_mask(unsigned line)
-{
-	gpio_int_unmasked[line >> 3] &= ~(1 << (line & 7));
-}
-
-void ep93xx_gpio_int_debounce(unsigned int irq, int enable)
-{
-	int line = irq_to_gpio(irq);
-	int port = line >> 3;
-	int port_mask = 1 << (line & 7);
-
-	if (enable)
-		gpio_int_debounce[port] |= port_mask;
-	else
-		gpio_int_debounce[port] &= ~port_mask;
-
-	__raw_writeb(gpio_int_debounce[port],
-		EP93XX_GPIO_REG(int_debounce_register_offset[port]));
-}
-EXPORT_SYMBOL(ep93xx_gpio_int_debounce);
-
-/*************************************************************************
  * EP93xx IRQ handling
  *************************************************************************/
-static void ep93xx_gpio_ab_irq_handler(unsigned int irq, struct irq_desc *desc)
-{
-	unsigned char status;
-	int i;
-
-	status = __raw_readb(EP93XX_GPIO_A_INT_STATUS);
-	for (i = 0; i < 8; i++) {
-		if (status & (1 << i)) {
-			int gpio_irq = gpio_to_irq(EP93XX_GPIO_LINE_A(0)) + i;
-			generic_handle_irq(gpio_irq);
-		}
-	}
-
-	status = __raw_readb(EP93XX_GPIO_B_INT_STATUS);
-	for (i = 0; i < 8; i++) {
-		if (status & (1 << i)) {
-			int gpio_irq = gpio_to_irq(EP93XX_GPIO_LINE_B(0)) + i;
-			generic_handle_irq(gpio_irq);
-		}
-	}
-}
-
-static void ep93xx_gpio_f_irq_handler(unsigned int irq, struct irq_desc *desc)
-{
-	/*
-	 * map discontiguous hw irq range to continous sw irq range:
-	 *
-	 *  IRQ_EP93XX_GPIO{0..7}MUX -> gpio_to_irq(EP93XX_GPIO_LINE_F({0..7})
-	 */
-	int port_f_idx = ((irq + 1) & 7) ^ 4; /* {19..22,47..50} -> {0..7} */
-	int gpio_irq = gpio_to_irq(EP93XX_GPIO_LINE_F(0)) + port_f_idx;
-
-	generic_handle_irq(gpio_irq);
-}
-
-static void ep93xx_gpio_irq_ack(unsigned int irq)
-{
-	int line = irq_to_gpio(irq);
-	int port = line >> 3;
-	int port_mask = 1 << (line & 7);
-
-	if ((irq_desc[irq].status & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
-		gpio_int_type2[port] ^= port_mask; /* switch edge direction */
-		ep93xx_gpio_update_int_params(port);
-	}
-
-	__raw_writeb(port_mask, EP93XX_GPIO_REG(eoi_register_offset[port]));
-}
-
-static void ep93xx_gpio_irq_mask_ack(unsigned int irq)
-{
-	int line = irq_to_gpio(irq);
-	int port = line >> 3;
-	int port_mask = 1 << (line & 7);
-
-	if ((irq_desc[irq].status & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
-		gpio_int_type2[port] ^= port_mask; /* switch edge direction */
-
-	gpio_int_unmasked[port] &= ~port_mask;
-	ep93xx_gpio_update_int_params(port);
-
-	__raw_writeb(port_mask, EP93XX_GPIO_REG(eoi_register_offset[port]));
-}
-
-static void ep93xx_gpio_irq_mask(unsigned int irq)
-{
-	int line = irq_to_gpio(irq);
-	int port = line >> 3;
-
-	gpio_int_unmasked[port] &= ~(1 << (line & 7));
-	ep93xx_gpio_update_int_params(port);
-}
-
-static void ep93xx_gpio_irq_unmask(unsigned int irq)
-{
-	int line = irq_to_gpio(irq);
-	int port = line >> 3;
-
-	gpio_int_unmasked[port] |= 1 << (line & 7);
-	ep93xx_gpio_update_int_params(port);
-}
-
-
-/*
- * gpio_int_type1 controls whether the interrupt is level (0) or
- * edge (1) triggered, while gpio_int_type2 controls whether it
- * triggers on low/falling (0) or high/rising (1).
- */
-static int ep93xx_gpio_irq_type(unsigned int irq, unsigned int type)
-{
-	struct irq_desc *desc = irq_desc + irq;
-	const int gpio = irq_to_gpio(irq);
-	const int port = gpio >> 3;
-	const int port_mask = 1 << (gpio & 7);
-
-	gpio_direction_input(gpio);
-
-	switch (type) {
-	case IRQ_TYPE_EDGE_RISING:
-		gpio_int_type1[port] |= port_mask;
-		gpio_int_type2[port] |= port_mask;
-		desc->handle_irq = handle_edge_irq;
-		break;
-	case IRQ_TYPE_EDGE_FALLING:
-		gpio_int_type1[port] |= port_mask;
-		gpio_int_type2[port] &= ~port_mask;
-		desc->handle_irq = handle_edge_irq;
-		break;
-	case IRQ_TYPE_LEVEL_HIGH:
-		gpio_int_type1[port] &= ~port_mask;
-		gpio_int_type2[port] |= port_mask;
-		desc->handle_irq = handle_level_irq;
-		break;
-	case IRQ_TYPE_LEVEL_LOW:
-		gpio_int_type1[port] &= ~port_mask;
-		gpio_int_type2[port] &= ~port_mask;
-		desc->handle_irq = handle_level_irq;
-		break;
-	case IRQ_TYPE_EDGE_BOTH:
-		gpio_int_type1[port] |= port_mask;
-		/* set initial polarity based on current input level */
-		if (gpio_get_value(gpio))
-			gpio_int_type2[port] &= ~port_mask; /* falling */
-		else
-			gpio_int_type2[port] |= port_mask; /* rising */
-		desc->handle_irq = handle_edge_irq;
-		break;
-	default:
-		pr_err("failed to set irq type %d for gpio %d\n", type, gpio);
-		return -EINVAL;
-	}
-
-	gpio_int_enabled[port] |= port_mask;
-
-	desc->status &= ~IRQ_TYPE_SENSE_MASK;
-	desc->status |= type & IRQ_TYPE_SENSE_MASK;
-
-	ep93xx_gpio_update_int_params(port);
-
-	return 0;
-}
-
-static struct irq_chip ep93xx_gpio_irq_chip = {
-	.name		= "GPIO",
-	.ack		= ep93xx_gpio_irq_ack,
-	.mask_ack	= ep93xx_gpio_irq_mask_ack,
-	.mask		= ep93xx_gpio_irq_mask,
-	.unmask		= ep93xx_gpio_irq_unmask,
-	.set_type	= ep93xx_gpio_irq_type,
-};
-
+extern void ep93xx_gpio_init_irq(void);
 
 void __init ep93xx_init_irq(void)
 {
-	int gpio_irq;
-
 	vic_init(EP93XX_VIC1_BASE, 0, EP93XX_VIC1_VALID_IRQ_MASK, 0);
 	vic_init(EP93XX_VIC2_BASE, 32, EP93XX_VIC2_VALID_IRQ_MASK, 0);
 
-	for (gpio_irq = gpio_to_irq(0);
-	     gpio_irq <= gpio_to_irq(EP93XX_GPIO_LINE_MAX_IRQ); ++gpio_irq) {
-		set_irq_chip(gpio_irq, &ep93xx_gpio_irq_chip);
-		set_irq_handler(gpio_irq, handle_level_irq);
-		set_irq_flags(gpio_irq, IRQF_VALID);
-	}
-
-	set_irq_chained_handler(IRQ_EP93XX_GPIO_AB, ep93xx_gpio_ab_irq_handler);
-	set_irq_chained_handler(IRQ_EP93XX_GPIO0MUX, ep93xx_gpio_f_irq_handler);
-	set_irq_chained_handler(IRQ_EP93XX_GPIO1MUX, ep93xx_gpio_f_irq_handler);
-	set_irq_chained_handler(IRQ_EP93XX_GPIO2MUX, ep93xx_gpio_f_irq_handler);
-	set_irq_chained_handler(IRQ_EP93XX_GPIO3MUX, ep93xx_gpio_f_irq_handler);
-	set_irq_chained_handler(IRQ_EP93XX_GPIO4MUX, ep93xx_gpio_f_irq_handler);
-	set_irq_chained_handler(IRQ_EP93XX_GPIO5MUX, ep93xx_gpio_f_irq_handler);
-	set_irq_chained_handler(IRQ_EP93XX_GPIO6MUX, ep93xx_gpio_f_irq_handler);
-	set_irq_chained_handler(IRQ_EP93XX_GPIO7MUX, ep93xx_gpio_f_irq_handler);
+	ep93xx_gpio_init_irq();
 }
 
 
diff --git a/arch/arm/mach-ep93xx/gpio.c b/arch/arm/mach-ep93xx/gpio.c
index 1ea8871..70bc978 100644
--- a/arch/arm/mach-ep93xx/gpio.c
+++ b/arch/arm/mach-ep93xx/gpio.c
@@ -13,6 +13,8 @@
  *  published by the Free Software Foundation.
  */
 
+#define pr_fmt(fmt) "ep93xx " KBUILD_MODNAME ": " fmt
+
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
@@ -22,6 +24,235 @@
 
 #include <mach/hardware.h>
 
+/*************************************************************************
+ * GPIO interrupt handling for EP93xx
+ *************************************************************************/
+static unsigned char gpio_int_unmasked[3];
+static unsigned char gpio_int_enabled[3];
+static unsigned char gpio_int_type1[3];
+static unsigned char gpio_int_type2[3];
+static unsigned char gpio_int_debounce[3];
+
+/* Port ordering is: A B F */
+static const u8 int_type1_register_offset[3]	= { 0x90, 0xac, 0x4c };
+static const u8 int_type2_register_offset[3]	= { 0x94, 0xb0, 0x50 };
+static const u8 eoi_register_offset[3]		= { 0x98, 0xb4, 0x54 };
+static const u8 int_en_register_offset[3]	= { 0x9c, 0xb8, 0x58 };
+static const u8 int_debounce_register_offset[3]	= { 0xa8, 0xc4, 0x64 };
+
+static void ep93xx_gpio_update_int_params(unsigned port)
+{
+	BUG_ON(port > 2);
+
+	__raw_writeb(0, EP93XX_GPIO_REG(int_en_register_offset[port]));
+
+	__raw_writeb(gpio_int_type2[port],
+		EP93XX_GPIO_REG(int_type2_register_offset[port]));
+
+	__raw_writeb(gpio_int_type1[port],
+		EP93XX_GPIO_REG(int_type1_register_offset[port]));
+
+	__raw_writeb(gpio_int_unmasked[port] & gpio_int_enabled[port],
+		EP93XX_GPIO_REG(int_en_register_offset[port]));
+}
+
+static inline void ep93xx_gpio_int_mask(unsigned line)
+{
+	gpio_int_unmasked[line >> 3] &= ~(1 << (line & 7));
+}
+
+void ep93xx_gpio_int_debounce(unsigned int irq, int enable)
+{
+	int line = irq_to_gpio(irq);
+	int port = line >> 3;
+	int port_mask = 1 << (line & 7);
+
+	if (enable)
+		gpio_int_debounce[port] |= port_mask;
+	else
+		gpio_int_debounce[port] &= ~port_mask;
+
+	__raw_writeb(gpio_int_debounce[port],
+		EP93XX_GPIO_REG(int_debounce_register_offset[port]));
+}
+EXPORT_SYMBOL(ep93xx_gpio_int_debounce);
+
+static void ep93xx_gpio_ab_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned char status;
+	int i;
+
+	status = __raw_readb(EP93XX_GPIO_A_INT_STATUS);
+	for (i = 0; i < 8; i++) {
+		if (status & (1 << i)) {
+			int gpio_irq = gpio_to_irq(EP93XX_GPIO_LINE_A(0)) + i;
+			generic_handle_irq(gpio_irq);
+		}
+	}
+
+	status = __raw_readb(EP93XX_GPIO_B_INT_STATUS);
+	for (i = 0; i < 8; i++) {
+		if (status & (1 << i)) {
+			int gpio_irq = gpio_to_irq(EP93XX_GPIO_LINE_B(0)) + i;
+			generic_handle_irq(gpio_irq);
+		}
+	}
+}
+
+static void ep93xx_gpio_f_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	/*
+	 * map discontiguous hw irq range to continous sw irq range:
+	 *
+	 *  IRQ_EP93XX_GPIO{0..7}MUX -> gpio_to_irq(EP93XX_GPIO_LINE_F({0..7})
+	 */
+	int port_f_idx = ((irq + 1) & 7) ^ 4; /* {19..22,47..50} -> {0..7} */
+	int gpio_irq = gpio_to_irq(EP93XX_GPIO_LINE_F(0)) + port_f_idx;
+
+	generic_handle_irq(gpio_irq);
+}
+
+static void ep93xx_gpio_irq_ack(unsigned int irq)
+{
+	int line = irq_to_gpio(irq);
+	int port = line >> 3;
+	int port_mask = 1 << (line & 7);
+
+	if ((irq_desc[irq].status & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
+		gpio_int_type2[port] ^= port_mask; /* switch edge direction */
+		ep93xx_gpio_update_int_params(port);
+	}
+
+	__raw_writeb(port_mask, EP93XX_GPIO_REG(eoi_register_offset[port]));
+}
+
+static void ep93xx_gpio_irq_mask_ack(unsigned int irq)
+{
+	int line = irq_to_gpio(irq);
+	int port = line >> 3;
+	int port_mask = 1 << (line & 7);
+
+	if ((irq_desc[irq].status & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
+		gpio_int_type2[port] ^= port_mask; /* switch edge direction */
+
+	gpio_int_unmasked[port] &= ~port_mask;
+	ep93xx_gpio_update_int_params(port);
+
+	__raw_writeb(port_mask, EP93XX_GPIO_REG(eoi_register_offset[port]));
+}
+
+static void ep93xx_gpio_irq_mask(unsigned int irq)
+{
+	int line = irq_to_gpio(irq);
+	int port = line >> 3;
+
+	gpio_int_unmasked[port] &= ~(1 << (line & 7));
+	ep93xx_gpio_update_int_params(port);
+}
+
+static void ep93xx_gpio_irq_unmask(unsigned int irq)
+{
+	int line = irq_to_gpio(irq);
+	int port = line >> 3;
+
+	gpio_int_unmasked[port] |= 1 << (line & 7);
+	ep93xx_gpio_update_int_params(port);
+}
+
+/*
+ * gpio_int_type1 controls whether the interrupt is level (0) or
+ * edge (1) triggered, while gpio_int_type2 controls whether it
+ * triggers on low/falling (0) or high/rising (1).
+ */
+static int ep93xx_gpio_irq_type(unsigned int irq, unsigned int type)
+{
+	struct irq_desc *desc = irq_desc + irq;
+	const int gpio = irq_to_gpio(irq);
+	const int port = gpio >> 3;
+	const int port_mask = 1 << (gpio & 7);
+
+	gpio_direction_input(gpio);
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		gpio_int_type1[port] |= port_mask;
+		gpio_int_type2[port] |= port_mask;
+		desc->handle_irq = handle_edge_irq;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		gpio_int_type1[port] |= port_mask;
+		gpio_int_type2[port] &= ~port_mask;
+		desc->handle_irq = handle_edge_irq;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		gpio_int_type1[port] &= ~port_mask;
+		gpio_int_type2[port] |= port_mask;
+		desc->handle_irq = handle_level_irq;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		gpio_int_type1[port] &= ~port_mask;
+		gpio_int_type2[port] &= ~port_mask;
+		desc->handle_irq = handle_level_irq;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		gpio_int_type1[port] |= port_mask;
+		/* set initial polarity based on current input level */
+		if (gpio_get_value(gpio))
+			gpio_int_type2[port] &= ~port_mask; /* falling */
+		else
+			gpio_int_type2[port] |= port_mask; /* rising */
+		desc->handle_irq = handle_edge_irq;
+		break;
+	default:
+		pr_err("failed to set irq type %d for gpio %d\n", type, gpio);
+		return -EINVAL;
+	}
+
+	gpio_int_enabled[port] |= port_mask;
+
+	desc->status &= ~IRQ_TYPE_SENSE_MASK;
+	desc->status |= type & IRQ_TYPE_SENSE_MASK;
+
+	ep93xx_gpio_update_int_params(port);
+
+	return 0;
+}
+
+static struct irq_chip ep93xx_gpio_irq_chip = {
+	.name		= "GPIO",
+	.ack		= ep93xx_gpio_irq_ack,
+	.mask_ack	= ep93xx_gpio_irq_mask_ack,
+	.mask		= ep93xx_gpio_irq_mask,
+	.unmask		= ep93xx_gpio_irq_unmask,
+	.set_type	= ep93xx_gpio_irq_type,
+};
+
+void __init ep93xx_gpio_init_irq(void)
+{
+	int gpio_irq;
+
+	for (gpio_irq = gpio_to_irq(0);
+	     gpio_irq <= gpio_to_irq(EP93XX_GPIO_LINE_MAX_IRQ); ++gpio_irq) {
+		set_irq_chip(gpio_irq, &ep93xx_gpio_irq_chip);
+		set_irq_handler(gpio_irq, handle_level_irq);
+		set_irq_flags(gpio_irq, IRQF_VALID);
+	}
+
+	set_irq_chained_handler(IRQ_EP93XX_GPIO_AB, ep93xx_gpio_ab_irq_handler);
+	set_irq_chained_handler(IRQ_EP93XX_GPIO0MUX, ep93xx_gpio_f_irq_handler);
+	set_irq_chained_handler(IRQ_EP93XX_GPIO1MUX, ep93xx_gpio_f_irq_handler);
+	set_irq_chained_handler(IRQ_EP93XX_GPIO2MUX, ep93xx_gpio_f_irq_handler);
+	set_irq_chained_handler(IRQ_EP93XX_GPIO3MUX, ep93xx_gpio_f_irq_handler);
+	set_irq_chained_handler(IRQ_EP93XX_GPIO4MUX, ep93xx_gpio_f_irq_handler);
+	set_irq_chained_handler(IRQ_EP93XX_GPIO5MUX, ep93xx_gpio_f_irq_handler);
+	set_irq_chained_handler(IRQ_EP93XX_GPIO6MUX, ep93xx_gpio_f_irq_handler);
+	set_irq_chained_handler(IRQ_EP93XX_GPIO7MUX, ep93xx_gpio_f_irq_handler);
+}
+
+
+/*************************************************************************
+ * gpiolib interface for EP93xx on-chip GPIOs
+ *************************************************************************/
 struct ep93xx_gpio_chip {
 	struct gpio_chip	chip;
 
@@ -31,10 +262,6 @@ struct ep93xx_gpio_chip {
 
 #define to_ep93xx_gpio_chip(c) container_of(c, struct ep93xx_gpio_chip, chip)
 
-/* From core.c */
-extern void ep93xx_gpio_int_mask(unsigned line);
-extern void ep93xx_gpio_update_int_params(unsigned port);
-
 static int ep93xx_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
 	struct ep93xx_gpio_chip *ep93xx_chip = to_ep93xx_gpio_chip(chip);
