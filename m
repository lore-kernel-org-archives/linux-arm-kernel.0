From: pgsellmann@portner-elektronik.at (Peter Gsellmann)
Date: Mon, 17 Jan 2011 18:43:06 +0100
Subject: [PATCH] Board support Pcontrol_G20, hardware revision 2
Message-ID: <201101171843.07148.pgsellmann@portner-elektronik.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Backplane timings adjusted
 Addition of specific platform devices and resources
 Leds renamed
 Minor bugfixes

this patch should not influence any other hardware

Signed-off-by: Peter Gsellmann <pgsellmann@portner-elektronik.at>
---
 arch/arm/mach-at91/board-pcontrol-g20.c |  141 ++++++++++++++++++++++++++-----
 1 files changed, 119 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
index feb6578..42798af 100644
--- a/arch/arm/mach-at91/board-pcontrol-g20.c
+++ b/arch/arm/mach-at91/board-pcontrol-g20.c
@@ -26,6 +26,10 @@
 #include <linux/gpio.h>
 #include <linux/w1-gpio.h>

+#include <linux/input.h>
+#include <linux/uio_driver.h>
+#include <linux/mtd/plat-ram.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>

@@ -60,19 +64,22 @@ static void __init init_irq(void)
 }


-static struct sam9_smc_config __initdata pcontrol_smc_config[2] = { {
-	.ncs_read_setup		= 16,
-	.nrd_setup		= 18,
-	.ncs_write_setup	= 16,
-	.nwe_setup		= 18,
+/*
+ * Bus timings; unit = 7.57ns
+ */
+static struct sam9_smc_config __initdata pcontrol_smc_config[] = { {
+	.ncs_read_setup		= 0,
+	.nrd_setup		= 8,
+	.ncs_write_setup	= 0,
+	.nwe_setup		= 8,

 	.ncs_read_pulse		= 63,
-	.nrd_pulse		= 55,
+	.nrd_pulse		= 45,
 	.ncs_write_pulse	= 63,
-	.nwe_pulse		= 55,
+	.nwe_pulse		= 45,

-	.read_cycle		= 127,
-	.write_cycle		= 127,
+	.read_cycle		= 100,
+	.write_cycle		= 100,

 	.mode			= AT91_SMC_READMODE | AT91_SMC_WRITEMODE
 			| AT91_SMC_EXNWMODE_DISABLE | AT91_SMC_BAT_SELECT
@@ -100,15 +107,105 @@ static struct sam9_smc_config __initdata pcontrol_smc_config[2] = { {
 	.tdf_cycles		= 1,
 } };

+
+static struct resource pcontrol_resources[] = {
+	{
+		.start	= AT91_CHIPSELECT_4,
+		.end	= AT91_CHIPSELECT_4 + SZ_256M - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= AT91_CHIPSELECT_7,
+		.end	= AT91_CHIPSELECT_7 + SZ_256M - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= AT91_CHIPSELECT_4,
+		.end	= AT91_CHIPSELECT_4 + 0x800 - 1,
+		.name   = "bus51",
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= AT91_CHIPSELECT_4 + 0x800,
+		.end	= AT91_CHIPSELECT_4 + 0x900 - 1,
+		.name   = "lcd40x16bw",
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= AT91_CHIPSELECT_4 + 0x900,
+		.end	= AT91_CHIPSELECT_4 + 0xa00 - 1,
+		.name   = "kbd6x3+5",
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= AT91_CHIPSELECT_7,
+		.end	= AT91_CHIPSELECT_7 + SZ_512K - 1,
+		.name   = "ferroram",
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
+static struct uio_info uioconfig = {
+		.name = "pcontrol-uio",
+		.version = "1",
+};
+
+struct platdata_mtd_ram mtd_config = {
+		.mapname = "ferro",
+		.bankwidth = 2,
+};
+
+static struct platform_device pcontrol_devices[] = {
+	{
+		.name = "atmel_smc",
+		.id = 4,
+		.resource = &pcontrol_resources[0],
+		.num_resources	= 1,
+	}, {
+		.name = "atmel_smc",
+		.id = 7,
+		.resource = &pcontrol_resources[1],
+		.num_resources	= 1,
+	}, {
+		.name = "uio_pdrv",
+		.id = -1,
+		.resource = &pcontrol_resources[2],
+		.num_resources	= 1,
+		.dev = {
+				.platform_data = &uioconfig,
+		},
+	}, {
+		.name = "mtd-ram",
+		.id = -1,
+		.resource = &pcontrol_resources[5],
+		.num_resources	= 1,
+		.dev = {
+				.platform_data = &mtd_config,
+		},
+	}, {
+		.name = "lcd240x128",
+		.id = -1,
+		.resource = &pcontrol_resources[3],
+		.num_resources	= 2,
+	}
+};
+
 static void __init add_device_pcontrol(void)
 {
+	/* set write protect pin for eeprom 24LC64  D7 */
+	at91_set_GPIO_periph(AT91_PIN_PB24, 1);
+	at91_set_gpio_output(AT91_PIN_PB24, 1);
 	/* configure chip-select 4 (IO compatible to 8051  X4 ) */
 	sam9_smc_configure(4, &pcontrol_smc_config[0]);
+	at91_set_A_periph(AT91_PIN_PC8, 0);
+	platform_device_register(&pcontrol_devices[0]);
+	/* add subdevices */
+	platform_device_register(&pcontrol_devices[2]);
+	platform_device_register(&pcontrol_devices[4]);
+
 	/* configure chip-select 7 (FerroRAM 256KiBx16bit MR2A16A  D4 ) */
 	sam9_smc_configure(7, &pcontrol_smc_config[1]);
+	at91_set_B_periph(AT91_PIN_PC12, 0);
+	platform_device_register(&pcontrol_devices[1]);
+	/* add subdevices */
+	platform_device_register(&pcontrol_devices[3]);
 }

-
 /*
  * USB Host port
  */
@@ -122,7 +219,8 @@ static struct at91_usbh_data __initdata usbh_data = {
  */
 static struct at91_udc_data __initdata pcontrol_g20_udc_data = {
 	.vbus_pin	= AT91_PIN_PA22,	/* Detect +5V bus voltage */
-	.pullup_pin	= AT91_PIN_PA4,		/* K-state, active low */
+	.pullup_pin	= AT91_PIN_PA5,		/* K-state, active low */
+	.pullup_active_low = 1,
 };


@@ -130,7 +228,7 @@ static struct at91_udc_data __initdata pcontrol_g20_udc_data = {
  * MACB Ethernet device
  */
 static struct at91_eth_data __initdata macb_data = {
-	.phy_irq_pin	= AT91_PIN_PA28,
+	.phy_irq_pin	= AT91_PIN_PA26,
 	.is_rmii	= 1,
 };

@@ -151,46 +249,45 @@ static struct i2c_board_info __initdata pcontrol_g20_i2c_devices[] = {
  */
 static struct gpio_led pcontrol_g20_leds[] = {
 	{
-		.name			= "LED1",	/* red  H5 */
+		.name			= "pcontrol:red:H5",
 		.gpio			= AT91_PIN_PB18,
 		.active_low		= 1,
 		.default_trigger	= "none",	/* supervisor */
 	}, {
-		.name			= "LED2",	/* yellow  H7 */
+		.name			= "pcontrol:yellow:H7",
 		.gpio			= AT91_PIN_PB19,
 		.active_low		= 1,
 		.default_trigger	= "mmc0",	/* SD-card activity */
 	}, {
-		.name			= "LED3",	/* green  H2 */
+		.name			= "pcontrol:green:H2",
 		.gpio			= AT91_PIN_PB20,
 		.active_low		= 1,
 		.default_trigger	= "heartbeat",	/* blinky */
 	}, {
-		.name			= "LED4",	/* red  H3 */
+		.name			= "pcontrol:red:H3",
 		.gpio			= AT91_PIN_PC6,
 		.active_low		= 1,
 		.default_trigger	= "none",	/* connection lost */
 	}, {
-		.name			= "LED5",	/* yellow  H6 */
+		.name			= "pcontrol:yellow:H6",
 		.gpio			= AT91_PIN_PC7,
 		.active_low		= 1,
 		.default_trigger	= "none",	/* unsent data */
 	}, {
-		.name			= "LED6",	/* green  H1 */
+		.name			= "pcontrol:green:H1",
 		.gpio			= AT91_PIN_PC9,
 		.active_low		= 1,
 		.default_trigger	= "none",	/* snafu */
 	}
 };

-
 /*
  * SPI devices
  */
-static struct spi_board_info pcontrol_g20_spi_devices[] = {
+static struct spi_board_info __initdata pcontrol_g20_spi_devices[] = {
 	{
 		.modalias	= "spidev",	/* HMI port  X4 */
-		.chip_select	= 1,
+		.chip_select	= 0,
 		.max_speed_hz	= 50 * 1000 * 1000,
 		.bus_num	= 0,
 	}, {
@@ -216,7 +313,7 @@ static void __init pcontrol_g20_board_init(void)
 	at91_gpio_leds(pcontrol_g20_leds,
 		ARRAY_SIZE(pcontrol_g20_leds));
 	/* piggyback  A2 */
-	at91_set_gpio_output(AT91_PIN_PB31, 1);
+	at91_set_A_periph(AT91_PIN_PB30, 0);
 }


--
1.7.2.3
