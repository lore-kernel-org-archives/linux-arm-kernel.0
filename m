From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 18 May 2010 12:38:40 +0200
Subject: [PATCH 02/11] ARM: S5PC100: Use common functions for gpiolib
	implementation
In-Reply-To: <1274179129-14659-1-git-send-email-m.szyprowski@samsung.com>
References: <1274179129-14659-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1274179129-14659-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIOlib helpers from plat-samsung already have functions for accessing
4bit gpio banks. This patch removes the duplicated functions from
plat-s5pc1xx/gpiolib.c.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-s5pc1xx/Kconfig   |    1 +
 arch/arm/plat-s5pc1xx/gpiolib.c |   96 ++++-----------------------------------
 2 files changed, 10 insertions(+), 87 deletions(-)

diff --git a/arch/arm/plat-s5pc1xx/Kconfig b/arch/arm/plat-s5pc1xx/Kconfig
index 79d3be7..98bbaf9 100644
--- a/arch/arm/plat-s5pc1xx/Kconfig
+++ b/arch/arm/plat-s5pc1xx/Kconfig
@@ -19,6 +19,7 @@ config PLAT_S5PC1XX
 	select S5P_GPIO_DRVSTR
 	select S3C_GPIO_CFG_S3C24XX
 	select S3C_GPIO_CFG_S3C64XX
+	select SAMSUNG_GPIOLIB_4BIT
 	help
 	  Base platform code for any Samsung S5PC1XX device
 
diff --git a/arch/arm/plat-s5pc1xx/gpiolib.c b/arch/arm/plat-s5pc1xx/gpiolib.c
index 1ffc57a..5a97a8f 100644
--- a/arch/arm/plat-s5pc1xx/gpiolib.c
+++ b/arch/arm/plat-s5pc1xx/gpiolib.c
@@ -61,74 +61,6 @@
  * L3	8	4Bit	None
  */
 
-#define OFF_GPCON	(0x00)
-#define OFF_GPDAT	(0x04)
-
-#define con_4bit_shift(__off) ((__off) * 4)
-
-#if 1
-#define gpio_dbg(x...) do { } while (0)
-#else
-#define gpio_dbg(x...) printk(KERN_DEBUG x)
-#endif
-
-/* The s5pc1xx_gpiolib routines are to control the gpio banks where
- * the gpio configuration register (GPxCON) has 4 bits per GPIO, as the
- * following example:
- *
- * base + 0x00: Control register, 4 bits per gpio
- *	        gpio n: 4 bits starting at (4*n)
- *		0000 = input, 0001 = output, others mean special-function
- * base + 0x04: Data register, 1 bit per gpio
- *		bit n: data bit n
- *
- * Note, since the data register is one bit per gpio and is at base + 0x4
- * we can use s3c_gpiolib_get and s3c_gpiolib_set to change the state of
- * the output.
- */
-
-static int s5pc1xx_gpiolib_input(struct gpio_chip *chip, unsigned offset)
-{
-	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
-	void __iomem *base = ourchip->base;
-	unsigned long con;
-
-	con = __raw_readl(base + OFF_GPCON);
-	con &= ~(0xf << con_4bit_shift(offset));
-	__raw_writel(con, base + OFF_GPCON);
-
-	gpio_dbg("%s: %p: CON now %08lx\n", __func__, base, con);
-
-	return 0;
-}
-
-static int s5pc1xx_gpiolib_output(struct gpio_chip *chip,
-				       unsigned offset, int value)
-{
-	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
-	void __iomem *base = ourchip->base;
-	unsigned long con;
-	unsigned long dat;
-
-	con = __raw_readl(base + OFF_GPCON);
-	con &= ~(0xf << con_4bit_shift(offset));
-	con |= 0x1 << con_4bit_shift(offset);
-
-	dat = __raw_readl(base + OFF_GPDAT);
-	if (value)
-		dat |= 1 << offset;
-	else
-		dat &= ~(1 << offset);
-
-	__raw_writel(dat, base + OFF_GPDAT);
-	__raw_writel(con, base + OFF_GPCON);
-	__raw_writel(dat, base + OFF_GPDAT);
-
-	gpio_dbg("%s: %p: CON %08lx, DAT %08lx\n", __func__, base, con, dat);
-
-	return 0;
-}
-
 static int s5pc1xx_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset)
 {
 	return S3C_IRQ_GPIO(chip->base + offset);
@@ -452,11 +384,8 @@ static struct s3c_gpio_chip s5pc100_gpio_chips[] = {
 extern struct irq_chip s5pc1xx_gpioint;
 extern void s5pc1xx_irq_gpioint_handler(unsigned int irq, struct irq_desc *desc);
 
-static __init void s5pc1xx_gpiolib_link(struct s3c_gpio_chip *chip)
+static __init void s5pc100_gpiolib_link(struct s3c_gpio_chip *chip)
 {
-	chip->chip.direction_input = s5pc1xx_gpiolib_input;
-	chip->chip.direction_output = s5pc1xx_gpiolib_output;
-	chip->pm = __gpio_pm(&s3c_gpio_pm_4bit);
 
 	/* Interrupt */
 	if (chip->config == &gpio_cfg) {
@@ -475,26 +404,19 @@ static __init void s5pc1xx_gpiolib_link(struct s3c_gpio_chip *chip)
 		chip->chip.to_irq = s5pc1xx_gpiolib_to_eint;
 }
 
-static __init void s5pc1xx_gpiolib_add(struct s3c_gpio_chip *chips,
-				       int nr_chips,
-				       void (*fn)(struct s3c_gpio_chip *))
-{
-	for (; nr_chips > 0; nr_chips--, chips++) {
-		if (fn)
-			(fn)(chips);
-		s3c_gpiolib_add(chips);
-	}
-}
-
 static __init int s5pc1xx_gpiolib_init(void)
 {
-	struct s3c_gpio_chip *chips;
+	struct s3c_gpio_chip *chip;
 	int nr_chips;
 
-		chips = s5pc100_gpio_chips;
-		nr_chips = ARRAY_SIZE(s5pc100_gpio_chips);
+	chip = s5pc100_gpio_chips;
+	nr_chips = ARRAY_SIZE(s5pc100_gpio_chips);
+
+	for (; nr_chips > 0; nr_chips--, chip++)
+		s5pc100_gpiolib_link(chip);
 
-	s5pc1xx_gpiolib_add(chips, nr_chips, s5pc1xx_gpiolib_link);
+	samsung_gpiolib_add_4bit_chips(s5pc100_gpio_chips,
+				       ARRAY_SIZE(s5pc100_gpio_chips));
 	/* Interrupt */
 	set_irq_chained_handler(IRQ_GPIOINT, s5pc1xx_irq_gpioint_handler);
 
-- 
1.6.4
