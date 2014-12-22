From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 22 Dec 2014 13:05:36 +0300
Subject: [PATCH 1/5] ARM: sa1100: split irq handling for low GPIOs
Message-ID: <1419242740-20219-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Low GPIO pins use an interrupt in SC interrupts space. However it's
possible to handle them as if all the GPIO interrupts are instead tied
to single GPIO handler, which later decodes GEDR register and
chain-calls next IRQ handler. So split first 11 interrupts into system
part (IRQ_GPIO0_SC - IRQ_GPIO10_SC) which work exactly like the rest of
system controller interrupts and real GPIO interrupts
(IRQ_GPIO0..IRQ_GPIO10). A single handler sa1100_gpio_handler then
decodes and calls next handler.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/include/mach/irqs.h | 73 +++++++++++++++------------
 arch/arm/mach-sa1100/irq.c               | 87 ++++++++++++++++++--------------
 drivers/gpio/gpio-sa1100.c               |  2 +-
 3 files changed, 93 insertions(+), 69 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/irqs.h b/arch/arm/mach-sa1100/include/mach/irqs.h
index de09834..734e30e 100644
--- a/arch/arm/mach-sa1100/include/mach/irqs.h
+++ b/arch/arm/mach-sa1100/include/mach/irqs.h
@@ -8,17 +8,17 @@
  * 2001/11/14	RMK	Cleaned up and standardised a lot of the IRQs.
  */
 
-#define	IRQ_GPIO0		1
-#define	IRQ_GPIO1		2
-#define	IRQ_GPIO2		3
-#define	IRQ_GPIO3		4
-#define	IRQ_GPIO4		5
-#define	IRQ_GPIO5		6
-#define	IRQ_GPIO6		7
-#define	IRQ_GPIO7		8
-#define	IRQ_GPIO8		9
-#define	IRQ_GPIO9		10
-#define	IRQ_GPIO10		11
+#define	IRQ_GPIO0_SC		1
+#define	IRQ_GPIO1_SC		2
+#define	IRQ_GPIO2_SC		3
+#define	IRQ_GPIO3_SC		4
+#define	IRQ_GPIO4_SC		5
+#define	IRQ_GPIO5_SC		6
+#define	IRQ_GPIO6_SC		7
+#define	IRQ_GPIO7_SC		8
+#define	IRQ_GPIO8_SC		9
+#define	IRQ_GPIO9_SC		10
+#define	IRQ_GPIO10_SC		11
 #define	IRQ_GPIO11_27		12
 #define	IRQ_LCD			13	/* LCD controller           */
 #define	IRQ_Ser0UDC		14	/* Ser. port 0 UDC          */
@@ -41,32 +41,43 @@
 #define	IRQ_RTC1Hz		31	/* RTC 1 Hz clock           */
 #define	IRQ_RTCAlrm		32	/* RTC Alarm                */
 
-#define	IRQ_GPIO11		33
-#define	IRQ_GPIO12		34
-#define	IRQ_GPIO13		35
-#define	IRQ_GPIO14		36
-#define	IRQ_GPIO15		37
-#define	IRQ_GPIO16		38
-#define	IRQ_GPIO17		39
-#define	IRQ_GPIO18		40
-#define	IRQ_GPIO19		41
-#define	IRQ_GPIO20		42
-#define	IRQ_GPIO21		43
-#define	IRQ_GPIO22		44
-#define	IRQ_GPIO23		45
-#define	IRQ_GPIO24		46
-#define	IRQ_GPIO25		47
-#define	IRQ_GPIO26		48
-#define	IRQ_GPIO27		49
+#define	IRQ_GPIO0		33
+#define	IRQ_GPIO1		34
+#define	IRQ_GPIO2		35
+#define	IRQ_GPIO3		36
+#define	IRQ_GPIO4		37
+#define	IRQ_GPIO5		38
+#define	IRQ_GPIO6		39
+#define	IRQ_GPIO7		40
+#define	IRQ_GPIO8		41
+#define	IRQ_GPIO9		42
+#define	IRQ_GPIO10		43
+#define	IRQ_GPIO11		44
+#define	IRQ_GPIO12		45
+#define	IRQ_GPIO13		46
+#define	IRQ_GPIO14		47
+#define	IRQ_GPIO15		48
+#define	IRQ_GPIO16		49
+#define	IRQ_GPIO17		50
+#define	IRQ_GPIO18		51
+#define	IRQ_GPIO19		52
+#define	IRQ_GPIO20		53
+#define	IRQ_GPIO21		54
+#define	IRQ_GPIO22		55
+#define	IRQ_GPIO23		56
+#define	IRQ_GPIO24		57
+#define	IRQ_GPIO25		58
+#define	IRQ_GPIO26		59
+#define	IRQ_GPIO27		60
 
 /*
  * The next 16 interrupts are for board specific purposes.  Since
  * the kernel can only run on one machine at a time, we can re-use
  * these.  If you need more, increase IRQ_BOARD_END, but keep it
- * within sensible limits.  IRQs 49 to 64 are available.
+ * within sensible limits.  IRQs 61 to 76 are available.
  */
-#define IRQ_BOARD_START		50
-#define IRQ_BOARD_END		66
+#define IRQ_BOARD_START		61
+#define IRQ_BOARD_END		77
 
 /*
  * Figure out the MAX IRQ number.
diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 63e2901..2dc6a2a 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -87,7 +87,7 @@ static struct irq_domain *sa1100_normal_irqdomain;
  */
 static int GPIO_IRQ_rising_edge;
 static int GPIO_IRQ_falling_edge;
-static int GPIO_IRQ_mask = (1 << 11) - 1;
+static int GPIO_IRQ_mask;
 
 static int sa1100_gpio_type(struct irq_data *d, unsigned int type)
 {
@@ -124,6 +124,26 @@ static void sa1100_gpio_ack(struct irq_data *d)
 	GEDR = BIT(d->hwirq);
 }
 
+static void sa1100_gpio_mask(struct irq_data *d)
+{
+	unsigned int mask = BIT(d->hwirq);
+
+	GPIO_IRQ_mask &= ~mask;
+
+	GRER &= ~mask;
+	GFER &= ~mask;
+}
+
+static void sa1100_gpio_unmask(struct irq_data *d)
+{
+	unsigned int mask = BIT(d->hwirq);
+
+	GPIO_IRQ_mask |= mask;
+
+	GRER = GPIO_IRQ_rising_edge & GPIO_IRQ_mask;
+	GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
+}
+
 static int sa1100_gpio_wake(struct irq_data *d, unsigned int on)
 {
 	if (on)
@@ -139,8 +159,8 @@ static int sa1100_gpio_wake(struct irq_data *d, unsigned int on)
 static struct irq_chip sa1100_low_gpio_chip = {
 	.name		= "GPIO-l",
 	.irq_ack	= sa1100_gpio_ack,
-	.irq_mask	= sa1100_mask_irq,
-	.irq_unmask	= sa1100_unmask_irq,
+	.irq_mask	= sa1100_gpio_mask,
+	.irq_unmask	= sa1100_gpio_unmask,
 	.irq_set_type	= sa1100_gpio_type,
 	.irq_set_wake	= sa1100_gpio_wake,
 };
@@ -163,16 +183,16 @@ static struct irq_domain_ops sa1100_low_gpio_irqdomain_ops = {
 static struct irq_domain *sa1100_low_gpio_irqdomain;
 
 /*
- * IRQ11 (GPIO11 through 27) handler.  We enter here with the
+ * IRQ 0-11 (GPIO) handler.  We enter here with the
  * irq_controller_lock held, and IRQs disabled.  Decode the IRQ
  * and call the handler.
  */
 static void
-sa1100_high_gpio_handler(unsigned int irq, struct irq_desc *desc)
+sa1100_gpio_handler(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned int mask;
 
-	mask = GEDR & 0xfffff800;
+	mask = GEDR;
 	do {
 		/*
 		 * clear down all currently active IRQ sources.
@@ -180,8 +200,7 @@ sa1100_high_gpio_handler(unsigned int irq, struct irq_desc *desc)
 		 */
 		GEDR = mask;
 
-		irq = IRQ_GPIO11;
-		mask >>= 11;
+		irq = IRQ_GPIO0;
 		do {
 			if (mask & 1)
 				generic_handle_irq(irq);
@@ -189,7 +208,7 @@ sa1100_high_gpio_handler(unsigned int irq, struct irq_desc *desc)
 			irq++;
 		} while (mask);
 
-		mask = GEDR & 0xfffff800;
+		mask = GEDR;
 	} while (mask);
 }
 
@@ -198,31 +217,11 @@ sa1100_high_gpio_handler(unsigned int irq, struct irq_desc *desc)
  * In addition, the IRQs are all collected up into one bit in the
  * interrupt controller registers.
  */
-static void sa1100_high_gpio_mask(struct irq_data *d)
-{
-	unsigned int mask = BIT(d->hwirq);
-
-	GPIO_IRQ_mask &= ~mask;
-
-	GRER &= ~mask;
-	GFER &= ~mask;
-}
-
-static void sa1100_high_gpio_unmask(struct irq_data *d)
-{
-	unsigned int mask = BIT(d->hwirq);
-
-	GPIO_IRQ_mask |= mask;
-
-	GRER = GPIO_IRQ_rising_edge & GPIO_IRQ_mask;
-	GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
-}
-
 static struct irq_chip sa1100_high_gpio_chip = {
 	.name		= "GPIO-h",
 	.irq_ack	= sa1100_gpio_ack,
-	.irq_mask	= sa1100_high_gpio_mask,
-	.irq_unmask	= sa1100_high_gpio_unmask,
+	.irq_mask	= sa1100_gpio_mask,
+	.irq_unmask	= sa1100_gpio_unmask,
 	.irq_set_type	= sa1100_gpio_type,
 	.irq_set_wake	= sa1100_gpio_wake,
 };
@@ -325,7 +324,7 @@ sa1100_handle_irq(struct pt_regs *regs)
 		if (mask == 0)
 			break;
 
-		handle_IRQ(ffs(mask) - 1 + IRQ_GPIO0, regs);
+		handle_IRQ(ffs(mask) - 1 + IRQ_GPIO0_SC, regs);
 	} while (1);
 }
 
@@ -350,22 +349,36 @@ void __init sa1100_init_irq(void)
 	 */
 	ICCR = 1;
 
+	sa1100_normal_irqdomain = irq_domain_add_legacy(NULL,
+			32, IRQ_GPIO0_SC, 0,
+			&sa1100_normal_irqdomain_ops, NULL);
+
 	sa1100_low_gpio_irqdomain = irq_domain_add_legacy(NULL,
 			11, IRQ_GPIO0, 0,
 			&sa1100_low_gpio_irqdomain_ops, NULL);
 
-	sa1100_normal_irqdomain = irq_domain_add_legacy(NULL,
-			21, IRQ_GPIO11_27, 11,
-			&sa1100_normal_irqdomain_ops, NULL);
-
 	sa1100_high_gpio_irqdomain = irq_domain_add_legacy(NULL,
 			17, IRQ_GPIO11, 11,
 			&sa1100_high_gpio_irqdomain_ops, NULL);
 
 	/*
+	 * Install handlers for GPIO 0-10 edge detect interrupts
+	 */
+	irq_set_chained_handler(IRQ_GPIO0_SC, sa1100_gpio_handler);
+	irq_set_chained_handler(IRQ_GPIO1_SC, sa1100_gpio_handler);
+	irq_set_chained_handler(IRQ_GPIO2_SC, sa1100_gpio_handler);
+	irq_set_chained_handler(IRQ_GPIO3_SC, sa1100_gpio_handler);
+	irq_set_chained_handler(IRQ_GPIO4_SC, sa1100_gpio_handler);
+	irq_set_chained_handler(IRQ_GPIO5_SC, sa1100_gpio_handler);
+	irq_set_chained_handler(IRQ_GPIO6_SC, sa1100_gpio_handler);
+	irq_set_chained_handler(IRQ_GPIO7_SC, sa1100_gpio_handler);
+	irq_set_chained_handler(IRQ_GPIO8_SC, sa1100_gpio_handler);
+	irq_set_chained_handler(IRQ_GPIO9_SC, sa1100_gpio_handler);
+	irq_set_chained_handler(IRQ_GPIO10_SC, sa1100_gpio_handler);
+	/*
 	 * Install handler for GPIO 11-27 edge detect interrupts
 	 */
-	irq_set_chained_handler(IRQ_GPIO11_27, sa1100_high_gpio_handler);
+	irq_set_chained_handler(IRQ_GPIO11_27, sa1100_gpio_handler);
 
 	set_handle_irq(sa1100_handle_irq);
 
diff --git a/drivers/gpio/gpio-sa1100.c b/drivers/gpio/gpio-sa1100.c
index a90be34..5b5d3c7 100644
--- a/drivers/gpio/gpio-sa1100.c
+++ b/drivers/gpio/gpio-sa1100.c
@@ -50,7 +50,7 @@ static int sa1100_direction_output(struct gpio_chip *chip, unsigned offset, int
 
 static int sa1100_to_irq(struct gpio_chip *chip, unsigned offset)
 {
-	return offset < 11 ? (IRQ_GPIO0 + offset) : (IRQ_GPIO11 - 11 + offset);
+	return IRQ_GPIO0 + offset;
 }
 
 static struct gpio_chip sa1100_gpio_chip = {
-- 
2.1.3
