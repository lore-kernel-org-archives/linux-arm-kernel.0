From: hsweeten@visionengravers.com (H Hartley Sweeten)
Date: Wed, 15 Feb 2017 09:22:53 -0700
Subject: [PATCH] ARM: ep93xx: simone: let the mmc_spi driver handle the card
 detect
Message-ID: <20170215162253.5410-1-hsweeten@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board uses a GPIO for the MMC card detect. Let the mmc_spi
driver handle it instead of the platform code.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ep93xx/simone.c | 54 +++----------------------------------------
 1 file changed, 3 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index 7bb540c..65ec16e 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -44,11 +44,6 @@ static struct ep93xxfb_mach_info __initdata simone_fb_info = {
 };
 
 /*
- * GPIO lines used for MMC card detection.
- */
-#define MMC_CARD_DETECT_GPIO EP93XX_GPIO_LINE_EGPIO0
-
-/*
  * Up to v1.3, the Sim.One used SFRMOUT as SD card chip select, but this goes
  * low between multi-message command blocks. From v1.4, it uses a GPIO instead.
  * v1.3 parts will still work, since the signal on SFRMOUT is automatic.
@@ -98,55 +93,12 @@ static struct ep93xx_spi_chip_ops simone_mmc_spi_ops = {
 	.cs_control	= simone_mmc_spi_cs_control,
 };
 
-/*
- * MMC card detection GPIO setup.
- */
-
-static int simone_mmc_spi_init(struct device *dev,
-	irqreturn_t (*irq_handler)(int, void *), void *mmc)
-{
-	unsigned int gpio = MMC_CARD_DETECT_GPIO;
-	int irq, err;
-
-	err = gpio_request(gpio, dev_name(dev));
-	if (err)
-		return err;
-
-	err = gpio_direction_input(gpio);
-	if (err)
-		goto fail;
-
-	irq = gpio_to_irq(gpio);
-	if (irq < 0)
-		goto fail;
-
-	err = request_irq(irq, irq_handler, IRQF_TRIGGER_FALLING,
-			  "MMC card detect", mmc);
-	if (err)
-		goto fail;
-
-	printk(KERN_INFO "%s: using irq %d for MMC card detection\n",
-	       dev_name(dev), irq);
-
-	return 0;
-fail:
-	gpio_free(gpio);
-	return err;
-}
-
-static void simone_mmc_spi_exit(struct device *dev, void *mmc)
-{
-	unsigned int gpio = MMC_CARD_DETECT_GPIO;
-
-	free_irq(gpio_to_irq(gpio), mmc);
-	gpio_free(gpio);
-}
-
 static struct mmc_spi_platform_data simone_mmc_spi_data = {
-	.init		= simone_mmc_spi_init,
-	.exit		= simone_mmc_spi_exit,
 	.detect_delay	= 500,
 	.ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34,
+	.flags		= MMC_SPI_USE_CD_GPIO,
+	.cd_gpio	= EP93XX_GPIO_LINE_EGPIO0,
+	.cd_debounce	= 1,
 };
 
 static struct spi_board_info simone_spi_devices[] __initdata = {
-- 
2.10.0
