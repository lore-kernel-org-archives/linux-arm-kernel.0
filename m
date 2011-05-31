From: chris@techworks.ie (Christian Gagneraud)
Date: Tue, 31 May 2011 17:04:22 +0100
Subject: [PATCH RFC 2/3] AT91: SPI: Split SPI controller device and SPI device
In-Reply-To: <1306857863-13424-1-git-send-email-chris@techworks.ie>
References: <1306857863-13424-1-git-send-email-chris@techworks.ie>
Message-ID: <1306857863-13424-3-git-send-email-chris@techworks.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new atmel_spi_data structure to allow platform specific GPIO handling.
Make at91_add_device_spi(), a function to add a SPI controller device.
Plaform's SPI devices are now simply added by calling
spi_register_board_info() from the board file.

Signed-off-by: Christian Gagneraud <chris@techworks.ie>
---
 arch/arm/mach-at91/at91sam9260_devices.c |   60 ++++++++++++++----------------
 arch/arm/mach-at91/include/mach/board.h  |   11 +++++-
 2 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 07eb7b0..e34225f 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -545,7 +545,12 @@ static struct platform_device at91sam9260_spi0_device = {
 	.num_resources	= ARRAY_SIZE(spi0_resources),
 };
 
-static const unsigned spi0_standard_cs[4] = { AT91_PIN_PA3, AT91_PIN_PC11, AT91_PIN_PC16, AT91_PIN_PC17 };
+static struct gpio spi0_standard_cs_pins[] = {
+	{ .gpio = AT91_PIN_PA3,  },
+	{ .gpio = AT91_PIN_PC11, },
+	{ .gpio = AT91_PIN_PC16, },
+	{ .gpio = AT91_PIN_PC17, },
+};
 
 static struct resource spi1_resources[] = {
 	[0] = {
@@ -571,53 +576,44 @@ static struct platform_device at91sam9260_spi1_device = {
 	.num_resources	= ARRAY_SIZE(spi1_resources),
 };
 
-static const unsigned spi1_standard_cs[4] = { AT91_PIN_PB3, AT91_PIN_PC5, AT91_PIN_PC4, AT91_PIN_PC3 };
+static struct gpio spi1_standard_cs_pins[] = {
+	{ .gpio = AT91_PIN_PB3, },
+	{ .gpio = AT91_PIN_PC5, },
+	{ .gpio = AT91_PIN_PC4, },
+	{ .gpio = AT91_PIN_PC3, },
+};
 
-void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
+void __init at91_add_device_spi(struct atmel_spi_data *data)
 {
 	int i;
-	unsigned long cs_pin;
-	short enable_spi0 = 0;
-	short enable_spi1 = 0;
-
-	/* Choose SPI chip-selects */
-	for (i = 0; i < nr_devices; i++) {
-		if (devices[i].controller_data)
-			cs_pin = (unsigned long) devices[i].controller_data;
-		else if (devices[i].bus_num == 0)
-			cs_pin = spi0_standard_cs[devices[i].chip_select];
-		else
-			cs_pin = spi1_standard_cs[devices[i].chip_select];
-
-		if (devices[i].bus_num == 0)
-			enable_spi0 = 1;
-		else
-			enable_spi1 = 1;
-
-		/* enable chip-select pin */
-		at91_set_gpio_output(cs_pin, 1);
-
-		/* pass chip-select pin to driver */
-		devices[i].controller_data = (void *) cs_pin;
-	}
 
-	spi_register_board_info(devices, nr_devices);
+	if (data->bus_num == 0) {
+		/* enable chip-select pins */
+		if (!data->cs_pins)
+			data->cs_pins = spi0_standard_cs_pins;
+		for (i = 0; i < data->num_cs_pin; i++)
+			at91_set_gpio_output(data->cs_pins[i].gpio, 1);
 
-	/* Configure SPI bus(es) */
-	if (enable_spi0) {
 		at91_set_A_periph(AT91_PIN_PA0, 0);	/* SPI0_MISO */
 		at91_set_A_periph(AT91_PIN_PA1, 0);	/* SPI0_MOSI */
 		at91_set_A_periph(AT91_PIN_PA2, 0);	/* SPI1_SPCK */
 
 		at91_clock_associate("spi0_clk", &at91sam9260_spi0_device.dev, "spi_clk");
+		platform_set_drvdata(&at91sam9260_spi0_device, data);
 		platform_device_register(&at91sam9260_spi0_device);
-	}
-	if (enable_spi1) {
+	} else if (data->bus_num == 1) {
+		/* enable chip-select pins */
+		if (!data->cs_pins)
+			data->cs_pins = spi1_standard_cs_pins;
+		for (i = 0; i < data->num_cs_pin; i++)
+			at91_set_gpio_output(data->cs_pins[i].gpio, 1);
+
 		at91_set_A_periph(AT91_PIN_PB0, 0);	/* SPI1_MISO */
 		at91_set_A_periph(AT91_PIN_PB1, 0);	/* SPI1_MOSI */
 		at91_set_A_periph(AT91_PIN_PB2, 0);	/* SPI1_SPCK */
 
 		at91_clock_associate("spi1_clk", &at91sam9260_spi1_device.dev, "spi_clk");
+		platform_set_drvdata(&at91sam9260_spi1_device, data);
 		platform_device_register(&at91sam9260_spi1_device);
 	}
 }
diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index 2b499eb..d7cc95f 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -124,7 +124,16 @@ extern void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_de
 #endif
 
  /* SPI */
-extern void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices);
+struct atmel_spi_data {
+	unsigned	bus_num;
+	unsigned	num_cs_pin;
+	struct gpio	*cs_pins;
+	unsigned	flags;
+#define ATMEL_SPI_CS_DEC	0x01	/* The CS pins are decoded to
+					   (2^num_cs_pin)-1 logical CS
+					   lines */
+};
+extern void __init at91_add_device_spi(struct atmel_spi_data *data);
 
  /* Serial */
 #define ATMEL_UART_CTS	0x01
-- 
1.7.4.1
