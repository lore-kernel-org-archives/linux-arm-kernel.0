From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 20 Jan 2010 11:10:44 -0700
Subject: [PATCH] locomo.c: make irq register access typesafe
Message-ID: <201001201110.44583.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In locomo_setup_irq a void __iomem * is stored by set_irq_chip_data
to hold the base address for the irq registers.  Unfortunately chip_data
is a void *. This will cause a number of (different address space) sparse
warnings.

Create a new struct to hold the void __iomem * and use a static
variable of that type to use as the chip_data.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

I have no way of actually testing this patch. If someone could test this
I would appreciate it.

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index bd36c77..bb4a79c 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -166,10 +166,17 @@ static struct locomo_dev_info locomo_devices[] = {
 #define	LOCOMO_IRQ_LT_START	(IRQ_LOCOMO_LT)
 #define	LOCOMO_IRQ_SPI_START	(IRQ_LOCOMO_SPI_RFR)
 
+struct locomo_irq_chip_data {
+	void __iomem *mapbase;
+};
+
+static struct locomo_irq_chip_data locomo_irq_chip;
+
 static void locomo_handler(unsigned int irq, struct irq_desc *desc)
 {
+	struct locomo_irq_chip_data *chip = get_irq_chip_data(irq);
+	void __iomem *mapbase = chip->mapbase;
 	int req, i;
-	void __iomem *mapbase = get_irq_chip_data(irq);
 
 	/* Acknowledge the parent IRQ */
 	desc->chip->ack(irq);
@@ -195,8 +202,10 @@ static void locomo_ack_irq(unsigned int irq)
 
 static void locomo_mask_irq(unsigned int irq)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct locomo_irq_chip_data *chip = get_irq_chip_data(irq);
+	void __iomem *mapbase = chip->mapbase;
 	unsigned int r;
+
 	r = locomo_readl(mapbase + LOCOMO_ICR);
 	r &= ~(0x0010 << (irq - LOCOMO_IRQ_START));
 	locomo_writel(r, mapbase + LOCOMO_ICR);
@@ -204,8 +213,10 @@ static void locomo_mask_irq(unsigned int irq)
 
 static void locomo_unmask_irq(unsigned int irq)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct locomo_irq_chip_data *chip = get_irq_chip_data(irq);
+	void __iomem *mapbase = chip->mapbase;
 	unsigned int r;
+
 	r = locomo_readl(mapbase + LOCOMO_ICR);
 	r |= (0x0010 << (irq - LOCOMO_IRQ_START));
 	locomo_writel(r, mapbase + LOCOMO_ICR);
@@ -220,7 +231,8 @@ static struct irq_chip locomo_chip = {
 
 static void locomo_key_handler(unsigned int irq, struct irq_desc *desc)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct locomo_irq_chip_data *chip = get_irq_chip_data(irq);
+	void __iomem *mapbase = chip->mapbase;
 
 	if (locomo_readl(mapbase + LOCOMO_KEYBOARD + LOCOMO_KIC) & 0x0001) {
 		generic_handle_irq(LOCOMO_IRQ_KEY_START);
@@ -229,8 +241,10 @@ static void locomo_key_handler(unsigned int irq, struct irq_desc *desc)
 
 static void locomo_key_ack_irq(unsigned int irq)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct locomo_irq_chip_data *chip = get_irq_chip_data(irq);
+	void __iomem *mapbase = chip->mapbase;
 	unsigned int r;
+
 	r = locomo_readl(mapbase + LOCOMO_KEYBOARD + LOCOMO_KIC);
 	r &= ~(0x0100 << (irq - LOCOMO_IRQ_KEY_START));
 	locomo_writel(r, mapbase + LOCOMO_KEYBOARD + LOCOMO_KIC);
@@ -238,8 +252,10 @@ static void locomo_key_ack_irq(unsigned int irq)
 
 static void locomo_key_mask_irq(unsigned int irq)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct locomo_irq_chip_data *chip = get_irq_chip_data(irq);
+	void __iomem *mapbase = chip->mapbase;
 	unsigned int r;
+
 	r = locomo_readl(mapbase + LOCOMO_KEYBOARD + LOCOMO_KIC);
 	r &= ~(0x0010 << (irq - LOCOMO_IRQ_KEY_START));
 	locomo_writel(r, mapbase + LOCOMO_KEYBOARD + LOCOMO_KIC);
@@ -247,8 +263,10 @@ static void locomo_key_mask_irq(unsigned int irq)
 
 static void locomo_key_unmask_irq(unsigned int irq)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct locomo_irq_chip_data *chip = get_irq_chip_data(irq);
+	void __iomem *mapbase = chip->mapbase;
 	unsigned int r;
+
 	r = locomo_readl(mapbase + LOCOMO_KEYBOARD + LOCOMO_KIC);
 	r |= (0x0010 << (irq - LOCOMO_IRQ_KEY_START));
 	locomo_writel(r, mapbase + LOCOMO_KEYBOARD + LOCOMO_KIC);
@@ -263,8 +281,9 @@ static struct irq_chip locomo_key_chip = {
 
 static void locomo_gpio_handler(unsigned int irq, struct irq_desc *desc)
 {
+	struct locomo_irq_chip_data *chip = get_irq_chip_data(irq);
+	void __iomem *mapbase = chip->mapbase;
 	int req, i;
-	void __iomem *mapbase = get_irq_chip_data(irq);
 
 	req = 	locomo_readl(mapbase + LOCOMO_GIR) &
 		locomo_readl(mapbase + LOCOMO_GPD) &
@@ -282,8 +301,10 @@ static void locomo_gpio_handler(unsigned int irq, struct irq_desc *desc)
 
 static void locomo_gpio_ack_irq(unsigned int irq)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct locomo_irq_chip_data *chip = get_irq_chip_data(irq);
+	void __iomem *mapbase = chip->mapbase;
 	unsigned int r;
+
 	r = locomo_readl(mapbase + LOCOMO_GWE);
 	r |= (0x0001 << (irq - LOCOMO_IRQ_GPIO_START));
 	locomo_writel(r, mapbase + LOCOMO_GWE);
@@ -299,8 +320,10 @@ static void locomo_gpio_ack_irq(unsigned int irq)
 
 static void locomo_gpio_mask_irq(unsigned int irq)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct locomo_irq_chip_data *chip = get_irq_chip_data(irq);
+	void __iomem *mapbase = chip->mapbase;
 	unsigned int r;
+
 	r = locomo_readl(mapbase + LOCOMO_GIE);
 	r &= ~(0x0001 << (irq - LOCOMO_IRQ_GPIO_START));
 	locomo_writel(r, mapbase + LOCOMO_GIE);
@@ -308,8 +331,10 @@ static void locomo_gpio_mask_irq(unsigned int irq)
 
 static void locomo_gpio_unmask_irq(unsigned int irq)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct locomo_irq_chip_data *chip = get_irq_chip_data(irq);
+	void __iomem *mapbase = chip->mapbase;
 	unsigned int r;
+
 	r = locomo_readl(mapbase + LOCOMO_GIE);
 	r |= (0x0001 << (irq - LOCOMO_IRQ_GPIO_START));
 	locomo_writel(r, mapbase + LOCOMO_GIE);
@@ -320,8 +345,9 @@ static int GPIO_IRQ_falling_edge;
 
 static int locomo_gpio_type(unsigned int irq, unsigned int type)
 {
+	struct locomo_irq_chip_data *chip = get_irq_chip_data(irq);
+	void __iomem *mapbase = chip->mapbase;
 	unsigned int mask;
-	void __iomem *mapbase = get_irq_chip_data(irq);
 
 	mask = 1 << (irq - LOCOMO_IRQ_GPIO_START);
 
@@ -355,7 +381,8 @@ static struct irq_chip locomo_gpio_chip = {
 
 static void locomo_lt_handler(unsigned int irq, struct irq_desc *desc)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct locomo_irq_chip_data *chip = get_irq_chip_data(irq);
+	void __iomem *mapbase = chip->mapbase;
 
 	if (locomo_readl(mapbase + LOCOMO_LTINT) & 0x0001) {
 		generic_handle_irq(LOCOMO_IRQ_LT_START);
@@ -364,8 +391,10 @@ static void locomo_lt_handler(unsigned int irq, struct irq_desc *desc)
 
 static void locomo_lt_ack_irq(unsigned int irq)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct locomo_irq_chip_data *chip = get_irq_chip_data(irq);
+	void __iomem *mapbase = chip->mapbase;
 	unsigned int r;
+
 	r = locomo_readl(mapbase + LOCOMO_LTINT);
 	r &= ~(0x0100 << (irq - LOCOMO_IRQ_LT_START));
 	locomo_writel(r, mapbase + LOCOMO_LTINT);
@@ -373,8 +402,10 @@ static void locomo_lt_ack_irq(unsigned int irq)
 
 static void locomo_lt_mask_irq(unsigned int irq)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct locomo_irq_chip_data *chip = get_irq_chip_data(irq);
+	void __iomem *mapbase = chip->mapbase;
 	unsigned int r;
+
 	r = locomo_readl(mapbase + LOCOMO_LTINT);
 	r &= ~(0x0010 << (irq - LOCOMO_IRQ_LT_START));
 	locomo_writel(r, mapbase + LOCOMO_LTINT);
@@ -382,8 +413,10 @@ static void locomo_lt_mask_irq(unsigned int irq)
 
 static void locomo_lt_unmask_irq(unsigned int irq)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct locomo_irq_chip_data *chip = get_irq_chip_data(irq);
+	void __iomem *mapbase = chip->mapbase;
 	unsigned int r;
+
 	r = locomo_readl(mapbase + LOCOMO_LTINT);
 	r |= (0x0010 << (irq - LOCOMO_IRQ_LT_START));
 	locomo_writel(r, mapbase + LOCOMO_LTINT);
@@ -398,8 +431,9 @@ static struct irq_chip locomo_lt_chip = {
 
 static void locomo_spi_handler(unsigned int irq, struct irq_desc *desc)
 {
+	struct locomo_irq_chip_data *chip = get_irq_chip_data(irq);
+	void __iomem *mapbase = chip->mapbase;
 	int req, i;
-	void __iomem *mapbase = get_irq_chip_data(irq);
 
 	req = locomo_readl(mapbase + LOCOMO_SPI + LOCOMO_SPIIR) & 0x000F;
 	if (req) {
@@ -415,8 +449,10 @@ static void locomo_spi_handler(unsigned int irq, struct irq_desc *desc)
 
 static void locomo_spi_ack_irq(unsigned int irq)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct locomo_irq_chip_data *chip = get_irq_chip_data(irq);
+	void __iomem *mapbase = chip->mapbase;
 	unsigned int r;
+
 	r = locomo_readl(mapbase + LOCOMO_SPI + LOCOMO_SPIWE);
 	r |= (0x0001 << (irq - LOCOMO_IRQ_SPI_START));
 	locomo_writel(r, mapbase + LOCOMO_SPI + LOCOMO_SPIWE);
@@ -432,8 +468,10 @@ static void locomo_spi_ack_irq(unsigned int irq)
 
 static void locomo_spi_mask_irq(unsigned int irq)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct locomo_irq_chip_data *chip = get_irq_chip_data(irq);
+	void __iomem *mapbase = chip->mapbase;
 	unsigned int r;
+
 	r = locomo_readl(mapbase + LOCOMO_SPI + LOCOMO_SPIIE);
 	r &= ~(0x0001 << (irq - LOCOMO_IRQ_SPI_START));
 	locomo_writel(r, mapbase + LOCOMO_SPI + LOCOMO_SPIIE);
@@ -441,8 +479,10 @@ static void locomo_spi_mask_irq(unsigned int irq)
 
 static void locomo_spi_unmask_irq(unsigned int irq)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct locomo_irq_chip_data *chip = get_irq_chip_data(irq);
+	void __iomem *mapbase = chip->mapbase;
 	unsigned int r;
+
 	r = locomo_readl(mapbase + LOCOMO_SPI + LOCOMO_SPIIE);
 	r |= (0x0001 << (irq - LOCOMO_IRQ_SPI_START));
 	locomo_writel(r, mapbase + LOCOMO_SPI + LOCOMO_SPIIE);
@@ -458,56 +498,57 @@ static struct irq_chip locomo_spi_chip = {
 static void locomo_setup_irq(struct locomo *lchip)
 {
 	int irq;
-	void __iomem *irqbase = lchip->base;
+
+	locomo_irq_chip->mapbase = lchip->base;
 
 	/*
 	 * Install handler for IRQ_LOCOMO_HW.
 	 */
 	set_irq_type(lchip->irq, IRQ_TYPE_EDGE_FALLING);
-	set_irq_chip_data(lchip->irq, irqbase);
+	set_irq_chip_data(lchip->irq, &locomo_irq_chip);
 	set_irq_chained_handler(lchip->irq, locomo_handler);
 
 	/* Install handlers for IRQ_LOCOMO_*_BASE */
 	set_irq_chip(IRQ_LOCOMO_KEY_BASE, &locomo_chip);
-	set_irq_chip_data(IRQ_LOCOMO_KEY_BASE, irqbase);
+	set_irq_chip_data(IRQ_LOCOMO_KEY_BASE, &locomo_irq_chip);
 	set_irq_chained_handler(IRQ_LOCOMO_KEY_BASE, locomo_key_handler);
 
 	set_irq_chip(IRQ_LOCOMO_GPIO_BASE, &locomo_chip);
-	set_irq_chip_data(IRQ_LOCOMO_GPIO_BASE, irqbase);
+	set_irq_chip_data(IRQ_LOCOMO_GPIO_BASE, &locomo_irq_chip);
 	set_irq_chained_handler(IRQ_LOCOMO_GPIO_BASE, locomo_gpio_handler);
 
 	set_irq_chip(IRQ_LOCOMO_LT_BASE, &locomo_chip);
-	set_irq_chip_data(IRQ_LOCOMO_LT_BASE, irqbase);
+	set_irq_chip_data(IRQ_LOCOMO_LT_BASE, &locomo_irq_chip);
 	set_irq_chained_handler(IRQ_LOCOMO_LT_BASE, locomo_lt_handler);
 
 	set_irq_chip(IRQ_LOCOMO_SPI_BASE, &locomo_chip);
-	set_irq_chip_data(IRQ_LOCOMO_SPI_BASE, irqbase);
+	set_irq_chip_data(IRQ_LOCOMO_SPI_BASE, &locomo_irq_chip);
 	set_irq_chained_handler(IRQ_LOCOMO_SPI_BASE, locomo_spi_handler);
 
 	/* install handlers for IRQ_LOCOMO_KEY_BASE generated interrupts */
 	set_irq_chip(LOCOMO_IRQ_KEY_START, &locomo_key_chip);
-	set_irq_chip_data(LOCOMO_IRQ_KEY_START, irqbase);
+	set_irq_chip_data(LOCOMO_IRQ_KEY_START, &locomo_irq_chip);
 	set_irq_handler(LOCOMO_IRQ_KEY_START, handle_edge_irq);
 	set_irq_flags(LOCOMO_IRQ_KEY_START, IRQF_VALID | IRQF_PROBE);
 
 	/* install handlers for IRQ_LOCOMO_GPIO_BASE generated interrupts */
 	for (irq = LOCOMO_IRQ_GPIO_START; irq < LOCOMO_IRQ_GPIO_START + 16; irq++) {
 		set_irq_chip(irq, &locomo_gpio_chip);
-		set_irq_chip_data(irq, irqbase);
+		set_irq_chip_data(irq, &locomo_irq_chip);
 		set_irq_handler(irq, handle_edge_irq);
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 	}
 
 	/* install handlers for IRQ_LOCOMO_LT_BASE generated interrupts */
 	set_irq_chip(LOCOMO_IRQ_LT_START, &locomo_lt_chip);
-	set_irq_chip_data(LOCOMO_IRQ_LT_START, irqbase);
+	set_irq_chip_data(LOCOMO_IRQ_LT_START, &locomo_irq_chip);
 	set_irq_handler(LOCOMO_IRQ_LT_START, handle_edge_irq);
 	set_irq_flags(LOCOMO_IRQ_LT_START, IRQF_VALID | IRQF_PROBE);
 
 	/* install handlers for IRQ_LOCOMO_SPI_BASE generated interrupts */
 	for (irq = LOCOMO_IRQ_SPI_START; irq < LOCOMO_IRQ_SPI_START + 4; irq++) {
 		set_irq_chip(irq, &locomo_spi_chip);
-		set_irq_chip_data(irq, irqbase);
+		set_irq_chip_data(irq, &locomo_irq_chip);
 		set_irq_handler(irq, handle_edge_irq);
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 	}
