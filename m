From: chris@techworks.ie (Christian Gagneraud)
Date: Tue, 31 May 2011 17:04:23 +0100
Subject: [PATCH RFC 3/3] AT91: SPI: Add example of platform specific CS/GPIO
	usage
In-Reply-To: <1306857863-13424-1-git-send-email-chris@techworks.ie>
References: <1306857863-13424-1-git-send-email-chris@techworks.ie>
Message-ID: <1306857863-13424-4-git-send-email-chris@techworks.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As an example, I used this board to show how to use the CS decode feature.

Signed-off-by: Christian Gagneraud <chris@techworks.ie>
---
 arch/arm/mach-at91/board-stamp9g20.c |   62 ++++++++++++++++++++++++++++++++--
 1 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index f8902b1..8278927 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -211,6 +211,25 @@ static struct gpio_led stamp9g20evb_leds[] = {
 /*
  * SPI devices
  */
+static struct atmel_spi_data portuxg20_spi0_data = {
+	.bus_num	= 0,
+	.num_cs_pin	= 2
+};
+
+/* Use LEDs for demo purpose */
+static struct gpio portuxg20_spi1_cs_pins[] = {
+	{ .gpio = AT91_PIN_PC5  },
+	{ .gpio = AT91_PIN_PC4  },
+	{ .gpio = AT91_PIN_PC10 },
+};
+
+static struct atmel_spi_data portuxg20_spi1_data = {
+	.bus_num	= 1,
+	.num_cs_pin	= 3,
+	.cs_pins	= &portuxg20_spi1_cs_pins[0],
+	.flags		= ATMEL_SPI_CS_DEC
+};
+
 static struct spi_board_info portuxg20_spi_devices[] = {
 	{
 		.modalias	= "spidev",
@@ -219,7 +238,42 @@ static struct spi_board_info portuxg20_spi_devices[] = {
 		.bus_num	= 0,
 	}, {
 		.modalias	= "spidev",
-		.chip_select	= 0,
+		.chip_select	= 1,
+		.max_speed_hz	= 1 * 1000 * 1000,
+		.bus_num	= 0,
+	}, {
+		.modalias	= "spidev",
+		.chip_select	= 0x0,
+		.max_speed_hz	= 1 * 1000 * 1000,
+		.bus_num	= 1,
+	}, {
+		.modalias	= "spidev",
+		.chip_select	= 0x1,
+		.max_speed_hz	= 1 * 1000 * 1000,
+		.bus_num	= 1,
+	}, {
+		.modalias	= "spidev",
+		.chip_select	= 0x2,
+		.max_speed_hz	= 1 * 1000 * 1000,
+		.bus_num	= 1,
+	}, {
+		.modalias	= "spidev",
+		.chip_select	= 0x3,
+		.max_speed_hz	= 1 * 1000 * 1000,
+		.bus_num	= 1,
+	}, {
+		.modalias	= "spidev",
+		.chip_select	= 0x4,
+		.max_speed_hz	= 1 * 1000 * 1000,
+		.bus_num	= 1,
+	}, {
+		.modalias	= "spidev",
+		.chip_select	= 0x5,
+		.max_speed_hz	= 1 * 1000 * 1000,
+		.bus_num	= 1,
+	}, {
+		.modalias	= "spidev",
+		.chip_select	= 0x6,
 		.max_speed_hz	= 1 * 1000 * 1000,
 		.bus_num	= 1,
 	},
@@ -276,9 +330,11 @@ static void __init portuxg20_board_init(void)
 	/* I2C */
 	at91_add_device_i2c(NULL, 0);
 	/* SPI */
-	at91_add_device_spi(portuxg20_spi_devices, ARRAY_SIZE(portuxg20_spi_devices));
+	at91_add_device_spi(&portuxg20_spi0_data);
+	at91_add_device_spi(&portuxg20_spi1_data);
+	spi_register_board_info(portuxg20_spi_devices, ARRAY_SIZE(portuxg20_spi_devices));
 	/* LEDs */
-	at91_gpio_leds(portuxg20_leds, ARRAY_SIZE(portuxg20_leds));
+	/* at91_gpio_leds(portuxg20_leds, ARRAY_SIZE(portuxg20_leds)); */
 }
 
 static void __init stamp9g20evb_board_init(void)
-- 
1.7.4.1
