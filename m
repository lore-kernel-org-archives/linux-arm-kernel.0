From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 10 Sep 2017 23:44:20 +0200
Subject: [PATCH 1/5] i2c: gpio: Convert to use descriptors
In-Reply-To: <20170910214424.14945-1-linus.walleij@linaro.org>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
Message-ID: <20170910214424.14945-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts the GPIO-based I2C-driver to using GPIO
descriptors instead of the old global numberspace-based
GPIO interface. We:

- Convert the driver to unconditionally grab two GPIOs
  from the device by index 0 (SDA) and 1 (SCL) which
  will work fine with device tree and descriptor tables.
  The existing device trees will continue to work just
  like before, but without any roundtrip through the
  global numberspace.

- Brutally convert all boardfiles still passing global
  GPIOs by registering descriptor tables associated with
  the devices instead so this driver does not need to keep
  supporting passing any GPIO numbers as platform data.

There is no stepwise approach as elegant as this, I
strongly prefer this big hammer over any antsteps for this
conversion. This way the old GPIO numbers go away and
NEVER COME BACK.

Special conversion for the different boards utilizing
I2C-GPIO:

- EP93xx (arch/arm/mach-ep93xx): pretty straight forward as
  all boards were using the same two GPIO lines, just define
  these two in a lookup table for "i2c-gpio" and register
  these along with the device. None of them define any
  other platform data so just pass NULL as platform data.
  This platform selects GPIOLIB so all should be smooth.
  The pins appear on a gpiochip for bank "G" as pins 1 (SDA)
  and 0 (SCL).

- IXP4 (arch/arm/mach-ixp4): descriptor tables have to
  be registered for each board separately. They all use
  "IXP4XX_GPIO_CHIP" so it is pretty straight forward.
  Most board define no other platform data than SCL/SDA
  so they can drop the #include of <linux/i2c-gpio.h> and
  assign NULL to platform data.

  The "goramo_mlr" (Goramo Multilink Router) board is a bit
  worrisome: it implements its own I2C bit-banging in the
  board file, and optionally registers an I2C serial port,
  but claims the same GPIO lines for itself in the board file.
  This is not going to work: there will be competition for the
  GPIO lines, so delete the optional extra I2C bus instead, no
  I2C devices are registered on it anyway, there are just hints
  that it may contain an EEPROM that may be accessed from
  userspace. This needs to be fixed up properly by the serial
  clock using I2C emulation so drop a note in the code.

- KS8695 board acs5k (arch/arm/mach-ks8695/board-acs5.c)
  has some platform data in addition to the pins so it needs to
  be kept around sans GPIO lines. Its GPIO chip is named
  "KS8695" and the arch selects GPIOLIB.

- PXA boards (arch/arm/mach-pxa/*) use some of the platform
  data so it needs to be preserved here. The viper board even
  registers two GPIO I2Cs. The gpiochip is named "gpio-pxa" and
  the arch selects GPIOLIB.

- SA1100 Simpad (arch/arm/mach-sa1100/simpad.c) defines a GPIO
  I2C bus, and the arch selects GPIOLIB.

- Blackfin boards (arch/blackfin/bf533 etc) for these I assume
  their I2C GPIOs refer to the local gpiochip defined in
  arch/blackfin/kernel/bfin_gpio.c names "BFIN-GPIO".
  The arch selects GPIOLIB. The boards get spiked with
  IF_ENABLED(I2C_GPIO) but that is a side effect of it
  being like that already (I would just have Kconfig select
  I2C_GPIO and get rid of them all.) I also delete any
  platform data set to 0 as it will get that value anyway
  from static declartions of platform data.

- The MIPS selects GPIOLIB and the Alchemy machine is using
  two local GPIO chips, one of them has a GPIO I2C. We need
  to adjust the local offset from the global number space here.
  The ATH79 has a proper GPIO driver in drivers/gpio/gpio-ath79.c
  and AFAICT the chip is named "ath79-gpio" and the PB44
  PCF857x expander spawns from this on GPIO 1 and 0. The latter
  board only use the platform data to specify pins so it can be
  cut altogether after this.

- The MFD Silicon Motion SM501 is a special case. It dynamically
  spawns an I2C bus off the MFD using sm501_create_subdev().
  We use an approach to dynamically create a machine descriptor
  table and attach this to the "SM501-LOW" or "SM501-HIGH"
  gpiochip. We use chip-local offsets to grab the right lines.
  We can get rid of two local static inline helpers as part
  of this refactoring.

Cc: arm at kernel.org
Cc: Steven Miao <realmz6@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: requesting ACK for Wolfram to take this patch.
Steven (Blackfin): requesting ACK for Wolfram to take this patch.
Ralf (MIPS): requesting ACK for Wolfram to take this patch.
Lee: requesting ACK for Wolfram to take this patch.
---
 arch/arm/mach-ep93xx/core.c                  |  39 ++++----
 arch/arm/mach-ep93xx/edb93xx.c               |  15 +--
 arch/arm/mach-ep93xx/include/mach/platform.h |   4 +-
 arch/arm/mach-ep93xx/simone.c                |  12 +--
 arch/arm/mach-ep93xx/snappercl15.c           |  12 +--
 arch/arm/mach-ep93xx/vision_ep9307.c         |   7 +-
 arch/arm/mach-ixp4xx/avila-setup.c           |  17 +++-
 arch/arm/mach-ixp4xx/dsmg600-setup.c         |  16 +++-
 arch/arm/mach-ixp4xx/fsg-setup.c             |  16 +++-
 arch/arm/mach-ixp4xx/goramo_mlr.c            |  24 ++---
 arch/arm/mach-ixp4xx/ixdp425-setup.c         |  16 +++-
 arch/arm/mach-ixp4xx/nas100d-setup.c         |  16 +++-
 arch/arm/mach-ixp4xx/nslu2-setup.c           |  16 +++-
 arch/arm/mach-ks8695/board-acs5k.c           |  13 ++-
 arch/arm/mach-pxa/palmz72.c                  |  12 ++-
 arch/arm/mach-pxa/viper.c                    |  27 +++++-
 arch/arm/mach-sa1100/simpad.c                |  12 ++-
 arch/blackfin/mach-bf533/boards/blackstamp.c |  19 +++-
 arch/blackfin/mach-bf533/boards/ezkit.c      |  18 +++-
 arch/blackfin/mach-bf533/boards/stamp.c      |  18 +++-
 arch/blackfin/mach-bf561/boards/ezkit.c      |  18 +++-
 arch/mips/alchemy/board-gpr.c                |  19 +++-
 arch/mips/ath79/mach-pb44.c                  |  16 +++-
 drivers/i2c/busses/i2c-gpio.c                | 134 +++++++++++++--------------
 drivers/mfd/sm501.c                          |  49 +++++-----
 include/linux/i2c-gpio.h                     |   4 -
 26 files changed, 327 insertions(+), 242 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index c393b1b0310d..6b4754ecaffc 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -31,7 +31,7 @@
 #include <linux/amba/serial.h>
 #include <linux/mtd/physmap.h>
 #include <linux/i2c.h>
-#include <linux/i2c-gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/spi/spi.h>
 #include <linux/export.h>
 #include <linux/irqchip/arm-vic.h>
@@ -320,42 +320,45 @@ void __init ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr)
 /*************************************************************************
  * EP93xx i2c peripheral handling
  *************************************************************************/
-static struct i2c_gpio_platform_data ep93xx_i2c_data;
+
+/* All EP93xx devices use the same two GPIO pins for I2C bit-banging */
+static struct gpiod_lookup_table ep93xx_i2c_gpiod_table = {
+	.dev_id		= "i2c-gpio",
+	.table		= {
+		/* Use local offsets on gpiochip/port "G" */
+		GPIO_LOOKUP_IDX("G", 1, NULL, 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("G", 0, NULL, 1, GPIO_ACTIVE_HIGH),
+	},
+};
 
 static struct platform_device ep93xx_i2c_device = {
 	.name		= "i2c-gpio",
 	.id		= 0,
 	.dev		= {
-		.platform_data	= &ep93xx_i2c_data,
+		.platform_data	= NULL,
 	},
 };
 
 /**
  * ep93xx_register_i2c - Register the i2c platform device.
- * @data:	platform specific i2c-gpio configuration (__initdata)
  * @devices:	platform specific i2c bus device information (__initdata)
  * @num:	the number of devices on the i2c bus
  */
-void __init ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
-				struct i2c_board_info *devices, int num)
+void __init ep93xx_register_i2c(struct i2c_board_info *devices, int num)
 {
 	/*
-	 * Set the EEPROM interface pin drive type control.
-	 * Defines the driver type for the EECLK and EEDAT pins as either
-	 * open drain, which will require an external pull-up, or a normal
-	 * CMOS driver.
+	 * FIXME: this just sets the two pins as non-opendrain, as no
+	 * platforms tries to do that anyway. Flag the applicable lines
+	 * as open drain in the GPIO_LOOKUP above and the driver or
+	 * gpiolib will handle open drain/open drain emulation as need
+	 * be. Right now i2c-gpio emulates open drain which is not
+	 * optimal.
 	 */
-	if (data->sda_is_open_drain && data->sda_pin != EP93XX_GPIO_LINE_EEDAT)
-		pr_warning("sda != EEDAT, open drain has no effect\n");
-	if (data->scl_is_open_drain && data->scl_pin != EP93XX_GPIO_LINE_EECLK)
-		pr_warning("scl != EECLK, open drain has no effect\n");
-
-	__raw_writel((data->sda_is_open_drain << 1) |
-		     (data->scl_is_open_drain << 0),
+	__raw_writel((0 << 1) | (0 << 0),
 		     EP93XX_GPIO_EEDRIVE);
 
-	ep93xx_i2c_data = *data;
 	i2c_register_board_info(0, devices, num);
+	gpiod_add_lookup_table(&ep93xx_i2c_gpiod_table);
 	platform_device_register(&ep93xx_i2c_device);
 }
 
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 0ac176386789..7e8f6f580fc3 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -28,7 +28,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
-#include <linux/i2c-gpio.h>
 #include <linux/spi/spi.h>
 
 #include <sound/cs4271.h>
@@ -61,14 +60,6 @@ static struct ep93xx_eth_data __initdata edb93xx_eth_data = {
 /*************************************************************************
  * EDB93xx i2c peripheral handling
  *************************************************************************/
-static struct i2c_gpio_platform_data __initdata edb93xx_i2c_gpio_data = {
-	.sda_pin		= EP93XX_GPIO_LINE_EEDAT,
-	.sda_is_open_drain	= 0,
-	.scl_pin		= EP93XX_GPIO_LINE_EECLK,
-	.scl_is_open_drain	= 0,
-	.udelay			= 0,	/* default to 100 kHz */
-	.timeout		= 0,	/* default to 100 ms */
-};
 
 static struct i2c_board_info __initdata edb93xxa_i2c_board_info[] = {
 	{
@@ -86,13 +77,11 @@ static void __init edb93xx_register_i2c(void)
 {
 	if (machine_is_edb9302a() || machine_is_edb9307a() ||
 	    machine_is_edb9315a()) {
-		ep93xx_register_i2c(&edb93xx_i2c_gpio_data,
-				    edb93xxa_i2c_board_info,
+		ep93xx_register_i2c(edb93xxa_i2c_board_info,
 				    ARRAY_SIZE(edb93xxa_i2c_board_info));
 	} else if (machine_is_edb9302() || machine_is_edb9307()
 		|| machine_is_edb9312() || machine_is_edb9315()) {
-		ep93xx_register_i2c(&edb93xx_i2c_gpio_data,
-				    edb93xx_i2c_board_info,
+		ep93xx_register_i2c(edb93xx_i2c_board_info,
 				    ARRAY_SIZE(edb93xx_i2c_board_info));
 	}
 }
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index 4c0bbd97f741..df2928aacf7c 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -7,7 +7,6 @@
 #include <linux/reboot.h>
 
 struct device;
-struct i2c_gpio_platform_data;
 struct i2c_board_info;
 struct spi_board_info;
 struct platform_device;
@@ -36,8 +35,7 @@ void ep93xx_register_flash(unsigned int width,
 			   resource_size_t start, resource_size_t size);
 
 void ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr);
-void ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
-			 struct i2c_board_info *devices, int num);
+void ep93xx_register_i2c(struct i2c_board_info *devices, int num);
 void ep93xx_register_spi(struct ep93xx_spi_info *info,
 			 struct spi_board_info *devices, int num);
 void ep93xx_register_fb(struct ep93xxfb_mach_info *data);
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index c7a40f245892..e61f3dee24c2 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -19,7 +19,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
-#include <linux/i2c-gpio.h>
 #include <linux/mmc/host.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/mmc_spi.h>
@@ -129,15 +128,6 @@ static struct ep93xx_spi_info simone_spi_info __initdata = {
 	.use_dma = 1,
 };
 
-static struct i2c_gpio_platform_data __initdata simone_i2c_gpio_data = {
-	.sda_pin		= EP93XX_GPIO_LINE_EEDAT,
-	.sda_is_open_drain	= 0,
-	.scl_pin		= EP93XX_GPIO_LINE_EECLK,
-	.scl_is_open_drain	= 0,
-	.udelay			= 0,
-	.timeout		= 0,
-};
-
 static struct i2c_board_info __initdata simone_i2c_board_info[] = {
 	{
 		I2C_BOARD_INFO("ds1337", 0x68),
@@ -161,7 +151,7 @@ static void __init simone_init_machine(void)
 	ep93xx_register_flash(2, EP93XX_CS6_PHYS_BASE, SZ_8M);
 	ep93xx_register_eth(&simone_eth_data, 1);
 	ep93xx_register_fb(&simone_fb_info);
-	ep93xx_register_i2c(&simone_i2c_gpio_data, simone_i2c_board_info,
+	ep93xx_register_i2c(simone_i2c_board_info,
 			    ARRAY_SIZE(simone_i2c_board_info));
 	ep93xx_register_spi(&simone_spi_info, simone_spi_devices,
 			    ARRAY_SIZE(simone_spi_devices));
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index b2db791b3b38..eeab863b60ca 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -21,7 +21,6 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/i2c.h>
-#include <linux/i2c-gpio.h>
 #include <linux/fb.h>
 
 #include <linux/mtd/partitions.h>
@@ -127,15 +126,6 @@ static struct ep93xx_eth_data __initdata snappercl15_eth_data = {
 	.phy_id			= 1,
 };
 
-static struct i2c_gpio_platform_data __initdata snappercl15_i2c_gpio_data = {
-	.sda_pin		= EP93XX_GPIO_LINE_EEDAT,
-	.sda_is_open_drain	= 0,
-	.scl_pin		= EP93XX_GPIO_LINE_EECLK,
-	.scl_is_open_drain	= 0,
-	.udelay			= 0,
-	.timeout		= 0,
-};
-
 static struct i2c_board_info __initdata snappercl15_i2c_data[] = {
 	{
 		/* Audio codec */
@@ -161,7 +151,7 @@ static void __init snappercl15_init_machine(void)
 {
 	ep93xx_init_devices();
 	ep93xx_register_eth(&snappercl15_eth_data, 1);
-	ep93xx_register_i2c(&snappercl15_i2c_gpio_data, snappercl15_i2c_data,
+	ep93xx_register_i2c(snappercl15_i2c_data,
 			    ARRAY_SIZE(snappercl15_i2c_data));
 	ep93xx_register_fb(&snappercl15_fb_info);
 	snappercl15_register_audio();
diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
index 1daf9441058c..5a0b6187990a 100644
--- a/arch/arm/mach-ep93xx/vision_ep9307.c
+++ b/arch/arm/mach-ep93xx/vision_ep9307.c
@@ -22,7 +22,6 @@
 #include <linux/io.h>
 #include <linux/mtd/partitions.h>
 #include <linux/i2c.h>
-#include <linux/i2c-gpio.h>
 #include <linux/platform_data/pca953x.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
@@ -144,10 +143,6 @@ static struct pca953x_platform_data pca953x_77_gpio_data = {
 /*************************************************************************
  * I2C Bus
  *************************************************************************/
-static struct i2c_gpio_platform_data vision_i2c_gpio_data __initdata = {
-	.sda_pin		= EP93XX_GPIO_LINE_EEDAT,
-	.scl_pin		= EP93XX_GPIO_LINE_EECLK,
-};
 
 static struct i2c_board_info vision_i2c_info[] __initdata = {
 	{
@@ -289,7 +284,7 @@ static void __init vision_init_machine(void)
 
 	vision_i2c_info[1].irq = gpio_to_irq(EP93XX_GPIO_LINE_F(7));
 
-	ep93xx_register_i2c(&vision_i2c_gpio_data, vision_i2c_info,
+	ep93xx_register_i2c(vision_i2c_info,
 				ARRAY_SIZE(vision_i2c_info));
 	ep93xx_register_spi(&vision_spi_master, vision_spi_board_info,
 				ARRAY_SIZE(vision_spi_board_info));
diff --git a/arch/arm/mach-ixp4xx/avila-setup.c b/arch/arm/mach-ixp4xx/avila-setup.c
index 6beec150c060..72122b5e7f28 100644
--- a/arch/arm/mach-ixp4xx/avila-setup.c
+++ b/arch/arm/mach-ixp4xx/avila-setup.c
@@ -17,7 +17,7 @@
 #include <linux/serial.h>
 #include <linux/tty.h>
 #include <linux/serial_8250.h>
-#include <linux/i2c-gpio.h>
+#include <linux/gpio/machine.h>
 #include <asm/types.h>
 #include <asm/setup.h>
 #include <asm/memory.h>
@@ -49,16 +49,21 @@ static struct platform_device avila_flash = {
 	.resource	= &avila_flash_resource,
 };
 
-static struct i2c_gpio_platform_data avila_i2c_gpio_data = {
-	.sda_pin	= AVILA_SDA_PIN,
-	.scl_pin	= AVILA_SCL_PIN,
+static struct gpiod_lookup_table avila_i2c_gpiod_table = {
+	.dev_id		= "i2c-gpio",
+	.table		= {
+		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", AVILA_SDA_PIN,
+				NULL, 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", AVILA_SCL_PIN,
+				NULL, 1, GPIO_ACTIVE_HIGH),
+	},
 };
 
 static struct platform_device avila_i2c_gpio = {
 	.name		= "i2c-gpio",
 	.id		= 0,
 	.dev	 = {
-		.platform_data	= &avila_i2c_gpio_data,
+		.platform_data	= NULL,
 	},
 };
 
@@ -147,6 +152,8 @@ static void __init avila_init(void)
 	avila_flash_resource.end =
 		IXP4XX_EXP_BUS_BASE(0) + ixp4xx_exp_bus_size - 1;
 
+	gpiod_add_lookup_table(&avila_i2c_gpiod_table);
+
 	platform_add_devices(avila_devices, ARRAY_SIZE(avila_devices));
 
 	avila_pata_resources[0].start = IXP4XX_EXP_BUS_BASE(1);
diff --git a/arch/arm/mach-ixp4xx/dsmg600-setup.c b/arch/arm/mach-ixp4xx/dsmg600-setup.c
index b3bd0e137f6d..68ccd669051b 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-setup.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-setup.c
@@ -25,7 +25,7 @@
 #include <linux/leds.h>
 #include <linux/reboot.h>
 #include <linux/i2c.h>
-#include <linux/i2c-gpio.h>
+#include <linux/gpio/machine.h>
 
 #include <mach/hardware.h>
 
@@ -68,16 +68,21 @@ static struct platform_device dsmg600_flash = {
 	.resource		= &dsmg600_flash_resource,
 };
 
-static struct i2c_gpio_platform_data dsmg600_i2c_gpio_data = {
-	.sda_pin		= DSMG600_SDA_PIN,
-	.scl_pin		= DSMG600_SCL_PIN,
+static struct gpiod_lookup_table dsmg600_i2c_gpiod_table = {
+	.dev_id		= "i2c-gpio",
+	.table		= {
+		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", DSMG600_SDA_PIN,
+				NULL, 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", DSMG600_SCL_PIN,
+				NULL, 1, GPIO_ACTIVE_HIGH),
+	},
 };
 
 static struct platform_device dsmg600_i2c_gpio = {
 	.name			= "i2c-gpio",
 	.id			= 0,
 	.dev	 = {
-		.platform_data	= &dsmg600_i2c_gpio_data,
+		.platform_data	= NULL,
 	},
 };
 
@@ -269,6 +274,7 @@ static void __init dsmg600_init(void)
 	dsmg600_flash_resource.end =
 		IXP4XX_EXP_BUS_BASE(0) + ixp4xx_exp_bus_size - 1;
 
+	gpiod_add_lookup_table(&dsmg600_i2c_gpiod_table);
 	i2c_register_board_info(0, dsmg600_i2c_board_info,
 				ARRAY_SIZE(dsmg600_i2c_board_info));
 
diff --git a/arch/arm/mach-ixp4xx/fsg-setup.c b/arch/arm/mach-ixp4xx/fsg-setup.c
index 5c4b0c4a1b37..a0350ad15175 100644
--- a/arch/arm/mach-ixp4xx/fsg-setup.c
+++ b/arch/arm/mach-ixp4xx/fsg-setup.c
@@ -22,7 +22,7 @@
 #include <linux/leds.h>
 #include <linux/reboot.h>
 #include <linux/i2c.h>
-#include <linux/i2c-gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/io.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -54,16 +54,21 @@ static struct platform_device fsg_flash = {
 	.resource		= &fsg_flash_resource,
 };
 
-static struct i2c_gpio_platform_data fsg_i2c_gpio_data = {
-	.sda_pin		= FSG_SDA_PIN,
-	.scl_pin		= FSG_SCL_PIN,
+static struct gpiod_lookup_table fsg_i2c_gpiod_table = {
+	.dev_id		= "i2c-gpio",
+	.table		= {
+		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", FSG_SDA_PIN,
+				NULL, 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", FSG_SCL_PIN,
+				NULL, 1, GPIO_ACTIVE_HIGH),
+	},
 };
 
 static struct platform_device fsg_i2c_gpio = {
 	.name			= "i2c-gpio",
 	.id			= 0,
 	.dev = {
-		.platform_data	= &fsg_i2c_gpio_data,
+		.platform_data	= NULL,
 	},
 };
 
@@ -196,6 +201,7 @@ static void __init fsg_init(void)
 	/* Configure CS2 for operation, 8bit and writable */
 	*IXP4XX_EXP_CS2 = 0xbfff0002;
 
+	gpiod_add_lookup_table(&fsg_i2c_gpiod_table);
 	i2c_register_board_info(0, fsg_i2c_board_info,
 				ARRAY_SIZE(fsg_i2c_board_info));
 
diff --git a/arch/arm/mach-ixp4xx/goramo_mlr.c b/arch/arm/mach-ixp4xx/goramo_mlr.c
index 80bd9d6d04de..f1529aa3f8e2 100644
--- a/arch/arm/mach-ixp4xx/goramo_mlr.c
+++ b/arch/arm/mach-ixp4xx/goramo_mlr.c
@@ -6,7 +6,6 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/hdlc.h>
-#include <linux/i2c-gpio.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
@@ -78,6 +77,12 @@
 static u32 hw_bits = 0xFFFFFFFD;    /* assume all hardware present */;
 static u8 control_value;
 
+/*
+ * FIXME: this is reimplementing I2C bit-bangining. Move this
+ * over to using driver/i2c/busses/i2c-gpio.c like all other boards
+ * and register proper I2C device(s) on the bus for this. (See
+ * other IXP4xx boards for examples.)
+ */
 static void set_scl(u8 value)
 {
 	gpio_set_value(GPIO_SCL, !!value);
@@ -216,20 +221,6 @@ static struct platform_device device_flash = {
 	.resource	= &flash_resource,
 };
 
-
-/* I^2C interface */
-static struct i2c_gpio_platform_data i2c_data = {
-	.sda_pin	= GPIO_SDA,
-	.scl_pin	= GPIO_SCL,
-};
-
-static struct platform_device device_i2c = {
-	.name		= "i2c-gpio",
-	.id		= 0,
-	.dev		= { .platform_data = &i2c_data },
-};
-
-
 /* IXP425 2 UART ports */
 static struct resource uart_resources[] = {
 	{
@@ -411,9 +402,6 @@ static void __init gmlr_init(void)
 	if (hw_bits & CFG_HW_HAS_HSS1)
 		device_tab[devices++] = &device_hss_tab[1]; /* max index 5 */
 
-	if (hw_bits & CFG_HW_HAS_EEPROM)
-		device_tab[devices++] = &device_i2c; /* max index 6 */
-
 	gpio_request(GPIO_SCL, "SCL/clock");
 	gpio_request(GPIO_SDA, "SDA/data");
 	gpio_request(GPIO_STR, "strobe");
diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index 508c2d7786e2..fd32ccde20c5 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -14,7 +14,7 @@
 #include <linux/serial.h>
 #include <linux/tty.h>
 #include <linux/serial_8250.h>
-#include <linux/i2c-gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/io.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
@@ -122,16 +122,21 @@ static struct platform_device ixdp425_flash_nand = {
 };
 #endif	/* CONFIG_MTD_NAND_PLATFORM */
 
-static struct i2c_gpio_platform_data ixdp425_i2c_gpio_data = {
-	.sda_pin	= IXDP425_SDA_PIN,
-	.scl_pin	= IXDP425_SCL_PIN,
+static struct gpiod_lookup_table ixdp425_i2c_gpiod_table = {
+	.dev_id		= "i2c-gpio",
+	.table		= {
+		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", IXDP425_SDA_PIN,
+				NULL, 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", IXDP425_SCL_PIN,
+				NULL, 1, GPIO_ACTIVE_HIGH),
+	},
 };
 
 static struct platform_device ixdp425_i2c_gpio = {
 	.name		= "i2c-gpio",
 	.id		= 0,
 	.dev	 = {
-		.platform_data	= &ixdp425_i2c_gpio_data,
+		.platform_data	= NULL,
 	},
 };
 
@@ -245,6 +250,7 @@ static void __init ixdp425_init(void)
 		ixdp425_uart_data[1].flags = 0;
 	}
 
+	gpiod_add_lookup_table(&ixdp425_i2c_gpiod_table);
 	platform_add_devices(ixdp425_devices, ARRAY_SIZE(ixdp425_devices));
 }
 
diff --git a/arch/arm/mach-ixp4xx/nas100d-setup.c b/arch/arm/mach-ixp4xx/nas100d-setup.c
index 4e0f762bc651..612ec8c63456 100644
--- a/arch/arm/mach-ixp4xx/nas100d-setup.c
+++ b/arch/arm/mach-ixp4xx/nas100d-setup.c
@@ -27,7 +27,7 @@
 #include <linux/leds.h>
 #include <linux/reboot.h>
 #include <linux/i2c.h>
-#include <linux/i2c-gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/io.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -100,16 +100,21 @@ static struct platform_device nas100d_leds = {
 	.dev.platform_data	= &nas100d_led_data,
 };
 
-static struct i2c_gpio_platform_data nas100d_i2c_gpio_data = {
-	.sda_pin		= NAS100D_SDA_PIN,
-	.scl_pin		= NAS100D_SCL_PIN,
+static struct gpiod_lookup_table nas100d_i2c_gpiod_table = {
+	.dev_id		= "i2c-gpio",
+	.table		= {
+		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", NAS100D_SDA_PIN,
+				NULL, 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", NAS100D_SCL_PIN,
+				NULL, 1, GPIO_ACTIVE_HIGH),
+	},
 };
 
 static struct platform_device nas100d_i2c_gpio = {
 	.name			= "i2c-gpio",
 	.id			= 0,
 	.dev	 = {
-		.platform_data	= &nas100d_i2c_gpio_data,
+		.platform_data	= NULL,
 	},
 };
 
@@ -280,6 +285,7 @@ static void __init nas100d_init(void)
 	nas100d_flash_resource.end =
 		IXP4XX_EXP_BUS_BASE(0) + ixp4xx_exp_bus_size - 1;
 
+	gpiod_add_lookup_table(&nas100d_i2c_gpiod_table);
 	i2c_register_board_info(0, nas100d_i2c_board_info,
 				ARRAY_SIZE(nas100d_i2c_board_info));
 
diff --git a/arch/arm/mach-ixp4xx/nslu2-setup.c b/arch/arm/mach-ixp4xx/nslu2-setup.c
index 88c025f52d8d..13afb03b50fa 100644
--- a/arch/arm/mach-ixp4xx/nslu2-setup.c
+++ b/arch/arm/mach-ixp4xx/nslu2-setup.c
@@ -24,7 +24,7 @@
 #include <linux/leds.h>
 #include <linux/reboot.h>
 #include <linux/i2c.h>
-#include <linux/i2c-gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/io.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -68,9 +68,14 @@ static struct platform_device nslu2_flash = {
 	.resource		= &nslu2_flash_resource,
 };
 
-static struct i2c_gpio_platform_data nslu2_i2c_gpio_data = {
-	.sda_pin		= NSLU2_SDA_PIN,
-	.scl_pin		= NSLU2_SCL_PIN,
+static struct gpiod_lookup_table nslu2_i2c_gpiod_table = {
+	.dev_id		= "i2c-gpio",
+	.table		= {
+		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", NSLU2_SDA_PIN,
+				NULL, 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", NSLU2_SCL_PIN,
+				NULL, 1, GPIO_ACTIVE_HIGH),
+	},
 };
 
 static struct i2c_board_info __initdata nslu2_i2c_board_info [] = {
@@ -115,7 +120,7 @@ static struct platform_device nslu2_i2c_gpio = {
 	.name			= "i2c-gpio",
 	.id			= 0,
 	.dev	 = {
-		.platform_data	= &nslu2_i2c_gpio_data,
+		.platform_data	= NULL,
 	},
 };
 
@@ -250,6 +255,7 @@ static void __init nslu2_init(void)
 	nslu2_flash_resource.end =
 		IXP4XX_EXP_BUS_BASE(0) + ixp4xx_exp_bus_size - 1;
 
+	gpiod_add_lookup_table(&nslu2_i2c_gpiod_table);
 	i2c_register_board_info(0, nslu2_i2c_board_info,
 				ARRAY_SIZE(nslu2_i2c_board_info));
 
diff --git a/arch/arm/mach-ks8695/board-acs5k.c b/arch/arm/mach-ks8695/board-acs5k.c
index e4d709c8ed32..f034724e01e1 100644
--- a/arch/arm/mach-ks8695/board-acs5k.c
+++ b/arch/arm/mach-ks8695/board-acs5k.c
@@ -16,7 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-
+#include <linux/gpio/machine.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 #include <linux/i2c-gpio.h>
@@ -38,9 +38,15 @@
 
 #include "generic.h"
 
+static struct gpiod_lookup_table acs5k_i2c_gpiod_table = {
+	.dev_id		= "i2c-gpio",
+	.table		= {
+		GPIO_LOOKUP_IDX("KS8695", 4, NULL, 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("KS8695", 5, NULL, 1, GPIO_ACTIVE_HIGH),
+	},
+};
+
 static struct i2c_gpio_platform_data acs5k_i2c_device_platdata = {
-	.sda_pin	= 4,
-	.scl_pin	= 5,
 	.udelay		= 10,
 };
 
@@ -95,6 +101,7 @@ static struct i2c_board_info acs5k_i2c_devs[] __initdata = {
 static void acs5k_i2c_init(void)
 {
 	/* The gpio interface */
+	gpiod_add_lookup_table(&acs5k_i2c_gpiod_table);
 	platform_device_register(&acs5k_i2c_device);
 	/* I2C devices */
 	i2c_register_board_info(0, acs5k_i2c_devs,
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index 29630061e700..94f75632c007 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -31,6 +31,7 @@
 #include <linux/power_supply.h>
 #include <linux/usb/gpio_vbus.h>
 #include <linux/i2c-gpio.h>
+#include <linux/gpio/machine.h>
 
 #include <asm/mach-types.h>
 #include <asm/suspend.h>
@@ -320,9 +321,15 @@ static struct soc_camera_link palmz72_iclink = {
 	.flags		= SOCAM_DATAWIDTH_8,
 };
 
+static struct gpiod_lookup_table palmz72_i2c_gpiod_table = {
+	.dev_id		= "i2c-gpio",
+	.table		= {
+		GPIO_LOOKUP_IDX("gpio-pxa", 118, NULL, 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-pxa", 117, NULL, 1, GPIO_ACTIVE_HIGH),
+	},
+};
+
 static struct i2c_gpio_platform_data palmz72_i2c_bus_data = {
-	.sda_pin	= 118,
-	.scl_pin	= 117,
 	.udelay		= 10,
 	.timeout	= 100,
 };
@@ -369,6 +376,7 @@ static void __init palmz72_camera_init(void)
 {
 	palmz72_cam_gpio_init();
 	pxa_set_camera_info(&palmz72_pxacamera_platform_data);
+	gpiod_add_lookup_table(&palmz72_i2c_gpiod_table);
 	platform_device_register(&palmz72_i2c_bus_device);
 	platform_device_register(&palmz72_camera);
 }
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 8e89d91b206b..a680742bee2b 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -36,6 +36,7 @@
 #include <linux/gpio.h>
 #include <linux/jiffies.h>
 #include <linux/i2c-gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/i2c/pxa-i2c.h>
 #include <linux/serial_8250.h>
 #include <linux/smc91x.h>
@@ -458,9 +459,17 @@ static struct platform_device smc91x_device = {
 };
 
 /* i2c */
+static struct gpiod_lookup_table viper_i2c_gpiod_table = {
+	.dev_id		= "i2c-gpio",
+	.table		= {
+		GPIO_LOOKUP_IDX("gpio-pxa", VIPER_RTC_I2C_SDA_GPIO,
+				NULL, 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-pxa", VIPER_RTC_I2C_SCL_GPIO,
+				NULL, 1, GPIO_ACTIVE_HIGH),
+	},
+};
+
 static struct i2c_gpio_platform_data i2c_bus_data = {
-	.sda_pin = VIPER_RTC_I2C_SDA_GPIO,
-	.scl_pin = VIPER_RTC_I2C_SCL_GPIO,
 	.udelay  = 10,
 	.timeout = HZ,
 };
@@ -779,12 +788,20 @@ static int __init viper_tpm_setup(char *str)
 
 __setup("tpm=", viper_tpm_setup);
 
+struct gpiod_lookup_table viper_tpm_i2c_gpiod_table = {
+	.dev_id = "i2c-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-pxa", VIPER_TPM_I2C_SDA_GPIO,
+				NULL, 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-pxa", VIPER_TPM_I2C_SCL_GPIO,
+				NULL, 1, GPIO_ACTIVE_HIGH),
+	},
+};
+
 static void __init viper_tpm_init(void)
 {
 	struct platform_device *tpm_device;
 	struct i2c_gpio_platform_data i2c_tpm_data = {
-		.sda_pin = VIPER_TPM_I2C_SDA_GPIO,
-		.scl_pin = VIPER_TPM_I2C_SCL_GPIO,
 		.udelay  = 10,
 		.timeout = HZ,
 	};
@@ -794,6 +811,7 @@ static void __init viper_tpm_init(void)
 	if (!viper_tpm)
 		return;
 
+	gpiod_add_lookup_table(&viper_tpm_i2c_gpiod_table);
 	tpm_device = platform_device_alloc("i2c-gpio", 2);
 	if (tpm_device) {
 		if (!platform_device_add_data(tpm_device,
@@ -943,6 +961,7 @@ static void __init viper_init(void)
 		smc91x_device.num_resources--;
 
 	pxa_set_i2c_info(NULL);
+	gpiod_add_lookup_table(&viper_i2c_gpiod_table);
 	pwm_add_table(viper_pwm_lookup, ARRAY_SIZE(viper_pwm_lookup));
 	platform_add_devices(viper_devs, ARRAY_SIZE(viper_devs));
 
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index bb3ca9c763de..c6e7e6d8733a 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -16,6 +16,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/io.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/machine.h>
 
 #include <mach/hardware.h>
 #include <asm/setup.h>
@@ -323,9 +324,15 @@ static struct platform_device simpad_gpio_leds = {
 /*
  * i2c
  */
+static struct gpiod_lookup_table simpad_i2c_gpiod_table = {
+	.dev_id = "i2c-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio", GPIO_GPIO21, NULL, 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio", GPIO_GPIO25, NULL, 1, GPIO_ACTIVE_HIGH),
+	},
+};
+
 static struct i2c_gpio_platform_data simpad_i2c_data = {
-	.sda_pin = GPIO_GPIO21,
-	.scl_pin = GPIO_GPIO25,
 	.udelay = 10,
 	.timeout = HZ,
 };
@@ -380,6 +387,7 @@ static int __init simpad_init(void)
 			      ARRAY_SIZE(simpad_flash_resources));
 	sa11x0_register_mcp(&simpad_mcp_data);
 
+	gpiod_add_lookup_table(&simpad_i2c_gpiod_table);
 	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	if(ret)
 		printk(KERN_WARNING "simpad: Unable to register mq200 framebuffer device");
diff --git a/arch/blackfin/mach-bf533/boards/blackstamp.c b/arch/blackfin/mach-bf533/boards/blackstamp.c
index 0ccf0cf4daaf..d801ca5ca6c4 100644
--- a/arch/blackfin/mach-bf533/boards/blackstamp.c
+++ b/arch/blackfin/mach-bf533/boards/blackstamp.c
@@ -22,6 +22,7 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
+#include <linux/gpio/machine.h>
 #include <asm/dma.h>
 #include <asm/bfin5xx_spi.h>
 #include <asm/portmux.h>
@@ -362,11 +363,17 @@ static struct platform_device bfin_device_gpiokeys = {
 #if IS_ENABLED(CONFIG_I2C_GPIO)
 #include <linux/i2c-gpio.h>
 
+static struct gpiod_lookup_table bfin_i2c_gpiod_table = {
+	.dev_id = "i2c-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX("BFIN-GPIO", GPIO_PF8, NULL, 0,
+				GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("BFIN-GPIO", GPIO_PF9, NULL, 1,
+				GPIO_ACTIVE_HIGH),
+	},
+};
+
 static struct i2c_gpio_platform_data i2c_gpio_data = {
-	.sda_pin		= GPIO_PF8,
-	.scl_pin		= GPIO_PF9,
-	.sda_is_open_drain	= 0,
-	.scl_is_open_drain	= 0,
 	.udelay			= 40,
 }; /* This hasn't actually been used these pins
     * are (currently) free pins on the expansion connector */
@@ -462,7 +469,9 @@ static int __init blackstamp_init(void)
 	int ret;
 
 	printk(KERN_INFO "%s(): registering device resources\n", __func__);
-
+#if IS_ENABLED(CONFIG_I2C_GPIO)
+	gpiod_add_lookup_table(&bfin_i2c_gpiod_table);
+#endif
 	i2c_register_board_info(0, bfin_i2c_board_info,
 				ARRAY_SIZE(bfin_i2c_board_info));
 
diff --git a/arch/blackfin/mach-bf533/boards/ezkit.c b/arch/blackfin/mach-bf533/boards/ezkit.c
index 3625e9eaa8a8..463a72358b0e 100644
--- a/arch/blackfin/mach-bf533/boards/ezkit.c
+++ b/arch/blackfin/mach-bf533/boards/ezkit.c
@@ -19,6 +19,7 @@
 #endif
 #include <linux/irq.h>
 #include <linux/i2c.h>
+#include <linux/gpio/machine.h>
 #include <asm/dma.h>
 #include <asm/bfin5xx_spi.h>
 #include <asm/portmux.h>
@@ -390,11 +391,17 @@ static struct platform_device bfin_device_gpiokeys = {
 #if IS_ENABLED(CONFIG_I2C_GPIO)
 #include <linux/i2c-gpio.h>
 
+static struct gpiod_lookup_table bfin_i2c_gpiod_table = {
+	.dev_id = "i2c-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX("BFIN-GPIO", GPIO_PF1, NULL, 0,
+				GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("BFIN-GPIO", GPIO_PF0, NULL, 1,
+				GPIO_ACTIVE_HIGH),
+	},
+};
+
 static struct i2c_gpio_platform_data i2c_gpio_data = {
-	.sda_pin		= GPIO_PF1,
-	.scl_pin		= GPIO_PF0,
-	.sda_is_open_drain	= 0,
-	.scl_is_open_drain	= 0,
 	.udelay			= 40,
 };
 
@@ -516,6 +523,9 @@ static struct platform_device *ezkit_devices[] __initdata = {
 static int __init ezkit_init(void)
 {
 	printk(KERN_INFO "%s(): registering device resources\n", __func__);
+#if IS_ENABLED(CONFIG_I2C_GPIO)
+	gpiod_add_lookup_table(&bfin_i2c_gpiod_table);
+#endif
 	platform_add_devices(ezkit_devices, ARRAY_SIZE(ezkit_devices));
 	spi_register_board_info(bfin_spi_board_info, ARRAY_SIZE(bfin_spi_board_info));
 	i2c_register_board_info(0, bfin_i2c_board_info,
diff --git a/arch/blackfin/mach-bf533/boards/stamp.c b/arch/blackfin/mach-bf533/boards/stamp.c
index 23eada79439c..d2479359adb7 100644
--- a/arch/blackfin/mach-bf533/boards/stamp.c
+++ b/arch/blackfin/mach-bf533/boards/stamp.c
@@ -21,6 +21,7 @@
 #include <linux/gpio.h>
 #include <linux/irq.h>
 #include <linux/i2c.h>
+#include <linux/gpio/machine.h>
 #include <asm/dma.h>
 #include <asm/bfin5xx_spi.h>
 #include <asm/reboot.h>
@@ -512,11 +513,17 @@ static struct platform_device bfin_device_gpiokeys = {
 #if IS_ENABLED(CONFIG_I2C_GPIO)
 #include <linux/i2c-gpio.h>
 
+static struct gpiod_lookup_table bfin_i2c_gpiod_table = {
+	.dev_id = "i2c-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX("BFIN-GPIO", GPIO_PF2, NULL, 0,
+				GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("BFIN-GPIO", GPIO_PF3, NULL, 1,
+				GPIO_ACTIVE_HIGH),
+	},
+};
+
 static struct i2c_gpio_platform_data i2c_gpio_data = {
-	.sda_pin		= GPIO_PF2,
-	.scl_pin		= GPIO_PF3,
-	.sda_is_open_drain	= 0,
-	.scl_is_open_drain	= 0,
 	.udelay			= 10,
 };
 
@@ -848,6 +855,9 @@ static int __init stamp_init(void)
 
 	printk(KERN_INFO "%s(): registering device resources\n", __func__);
 
+#if IS_ENABLED(CONFIG_I2C_GPIO)
+	gpiod_add_lookup_table(&bfin_i2c_gpiod_table);
+#endif
 	i2c_register_board_info(0, bfin_i2c_board_info,
 				ARRAY_SIZE(bfin_i2c_board_info));
 
diff --git a/arch/blackfin/mach-bf561/boards/ezkit.c b/arch/blackfin/mach-bf561/boards/ezkit.c
index 57d1c43726d9..72f757ebaa84 100644
--- a/arch/blackfin/mach-bf561/boards/ezkit.c
+++ b/arch/blackfin/mach-bf561/boards/ezkit.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
 #include <linux/delay.h>
+#include <linux/gpio/machine.h>
 #include <asm/dma.h>
 #include <asm/bfin5xx_spi.h>
 #include <asm/portmux.h>
@@ -379,11 +380,17 @@ static struct platform_device bfin_device_gpiokeys = {
 #if IS_ENABLED(CONFIG_I2C_GPIO)
 #include <linux/i2c-gpio.h>
 
+static struct gpiod_lookup_table bfin_i2c_gpiod_table = {
+	.dev_id = "i2c-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX("BFIN-GPIO", GPIO_PF1, NULL, 0,
+				GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("BFIN-GPIO", GPIO_PF0, NULL, 1,
+				GPIO_ACTIVE_HIGH),
+	},
+};
+
 static struct i2c_gpio_platform_data i2c_gpio_data = {
-	.sda_pin		= GPIO_PF1,
-	.scl_pin		= GPIO_PF0,
-	.sda_is_open_drain	= 0,
-	.scl_is_open_drain	= 0,
 	.udelay			= 10,
 };
 
@@ -633,6 +640,9 @@ static int __init ezkit_init(void)
 
 	printk(KERN_INFO "%s(): registering device resources\n", __func__);
 
+#if IS_ENABLED(CONFIG_I2C_GPIO)
+	gpiod_add_lookup_table(&bfin_i2c_gpiod_table);
+#endif
 	ret = platform_add_devices(ezkit_devices, ARRAY_SIZE(ezkit_devices));
 	if (ret < 0)
 		return ret;
diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
index 6fb6b3faa158..daebc36e5ecb 100644
--- a/arch/mips/alchemy/board-gpr.c
+++ b/arch/mips/alchemy/board-gpr.c
@@ -30,6 +30,7 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
+#include <linux/gpio/machine.h>
 #include <asm/bootinfo.h>
 #include <asm/idle.h>
 #include <asm/reboot.h>
@@ -218,10 +219,23 @@ static struct platform_device gpr_led_devices = {
 /*
  * I2C
  */
+static struct gpiod_lookup_table gpr_i2c_gpiod_table = {
+	.dev_id = "i2c-gpio",
+	.table = {
+		/*
+		 * This should be on "GPIO2" which has base at 200 so
+		 * the global numbers 209 and 210 should correspond to
+		 * local offsets 9 and 10.
+		 */
+		GPIO_LOOKUP_IDX("alchemy-gpio2", 9, NULL, 0,
+				GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("alchemy-gpio2", 10, NULL, 1,
+				GPIO_ACTIVE_HIGH),
+	},
+};
+
 static struct i2c_gpio_platform_data gpr_i2c_data = {
-	.sda_pin		= 209,
 	.sda_is_open_drain	= 1,
-	.scl_pin		= 210,
 	.scl_is_open_drain	= 1,
 	.udelay			= 2,		/* ~100 kHz */
 	.timeout		= HZ,
@@ -295,6 +309,7 @@ arch_initcall(gpr_pci_init);
 
 static int __init gpr_dev_init(void)
 {
+	gpiod_add_lookup_table(&gpr_i2c_gpiod_table);
 	i2c_register_board_info(0, gpr_i2c_info, ARRAY_SIZE(gpr_i2c_info));
 
 	return platform_add_devices(gpr_devices, ARRAY_SIZE(gpr_devices));
diff --git a/arch/mips/ath79/mach-pb44.c b/arch/mips/ath79/mach-pb44.c
index be78298dffb4..a95409063847 100644
--- a/arch/mips/ath79/mach-pb44.c
+++ b/arch/mips/ath79/mach-pb44.c
@@ -11,7 +11,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
-#include <linux/i2c-gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/platform_data/pcf857x.h>
 
 #include "machtypes.h"
@@ -33,16 +33,21 @@
 #define PB44_KEYS_POLL_INTERVAL		20	/* msecs */
 #define PB44_KEYS_DEBOUNCE_INTERVAL	(3 * PB44_KEYS_POLL_INTERVAL)
 
-static struct i2c_gpio_platform_data pb44_i2c_gpio_data = {
-	.sda_pin	= PB44_GPIO_I2C_SDA,
-	.scl_pin	= PB44_GPIO_I2C_SCL,
+static struct gpiod_lookup_table pb44_i2c_gpiod_table = {
+	.dev_id = "i2c-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX("ath79-gpio", PB44_GPIO_I2C_SDA,
+				NULL, 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("ath79-gpio", PB44_GPIO_I2C_SCL,
+				NULL, 1, GPIO_ACTIVE_HIGH),
+	},
 };
 
 static struct platform_device pb44_i2c_gpio_device = {
 	.name		= "i2c-gpio",
 	.id		= 0,
 	.dev = {
-		.platform_data	= &pb44_i2c_gpio_data,
+		.platform_data	= NULL,
 	}
 };
 
@@ -103,6 +108,7 @@ static struct ath79_spi_platform_data pb44_spi_data = {
 
 static void __init pb44_init(void)
 {
+	gpiod_add_lookup_table(&pb44_i2c_gpiod_table);
 	i2c_register_board_info(0, pb44_i2c_board_info,
 				ARRAY_SIZE(pb44_i2c_board_info));
 	platform_device_register(&pb44_i2c_gpio_device);
diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index 34cfc0ebdcb9..49e8b3ab30be 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -14,11 +14,12 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 
 struct i2c_gpio_private_data {
+	struct gpio_desc *sda;
+	struct gpio_desc *scl;
 	struct i2c_adapter adap;
 	struct i2c_algo_bit_data bit_data;
 	struct i2c_gpio_platform_data pdata;
@@ -27,12 +28,18 @@ struct i2c_gpio_private_data {
 /* Toggle SDA by changing the direction of the pin */
 static void i2c_gpio_setsda_dir(void *data, int state)
 {
-	struct i2c_gpio_platform_data *pdata = data;
-
+	struct i2c_gpio_private_data *priv = data;
+
+	/*
+	 * This is a way of saying "do not drive
+	 * me actively high" which means emulating open drain.
+	 * The right way to do this is for gpiolib to
+	 * handle this, by the function below.
+	 */
 	if (state)
-		gpio_direction_input(pdata->sda_pin);
+		gpiod_direction_input(priv->sda);
 	else
-		gpio_direction_output(pdata->sda_pin, 0);
+		gpiod_direction_output(priv->sda, 0);
 }
 
 /*
@@ -42,20 +49,20 @@ static void i2c_gpio_setsda_dir(void *data, int state)
  */
 static void i2c_gpio_setsda_val(void *data, int state)
 {
-	struct i2c_gpio_platform_data *pdata = data;
+	struct i2c_gpio_private_data *priv = data;
 
-	gpio_set_value(pdata->sda_pin, state);
+	gpiod_set_value(priv->sda, state);
 }
 
 /* Toggle SCL by changing the direction of the pin. */
 static void i2c_gpio_setscl_dir(void *data, int state)
 {
-	struct i2c_gpio_platform_data *pdata = data;
+	struct i2c_gpio_private_data *priv = data;
 
 	if (state)
-		gpio_direction_input(pdata->scl_pin);
+		gpiod_direction_input(priv->scl);
 	else
-		gpio_direction_output(pdata->scl_pin, 0);
+		gpiod_direction_output(priv->scl, 0);
 }
 
 /*
@@ -66,44 +73,23 @@ static void i2c_gpio_setscl_dir(void *data, int state)
  */
 static void i2c_gpio_setscl_val(void *data, int state)
 {
-	struct i2c_gpio_platform_data *pdata = data;
+	struct i2c_gpio_private_data *priv = data;
 
-	gpio_set_value(pdata->scl_pin, state);
+	gpiod_set_value(priv->scl, state);
 }
 
 static int i2c_gpio_getsda(void *data)
 {
-	struct i2c_gpio_platform_data *pdata = data;
+	struct i2c_gpio_private_data *priv = data;
 
-	return gpio_get_value(pdata->sda_pin);
+	return gpiod_get_value(priv->sda);
 }
 
 static int i2c_gpio_getscl(void *data)
 {
-	struct i2c_gpio_platform_data *pdata = data;
+	struct i2c_gpio_private_data *priv = data;
 
-	return gpio_get_value(pdata->scl_pin);
-}
-
-static int of_i2c_gpio_get_pins(struct device_node *np,
-				unsigned int *sda_pin, unsigned int *scl_pin)
-{
-	if (of_gpio_count(np) < 2)
-		return -ENODEV;
-
-	*sda_pin = of_get_gpio(np, 0);
-	*scl_pin = of_get_gpio(np, 1);
-
-	if (*sda_pin == -EPROBE_DEFER || *scl_pin == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-
-	if (!gpio_is_valid(*sda_pin) || !gpio_is_valid(*scl_pin)) {
-		pr_err("%s: invalid GPIO pins, sda=%d/scl=%d\n",
-		       np->full_name, *sda_pin, *scl_pin);
-		return -ENODEV;
-	}
-
-	return 0;
+	return gpiod_get_value(priv->scl);
 }
 
 static void of_i2c_gpio_get_props(struct device_node *np,
@@ -130,64 +116,65 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 	struct i2c_gpio_platform_data *pdata;
 	struct i2c_algo_bit_data *bit_data;
 	struct i2c_adapter *adap;
-	unsigned int sda_pin, scl_pin;
 	int ret;
 
-	/* First get the GPIO pins; if it fails, we'll defer the probe. */
-	if (pdev->dev.of_node) {
-		ret = of_i2c_gpio_get_pins(pdev->dev.of_node,
-					   &sda_pin, &scl_pin);
-		if (ret)
-			return ret;
-	} else {
-		if (!dev_get_platdata(&pdev->dev))
-			return -ENXIO;
-		pdata = dev_get_platdata(&pdev->dev);
-		sda_pin = pdata->sda_pin;
-		scl_pin = pdata->scl_pin;
-	}
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
 
-	ret = devm_gpio_request(&pdev->dev, sda_pin, "sda");
-	if (ret) {
+	/* First get the GPIO pins; if it fails, we'll defer the probe. */
+	priv->sda = devm_gpiod_get_index(&pdev->dev, NULL, 0, GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->sda)) {
+		ret = PTR_ERR(priv->sda);
+		/* FIXME: hack in the old code, is this really necessary? */
 		if (ret == -EINVAL)
-			ret = -EPROBE_DEFER;	/* Try again later */
+			ret = -EPROBE_DEFER;
 		return ret;
 	}
-	ret = devm_gpio_request(&pdev->dev, scl_pin, "scl");
-	if (ret) {
+	priv->scl = devm_gpiod_get_index(&pdev->dev, NULL, 1, GPIOD_OUT_LOW);
+	if (IS_ERR(priv->scl)) {
+		ret = PTR_ERR(priv->sda);
+		/* FIXME: hack in the old code, is this really necessary? */
 		if (ret == -EINVAL)
-			ret = -EPROBE_DEFER;	/* Try again later */
+			ret = -EPROBE_DEFER;
 		return ret;
 	}
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
 	adap = &priv->adap;
 	bit_data = &priv->bit_data;
 	pdata = &priv->pdata;
 
 	if (pdev->dev.of_node) {
-		pdata->sda_pin = sda_pin;
-		pdata->scl_pin = scl_pin;
 		of_i2c_gpio_get_props(pdev->dev.of_node, pdata);
 	} else {
-		memcpy(pdata, dev_get_platdata(&pdev->dev), sizeof(*pdata));
+		/*
+		 * If all platform data settings are zero it is OK
+		 * to not provide any platform data from the board.
+		 */
+		if (dev_get_platdata(&pdev->dev))
+			memcpy(pdata, dev_get_platdata(&pdev->dev),
+			       sizeof(*pdata));
 	}
 
+	/*
+	 * FIXME: this is a hack emulating the open drain emulation
+	 * that gpiolib can already do for us. Make all clients properly
+	 * flag their lines as open drain and get rid of this property
+	 * and the special callback.
+	 */
 	if (pdata->sda_is_open_drain) {
-		gpio_direction_output(pdata->sda_pin, 1);
+		gpiod_direction_output(priv->sda, 1);
 		bit_data->setsda = i2c_gpio_setsda_val;
 	} else {
-		gpio_direction_input(pdata->sda_pin);
+		gpiod_direction_input(priv->sda);
 		bit_data->setsda = i2c_gpio_setsda_dir;
 	}
 
 	if (pdata->scl_is_open_drain || pdata->scl_is_output_only) {
-		gpio_direction_output(pdata->scl_pin, 1);
+		gpiod_direction_output(priv->scl, 1);
 		bit_data->setscl = i2c_gpio_setscl_val;
 	} else {
-		gpio_direction_input(pdata->scl_pin);
+		gpiod_direction_input(priv->scl);
 		bit_data->setscl = i2c_gpio_setscl_dir;
 	}
 
@@ -207,7 +194,7 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 	else
 		bit_data->timeout = HZ / 10;		/* 100 ms */
 
-	bit_data->data = pdata;
+	bit_data->data = priv;
 
 	adap->owner = THIS_MODULE;
 	if (pdev->dev.of_node)
@@ -227,8 +214,13 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	dev_info(&pdev->dev, "using pins %u (SDA) and %u (SCL%s)\n",
-		 pdata->sda_pin, pdata->scl_pin,
+	/*
+	 * FIXME: using global GPIO numbers is not helpful. If/when we
+	 * get accessors to get the actual name of the GPIO line,
+	 * from the descriptor, then provide that instead.
+	 */
+	dev_info(&pdev->dev, "using lines %u (SDA) and %u (SCL%s)\n",
+		 desc_to_gpio(priv->sda), desc_to_gpio(priv->scl),
 		 pdata->scl_is_output_only
 		 ? ", no clock stretching" : "");
 
diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 40534352e574..4d40d013a412 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/pci.h>
 #include <linux/i2c-gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/slab.h>
 
 #include <linux/sm501.h>
@@ -1107,14 +1108,6 @@ static void sm501_gpio_remove(struct sm501_devdata *sm)
 	kfree(gpio->regs_res);
 }
 
-static inline int sm501_gpio_pin2nr(struct sm501_devdata *sm, unsigned int pin)
-{
-	struct sm501_gpio *gpio = &sm->gpio;
-	int base = (pin < 32) ? gpio->low.gpio.base : gpio->high.gpio.base;
-
-	return (pin % 32) + base;
-}
-
 static inline int sm501_gpio_isregistered(struct sm501_devdata *sm)
 {
 	return sm->gpio.registered;
@@ -1129,11 +1122,6 @@ static inline void sm501_gpio_remove(struct sm501_devdata *sm)
 {
 }
 
-static inline int sm501_gpio_pin2nr(struct sm501_devdata *sm, unsigned int pin)
-{
-	return -1;
-}
-
 static inline int sm501_gpio_isregistered(struct sm501_devdata *sm)
 {
 	return 0;
@@ -1145,20 +1133,37 @@ static int sm501_register_gpio_i2c_instance(struct sm501_devdata *sm,
 {
 	struct i2c_gpio_platform_data *icd;
 	struct platform_device *pdev;
+	struct gpiod_lookup_table *lookup;
 
 	pdev = sm501_create_subdev(sm, "i2c-gpio", 0,
 				   sizeof(struct i2c_gpio_platform_data));
 	if (!pdev)
 		return -ENOMEM;
 
-	icd = dev_get_platdata(&pdev->dev);
-
-	/* We keep the pin_sda and pin_scl fields relative in case the
-	 * same platform data is passed to >1 SM501.
-	 */
+	/* Create a gpiod lookup using gpiochip-local offsets */
+	lookup = devm_kzalloc(&pdev->dev,
+			      sizeof(*lookup) + 3 * sizeof(struct gpiod_lookup),
+			      GFP_KERNEL);
+	lookup->dev_id = "i2c-gpio";
+	if (iic->pin_sda < 32)
+		lookup->table[0].chip_label = "SM501-LOW";
+	else
+		lookup->table[0].chip_label = "SM501-HIGH";
+	lookup->table[0].chip_hwnum = iic->pin_sda % 32;
+	lookup->table[0].con_id = NULL;
+	lookup->table[0].idx = 0;
+	lookup->table[0].flags = GPIO_ACTIVE_HIGH;
+	if (iic->pin_scl < 32)
+		lookup->table[1].chip_label = "SM501-LOW";
+	else
+		lookup->table[1].chip_label = "SM501-HIGH";
+	lookup->table[1].chip_hwnum = iic->pin_scl % 32;
+	lookup->table[1].con_id = NULL;
+	lookup->table[1].idx = 1;
+	lookup->table[1].flags = GPIO_ACTIVE_HIGH;
+	gpiod_add_lookup_table(lookup);
 
-	icd->sda_pin = sm501_gpio_pin2nr(sm, iic->pin_sda);
-	icd->scl_pin = sm501_gpio_pin2nr(sm, iic->pin_scl);
+	icd = dev_get_platdata(&pdev->dev);
 	icd->timeout = iic->timeout;
 	icd->udelay = iic->udelay;
 
@@ -1170,9 +1175,9 @@ static int sm501_register_gpio_i2c_instance(struct sm501_devdata *sm,
 
 	pdev->id = iic->bus_num;
 
-	dev_info(sm->dev, "registering i2c-%d: sda=%d (%d), scl=%d (%d)\n",
+	dev_info(sm->dev, "registering i2c-%d: sda=%d, scl=%d\n",
 		 iic->bus_num,
-		 icd->sda_pin, iic->pin_sda, icd->scl_pin, iic->pin_scl);
+		 iic->pin_sda, iic->pin_scl);
 
 	return sm501_register_device(sm, pdev);
 }
diff --git a/include/linux/i2c-gpio.h b/include/linux/i2c-gpio.h
index c1bcb1f1d73b..352c1426fd4d 100644
--- a/include/linux/i2c-gpio.h
+++ b/include/linux/i2c-gpio.h
@@ -12,8 +12,6 @@
 
 /**
  * struct i2c_gpio_platform_data - Platform-dependent data for i2c-gpio
- * @sda_pin: GPIO pin ID to use for SDA
- * @scl_pin: GPIO pin ID to use for SCL
  * @udelay: signal toggle delay. SCL frequency is (500 / udelay) kHz
  * @timeout: clock stretching timeout in jiffies. If the slave keeps
  *	SCL low for longer than this, the transfer will time out.
@@ -26,8 +24,6 @@
  * @scl_is_output_only: SCL output drivers cannot be turned off.
  */
 struct i2c_gpio_platform_data {
-	unsigned int	sda_pin;
-	unsigned int	scl_pin;
 	int		udelay;
 	int		timeout;
 	unsigned int	sda_is_open_drain:1;
-- 
2.13.5
