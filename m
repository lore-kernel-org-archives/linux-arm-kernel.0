From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Mon, 15 Mar 2010 18:26:09 +0200
Subject: [PATCH 0/3] spi: driver for Cirrus EP93xx SPI controller
Message-ID: <cover.1268669236.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series provides SPI master controller driver implementation for Cirrus
Logic EP93xx controllers.

I've tested this on my TS-7260 board with SPI EEPROM (through at25 driver) and
with few SD/MMC cards that I own (through mmc_spi driver). Unfortunately I don't
have other SPI devices so if someone wants to try this, it would be great
(see [1] for example code that I used with MMC cards).

This series applies on top of Linus' 2.6.34-rc1.

Please review.

Thanks,
MW

Mika Westerberg (3):
  spi: implemented driver for Cirrus EP93xx SPI controller
  ep93xx: added chip revision reading function
  ep93xx: SPI driver platform support code

 arch/arm/mach-ep93xx/clock.c                    |   21 +
 arch/arm/mach-ep93xx/core.c                     |   68 ++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h  |   34 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |   13 +
 drivers/spi/Kconfig                             |   11 +
 drivers/spi/Makefile                            |    1 +
 drivers/spi/ep93xx_spi.c                        | 1020 +++++++++++++++++++++++
 8 files changed, 1169 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h
 create mode 100644 drivers/spi/ep93xx_spi.c

---
[1] sample code for using SD cards with TS-7260:

diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index fac1ec7..425225a 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -14,11 +14,15 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/gpio.h>
 #include <linux/m48t86.h>
 #include <linux/mtd/physmap.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/eeprom.h>
 
 #include <mach/hardware.h>
 #include <mach/ts72xx.h>
+#include <mach/ep93xx_spi.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
@@ -190,6 +194,105 @@ static struct ep93xx_eth_data ts72xx_eth_data = {
 	.phy_id		= 1,
 };
 
+static const struct spi_board_info ts72xx_spi_devices[] __initconst = {
+	{
+		.modalias	= "mmc_spi",
+		.max_speed_hz	= 10 * 1000 * 1000,
+		.bus_num	= 0,
+		.chip_select	= 1,
+		.mode		= SPI_MODE_0,
+	},
+};
+
+/*
+ * Mapping of SPI chip selects to GPIO pins. In TS-72xx we have GPIO lines
+ * 8-15 wired into DIO1 header which can be used as chip selects.
+ */
+static const unsigned ts72xx_spi_chip_selects[] = {
+	[0] = EP93XX_GPIO_LINE_EGPIO8,
+	[1] = EP93XX_GPIO_LINE_EGPIO9,
+	/*
+	 * Add more here as needed.
+	 */
+};
+
+static inline unsigned cs_to_gpio(unsigned cs)
+{
+	BUG_ON(cs >= ARRAY_SIZE(ts72xx_spi_chip_selects));
+	return ts72xx_spi_chip_selects[cs];
+}
+
+static void ts72xx_spi_cs_control(unsigned cs, unsigned value, void *data)
+{
+	(void)data;
+	gpio_set_value(cs_to_gpio(cs), value);
+}
+
+static struct ep93xx_spi_info ts72xx_spi_info = {
+	.num_chipselect	= ARRAY_SIZE(ts72xx_spi_chip_selects),
+	.cs_control	= ts72xx_spi_cs_control,
+};
+
+/**
+ * ts72xx_init_spi() - initializes board SPI devices
+ *
+ * This function initializes all the SPI devices declared in ts72xx_spi_devices
+ * array. It also allocates GPIO line as chip selects for each device. Chip
+ * selects are declared in ts72xx_spi_chip_selects array.
+ */
+static void __init ts72xx_init_spi(void)
+{
+	unsigned gpio;
+	int i, err;
+
+	/*
+	 * Now go through all SPI peripherals that board wants to register
+	 * and acquire gpio for every chip select.
+	 */
+	for (i = 0; i < ARRAY_SIZE(ts72xx_spi_devices); i++) {
+		gpio = cs_to_gpio(ts72xx_spi_devices[i].chip_select);
+
+		err = gpio_request(gpio, "ep93xx-spi");
+		if (err) {
+			pr_err("failed to allocate GPIO%d\n", gpio);
+			goto fail;
+		}
+
+		/*
+		 * We default chip selects to be active low. This can be
+		 * changed by the protocol drivers passing SPI_CS_HIGH flag
+		 * to ep93xx-spi driver. The driver then changes the value
+		 * by using info->cs_control().
+		 */
+		err = gpio_direction_output(gpio, 1);
+		if (err) {
+			pr_err("failed to configure GPIO%d\n", gpio);
+			goto fail;
+		}
+	}
+
+	err = spi_register_board_info(ts72xx_spi_devices,
+				      ARRAY_SIZE(ts72xx_spi_devices));
+	if (err) {
+		pr_err("failed to register SPI devices\n");
+		goto fail;
+	}
+
+	err = ep93xx_register_spi(&ts72xx_spi_info);
+	if (err) {
+		pr_err("failed to register SPI platform device\n");
+		goto fail;
+	}
+
+	return;
+
+fail:
+	while (--i >= 0) {
+		gpio = cs_to_gpio(ts72xx_spi_devices[i].chip_select);
+		gpio_free(gpio);
+	}
+}
+
 static void __init ts72xx_init_machine(void)
 {
 	ep93xx_init_devices();
@@ -198,6 +301,7 @@ static void __init ts72xx_init_machine(void)
 	platform_device_register(&ts72xx_wdt_device);
 
 	ep93xx_register_eth(&ts72xx_eth_data, 1);
+	ts72xx_init_spi();
 }
 
 MACHINE_START(TS72XX, "Technologic Systems TS-72xx SBC")
