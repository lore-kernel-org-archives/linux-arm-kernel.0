From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 11:42:25 +0100
Subject: [PATCH 11/17] ARM: pxa/raumfeld: add SPI controlled devices
In-Reply-To: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
Message-ID: <1259145751-3331-12-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-pxa/raumfeld.c |   87 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index d0c4eab..43a8195 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -30,6 +30,9 @@
 #include <linux/w1-gpio.h>
 #include <linux/sched.h>
 #include <linux/pwm_backlight.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_gpio.h>
+#include <linux/lis3lv02d.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -107,6 +110,11 @@ static mfp_cfg_t raumfeld_pin_config[] __initdata = {
 	/* USB Host */
 	GPIO0_2_USBH_PEN,
 	GPIO1_2_USBH_PWR,
+
+	/* SPI */
+	GPIO34_GPIO,	/* SPDIF_CS */
+	GPIO96_GPIO,	/* MCLK_CS */
+	GPIO125_GPIO,	/* ACCEL_CS */
 };
 
 /*
@@ -478,9 +486,85 @@ static void __init raumfeld_lcd_init(void)
 #endif
 }
 
+/**
+ * SPI devices
+ */
+
+struct spi_gpio_platform_data raumfeld_spi_platform_data = {
+	.sck		= mfp_to_gpio(GPIO_SPI_CLK),
+	.mosi		= mfp_to_gpio(GPIO_SPI_MOSI),
+	.miso		= mfp_to_gpio(GPIO_SPI_MISO),
+	.num_chipselect	= 3,
+};
+
+static struct platform_device raumfeld_spi_device = {
+	.name	= "spi_gpio",
+	.id	= 0,
+	.dev 	= {
+		.platform_data	= &raumfeld_spi_platform_data,
+	}
+};
+
+static struct lis3lv02d_platform_data lis3_pdata = {
+	.click_flags 	= LIS3_CLICK_SINGLE_X |
+			  LIS3_CLICK_SINGLE_Y |
+			  LIS3_CLICK_SINGLE_Z,
+	.irq_cfg	= LIS3_IRQ1_CLICK | LIS3_IRQ2_CLICK,
+	.wakeup_flags	= LIS3_WAKEUP_X_LO | LIS3_WAKEUP_X_HI |
+			  LIS3_WAKEUP_Y_LO | LIS3_WAKEUP_Y_HI |
+			  LIS3_WAKEUP_Z_LO | LIS3_WAKEUP_Z_HI,
+	.wakeup_thresh	= 10,
+	.click_thresh_x = 10,
+	.click_thresh_y = 10,
+	.click_thresh_z = 10,
+};
+
+#define SPI_AK4104	\
+{			\
+	.modalias	= "ak4104",	\
+	.max_speed_hz	= 10000,	\
+	.bus_num	= 0,		\
+	.chip_select	= 0,		\
+	.controller_data = (void *) mfp_to_gpio(GPIO_SPDIF_CS),	\
+}
+
+#define SPI_LIS3	\
+{			\
+	.modalias	= "lis3lv02d_spi",	\
+	.max_speed_hz	= 1000000,		\
+	.bus_num	= 0,			\
+	.chip_select	= 1,			\
+	.controller_data = (void *) mfp_to_gpio(GPIO_ACCEL_CS),	\
+	.platform_data	= &lis3_pdata,		\
+	.irq		= gpio_to_irq(mfp_to_gpio(GPIO_ACCEL_IRQ)),	\
+}
+
+#define SPI_DAC7512	\
+{	\
+	.modalias	= "dac7512",		\
+	.max_speed_hz	= 1000000,		\
+	.bus_num	= 0,			\
+	.chip_select	= 2,			\
+	.controller_data = (void *) mfp_to_gpio(GPIO_MCLK_DAC_CS),	\
+}
+
+static struct spi_board_info connector_spi_devices[] __initdata = {
+	SPI_AK4104,
+	SPI_DAC7512,
+};
+
+static struct spi_board_info speaker_spi_devices[] __initdata = {
+	SPI_DAC7512,
+};
+
+static struct spi_board_info controller_spi_devices[] __initdata = {
+	SPI_LIS3,
+};
+
 static struct platform_device *raumfeld_common_devices[] = {
 	&raumfeld_gpio_keys_device,
 	&raumfeld_led_device,
+	&raumfeld_spi_device,
 };
 
 static void __init raumfeld_common_init(void)
@@ -520,6 +604,7 @@ static void __init raumfeld_controller_init(void)
 	};
 
 	platform_add_devices(ARRAY_AND_SIZE(raumfeld_controller_devices));
+	spi_register_board_info(ARRAY_AND_SIZE(controller_spi_devices));
 
 	raumfeld_common_init();
 	raumfeld_lcd_init();
@@ -528,6 +613,7 @@ static void __init raumfeld_controller_init(void)
 
 static void __init raumfeld_connector_init(void)
 {
+	spi_register_board_info(ARRAY_AND_SIZE(connector_spi_devices));
 	raumfeld_common_init();
 	raumfeld_eth_init();
 }
@@ -539,6 +625,7 @@ static void __init raumfeld_speaker_init(void)
 	};
 
 	platform_add_devices(ARRAY_AND_SIZE(raumfeld_speaker_devices));
+	spi_register_board_info(ARRAY_AND_SIZE(speaker_spi_devices));
 
 	raumfeld_common_init();
 	raumfeld_eth_init();
-- 
1.6.5.2
