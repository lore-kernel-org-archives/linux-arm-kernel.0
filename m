From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 25 May 2017 16:30:40 +1200
Subject: [RFC PATCH 2/5] ARM: ep93xx: add gpiod_lookup_table for spi
 chip-selects
In-Reply-To: <20170525043043.1930-1-chris.packham@alliedtelesis.co.nz>
References: <20170525043043.1930-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170525043043.1930-3-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a preparatory step which will allow the conversion of
spi-ep93xx.c to gpiod.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/mach-ep93xx/edb93xx.c       | 12 ++++++++++++
 arch/arm/mach-ep93xx/simone.c        | 11 +++++++++++
 arch/arm/mach-ep93xx/vision_ep9307.c | 15 +++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 0ac176386789..9042adfe03de 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -27,6 +27,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
 #include <linux/spi/spi.h>
@@ -116,6 +118,15 @@ static struct spi_board_info edb93xx_spi_board_info[] __initdata = {
 	},
 };
 
+static struct gpiod_lookup_table edb93xx_gpios_table = {
+	.dev_id = "spi.0",
+	.table = {
+		GPIO_LOOKUP("gpio-ep93xx", EP93XX_GPIO_LINE_EGPIO6,
+			    "spi-cs", GPIO_ACTIVE_HIGH),
+		{},
+	},
+};
+
 static int edb93xx_spi_chipselects[] __initdata = {
 	EP93XX_GPIO_LINE_EGPIO6,
 };
@@ -134,6 +145,7 @@ static void __init edb93xx_register_spi(void)
 	else if (machine_is_edb9315a())
 		edb93xx_cs4271_data.gpio_nreset = EP93XX_GPIO_LINE_EGPIO14;
 
+	gpiod_add_lookup_table(&edb93xx_gpios_table);
 	ep93xx_register_spi(&edb93xx_spi_info, edb93xx_spi_board_info,
 			    ARRAY_SIZE(edb93xx_spi_board_info));
 }
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index c7a40f245892..f297a7a89ed9 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -26,6 +26,7 @@
 #include <linux/platform_data/video-ep93xx.h>
 #include <linux/platform_data/spi-ep93xx.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 
 #include <mach/hardware.h>
 #include <mach/gpio-ep93xx.h>
@@ -119,6 +120,15 @@ static struct spi_board_info simone_spi_devices[] __initdata = {
  * low between multi-message command blocks. From v1.4, it uses a GPIO instead.
  * v1.3 parts will still work, since the signal on SFRMOUT is automatic.
  */
+static struct gpiod_lookup_table simone_gpios_table = {
+	.dev_id = "spi.0",
+	.table = {
+		GPIO_LOOKUP("gpio-ep93xx", EP93XX_GPIO_LINE_EGPIO1,
+			    "spi-cs", GPIO_ACTIVE_HIGH),
+		{},
+	},
+};
+
 static int simone_spi_chipselects[] __initdata = {
 	EP93XX_GPIO_LINE_EGPIO1,
 };
@@ -163,6 +173,7 @@ static void __init simone_init_machine(void)
 	ep93xx_register_fb(&simone_fb_info);
 	ep93xx_register_i2c(&simone_i2c_gpio_data, simone_i2c_board_info,
 			    ARRAY_SIZE(simone_i2c_board_info));
+	gpiod_add_lookup_table(&simone_gpios_table);
 	ep93xx_register_spi(&simone_spi_info, simone_spi_devices,
 			    ARRAY_SIZE(simone_spi_devices));
 	simone_register_audio();
diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
index 1daf9441058c..3d9c66bbf2af 100644
--- a/arch/arm/mach-ep93xx/vision_ep9307.c
+++ b/arch/arm/mach-ep93xx/vision_ep9307.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/fb.h>
 #include <linux/io.h>
 #include <linux/mtd/partitions.h>
@@ -242,6 +243,19 @@ static struct spi_board_info vision_spi_board_info[] __initdata = {
 	},
 };
 
+static struct gpiod_lookup_table vision_gpios_table = {
+	.dev_id = "spi.0",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-ep93xx", EP93XX_GPIO_LINE_EGPIO6,
+				"spi-cs", 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-ep93xx", EP93XX_GPIO_LINE_EGPIO7,
+				"spi-cs", 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-ep93xx", EP93XX_GPIO_LINE_G(2),
+				"spi-cs", 2, GPIO_ACTIVE_HIGH),
+		{},
+	},
+};
+
 static int vision_spi_chipselects[] __initdata = {
 	EP93XX_GPIO_LINE_EGPIO6,
 	EP93XX_GPIO_LINE_EGPIO7,
@@ -291,6 +305,7 @@ static void __init vision_init_machine(void)
 
 	ep93xx_register_i2c(&vision_i2c_gpio_data, vision_i2c_info,
 				ARRAY_SIZE(vision_i2c_info));
+	gpiod_add_lookup_table(&vision_gpios_table);
 	ep93xx_register_spi(&vision_spi_master, vision_spi_board_info,
 				ARRAY_SIZE(vision_spi_board_info));
 	vision_register_i2s();
-- 
2.13.0
