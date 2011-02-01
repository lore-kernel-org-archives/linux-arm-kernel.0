From: subaparts@yandex.ru (Alexander Sverdlin)
Date: Wed, 02 Feb 2011 02:40:53 +0300
Subject: [PATCH] EDB93xx: Add support for CS4271 CODEC on EDB93xx boards
Message-ID: <1296603653.1504.9.camel@r60e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Sverdlin <subaparts@yandex.ru>

Add support for CS4271 SPI-connected CODEC on EDB93xx boards.
Major rework based on code provided by H Hartley Sweeten <hsweeten@visionengravers.com>.
Tested on EDB9302, others (EDB9301, EDB9302A, EDB9307A, EDB0315A) should work.
        
Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
---
 arch/arm/mach-ep93xx/edb93xx.c |  117 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 117 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 4b04316..f20be96 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -30,12 +30,22 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
+#include <linux/spi/spi.h>
+#include <linux/delay.h>
+#include <mach/ep93xx_spi.h>
 
 #include <mach/hardware.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include <sound/cs4271.h>
+
+#define edb93xx_has_audio() (machine_is_edb9301() ||	\
+			     machine_is_edb9302() ||	\
+			     machine_is_edb9302a() ||	\
+			     machine_is_edb9307a() ||	\
+			     machine_is_edb9315a())
 
 static void __init edb93xx_register_flash(void)
 {
@@ -93,6 +103,111 @@ static void __init edb93xx_register_i2c(void)
 
 
 /*************************************************************************
+ * EDB93xx SPI peripheral handling
+ *************************************************************************/
+static int edb93xx_cs4271_hw_setup(struct spi_device *spi)
+{
+	int gpio_nreset;
+	int err;
+
+	if (machine_is_edb9301() || machine_is_edb9302()) {
+		gpio_nreset = EP93XX_GPIO_LINE_EGPIO1;
+	} else if (machine_is_edb9302a() || machine_is_edb9307a()) {
+		ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_HONIDE);
+		gpio_nreset = EP93XX_GPIO_LINE_DD2;
+	} else if (machine_is_edb9315a()) {
+		gpio_nreset = EP93XX_GPIO_LINE_EGPIO14;
+	} else {
+		return -EINVAL;
+	}
+
+	err = gpio_request(gpio_nreset, spi->modalias);
+	if (err)
+		return err;
+	err = gpio_request(EP93XX_GPIO_LINE_EGPIO6, spi->modalias);
+	if (err)
+		return err;
+
+	gpio_direction_output(EP93XX_GPIO_LINE_EGPIO6, 1);
+
+	/* Reset codec */
+	gpio_direction_output(gpio_nreset, 0);
+	udelay(1);
+	gpio_set_value(gpio_nreset, 1);
+	/* Give the codec time to wake up */
+	udelay(1);
+
+	return 0;
+}
+
+static void edb93xx_cs4271_hw_cleanup(struct spi_device *spi)
+{
+	int gpio_nreset;
+
+	if (machine_is_edb9301() || machine_is_edb9302())
+		gpio_nreset = EP93XX_GPIO_LINE_EGPIO1;
+	else if (machine_is_edb9302a() || machine_is_edb9307a())
+		gpio_nreset = EP93XX_GPIO_LINE_DD2;
+	else if (machine_is_edb9315a())
+		gpio_nreset = EP93XX_GPIO_LINE_EGPIO14;
+	else
+		return;
+
+	gpio_set_value(gpio_nreset, 0);
+	gpio_free(gpio_nreset);
+
+	gpio_set_value(EP93XX_GPIO_LINE_EGPIO6, 1);
+	gpio_free(EP93XX_GPIO_LINE_EGPIO6);
+}
+
+static void edb93xx_cs4271_hw_cs_control(struct spi_device *spi, int value)
+{
+	gpio_set_value(EP93XX_GPIO_LINE_EGPIO6, value);
+}
+
+static struct ep93xx_spi_chip_ops edb93xx_cs4271_hw = {
+	.setup		= edb93xx_cs4271_hw_setup,
+	.cleanup	= edb93xx_cs4271_hw_cleanup,
+	.cs_control	= edb93xx_cs4271_hw_cs_control,
+};
+
+static struct spi_board_info edb93xx_spi_board_info[] __initdata = {
+	{
+		.modalias		= "cs4271",
+		.controller_data	= &edb93xx_cs4271_hw,
+		.max_speed_hz		= 6000000,
+		.bus_num		= 0,
+		.chip_select		= 0,
+		.mode			= SPI_MODE_3,
+	},
+};
+
+static struct ep93xx_spi_info edb93xx_spi_info = {
+	.num_chipselect	= ARRAY_SIZE(edb93xx_spi_board_info),
+};
+
+static void __init edb93xx_register_spi(void)
+{
+	if (edb93xx_has_audio()) {
+		ep93xx_register_spi(&edb93xx_spi_info,
+				    edb93xx_spi_board_info,
+				    ARRAY_SIZE(edb93xx_spi_board_info));
+	}
+}
+
+
+/*************************************************************************
+ * EDB93xx I2S
+ *************************************************************************/
+static void __init edb93xx_register_i2s(void)
+{
+	if (edb93xx_has_audio()) {
+		ep93xx_register_i2s();
+	}
+}
+
+
+/*************************************************************************
  * EDB93xx pwm
  *************************************************************************/
 static void __init edb93xx_register_pwm(void)
@@ -117,6 +232,8 @@ static void __init edb93xx_init_machine(void)
 	edb93xx_register_flash();
 	ep93xx_register_eth(&edb93xx_eth_data, 1);
 	edb93xx_register_i2c();
+	edb93xx_register_spi();
+	edb93xx_register_i2s();
 	edb93xx_register_pwm();
 }
 
