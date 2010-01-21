From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 21 Jan 2010 10:13:00 +0800
Subject: [PATCH] locomo.c: make irq register access typesafe
In-Reply-To: <201001201110.44583.hartleys@visionengravers.com>
References: <201001201110.44583.hartleys@visionengravers.com>
Message-ID: <f17812d71001201813hf93c33wbfc9f50452ec38fa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2010 at 2:10 AM, H Hartley Sweeten
<hartleys@visionengravers.com> wrote:
> In locomo_setup_irq a void __iomem * is stored by set_irq_chip_data
> to hold the base address for the irq registers. ?Unfortunately chip_data
> is a void *. This will cause a number of (different address space) sparse
> warnings.
>

That's actually been fixed as a side effect in my previous proposed
irq cleanup patches. The way is to pass locomo chip as the data
instead of a raw pointer. Please let me know how you think, the
specific patch follows:

commit a53c2b1a0b2641ad9403a0e3e990e885fa56ded2
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Fri Dec 25 23:01:39 2009 +0800

    [ARM] locomo: allow cascaded IRQ base to be specified by platforms

    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index a16df07..aef6cc4 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -32,6 +32,12 @@

 #include <asm/hardware/locomo.h>

+/* LoCoMo Interrupts */
+#define IRQ_LOCOMO_KEY		(0)
+#define IRQ_LOCOMO_GPIO		(1)
+#define IRQ_LOCOMO_LT		(2)
+#define IRQ_LOCOMO_SPI		(3)
+
 /* M62332 output channel selection */
 #define M62332_EVR_CH	1	/* M62332 volume channel number  */
 				/*   0 : CH.1 , 1 : CH. 2        */
@@ -58,6 +64,7 @@ struct locomo {
 	struct device *dev;
 	unsigned long phys;
 	unsigned int irq;
+	int irq_base;
 	spinlock_t lock;
 	void __iomem *base;
 #ifdef CONFIG_PM
@@ -81,9 +88,7 @@ struct locomo_dev_info {
 static struct locomo_dev_info locomo_devices[] = {
 	{
 		.devid 		= LOCOMO_DEVID_KEYBOARD,
-		.irq = {
-			IRQ_LOCOMO_KEY,
-		},
+		.irq		= { IRQ_LOCOMO_KEY },
 		.name		= "locomo-keyboard",
 		.offset		= LOCOMO_KEYBOARD,
 		.length		= 16,
@@ -135,18 +140,18 @@ static struct locomo_dev_info locomo_devices[] = {

 static void locomo_handler(unsigned int irq, struct irq_desc *desc)
 {
+	struct locomo *lchip = get_irq_chip_data(irq);
 	int req, i;
-	void __iomem *mapbase = get_irq_chip_data(irq);

 	/* Acknowledge the parent IRQ */
 	desc->chip->ack(irq);

 	/* check why this interrupt was generated */
-	req = locomo_readl(mapbase + LOCOMO_ICR) & 0x0f00;
+	req = locomo_readl(lchip->base + LOCOMO_ICR) & 0x0f00;

 	if (req) {
 		/* generate the next interrupt(s) */
-		irq = IRQ_LOCOMO_KEY;
+		irq = lchip->irq_base;
 		for (i = 0; i <= 3; i++, irq++) {
 			if (req & (0x0100 << i)) {
 				generic_handle_irq(irq);
@@ -162,20 +167,20 @@ static void locomo_ack_irq(unsigned int irq)

 static void locomo_mask_irq(unsigned int irq)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct locomo *lchip = get_irq_chip_data(irq);
 	unsigned int r;
-	r = locomo_readl(mapbase + LOCOMO_ICR);
-	r &= ~(0x0010 << (irq - IRQ_LOCOMO_KEY));
-	locomo_writel(r, mapbase + LOCOMO_ICR);
+	r = locomo_readl(lchip->base + LOCOMO_ICR);
+	r &= ~(0x0010 << (irq - lchip->irq_base));
+	locomo_writel(r, lchip->base + LOCOMO_ICR);
 }

 static void locomo_unmask_irq(unsigned int irq)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct locomo *lchip = get_irq_chip_data(irq);
 	unsigned int r;
-	r = locomo_readl(mapbase + LOCOMO_ICR);
-	r |= (0x0010 << (irq - IRQ_LOCOMO_KEY));
-	locomo_writel(r, mapbase + LOCOMO_ICR);
+	r = locomo_readl(lchip->base + LOCOMO_ICR);
+	r |= (0x0010 << (irq - lchip->irq_base));
+	locomo_writel(r, lchip->base + LOCOMO_ICR);
 }

 static struct irq_chip locomo_chip = {
@@ -187,20 +192,19 @@ static struct irq_chip locomo_chip = {

 static void locomo_setup_irq(struct locomo *lchip)
 {
-	int irq;
-	void __iomem *irqbase = lchip->base;
+	int irq = lchip->irq_base;

 	/*
 	 * Install handler for IRQ_LOCOMO_HW.
 	 */
 	set_irq_type(lchip->irq, IRQ_TYPE_EDGE_FALLING);
-	set_irq_chip_data(lchip->irq, irqbase);
+	set_irq_chip_data(lchip->irq, lchip);
 	set_irq_chained_handler(lchip->irq, locomo_handler);

 	/* Install handlers for IRQ_LOCOMO_* */
-	for (irq = IRQ_LOCOMO_KEY; irq <= IRQ_LOCOMO_SPI; irq++) {
+	for ( ; irq <= lchip->irq_base + 3; irq++) {
 		set_irq_chip(irq, &locomo_chip);
-		set_irq_chip_data(irq, irqbase);
+		set_irq_chip_data(irq, lchip);
 		set_irq_handler(irq, handle_level_irq);
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 	}
@@ -247,7 +251,8 @@ locomo_init_one_child(struct locomo *lchip, struct
locomo_dev_info *info)
 		dev->mapbase = 0;
 	dev->length = info->length;

-	memmove(dev->irq, info->irq, sizeof(dev->irq));
+	dev->irq[0] = (lchip->irq_base == NO_IRQ) ?
+			NO_IRQ : lchip->irq_base + info->irq[0];

 	ret = device_register(&dev->dev);
 	if (ret) {
@@ -364,6 +369,7 @@ static int locomo_resume(struct platform_device *dev)
 static int
 __locomo_probe(struct device *me, struct resource *mem, int irq)
 {
+	struct locomo_platform_data *pdata = me->platform_data;
 	struct locomo *lchip;
 	unsigned long r;
 	int i, ret = -ENODEV;
@@ -379,6 +385,7 @@ __locomo_probe(struct device *me, struct resource
*mem, int irq)

 	lchip->phys = mem->start;
 	lchip->irq = irq;
+	lchip->irq_base = (pdata) ? pdata->irq_base : NO_IRQ;

 	/*
 	 * Map the whole region.  This also maps the
@@ -445,7 +452,7 @@ __locomo_probe(struct device *me, struct resource
*mem, int irq)
 	 * The interrupt controller must be initialised before any
 	 * other device to ensure that the interrupts are available.
 	 */
-	if (lchip->irq != NO_IRQ)
+	if (lchip->irq != NO_IRQ && lchip->irq_base != NO_IRQ)
 		locomo_setup_irq(lchip);

 	for (i = 0; i < ARRAY_SIZE(locomo_devices); i++)
diff --git a/arch/arm/include/asm/hardware/locomo.h
b/arch/arm/include/asm/hardware/locomo.h
index 954b1be..74e51d6 100644
--- a/arch/arm/include/asm/hardware/locomo.h
+++ b/arch/arm/include/asm/hardware/locomo.h
@@ -214,4 +214,8 @@ void locomo_m62332_senddata(struct locomo_dev
*ldev, unsigned int dac_data, int
 /* Frontlight control */
 void locomo_frontlight_set(struct locomo_dev *dev, int duty, int vr, int bpwf);

+struct locomo_platform_data {
+	int	irq_base;	/* IRQ base for cascaded on-chip IRQs */
+};
+
 #endif
diff --git a/arch/arm/mach-pxa/include/mach/irqs.h
b/arch/arm/mach-pxa/include/mach/irqs.h
index 56a2c61..83b14f1 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -247,12 +247,6 @@
 #define BALLOON3_CODEC_IRQ	IRQ_GPIO(BALLOON3_GPIO_CODEC_IRQ)
 #define BALLOON3_S0_CD_IRQ	IRQ_GPIO(BALLOON3_GPIO_S0_CD)

-/* LoCoMo Interrupts (CONFIG_SHARP_LOCOMO) */
-#define IRQ_LOCOMO_KEY		(IRQ_BOARD_START + 0)
-#define IRQ_LOCOMO_GPIO		(IRQ_BOARD_START + 1)
-#define IRQ_LOCOMO_LT		(IRQ_BOARD_START + 2)
-#define IRQ_LOCOMO_SPI		(IRQ_BOARD_START + 3)
-
 /* phyCORE-PXA270 (PCM027) Interrupts */
 #define PCM027_IRQ(x)          (IRQ_BOARD_START + (x))
 #define PCM027_BTDET_IRQ       PCM027_IRQ(0)
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index c2b938a..35ce7ea 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -193,11 +193,18 @@ static struct resource locomo_resources[] = {
 	},
 };

+static struct locomo_platform_data locomo_info = {
+	.irq_base	= IRQ_BOARD_START,
+};
+
 struct platform_device poodle_locomo_device = {
 	.name		= "locomo",
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(locomo_resources),
 	.resource	= locomo_resources,
+	.dev		= {
+		.platform_data	= &locomo_info,
+	},
 };

 EXPORT_SYMBOL(poodle_locomo_device);
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index 9982c5c..5d5f330 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -234,6 +234,10 @@ static struct resource locomo_resources[] = {
 	},
 };

+static struct locomo_platform_data locomo_info = {
+	.irq_base	= IRQ_BOARD_START,
+};
+
 struct platform_device collie_locomo_device = {
 	.name		= "locomo",
 	.id		= 0,
diff --git a/arch/arm/mach-sa1100/include/mach/irqs.h
b/arch/arm/mach-sa1100/include/mach/irqs.h
index a8dc68e..bc67722 100644
--- a/arch/arm/mach-sa1100/include/mach/irqs.h
+++ b/arch/arm/mach-sa1100/include/mach/irqs.h
@@ -124,13 +124,13 @@
  * Figure out the MAX IRQ number.
  *
  * If we have an SA1111, the max IRQ is S1_BVD1_STSCHG+1.
- * If we have an LoCoMo, the max IRQ is IRQ_LOCOMO_SPI_TEND+1
+ * If we have an LoCoMo, the max IRQ is IRQ_BOARD_START + 4
  * Otherwise, we have the standard IRQs only.
  */
 #ifdef CONFIG_SA1111
 #define NR_IRQS			(IRQ_S1_BVD1_STSCHG + 1)
 #elif CONFIG_SHARPSL_LOCOMO
-#define NR_IRQS			(IRQ_LOCOMO_SPI + 1)
+#define NR_IRQS			(IRQ_BOARD_START + 4)
 #else
 #define NR_IRQS			(IRQ_BOARD_START)
 #endif
@@ -142,10 +142,3 @@
 #define IRQ_NEPONSET_SMC9196	(IRQ_BOARD_START + 0)
 #define IRQ_NEPONSET_USAR	(IRQ_BOARD_START + 1)
 #define IRQ_NEPONSET_SA1111	(IRQ_BOARD_START + 2)
-
-/* LoCoMo Interrupts (CONFIG_SHARP_LOCOMO) */
-#define IRQ_LOCOMO_KEY		(IRQ_BOARD_START + 0)
-#define IRQ_LOCOMO_GPIO		(IRQ_BOARD_START + 1)
-#define IRQ_LOCOMO_LT		(IRQ_BOARD_START + 2)
-#define IRQ_LOCOMO_SPI		(IRQ_BOARD_START + 3)
-
