From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 15 Nov 2013 12:47:58 +0400
Subject: [PATCH 7/9] ARM: sa1100: move gpio irq handling to GPIO driver
In-Reply-To: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
References: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1384505280-25389-8-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-sa1100's irq.c contains a mixture of system and GPIO irqs handling.
Split out GPIO irqchip to gpio-sa1100.c. To decouple first 11 GPIO IRQs
handling, make IRQ0-IRQ10 use chained irq handler that just passes the
IRQ to GPIO IRQs.

Also during this refactoring introduce irq domain support for sa1100
gpio irqs.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/generic.c           |  12 ++
 arch/arm/mach-sa1100/include/mach/irqs.h |  73 ++++++----
 arch/arm/mach-sa1100/irq.c               | 202 +-------------------------
 drivers/gpio/gpio-sa1100.c               | 238 +++++++++++++++++++++++++++++--
 4 files changed, 284 insertions(+), 241 deletions(-)

diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 702f18c..098593c 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -300,6 +300,18 @@ static struct platform_device sa11x0dma_device = {
 
 static struct resource sa11x0_gpio_resources[] = {
 	DEFINE_RES_MEM(GPIO_PHYS, GPIO_SIZE),
+	DEFINE_RES_IRQ(IRQ_GPIO0_),
+	DEFINE_RES_IRQ(IRQ_GPIO1_),
+	DEFINE_RES_IRQ(IRQ_GPIO2_),
+	DEFINE_RES_IRQ(IRQ_GPIO3_),
+	DEFINE_RES_IRQ(IRQ_GPIO4_),
+	DEFINE_RES_IRQ(IRQ_GPIO5_),
+	DEFINE_RES_IRQ(IRQ_GPIO6_),
+	DEFINE_RES_IRQ(IRQ_GPIO7_),
+	DEFINE_RES_IRQ(IRQ_GPIO8_),
+	DEFINE_RES_IRQ(IRQ_GPIO9_),
+	DEFINE_RES_IRQ(IRQ_GPIO10_),
+	DEFINE_RES_IRQ(IRQ_GPIO11_27),
 };
 
 static struct platform_device sa11x0gpio_device = {
diff --git a/arch/arm/mach-sa1100/include/mach/irqs.h b/arch/arm/mach-sa1100/include/mach/irqs.h
index 3790298..01aed94 100644
--- a/arch/arm/mach-sa1100/include/mach/irqs.h
+++ b/arch/arm/mach-sa1100/include/mach/irqs.h
@@ -8,17 +8,17 @@
  * 2001/11/14	RMK	Cleaned up and standardised a lot of the IRQs.
  */
 
-#define	IRQ_GPIO0		0
-#define	IRQ_GPIO1		1
-#define	IRQ_GPIO2		2
-#define	IRQ_GPIO3		3
-#define	IRQ_GPIO4		4
-#define	IRQ_GPIO5		5
-#define	IRQ_GPIO6		6
-#define	IRQ_GPIO7		7
-#define	IRQ_GPIO8		8
-#define	IRQ_GPIO9		9
-#define	IRQ_GPIO10		10
+#define	IRQ_GPIO0_		0
+#define	IRQ_GPIO1_		1
+#define	IRQ_GPIO2_		2
+#define	IRQ_GPIO3_		3
+#define	IRQ_GPIO4_		4
+#define	IRQ_GPIO5_		5
+#define	IRQ_GPIO6_		6
+#define	IRQ_GPIO7_		7
+#define	IRQ_GPIO8_		8
+#define	IRQ_GPIO9_		9
+#define	IRQ_GPIO10_		10
 #define	IRQ_GPIO11_27		11
 #define	IRQ_LCD  		12	/* LCD controller           */
 #define	IRQ_Ser0UDC		13	/* Ser. port 0 UDC          */
@@ -41,32 +41,43 @@
 #define	IRQ_RTC1Hz		30	/* RTC 1 Hz clock           */
 #define	IRQ_RTCAlrm		31	/* RTC Alarm                */
 
-#define	IRQ_GPIO11		32
-#define	IRQ_GPIO12		33
-#define	IRQ_GPIO13		34
-#define	IRQ_GPIO14		35
-#define	IRQ_GPIO15		36
-#define	IRQ_GPIO16		37
-#define	IRQ_GPIO17		38
-#define	IRQ_GPIO18		39
-#define	IRQ_GPIO19		40
-#define	IRQ_GPIO20		41
-#define	IRQ_GPIO21		42
-#define	IRQ_GPIO22		43
-#define	IRQ_GPIO23		44
-#define	IRQ_GPIO24		45
-#define	IRQ_GPIO25		46
-#define	IRQ_GPIO26		47
-#define	IRQ_GPIO27		48
+#define	IRQ_GPIO0		32
+#define	IRQ_GPIO1		33
+#define	IRQ_GPIO2		34
+#define	IRQ_GPIO3		35
+#define	IRQ_GPIO4		36
+#define	IRQ_GPIO5		37
+#define	IRQ_GPIO6		38
+#define	IRQ_GPIO7		39
+#define	IRQ_GPIO8		40
+#define	IRQ_GPIO9		41
+#define	IRQ_GPIO10		42
+#define	IRQ_GPIO11		43
+#define	IRQ_GPIO12		44
+#define	IRQ_GPIO13		45
+#define	IRQ_GPIO14		46
+#define	IRQ_GPIO15		47
+#define	IRQ_GPIO16		48
+#define	IRQ_GPIO17		49
+#define	IRQ_GPIO18		50
+#define	IRQ_GPIO19		51
+#define	IRQ_GPIO20		52
+#define	IRQ_GPIO21		53
+#define	IRQ_GPIO22		54
+#define	IRQ_GPIO23		55
+#define	IRQ_GPIO24		56
+#define	IRQ_GPIO25		57
+#define	IRQ_GPIO26		58
+#define	IRQ_GPIO27		59
 
 /*
  * The next 16 interrupts are for board specific purposes.  Since
  * the kernel can only run on one machine at a time, we can re-use
  * these.  If you need more, increase IRQ_BOARD_END, but keep it
- * within sensible limits.  IRQs 49 to 64 are available.
+ * within sensible limits.  IRQs 60 to 75 are available.
  */
-#define IRQ_BOARD_START		49
-#define IRQ_BOARD_END		65
+#define IRQ_BOARD_START		60
+#define IRQ_BOARD_END		76
 
 /*
  * Figure out the MAX IRQ number.
diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index f055a6b..59c1617 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -24,169 +24,6 @@
 
 #include "generic.h"
 
-
-/*
- * SA1100 GPIO edge detection for IRQs:
- * IRQs are generated on Falling-Edge, Rising-Edge, or both.
- * Use this instead of directly setting GRER/GFER.
- */
-static int GPIO_IRQ_rising_edge;
-static int GPIO_IRQ_falling_edge;
-static int GPIO_IRQ_mask = (1 << 11) - 1;
-
-/*
- * To get the GPIO number from an IRQ number
- */
-#define GPIO_11_27_IRQ(i)	((i) - 21)
-#define GPIO11_27_MASK(irq)	(1 << GPIO_11_27_IRQ(irq))
-
-static int sa1100_gpio_type(struct irq_data *d, unsigned int type)
-{
-	unsigned int mask;
-
-	if (d->irq <= 10)
-		mask = 1 << d->irq;
-	else
-		mask = GPIO11_27_MASK(d->irq);
-
-	if (type == IRQ_TYPE_PROBE) {
-		if ((GPIO_IRQ_rising_edge | GPIO_IRQ_falling_edge) & mask)
-			return 0;
-		type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
-	}
-
-	if (type & IRQ_TYPE_EDGE_RISING) {
-		GPIO_IRQ_rising_edge |= mask;
-	} else
-		GPIO_IRQ_rising_edge &= ~mask;
-	if (type & IRQ_TYPE_EDGE_FALLING) {
-		GPIO_IRQ_falling_edge |= mask;
-	} else
-		GPIO_IRQ_falling_edge &= ~mask;
-
-	GRER = GPIO_IRQ_rising_edge & GPIO_IRQ_mask;
-	GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
-
-	return 0;
-}
-
-/*
- * GPIO IRQs must be acknowledged.  This is for IRQs from 0 to 10.
- */
-static void sa1100_low_gpio_ack(struct irq_data *d)
-{
-	GEDR = (1 << d->irq);
-}
-
-static void sa1100_low_gpio_mask(struct irq_data *d)
-{
-	ICMR &= ~(1 << d->irq);
-}
-
-static void sa1100_low_gpio_unmask(struct irq_data *d)
-{
-	ICMR |= 1 << d->irq;
-}
-
-static int sa1100_low_gpio_wake(struct irq_data *d, unsigned int on)
-{
-	if (on)
-		PWER |= 1 << d->irq;
-	else
-		PWER &= ~(1 << d->irq);
-	return 0;
-}
-
-static struct irq_chip sa1100_low_gpio_chip = {
-	.name		= "GPIO-l",
-	.irq_ack	= sa1100_low_gpio_ack,
-	.irq_mask	= sa1100_low_gpio_mask,
-	.irq_unmask	= sa1100_low_gpio_unmask,
-	.irq_set_type	= sa1100_gpio_type,
-	.irq_set_wake	= sa1100_low_gpio_wake,
-};
-
-/*
- * IRQ11 (GPIO11 through 27) handler.  We enter here with the
- * irq_controller_lock held, and IRQs disabled.  Decode the IRQ
- * and call the handler.
- */
-static void
-sa1100_high_gpio_handler(unsigned int irq, struct irq_desc *desc)
-{
-	unsigned int mask;
-
-	mask = GEDR & 0xfffff800;
-	do {
-		/*
-		 * clear down all currently active IRQ sources.
-		 * We will be processing them all.
-		 */
-		GEDR = mask;
-
-		irq = IRQ_GPIO11;
-		mask >>= 11;
-		do {
-			if (mask & 1)
-				generic_handle_irq(irq);
-			mask >>= 1;
-			irq++;
-		} while (mask);
-
-		mask = GEDR & 0xfffff800;
-	} while (mask);
-}
-
-/*
- * Like GPIO0 to 10, GPIO11-27 IRQs need to be handled specially.
- * In addition, the IRQs are all collected up into one bit in the
- * interrupt controller registers.
- */
-static void sa1100_high_gpio_ack(struct irq_data *d)
-{
-	unsigned int mask = GPIO11_27_MASK(d->irq);
-
-	GEDR = mask;
-}
-
-static void sa1100_high_gpio_mask(struct irq_data *d)
-{
-	unsigned int mask = GPIO11_27_MASK(d->irq);
-
-	GPIO_IRQ_mask &= ~mask;
-
-	GRER &= ~mask;
-	GFER &= ~mask;
-}
-
-static void sa1100_high_gpio_unmask(struct irq_data *d)
-{
-	unsigned int mask = GPIO11_27_MASK(d->irq);
-
-	GPIO_IRQ_mask |= mask;
-
-	GRER = GPIO_IRQ_rising_edge & GPIO_IRQ_mask;
-	GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
-}
-
-static int sa1100_high_gpio_wake(struct irq_data *d, unsigned int on)
-{
-	if (on)
-		PWER |= GPIO11_27_MASK(d->irq);
-	else
-		PWER &= ~GPIO11_27_MASK(d->irq);
-	return 0;
-}
-
-static struct irq_chip sa1100_high_gpio_chip = {
-	.name		= "GPIO-h",
-	.irq_ack	= sa1100_high_gpio_ack,
-	.irq_mask	= sa1100_high_gpio_mask,
-	.irq_unmask	= sa1100_high_gpio_unmask,
-	.irq_set_type	= sa1100_gpio_type,
-	.irq_set_wake	= sa1100_high_gpio_wake,
-};
-
 /*
  * We don't need to ACK IRQs on the SA1100 unless they're GPIOs
  * this is for internal IRQs i.e. from 11 to 31.
@@ -250,16 +87,6 @@ static int sa1100irq_suspend(void)
 		  IC_GPIO6|IC_GPIO5|IC_GPIO4|IC_GPIO3|IC_GPIO2|
 		  IC_GPIO1|IC_GPIO0);
 
-	/*
-	 * Set the appropriate edges for wakeup.
-	 */
-	GRER = PWER & GPIO_IRQ_rising_edge;
-	GFER = PWER & GPIO_IRQ_falling_edge;
-	
-	/*
-	 * Clear any pending GPIO interrupts.
-	 */
-	GEDR = GEDR;
 
 	return 0;
 }
@@ -271,10 +98,6 @@ static void sa1100irq_resume(void)
 	if (st->saved) {
 		ICCR = st->iccr;
 		ICLR = st->iclr;
-
-		GRER = GPIO_IRQ_rising_edge & GPIO_IRQ_mask;
-		GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
-
 		ICMR = st->icmr;
 	}
 }
@@ -321,40 +144,17 @@ void __init sa1100_init_irq(void)
 	/* all IRQs are IRQ, not FIQ */
 	ICLR = 0;
 
-	/* clear all GPIO edge detects */
-	GFER = 0;
-	GRER = 0;
-	GEDR = -1;
-
 	/*
 	 * Whatever the doc says, this has to be set for the wait-on-irq
 	 * instruction to work... on a SA1100 rev 9 at least.
 	 */
 	ICCR = 1;
 
-	for (irq = 0; irq <= 10; irq++) {
-		irq_set_chip_and_handler(irq, &sa1100_low_gpio_chip,
-					 handle_edge_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-	}
-
-	for (irq = 12; irq <= 31; irq++) {
+	for (irq = 0; irq <= 31; irq++) {
 		irq_set_chip_and_handler(irq, &sa1100_normal_chip,
 					 handle_level_irq);
 		set_irq_flags(irq, IRQF_VALID);
 	}
 
-	for (irq = 32; irq <= 48; irq++) {
-		irq_set_chip_and_handler(irq, &sa1100_high_gpio_chip,
-					 handle_edge_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-	}
-
-	/*
-	 * Install handler for GPIO 11-27 edge detect interrupts
-	 */
-	irq_set_chip(IRQ_GPIO11_27, &sa1100_normal_chip);
-	irq_set_chained_handler(IRQ_GPIO11_27, sa1100_high_gpio_handler);
-
 	set_handle_irq(sa1100_handle_irq);
 }
diff --git a/drivers/gpio/gpio-sa1100.c b/drivers/gpio/gpio-sa1100.c
index f4e881a..89719fb1 100644
--- a/drivers/gpio/gpio-sa1100.c
+++ b/drivers/gpio/gpio-sa1100.c
@@ -12,14 +12,29 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/platform_device.h>
+#include <linux/syscore_ops.h>
 #include <mach/irqs.h>
+#include <mach/generic.h>
+
+/*
+ * SA1100 GPIO edge detection for IRQs:
+ * IRQs are generated on Falling-Edge, Rising-Edge, or both.
+ * Use this instead of directly setting GRER/GFER.
+ */
 
 #define SA1100_NGPIO 28
 
 struct sa1100_gpio_chip {
 	struct gpio_chip gc;
 	void __iomem *regbase;
+	struct irq_domain *domain;
+	int gpio_rising;
+	int gpio_falling;
+	int gpio_mask;
+	int irq_base;
 };
 
 #define to_sgc(chip)	container_of(chip, struct sa1100_gpio_chip, gc)
@@ -81,28 +96,145 @@ static int sa1100_direction_output(struct gpio_chip *chip, unsigned offset, int
 
 static int sa1100_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 {
-	return offset < 11 ? (IRQ_GPIO0 + offset) : (IRQ_GPIO11 - 11 + offset);
+	struct sa1100_gpio_chip *sgc = to_sgc(chip);
+	return irq_find_mapping(sgc->domain, offset);
+}
+
+static int sa1100_gpio_type(struct irq_data *d, unsigned int type)
+{
+	struct sa1100_gpio_chip *sgc = irq_data_get_irq_chip_data(d);
+	unsigned int mask = BIT(d->hwirq);
+
+	if (type == IRQ_TYPE_PROBE) {
+		if ((sgc->gpio_rising | sgc->gpio_falling) & mask)
+			return 0;
+		type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
+	}
+
+	if (type & IRQ_TYPE_EDGE_RISING)
+		sgc->gpio_rising |= mask;
+	else
+		sgc->gpio_rising &= ~mask;
+
+	if (type & IRQ_TYPE_EDGE_FALLING)
+		sgc->gpio_falling |= mask;
+	else
+		sgc->gpio_falling &= ~mask;
+
+	writel_relaxed(sgc->gpio_rising & sgc->gpio_mask,
+			sgc->regbase + GRER_OFFSET);
+	writel_relaxed(sgc->gpio_falling & sgc->gpio_mask,
+			sgc->regbase + GFER_OFFSET);
+
+	return 0;
+}
+
+/*
+ * GPIO IRQs must be acknowledged.
+ */
+static void sa1100_gpio_ack(struct irq_data *d)
+{
+	struct sa1100_gpio_chip *sgc = irq_data_get_irq_chip_data(d);
+
+	writel_relaxed(BIT(d->hwirq), sgc->regbase + GEDR_OFFSET);
+}
+
+static int sa1100_gpio_wake(struct irq_data *d, unsigned int on)
+{
+	return sa11x0_gpio_set_wake(d->hwirq, on);
+}
+
+static void sa1100_gpio_mask(struct irq_data *d)
+{
+	struct sa1100_gpio_chip *sgc = irq_data_get_irq_chip_data(d);
+
+	sgc->gpio_mask &= ~BIT(d->hwirq);
+
+	writel_relaxed(sgc->gpio_rising & sgc->gpio_mask,
+			sgc->regbase + GRER_OFFSET);
+	writel_relaxed(sgc->gpio_falling & sgc->gpio_mask,
+			sgc->regbase + GFER_OFFSET);
+}
+
+static void sa1100_gpio_unmask(struct irq_data *d)
+{
+	struct sa1100_gpio_chip *sgc = irq_data_get_irq_chip_data(d);
+
+	sgc->gpio_mask |= BIT(d->hwirq);
+
+	writel_relaxed(sgc->gpio_rising & sgc->gpio_mask,
+			sgc->regbase + GRER_OFFSET);
+	writel_relaxed(sgc->gpio_falling & sgc->gpio_mask,
+			sgc->regbase + GFER_OFFSET);
+}
+
+static void
+sa1100_gpio_handler(unsigned int irq, struct irq_desc *desc)
+{
+	struct sa1100_gpio_chip *sgc = irq_get_handler_data(irq);
+	unsigned int hwirq = 0;
+	unsigned int mask = readl_relaxed(sgc->regbase + GEDR_OFFSET);
+	/*
+	 * clear down all currently active IRQ sources.
+	 * We will be processing them all.
+	 */
+	writel_relaxed(mask, sgc->regbase + GEDR_OFFSET);
+
+	while (mask) {
+		if (mask & 1)
+			generic_handle_irq(irq_find_mapping(sgc->domain,
+						hwirq));
+		mask >>= 1;
+		hwirq++;
+	}
 }
 
+static struct irq_chip sa1100_gpio_irq_chip = {
+	.name		= "GPIO",
+	.irq_ack	= sa1100_gpio_ack,
+	.irq_mask	= sa1100_gpio_mask,
+	.irq_unmask	= sa1100_gpio_unmask,
+	.irq_set_type	= sa1100_gpio_type,
+	.irq_set_wake	= sa1100_gpio_wake,
+};
+
+static int sa1100_gpio_irqdomain_map(struct irq_domain *d, unsigned int irq,
+		irq_hw_number_t hwirq)
+{
+	struct sa1100_gpio_chip *sgc = d->host_data;
+
+	irq_set_chip_data(irq, sgc);
+	irq_set_chip_and_handler(irq, &sa1100_gpio_irq_chip, handle_edge_irq);
+	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+
+	return 0;
+}
+
+static struct irq_domain_ops sa1100_gpio_irqdomain_ops = {
+	.map = sa1100_gpio_irqdomain_map,
+	.xlate = irq_domain_xlate_onetwocell,
+};
+
+static struct sa1100_gpio_chip *chip;
+
 static int sa1100_gpio_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	int ret;
+	unsigned int i, irq;
 	struct sa1100_gpio_chip *sgc;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -EINVAL;
 
-	sgc = kzalloc(sizeof(*sgc), GFP_KERNEL);
+	sgc = devm_kzalloc(&pdev->dev, sizeof(*sgc), GFP_KERNEL);
 	if  (!sgc)
 		return -ENOMEM;
 
-	sgc->regbase = ioremap(res->start, resource_size(res));
-	if (!sgc->regbase) {
-		kfree(sgc);
+	sgc->regbase = devm_ioremap_resource(&pdev->dev, res);
+	if (!sgc->regbase)
 		return -EINVAL;
-	}
 
 	sgc->gc.label = "gpio";
 	sgc->gc.direction_input = sa1100_direction_input;
@@ -114,12 +246,45 @@ static int sa1100_gpio_probe(struct platform_device *pdev)
 	sgc->gc.base = 0;
 	sgc->gc.ngpio = SA1100_NGPIO;
 
+	sgc->irq_base = IRQ_GPIO0;
+
+	/* clear all GPIO edge detects */
+	writel_relaxed(0, sgc->regbase + GFER_OFFSET);
+	writel_relaxed(0, sgc->regbase + GRER_OFFSET);
+	writel_relaxed(-1, sgc->regbase + GEDR_OFFSET);
+
 	/* Initialize GPIO chips */
 	ret = gpiochip_add(&sgc->gc);
-	if (ret) {
-		iounmap(sgc->regbase);
-		kfree(sgc);
+	if (ret)
+		return ret;
+
+	sgc->domain = irq_domain_add_legacy(NULL, SA1100_NGPIO, IRQ_GPIO0, 0,
+			&sa1100_gpio_irqdomain_ops, sgc);
+	/*
+	 * Install handler for GPIO 11-27 edge detect interrupts
+	 */
+	for (i = 0; i < 11; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0)
+			goto err_irq;
+		irq_set_handler_data(irq, sgc);
+		irq_set_chained_handler(irq, sa1100_gpio_handler);
 	}
+	irq = platform_get_irq(pdev, 11);
+	if (irq < 0)
+		goto err_irq;
+	irq_set_handler_data(irq, sgc);
+	irq_set_chained_handler(irq, sa1100_gpio_handler);
+
+	chip = sgc;
+
+	return 0;
+
+err_irq:
+	dev_err(&pdev->dev, "Error retrieving irq resource %d (%d)\n", i, irq);
+	i = gpiochip_remove(&sgc->gc);
+	if (i)
+		dev_err(&pdev->dev, "Error removing gpio chip (%d)!\n", i);
 
 	return ret;
 }
@@ -136,3 +301,58 @@ static int __init sa1100_gpio_init(void)
 	return platform_driver_register(&sa1100_gpio_driver);
 }
 postcore_initcall(sa1100_gpio_init);
+
+#ifdef CONFIG_PM
+static unsigned long	saved_gplr;
+static unsigned long	saved_gpdr;
+static unsigned long	saved_grer;
+static unsigned long	saved_gfer;
+
+static int sa1100_gpio_suspend(void)
+{
+	struct sa1100_gpio_chip *sgc = chip;
+	saved_gplr = readl_relaxed(sgc->regbase + GPLR_OFFSET);
+	saved_gpdr = readl_relaxed(sgc->regbase + GPDR_OFFSET);
+	saved_grer = readl_relaxed(sgc->regbase + GRER_OFFSET);
+	saved_gfer = readl_relaxed(sgc->regbase + GFER_OFFSET);
+
+	/* Clear GPIO transition detect bits */
+	writel_relaxed(0xffffffff, sgc->regbase + GEDR_OFFSET);
+
+	/* FIXME: Original code also reprogramed GRER/GFER here,
+	 * I don't see the purpose though.
+	GRER = PWER & sgc->gpio_rising;
+	GFER = PWER & sgc->gpio_falling;
+	 */
+
+	return 0;
+}
+
+static void sa1100_gpio_resume(void)
+{
+	struct sa1100_gpio_chip *sgc = chip;
+	/* restore level with set/clear */
+	writel_relaxed(saved_gplr, sgc->regbase + GPSR_OFFSET);
+	writel_relaxed(~saved_gplr, sgc->regbase + GPCR_OFFSET);
+
+	writel_relaxed(saved_grer, sgc->regbase + GRER_OFFSET);
+	writel_relaxed(saved_gfer, sgc->regbase + GFER_OFFSET);
+	writel_relaxed(saved_gpdr, sgc->regbase + GPDR_OFFSET);
+}
+#else
+#define sa1100_gpio_suspend	NULL
+#define sa1100_gpio_resume	NULL
+#endif
+
+static struct syscore_ops sa1100_gpio_syscore_ops = {
+	.suspend	= sa1100_gpio_suspend,
+	.resume		= sa1100_gpio_resume,
+};
+
+static int __init sa1100_gpio_sysinit(void)
+{
+	if (chip)
+		register_syscore_ops(&sa1100_gpio_syscore_ops);
+	return 0;
+}
+postcore_initcall(sa1100_gpio_sysinit);
-- 
1.8.4.2
