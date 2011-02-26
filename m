From: subaparts@yandex.ru (Alexander Sverdlin)
Date: Sat, 26 Feb 2011 10:43:01 +0300
Subject: [PATCH] EDB93xx: Add support for CS4271 SPI-connected CODEC
Message-ID: <1298706181.22098.8.camel@r60e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Sverdlin <subaparts@yandex.ru>

Add support for CS4271 SPI-connected CODEC to EDB93xx.
        
Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Acked-by: liam Girdwood <lrg@slimlogic.co.uk>

---
 arch/arm/mach-ep93xx/edb93xx.c |   83 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 3f37567..2c2f84d 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -30,9 +30,13 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
+#include <linux/spi/spi.h>
+
+#include <sound/cs4271.h>
 
 #include <mach/hardware.h>
 #include <mach/fb.h>
+#include <mach/ep93xx_spi.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -94,6 +98,83 @@ static void __init edb93xx_register_i2c(void)
 

 /*************************************************************************
+ * EDB93xx SPI peripheral handling
+ *************************************************************************/
+static struct cs4271_platform_data edb93xx_cs4271_data = {
+	.gpio_nreset	= -EINVAL,	/* filled in later */
+};
+
+static int edb93xx_cs4271_hw_setup(struct spi_device *spi)
+{
+	return gpio_request_one(EP93XX_GPIO_LINE_EGPIO6,
+				GPIOF_OUT_INIT_HIGH, spi->modalias);
+}
+
+static void edb93xx_cs4271_hw_cleanup(struct spi_device *spi)
+{
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
+		.platform_data		= &edb93xx_cs4271_data,
+		.controller_data	= &edb93xx_cs4271_hw,
+		.max_speed_hz		= 6000000,
+		.bus_num		= 0,
+		.chip_select		= 0,
+		.mode			= SPI_MODE_3,
+	},
+};
+
+static struct ep93xx_spi_info edb93xx_spi_info __initdata = {
+	.num_chipselect	= ARRAY_SIZE(edb93xx_spi_board_info),
+};
+
+static void __init edb93xx_register_spi(void)
+{
+	if (machine_is_edb9301() || machine_is_edb9302())
+		edb93xx_cs4271_data.gpio_nreset = EP93XX_GPIO_LINE_EGPIO1;
+	else if (machine_is_edb9302a() || machine_is_edb9307a())
+		edb93xx_cs4271_data.gpio_nreset = EP93XX_GPIO_LINE_H(2);
+	else if (machine_is_edb9315a())
+		edb93xx_cs4271_data.gpio_nreset = EP93XX_GPIO_LINE_EGPIO14;
+
+	ep93xx_register_spi(&edb93xx_spi_info, edb93xx_spi_board_info,
+			    ARRAY_SIZE(edb93xx_spi_board_info));
+}
+
+
+/*************************************************************************
+ * EDB93xx I2S
+ *************************************************************************/
+static int __init edb93xx_has_audio(void)
+{
+	return (machine_is_edb9301() || machine_is_edb9302() ||
+		machine_is_edb9302a() || machine_is_edb9307a() ||
+		machine_is_edb9315a());
+}
+
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
@@ -149,6 +230,8 @@ static void __init edb93xx_init_machine(void)
 	edb93xx_register_flash();
 	ep93xx_register_eth(&edb93xx_eth_data, 1);
 	edb93xx_register_i2c();
+	edb93xx_register_spi();
+	edb93xx_register_i2s();
 	edb93xx_register_pwm();
 	edb93xx_register_fb();
 }
