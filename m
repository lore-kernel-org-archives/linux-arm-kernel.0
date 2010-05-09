From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sun, 9 May 2010 12:29:17 +0300
Subject: [PATCH v7 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <AANLkTimZywbu5KVvnUouLUoY1GUxWGlYoSgIbUlRDT5w@mail.gmail.com>
References: <cover.1273120206.git.mika.westerberg@iki.fi>
	<3729cd3650f5af6aebfc5bae02ff6aad1b9b1e82.1273120206.git.mika.westerberg@iki.fi>
	<AANLkTimZywbu5KVvnUouLUoY1GUxWGlYoSgIbUlRDT5w@mail.gmail.com>
Message-ID: <20100509092917.GR26418@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 08, 2010 at 06:32:47PM +0100, Martin Guy wrote:
> On 5/6/10, Mika Westerberg <mika.westerberg@iki.fi> wrote:
> > This patch adds an SPI master driver for the Cirrus EP93xx SPI controller found
> >  in EP93xx chips.
> 
>    I'm confused by the change in this version of the structure of the
> board setup code.

Yeah. We changed it to support also other than built-in GPIOs.

>    Can you post example patches for the board definitions of the
> ts72xx and maybe also the Sim.One?

Sample code for TS-7260 can be found Documentation/spi/ep93xx_spi
(which comes with the first patch).

For Sim.One, I modified your patches a bit and resulting patch is
included. Note that I have hooked EGPIO9 as a chip select but in
normal case (SFRMOUT) you can just do following (leave .controller_data
as NULL):

static struct spi_board_info simone_spi_devices[] __initdata = {
	{
		.modalias		= "mmc_spi",
		.platform_data		= &simone_mmc_spi_data,
		/*
		* We use 10 MHz even though the maximum is 3.7 MHz. The driver
		* will limit it automatically to max. frequency.
		*/
		.max_speed_hz		= 10 * 1000 * 1000,
		.bus_num		= 0,
		.chip_select		= 0,
		.mode			= SPI_MODE_0,
	},
};

Regards,
MW

>From 04034329d0442b4a4b30f83fa0bdbd28cf65362f Mon Sep 17 00:00:00 2001
From: Mika Westerberg <mika.westerberg@iki.fi>
Date: Wed, 28 Apr 2010 08:42:46 +0300
Subject: [PATCH] ep93xx: simone: added board specific SPI support for MMC/SD cards

This includes setting up EGPIOs 0 and 9 for card detection and chip select
respectively.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 arch/arm/mach-ep93xx/simone.c |  126 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 126 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index cd93990..b102150 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -18,13 +18,17 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/mmc/host.h>
 #include <linux/mtd/physmap.h>
 #include <linux/gpio.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/mmc_spi.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
 
 #include <mach/hardware.h>
 #include <mach/fb.h>
+#include <mach/ep93xx_spi.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -59,6 +63,126 @@ static struct ep93xxfb_mach_info simone_fb_info = {
 	.flags		= EP93XXFB_USE_SDCSN0 | EP93XXFB_PCLK_FALLING,
 };
 
+/*
+ * GPIO lines used for MMC chip select and card detection.
+ */
+#define MMC_CARD_DETECT_GPIO EP93XX_GPIO_LINE_EGPIO0
+#define MMC_CHIP_SELECT_GPIO EP93XX_GPIO_LINE_EGPIO9
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
+		.mode			= SPI_MODE_0,
+	},
+};
+
+static struct ep93xx_spi_info simone_spi_info __initdata = {
+	.num_chipselect	= ARRAY_SIZE(simone_spi_devices),
+};
+
 static struct i2c_gpio_platform_data simone_i2c_gpio_data = {
 	.sda_pin		= EP93XX_GPIO_LINE_EEDAT,
 	.sda_is_open_drain	= 0,
@@ -83,6 +207,8 @@ static void __init simone_init_machine(void)
 	ep93xx_register_fb(&simone_fb_info);
 	ep93xx_register_i2c(&simone_i2c_gpio_data, simone_i2c_board_info,
 			    ARRAY_SIZE(simone_i2c_board_info));
+	ep93xx_register_spi(&simone_spi_info, simone_spi_devices,
+			    ARRAY_SIZE(simone_spi_devices));
 }
 
 MACHINE_START(SIM_ONE, "Simplemachines Sim.One Board")
-- 
1.5.6.5
