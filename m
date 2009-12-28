From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 28 Dec 2009 13:18:04 +0800
Subject: [PATCH 3/7] [ARM] locomo: remove unused IRQs and avoid unnecessary
	cascade
In-Reply-To: <1261977488-18271-1-git-send-email-eric.y.miao@gmail.com>
References: <1261977488-18271-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1261977488-18271-4-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IRQ_LOCOMO_* are never used elsewhere, remove these definitions. As well
as the cascade of these IRQs. IRQ_LOCOMO_*_BASE changed to IRQ_LOCOMO_*.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/common/locomo.c                 |  325 +-----------------------------
 arch/arm/mach-pxa/Kconfig                |    1 +
 arch/arm/mach-pxa/include/mach/irqs.h    |   34 +---
 arch/arm/mach-sa1100/include/mach/irqs.h |   36 +---
 4 files changed, 19 insertions(+), 377 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 43cdb5a..a16df07 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -82,7 +82,7 @@ static struct locomo_dev_info locomo_devices[] = {
 	{
 		.devid 		= LOCOMO_DEVID_KEYBOARD,
 		.irq = {
-			IRQ_LOCOMO_KEY_BASE,
+			IRQ_LOCOMO_KEY,
 		},
 		.name		= "locomo-keyboard",
 		.offset		= LOCOMO_KEYBOARD,
@@ -133,39 +133,6 @@ static struct locomo_dev_info locomo_devices[] = {
 	},
 };
 
-
-/** LoCoMo interrupt handling stuff.
- * NOTE: LoCoMo has a 1 to many mapping on all of its IRQs.
- * that is, there is only one real hardware interrupt
- * we determine which interrupt it is by reading some IO memory.
- * We have two levels of expansion, first in the handler for the
- * hardware interrupt we generate an interrupt
- * IRQ_LOCOMO_*_BASE and those handlers generate more interrupts
- *
- * hardware irq reads LOCOMO_ICR & 0x0f00
- *   IRQ_LOCOMO_KEY_BASE
- *   IRQ_LOCOMO_GPIO_BASE
- *   IRQ_LOCOMO_LT_BASE
- *   IRQ_LOCOMO_SPI_BASE
- * IRQ_LOCOMO_KEY_BASE reads LOCOMO_KIC & 0x0001
- *   IRQ_LOCOMO_KEY
- * IRQ_LOCOMO_GPIO_BASE reads LOCOMO_GIR & LOCOMO_GPD & 0xffff
- *   IRQ_LOCOMO_GPIO[0-15]
- * IRQ_LOCOMO_LT_BASE reads LOCOMO_LTINT & 0x0001
- *   IRQ_LOCOMO_LT
- * IRQ_LOCOMO_SPI_BASE reads LOCOMO_SPIIR & 0x000F
- *   IRQ_LOCOMO_SPI_RFR
- *   IRQ_LOCOMO_SPI_RFW
- *   IRQ_LOCOMO_SPI_OVRN
- *   IRQ_LOCOMO_SPI_TEND
- */
-
-#define LOCOMO_IRQ_START	(IRQ_LOCOMO_KEY_BASE)
-#define LOCOMO_IRQ_KEY_START	(IRQ_LOCOMO_KEY)
-#define	LOCOMO_IRQ_GPIO_START	(IRQ_LOCOMO_GPIO0)
-#define	LOCOMO_IRQ_LT_START	(IRQ_LOCOMO_LT)
-#define	LOCOMO_IRQ_SPI_START	(IRQ_LOCOMO_SPI_RFR)
-
 static void locomo_handler(unsigned int irq, struct irq_desc *desc)
 {
 	int req, i;
@@ -179,7 +146,7 @@ static void locomo_handler(unsigned int irq, struct irq_desc *desc)
 
 	if (req) {
 		/* generate the next interrupt(s) */
-		irq = LOCOMO_IRQ_START;
+		irq = IRQ_LOCOMO_KEY;
 		for (i = 0; i <= 3; i++, irq++) {
 			if (req & (0x0100 << i)) {
 				generic_handle_irq(irq);
@@ -198,7 +165,7 @@ static void locomo_mask_irq(unsigned int irq)
 	void __iomem *mapbase = get_irq_chip_data(irq);
 	unsigned int r;
 	r = locomo_readl(mapbase + LOCOMO_ICR);
-	r &= ~(0x0010 << (irq - LOCOMO_IRQ_START));
+	r &= ~(0x0010 << (irq - IRQ_LOCOMO_KEY));
 	locomo_writel(r, mapbase + LOCOMO_ICR);
 }
 
@@ -207,7 +174,7 @@ static void locomo_unmask_irq(unsigned int irq)
 	void __iomem *mapbase = get_irq_chip_data(irq);
 	unsigned int r;
 	r = locomo_readl(mapbase + LOCOMO_ICR);
-	r |= (0x0010 << (irq - LOCOMO_IRQ_START));
+	r |= (0x0010 << (irq - IRQ_LOCOMO_KEY));
 	locomo_writel(r, mapbase + LOCOMO_ICR);
 }
 
@@ -218,243 +185,6 @@ static struct irq_chip locomo_chip = {
 	.unmask	= locomo_unmask_irq,
 };
 
-static void locomo_key_handler(unsigned int irq, struct irq_desc *desc)
-{
-	void __iomem *mapbase = get_irq_chip_data(irq);
-
-	if (locomo_readl(mapbase + LOCOMO_KEYBOARD + LOCOMO_KIC) & 0x0001) {
-		generic_handle_irq(LOCOMO_IRQ_KEY_START);
-	}
-}
-
-static void locomo_key_ack_irq(unsigned int irq)
-{
-	void __iomem *mapbase = get_irq_chip_data(irq);
-	unsigned int r;
-	r = locomo_readl(mapbase + LOCOMO_KEYBOARD + LOCOMO_KIC);
-	r &= ~(0x0100 << (irq - LOCOMO_IRQ_KEY_START));
-	locomo_writel(r, mapbase + LOCOMO_KEYBOARD + LOCOMO_KIC);
-}
-
-static void locomo_key_mask_irq(unsigned int irq)
-{
-	void __iomem *mapbase = get_irq_chip_data(irq);
-	unsigned int r;
-	r = locomo_readl(mapbase + LOCOMO_KEYBOARD + LOCOMO_KIC);
-	r &= ~(0x0010 << (irq - LOCOMO_IRQ_KEY_START));
-	locomo_writel(r, mapbase + LOCOMO_KEYBOARD + LOCOMO_KIC);
-}
-
-static void locomo_key_unmask_irq(unsigned int irq)
-{
-	void __iomem *mapbase = get_irq_chip_data(irq);
-	unsigned int r;
-	r = locomo_readl(mapbase + LOCOMO_KEYBOARD + LOCOMO_KIC);
-	r |= (0x0010 << (irq - LOCOMO_IRQ_KEY_START));
-	locomo_writel(r, mapbase + LOCOMO_KEYBOARD + LOCOMO_KIC);
-}
-
-static struct irq_chip locomo_key_chip = {
-	.name	= "LOCOMO-key",
-	.ack	= locomo_key_ack_irq,
-	.mask	= locomo_key_mask_irq,
-	.unmask	= locomo_key_unmask_irq,
-};
-
-static void locomo_gpio_handler(unsigned int irq, struct irq_desc *desc)
-{
-	int req, i;
-	void __iomem *mapbase = get_irq_chip_data(irq);
-
-	req = 	locomo_readl(mapbase + LOCOMO_GIR) &
-		locomo_readl(mapbase + LOCOMO_GPD) &
-		0xffff;
-
-	if (req) {
-		irq = LOCOMO_IRQ_GPIO_START;
-		for (i = 0; i <= 15; i++, irq++) {
-			if (req & (0x0001 << i)) {
-				generic_handle_irq(irq);
-			}
-		}
-	}
-}
-
-static void locomo_gpio_ack_irq(unsigned int irq)
-{
-	void __iomem *mapbase = get_irq_chip_data(irq);
-	unsigned int r;
-	r = locomo_readl(mapbase + LOCOMO_GWE);
-	r |= (0x0001 << (irq - LOCOMO_IRQ_GPIO_START));
-	locomo_writel(r, mapbase + LOCOMO_GWE);
-
-	r = locomo_readl(mapbase + LOCOMO_GIS);
-	r &= ~(0x0001 << (irq - LOCOMO_IRQ_GPIO_START));
-	locomo_writel(r, mapbase + LOCOMO_GIS);
-
-	r = locomo_readl(mapbase + LOCOMO_GWE);
-	r &= ~(0x0001 << (irq - LOCOMO_IRQ_GPIO_START));
-	locomo_writel(r, mapbase + LOCOMO_GWE);
-}
-
-static void locomo_gpio_mask_irq(unsigned int irq)
-{
-	void __iomem *mapbase = get_irq_chip_data(irq);
-	unsigned int r;
-	r = locomo_readl(mapbase + LOCOMO_GIE);
-	r &= ~(0x0001 << (irq - LOCOMO_IRQ_GPIO_START));
-	locomo_writel(r, mapbase + LOCOMO_GIE);
-}
-
-static void locomo_gpio_unmask_irq(unsigned int irq)
-{
-	void __iomem *mapbase = get_irq_chip_data(irq);
-	unsigned int r;
-	r = locomo_readl(mapbase + LOCOMO_GIE);
-	r |= (0x0001 << (irq - LOCOMO_IRQ_GPIO_START));
-	locomo_writel(r, mapbase + LOCOMO_GIE);
-}
-
-static int GPIO_IRQ_rising_edge;
-static int GPIO_IRQ_falling_edge;
-
-static int locomo_gpio_type(unsigned int irq, unsigned int type)
-{
-	unsigned int mask;
-	void __iomem *mapbase = get_irq_chip_data(irq);
-
-	mask = 1 << (irq - LOCOMO_IRQ_GPIO_START);
-
-	if (type == IRQ_TYPE_PROBE) {
-		if ((GPIO_IRQ_rising_edge | GPIO_IRQ_falling_edge) & mask)
-			return 0;
-		type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
-	}
-
-	if (type & IRQ_TYPE_EDGE_RISING)
-		GPIO_IRQ_rising_edge |= mask;
-	else
-		GPIO_IRQ_rising_edge &= ~mask;
-	if (type & IRQ_TYPE_EDGE_FALLING)
-		GPIO_IRQ_falling_edge |= mask;
-	else
-		GPIO_IRQ_falling_edge &= ~mask;
-	locomo_writel(GPIO_IRQ_rising_edge, mapbase + LOCOMO_GRIE);
-	locomo_writel(GPIO_IRQ_falling_edge, mapbase + LOCOMO_GFIE);
-
-	return 0;
-}
-
-static struct irq_chip locomo_gpio_chip = {
-	.name	  = "LOCOMO-gpio",
-	.ack	  = locomo_gpio_ack_irq,
-	.mask	  = locomo_gpio_mask_irq,
-	.unmask	  = locomo_gpio_unmask_irq,
-	.set_type = locomo_gpio_type,
-};
-
-static void locomo_lt_handler(unsigned int irq, struct irq_desc *desc)
-{
-	void __iomem *mapbase = get_irq_chip_data(irq);
-
-	if (locomo_readl(mapbase + LOCOMO_LTINT) & 0x0001) {
-		generic_handle_irq(LOCOMO_IRQ_LT_START);
-	}
-}
-
-static void locomo_lt_ack_irq(unsigned int irq)
-{
-	void __iomem *mapbase = get_irq_chip_data(irq);
-	unsigned int r;
-	r = locomo_readl(mapbase + LOCOMO_LTINT);
-	r &= ~(0x0100 << (irq - LOCOMO_IRQ_LT_START));
-	locomo_writel(r, mapbase + LOCOMO_LTINT);
-}
-
-static void locomo_lt_mask_irq(unsigned int irq)
-{
-	void __iomem *mapbase = get_irq_chip_data(irq);
-	unsigned int r;
-	r = locomo_readl(mapbase + LOCOMO_LTINT);
-	r &= ~(0x0010 << (irq - LOCOMO_IRQ_LT_START));
-	locomo_writel(r, mapbase + LOCOMO_LTINT);
-}
-
-static void locomo_lt_unmask_irq(unsigned int irq)
-{
-	void __iomem *mapbase = get_irq_chip_data(irq);
-	unsigned int r;
-	r = locomo_readl(mapbase + LOCOMO_LTINT);
-	r |= (0x0010 << (irq - LOCOMO_IRQ_LT_START));
-	locomo_writel(r, mapbase + LOCOMO_LTINT);
-}
-
-static struct irq_chip locomo_lt_chip = {
-	.name	= "LOCOMO-lt",
-	.ack	= locomo_lt_ack_irq,
-	.mask	= locomo_lt_mask_irq,
-	.unmask	= locomo_lt_unmask_irq,
-};
-
-static void locomo_spi_handler(unsigned int irq, struct irq_desc *desc)
-{
-	int req, i;
-	void __iomem *mapbase = get_irq_chip_data(irq);
-
-	req = locomo_readl(mapbase + LOCOMO_SPI + LOCOMO_SPIIR) & 0x000F;
-	if (req) {
-		irq = LOCOMO_IRQ_SPI_START;
-
-		for (i = 0; i <= 3; i++, irq++) {
-			if (req & (0x0001 << i)) {
-				generic_handle_irq(irq);
-			}
-		}
-	}
-}
-
-static void locomo_spi_ack_irq(unsigned int irq)
-{
-	void __iomem *mapbase = get_irq_chip_data(irq);
-	unsigned int r;
-	r = locomo_readl(mapbase + LOCOMO_SPI + LOCOMO_SPIWE);
-	r |= (0x0001 << (irq - LOCOMO_IRQ_SPI_START));
-	locomo_writel(r, mapbase + LOCOMO_SPI + LOCOMO_SPIWE);
-
-	r = locomo_readl(mapbase + LOCOMO_SPI + LOCOMO_SPIIS);
-	r &= ~(0x0001 << (irq - LOCOMO_IRQ_SPI_START));
-	locomo_writel(r, mapbase + LOCOMO_SPI + LOCOMO_SPIIS);
-
-	r = locomo_readl(mapbase + LOCOMO_SPI + LOCOMO_SPIWE);
-	r &= ~(0x0001 << (irq - LOCOMO_IRQ_SPI_START));
-	locomo_writel(r, mapbase + LOCOMO_SPI + LOCOMO_SPIWE);
-}
-
-static void locomo_spi_mask_irq(unsigned int irq)
-{
-	void __iomem *mapbase = get_irq_chip_data(irq);
-	unsigned int r;
-	r = locomo_readl(mapbase + LOCOMO_SPI + LOCOMO_SPIIE);
-	r &= ~(0x0001 << (irq - LOCOMO_IRQ_SPI_START));
-	locomo_writel(r, mapbase + LOCOMO_SPI + LOCOMO_SPIIE);
-}
-
-static void locomo_spi_unmask_irq(unsigned int irq)
-{
-	void __iomem *mapbase = get_irq_chip_data(irq);
-	unsigned int r;
-	r = locomo_readl(mapbase + LOCOMO_SPI + LOCOMO_SPIIE);
-	r |= (0x0001 << (irq - LOCOMO_IRQ_SPI_START));
-	locomo_writel(r, mapbase + LOCOMO_SPI + LOCOMO_SPIIE);
-}
-
-static struct irq_chip locomo_spi_chip = {
-	.name	= "LOCOMO-spi",
-	.ack	= locomo_spi_ack_irq,
-	.mask	= locomo_spi_mask_irq,
-	.unmask	= locomo_spi_unmask_irq,
-};
-
 static void locomo_setup_irq(struct locomo *lchip)
 {
 	int irq;
@@ -467,54 +197,15 @@ static void locomo_setup_irq(struct locomo *lchip)
 	set_irq_chip_data(lchip->irq, irqbase);
 	set_irq_chained_handler(lchip->irq, locomo_handler);
 
-	/* Install handlers for IRQ_LOCOMO_*_BASE */
-	set_irq_chip(IRQ_LOCOMO_KEY_BASE, &locomo_chip);
-	set_irq_chip_data(IRQ_LOCOMO_KEY_BASE, irqbase);
-	set_irq_handler(IRQ_LOCOMO_KEY_BASE, handle_level_irq);
-	set_irq_flags(IRQ_LOCOMO_KEY_BASE, IRQF_VALID | IRQF_PROBE);
-
-	set_irq_chip(IRQ_LOCOMO_GPIO_BASE, &locomo_chip);
-	set_irq_chip_data(IRQ_LOCOMO_GPIO_BASE, irqbase);
-	set_irq_chained_handler(IRQ_LOCOMO_GPIO_BASE, locomo_gpio_handler);
-
-	set_irq_chip(IRQ_LOCOMO_LT_BASE, &locomo_chip);
-	set_irq_chip_data(IRQ_LOCOMO_LT_BASE, irqbase);
-	set_irq_chained_handler(IRQ_LOCOMO_LT_BASE, locomo_lt_handler);
-
-	set_irq_chip(IRQ_LOCOMO_SPI_BASE, &locomo_chip);
-	set_irq_chip_data(IRQ_LOCOMO_SPI_BASE, irqbase);
-	set_irq_chained_handler(IRQ_LOCOMO_SPI_BASE, locomo_spi_handler);
-
-	/* install handlers for IRQ_LOCOMO_KEY_BASE generated interrupts */
-	set_irq_chip(LOCOMO_IRQ_KEY_START, &locomo_key_chip);
-	set_irq_chip_data(LOCOMO_IRQ_KEY_START, irqbase);
-	set_irq_handler(LOCOMO_IRQ_KEY_START, handle_edge_irq);
-	set_irq_flags(LOCOMO_IRQ_KEY_START, IRQF_VALID | IRQF_PROBE);
-
-	/* install handlers for IRQ_LOCOMO_GPIO_BASE generated interrupts */
-	for (irq = LOCOMO_IRQ_GPIO_START; irq < LOCOMO_IRQ_GPIO_START + 16; irq++) {
-		set_irq_chip(irq, &locomo_gpio_chip);
-		set_irq_chip_data(irq, irqbase);
-		set_irq_handler(irq, handle_edge_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-	}
-
-	/* install handlers for IRQ_LOCOMO_LT_BASE generated interrupts */
-	set_irq_chip(LOCOMO_IRQ_LT_START, &locomo_lt_chip);
-	set_irq_chip_data(LOCOMO_IRQ_LT_START, irqbase);
-	set_irq_handler(LOCOMO_IRQ_LT_START, handle_edge_irq);
-	set_irq_flags(LOCOMO_IRQ_LT_START, IRQF_VALID | IRQF_PROBE);
-
-	/* install handlers for IRQ_LOCOMO_SPI_BASE generated interrupts */
-	for (irq = LOCOMO_IRQ_SPI_START; irq < LOCOMO_IRQ_SPI_START + 4; irq++) {
-		set_irq_chip(irq, &locomo_spi_chip);
+	/* Install handlers for IRQ_LOCOMO_* */
+	for (irq = IRQ_LOCOMO_KEY; irq <= IRQ_LOCOMO_SPI; irq++) {
+		set_irq_chip(irq, &locomo_chip);
 		set_irq_chip_data(irq, irqbase);
-		set_irq_handler(irq, handle_edge_irq);
+		set_irq_handler(irq, handle_level_irq);
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 	}
 }
 
-
 static void locomo_dev_release(struct device *_dev)
 {
 	struct locomo_dev *dev = LOCOMO_DEV(_dev);
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 8a0837e..7fdc914 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -443,6 +443,7 @@ config MACH_POODLE
 	depends on PXA_SHARPSL
 	select PXA25x
 	select SHARP_LOCOMO
+	select PXA_HAVE_BOARD_IRQS
 	select PXA_SSP
 
 config MACH_CORGI
diff --git a/arch/arm/mach-pxa/include/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h
index 3677a9a..56a2c61 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -187,30 +187,6 @@
 #define IRQ_S0_BVD1_STSCHG	(IRQ_BOARD_END + 53)
 #define IRQ_S1_BVD1_STSCHG	(IRQ_BOARD_END + 54)
 
-#define IRQ_LOCOMO_START	(IRQ_BOARD_END)
-#define IRQ_LOCOMO_KEY		(IRQ_BOARD_END + 0)
-#define IRQ_LOCOMO_GPIO0	(IRQ_BOARD_END + 1)
-#define IRQ_LOCOMO_GPIO1	(IRQ_BOARD_END + 2)
-#define IRQ_LOCOMO_GPIO2	(IRQ_BOARD_END + 3)
-#define IRQ_LOCOMO_GPIO3	(IRQ_BOARD_END + 4)
-#define IRQ_LOCOMO_GPIO4	(IRQ_BOARD_END + 5)
-#define IRQ_LOCOMO_GPIO5	(IRQ_BOARD_END + 6)
-#define IRQ_LOCOMO_GPIO6	(IRQ_BOARD_END + 7)
-#define IRQ_LOCOMO_GPIO7	(IRQ_BOARD_END + 8)
-#define IRQ_LOCOMO_GPIO8	(IRQ_BOARD_END + 9)
-#define IRQ_LOCOMO_GPIO9	(IRQ_BOARD_END + 10)
-#define IRQ_LOCOMO_GPIO10	(IRQ_BOARD_END + 11)
-#define IRQ_LOCOMO_GPIO11	(IRQ_BOARD_END + 12)
-#define IRQ_LOCOMO_GPIO12	(IRQ_BOARD_END + 13)
-#define IRQ_LOCOMO_GPIO13	(IRQ_BOARD_END + 14)
-#define IRQ_LOCOMO_GPIO14	(IRQ_BOARD_END + 15)
-#define IRQ_LOCOMO_GPIO15	(IRQ_BOARD_END + 16)
-#define IRQ_LOCOMO_LT		(IRQ_BOARD_END + 17)
-#define IRQ_LOCOMO_SPI_RFR	(IRQ_BOARD_END + 18)
-#define IRQ_LOCOMO_SPI_RFW	(IRQ_BOARD_END + 19)
-#define IRQ_LOCOMO_SPI_OVRN	(IRQ_BOARD_END + 20)
-#define IRQ_LOCOMO_SPI_TEND	(IRQ_BOARD_END + 21)
-
 /*
  * Figure out the MAX IRQ number.
  *
@@ -220,8 +196,6 @@
  */
 #ifdef CONFIG_SA1111
 #define NR_IRQS			(IRQ_S1_BVD1_STSCHG + 1)
-#elif defined(CONFIG_SHARP_LOCOMO)
-#define NR_IRQS			(IRQ_LOCOMO_SPI_TEND + 1)
 #elif defined(CONFIG_PXA_HAVE_BOARD_IRQS)
 #define NR_IRQS			(IRQ_BOARD_END)
 #else
@@ -274,10 +248,10 @@
 #define BALLOON3_S0_CD_IRQ	IRQ_GPIO(BALLOON3_GPIO_S0_CD)
 
 /* LoCoMo Interrupts (CONFIG_SHARP_LOCOMO) */
-#define IRQ_LOCOMO_KEY_BASE	(IRQ_BOARD_START + 0)
-#define IRQ_LOCOMO_GPIO_BASE	(IRQ_BOARD_START + 1)
-#define IRQ_LOCOMO_LT_BASE	(IRQ_BOARD_START + 2)
-#define IRQ_LOCOMO_SPI_BASE	(IRQ_BOARD_START + 3)
+#define IRQ_LOCOMO_KEY		(IRQ_BOARD_START + 0)
+#define IRQ_LOCOMO_GPIO		(IRQ_BOARD_START + 1)
+#define IRQ_LOCOMO_LT		(IRQ_BOARD_START + 2)
+#define IRQ_LOCOMO_SPI		(IRQ_BOARD_START + 3)
 
 /* phyCORE-PXA270 (PCM027) Interrupts */
 #define PCM027_IRQ(x)          (IRQ_BOARD_START + (x))
diff --git a/arch/arm/mach-sa1100/include/mach/irqs.h b/arch/arm/mach-sa1100/include/mach/irqs.h
index ae81f80..a8dc68e 100644
--- a/arch/arm/mach-sa1100/include/mach/irqs.h
+++ b/arch/arm/mach-sa1100/include/mach/irqs.h
@@ -120,30 +120,6 @@
 #define IRQ_S0_BVD1_STSCHG	(IRQ_BOARD_END + 53)
 #define IRQ_S1_BVD1_STSCHG	(IRQ_BOARD_END + 54)
 
-#define IRQ_LOCOMO_START	(IRQ_BOARD_END)
-#define IRQ_LOCOMO_KEY		(IRQ_BOARD_END + 0)
-#define IRQ_LOCOMO_GPIO0	(IRQ_BOARD_END + 1)
-#define IRQ_LOCOMO_GPIO1	(IRQ_BOARD_END + 2)
-#define IRQ_LOCOMO_GPIO2	(IRQ_BOARD_END + 3)
-#define IRQ_LOCOMO_GPIO3	(IRQ_BOARD_END + 4)
-#define IRQ_LOCOMO_GPIO4	(IRQ_BOARD_END + 5)
-#define IRQ_LOCOMO_GPIO5	(IRQ_BOARD_END + 6)
-#define IRQ_LOCOMO_GPIO6	(IRQ_BOARD_END + 7)
-#define IRQ_LOCOMO_GPIO7	(IRQ_BOARD_END + 8)
-#define IRQ_LOCOMO_GPIO8	(IRQ_BOARD_END + 9)
-#define IRQ_LOCOMO_GPIO9	(IRQ_BOARD_END + 10)
-#define IRQ_LOCOMO_GPIO10	(IRQ_BOARD_END + 11)
-#define IRQ_LOCOMO_GPIO11	(IRQ_BOARD_END + 12)
-#define IRQ_LOCOMO_GPIO12	(IRQ_BOARD_END + 13)
-#define IRQ_LOCOMO_GPIO13	(IRQ_BOARD_END + 14)
-#define IRQ_LOCOMO_GPIO14	(IRQ_BOARD_END + 15)
-#define IRQ_LOCOMO_GPIO15	(IRQ_BOARD_END + 16)
-#define IRQ_LOCOMO_LT		(IRQ_BOARD_END + 17)
-#define IRQ_LOCOMO_SPI_RFR	(IRQ_BOARD_END + 18)
-#define IRQ_LOCOMO_SPI_RFW	(IRQ_BOARD_END + 19)
-#define IRQ_LOCOMO_SPI_REND	(IRQ_BOARD_END + 20)
-#define IRQ_LOCOMO_SPI_TEND	(IRQ_BOARD_END + 21)
-
 /*
  * Figure out the MAX IRQ number.
  *
@@ -153,8 +129,8 @@
  */
 #ifdef CONFIG_SA1111
 #define NR_IRQS			(IRQ_S1_BVD1_STSCHG + 1)
-#elif defined(CONFIG_SHARP_LOCOMO)
-#define NR_IRQS			(IRQ_LOCOMO_SPI_TEND + 1)
+#elif CONFIG_SHARPSL_LOCOMO
+#define NR_IRQS			(IRQ_LOCOMO_SPI + 1)
 #else
 #define NR_IRQS			(IRQ_BOARD_START)
 #endif
@@ -168,8 +144,8 @@
 #define IRQ_NEPONSET_SA1111	(IRQ_BOARD_START + 2)
 
 /* LoCoMo Interrupts (CONFIG_SHARP_LOCOMO) */
-#define IRQ_LOCOMO_KEY_BASE	(IRQ_BOARD_START + 0)
-#define IRQ_LOCOMO_GPIO_BASE	(IRQ_BOARD_START + 1)
-#define IRQ_LOCOMO_LT_BASE	(IRQ_BOARD_START + 2)
-#define IRQ_LOCOMO_SPI_BASE	(IRQ_BOARD_START + 3)
+#define IRQ_LOCOMO_KEY		(IRQ_BOARD_START + 0)
+#define IRQ_LOCOMO_GPIO		(IRQ_BOARD_START + 1)
+#define IRQ_LOCOMO_LT		(IRQ_BOARD_START + 2)
+#define IRQ_LOCOMO_SPI		(IRQ_BOARD_START + 3)
 
-- 
1.6.3.3
