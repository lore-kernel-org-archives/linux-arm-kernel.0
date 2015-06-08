From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  8 Jun 2015 15:22:39 +0200
Subject: [PATCH] ARM: ep93xx: simone: support for SPI-based MMC/SD cards
Message-ID: <1433769759-6414-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mika Westerberg <mika.westerberg@iki.fi>

This includes setting up EGPIOs 0 and 9 for card detection and
chip select respectively. This patch is needed to mount a root
filesystem on the SPI-based MMC card reader found on the Sim.One.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi ARM SoC guys,

please apply this patch directly to ARM SoC if you're OK
with it. It makes my Sim.One platform mount root successfully
from SD/MMC which is kind of a prerequisite for work that I need
to be doing to clean up this platform a bit.
---
 arch/arm/mach-ep93xx/simone.c | 135 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index 36f22c1a31fe..3c950f5864f3 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -20,9 +20,14 @@
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
+#include <linux/mmc/host.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/mmc_spi.h>
+#include <linux/platform_data/video-ep93xx.h>
+#include <linux/platform_data/spi-ep93xx.h>
+#include <linux/gpio.h>
 
 #include <mach/hardware.h>
-#include <linux/platform_data/video-ep93xx.h>
 #include <mach/gpio-ep93xx.h>
 
 #include <asm/mach-types.h>
@@ -40,6 +45,132 @@ static struct ep93xxfb_mach_info __initdata simone_fb_info = {
 	.flags		= EP93XXFB_USE_SDCSN0 | EP93XXFB_PCLK_FALLING,
 };
 
+/*
+ * GPIO lines used for MMC card detection.
+ */
+#define MMC_CARD_DETECT_GPIO EP93XX_GPIO_LINE_EGPIO0
+
+/*
+ * Up to v1.3, the Sim.One used SFRMOUT as SD card chip select, but this goes
+ * low between multi-message command blocks. From v1.4, it uses a GPIO instead.
+ * v1.3 parts will still work, since the signal on SFRMOUT is automatic.
+ */
+#define MMC_CHIP_SELECT_GPIO EP93XX_GPIO_LINE_EGPIO1
+
+/*
+ * MMC SPI chip select GPIO handling. If you are using SFRMOUT (SFRM1) signal,
+ * you can leave these empty and pass NULL as .controller_data.
+ */
+
+static int simone_mmc_spi_setup(struct spi_device *spi)
+{
+	unsigned int gpio = MMC_CHIP_SELECT_GPIO;
+	int err;
+
+	err = gpio_request(gpio, spi->modalias);
+	if (err)
+		return err;
+
+	err = gpio_direction_output(gpio, 1);
+	if (err) {
+		gpio_free(gpio);
+		return err;
+	}
+
+	return 0;
+}
+
+static void simone_mmc_spi_cleanup(struct spi_device *spi)
+{
+	unsigned int gpio = MMC_CHIP_SELECT_GPIO;
+
+	gpio_set_value(gpio, 1);
+	gpio_direction_input(gpio);
+	gpio_free(gpio);
+}
+
+static void simone_mmc_spi_cs_control(struct spi_device *spi, int value)
+{
+	gpio_set_value(MMC_CHIP_SELECT_GPIO, value);
+}
+
+static struct ep93xx_spi_chip_ops simone_mmc_spi_ops = {
+	.setup		= simone_mmc_spi_setup,
+	.cleanup	= simone_mmc_spi_cleanup,
+	.cs_control	= simone_mmc_spi_cs_control,
+};
+
+/*
+ * MMC card detection GPIO setup.
+ */
+
+static int simone_mmc_spi_init(struct device *dev,
+	irqreturn_t (*irq_handler)(int, void *), void *mmc)
+{
+	unsigned int gpio = MMC_CARD_DETECT_GPIO;
+	int irq, err;
+
+	err = gpio_request(gpio, dev_name(dev));
+	if (err)
+		return err;
+
+	err = gpio_direction_input(gpio);
+	if (err)
+		goto fail;
+
+	irq = gpio_to_irq(gpio);
+	if (irq < 0)
+		goto fail;
+
+	err = request_irq(irq, irq_handler, IRQF_TRIGGER_FALLING,
+			  "MMC card detect", mmc);
+	if (err)
+		goto fail;
+
+	printk(KERN_INFO "%s: using irq %d for MMC card detection\n",
+	       dev_name(dev), irq);
+
+	return 0;
+fail:
+	gpio_free(gpio);
+	return err;
+}
+
+static void simone_mmc_spi_exit(struct device *dev, void *mmc)
+{
+	unsigned int gpio = MMC_CARD_DETECT_GPIO;
+
+	free_irq(gpio_to_irq(gpio), mmc);
+	gpio_free(gpio);
+}
+
+static struct mmc_spi_platform_data simone_mmc_spi_data = {
+	.init		= simone_mmc_spi_init,
+	.exit		= simone_mmc_spi_exit,
+	.detect_delay	= 500,
+	.ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34,
+};
+
+static struct spi_board_info simone_spi_devices[] __initdata = {
+	{
+		.modalias		= "mmc_spi",
+		.controller_data	= &simone_mmc_spi_ops,
+		.platform_data		= &simone_mmc_spi_data,
+		/*
+		 * We use 10 MHz even though the maximum is 3.7 MHz. The driver
+		 * will limit it automatically to max. frequency.
+		 */
+		.max_speed_hz		= 10 * 1000 * 1000,
+		.bus_num		= 0,
+		.chip_select		= 0,
+		.mode			= SPI_MODE_3,
+	},
+};
+
+static struct ep93xx_spi_info simone_spi_info __initdata = {
+	.num_chipselect	= ARRAY_SIZE(simone_spi_devices),
+};
+
 static struct i2c_gpio_platform_data __initdata simone_i2c_gpio_data = {
 	.sda_pin		= EP93XX_GPIO_LINE_EEDAT,
 	.sda_is_open_drain	= 0,
@@ -74,6 +205,8 @@ static void __init simone_init_machine(void)
 	ep93xx_register_fb(&simone_fb_info);
 	ep93xx_register_i2c(&simone_i2c_gpio_data, simone_i2c_board_info,
 			    ARRAY_SIZE(simone_i2c_board_info));
+	ep93xx_register_spi(&simone_spi_info, simone_spi_devices,
+			    ARRAY_SIZE(simone_spi_devices));
 	simone_register_audio();
 }
 
-- 
1.9.3
