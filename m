From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 25 May 2017 16:30:41 +1200
Subject: [RFC PATCH 3/5] ARM: imx: add gpiod_lookup_table for spi chip-selects
In-Reply-To: <20170525043043.1930-1-chris.packham@alliedtelesis.co.nz>
References: <20170525043043.1930-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170525043043.1930-4-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a preparatory step which will allow the conversion of
spi-imx.c to gpiod.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/mach-imx/mach-mx27_3ds.c | 21 +++++++++++++++++++++
 arch/arm/mach-imx/mach-pca100.c   | 13 +++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 45e16bd7e2f2..46d67be124f0 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -22,6 +22,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/irq.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
@@ -313,6 +314,15 @@ static struct imx_ssi_platform_data mx27_3ds_ssi_pdata = {
 };
 
 /* SPI */
+static struct gpiod_lookup_table spi1_cs_gpio_table = {
+	.dev_id = "spi.0",
+	.table = {
+		GPIO_LOOKUP("gpio-mxc", SPI1_SS0,
+			    "spi-cs", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static int spi1_chipselect[] = {SPI1_SS0};
 
 static const struct spi_imx_master spi1_pdata __initconst = {
@@ -320,6 +330,15 @@ static const struct spi_imx_master spi1_pdata __initconst = {
 	.num_chipselect	= ARRAY_SIZE(spi1_chipselect),
 };
 
+static struct gpiod_lookup_table spi2_cs_gpio_table = {
+	.dev_id = "spi.1",
+	.table = {
+		GPIO_LOOKUP("gpio-mxc", SPI2_SS0,
+			    "spi-cs", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static int spi2_chipselect[] = {SPI2_SS0};
 
 static const struct spi_imx_master spi2_pdata __initconst = {
@@ -398,7 +417,9 @@ static void __init mx27pdk_init(void)
 	imx27_add_imx_keypad(&mx27_3ds_keymap_data);
 	imx27_add_imx2_wdt();
 
+	gpiod_add_lookup_table(&spi2_cs_gpio_table);
 	imx27_add_spi_imx1(&spi2_pdata);
+	gpiod_add_lookup_table(&spi1_cs_gpio_table);
 	imx27_add_spi_imx0(&spi1_pdata);
 
 	imx27_add_imx_i2c(0, &mx27_3ds_i2c0_data);
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index ed675863655b..8a2b5860f327 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -27,6 +27,7 @@
 #include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 
@@ -202,6 +203,17 @@ static struct spi_board_info pca100_spi_board_info[] __initdata = {
 	},
 };
 
+static struct gpiod_lookup_table pca100_spi_cs_gpio_table = {
+	.dev_id = "spi.0",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-mxc", SPI1_SS0,
+				"spi-cs", 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-mxc", SPI1_SS1,
+				"spi-cs", 1, GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static int pca100_spi_cs[] = {SPI1_SS0, SPI1_SS1};
 
 static const struct spi_imx_master pca100_spi0_data __initconst = {
@@ -376,6 +388,7 @@ static void __init pca100_init(void)
 	mxc_gpio_mode(GPIO_PORTD | 27 | GPIO_GPIO | GPIO_IN);
 	spi_register_board_info(pca100_spi_board_info,
 				ARRAY_SIZE(pca100_spi_board_info));
+	gpiod_add_lookup_table(&pca100_spi_cs_gpio_table);
 	imx27_add_spi_imx0(&pca100_spi0_data);
 
 	imx27_add_imx_fb(&pca100_fb_data);
-- 
2.13.0
