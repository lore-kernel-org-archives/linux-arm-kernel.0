From: alberto@amarulasolutions.com (Alberto Panizzo)
Date: Mon, 07 Mar 2011 11:46:38 +0100
Subject: [PATCHv3 3/4] mach-mx31_3ds: Add support for framebuffer and LCD
In-Reply-To: <1299494529.2468.42.camel@realization>
References: <1299492598.2468.30.camel@realization>
	<4D74B091.2010908@pengutronix.de>
	<1299494529.2468.42.camel@realization>
Message-ID: <1299494798.2468.47.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Signed-off-by: Alberto Panizzo <alberto@amarulasolutions.com>
---
 arch/arm/mach-mx3/mach-mx31_3ds.c |  130 +++++++++++++++++++++++++++++++++++++
 1 files changed, 130 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index cff9206..bb7e432 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/mfd/mc13783.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/l4f00242t03.h>
 #include <linux/regulator/machine.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
@@ -36,6 +37,8 @@
 #include <mach/3ds_debugboard.h>
 #include <mach/ulpi.h>
 #include <mach/mmc.h>
+#include <mach/ipu.h>
+#include <mach/mx3fb.h>
 
 #include "devices-imx31.h"
 #include "devices.h"
@@ -50,6 +53,12 @@ static int mx31_3ds_pins[] = {
 	MX31_PIN_TXD1__TXD1,
 	MX31_PIN_RXD1__RXD1,
 	IOMUX_MODE(MX31_PIN_GPIO1_1, IOMUX_CONFIG_GPIO),
+	/*SPI0*/
+	MX31_PIN_CSPI1_SCLK__SCLK,
+	MX31_PIN_CSPI1_MOSI__MOSI,
+	MX31_PIN_CSPI1_MISO__MISO,
+	MX31_PIN_CSPI1_SPI_RDY__SPI_RDY,
+	MX31_PIN_CSPI1_SS2__SS2, /* CS for LCD */
 	/* SPI 1 */
 	MX31_PIN_CSPI2_SCLK__SCLK,
 	MX31_PIN_CSPI2_MOSI__MOSI,
@@ -109,6 +118,70 @@ static int mx31_3ds_pins[] = {
 	MX31_PIN_SD1_CMD__SD1_CMD,
 	MX31_PIN_GPIO3_1__GPIO3_1, /* Card detect */
 	MX31_PIN_GPIO3_0__GPIO3_0, /* OE */
+	/* Framebuffer */
+	MX31_PIN_LD0__LD0,
+	MX31_PIN_LD1__LD1,
+	MX31_PIN_LD2__LD2,
+	MX31_PIN_LD3__LD3,
+	MX31_PIN_LD4__LD4,
+	MX31_PIN_LD5__LD5,
+	MX31_PIN_LD6__LD6,
+	MX31_PIN_LD7__LD7,
+	MX31_PIN_LD8__LD8,
+	MX31_PIN_LD9__LD9,
+	MX31_PIN_LD10__LD10,
+	MX31_PIN_LD11__LD11,
+	MX31_PIN_LD12__LD12,
+	MX31_PIN_LD13__LD13,
+	MX31_PIN_LD14__LD14,
+	MX31_PIN_LD15__LD15,
+	MX31_PIN_LD16__LD16,
+	MX31_PIN_LD17__LD17,
+	MX31_PIN_VSYNC3__VSYNC3,
+	MX31_PIN_HSYNC__HSYNC,
+	MX31_PIN_FPSHIFT__FPSHIFT,
+	MX31_PIN_CONTRAST__CONTRAST,
+};
+
+/*
+ * FB support
+ */
+static const struct fb_videomode fb_modedb[] = {
+	{	/* 480x640 @ 60 Hz */
+		.name		= "Epson-VGA",
+		.refresh	= 60,
+		.xres		= 480,
+		.yres		= 640,
+		.pixclock	= 41701,
+		.left_margin	= 20,
+		.right_margin	= 41,
+		.upper_margin	= 10,
+		.lower_margin	= 5,
+		.hsync_len	= 20,
+		.vsync_len	= 10,
+		.sync		= FB_SYNC_OE_ACT_HIGH | FB_SYNC_CLK_INVERT,
+		.vmode		= FB_VMODE_NONINTERLACED,
+		.flag		= 0,
+	},
+};
+
+static struct ipu_platform_data mx3_ipu_data = {
+	.irq_base = MXC_IPU_IRQ_START,
+};
+
+static struct mx3fb_platform_data mx3fb_pdata = {
+	.dma_dev	= &mx3_ipu.dev,
+	.name		= "Epson-VGA",
+	.mode		= fb_modedb,
+	.num_modes	= ARRAY_SIZE(fb_modedb),
+};
+
+/* LCD */
+static struct l4f00242t03_pdata mx31_3ds_l4f00242t03_pdata = {
+	.reset_gpio		= IOMUX_TO_GPIO(MX31_PIN_LCS1),
+	.data_enable_gpio	= IOMUX_TO_GPIO(MX31_PIN_SER_RS),
+	.core_supply		= "lcd_2v8",
+	.io_supply		= "vdd_lcdio",
 };
 
 /*
@@ -232,6 +305,38 @@ static struct regulator_init_data vmmc2_init = {
 	.consumer_supplies = vmmc2_consumers,
 };
 
+static struct regulator_consumer_supply vmmc1_consumers[] = {
+	REGULATOR_SUPPLY("lcd_2v8", NULL),
+};
+
+static struct regulator_init_data vmmc1_init = {
+	.constraints = {
+		.min_uV = 2800000,
+		.max_uV = 2800000,
+		.apply_uV = 1,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+				  REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(vmmc1_consumers),
+	.consumer_supplies = vmmc1_consumers,
+};
+
+static struct regulator_consumer_supply vgen_consumers[] = {
+	REGULATOR_SUPPLY("vdd_lcdio", NULL),
+};
+
+static struct regulator_init_data vgen_init = {
+	.constraints = {
+		.min_uV = 1800000,
+		.max_uV = 1800000,
+		.apply_uV = 1,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+				  REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(vgen_consumers),
+	.consumer_supplies = vgen_consumers,
+};
+
 static struct mc13xxx_regulator_init_data mx31_3ds_regulators[] = {
 	{
 		.id = MC13783_REG_PWGT1SPI, /* Power Gate for ARM core. */
@@ -249,6 +354,12 @@ static struct mc13xxx_regulator_init_data mx31_3ds_regulators[] = {
 	}, {
 		.id = MC13783_REG_VMMC2, /* Power MMC/SD, WiFi/Bluetooth. */
 		.init_data = &vmmc2_init,
+	}, {
+		.id = MC13783_REG_VMMC1, /* Power LCD, CMOS, FM, GPS, Accel. */
+		.init_data = &vmmc1_init,
+	}, {
+		.id = MC13783_REG_VGEN,  /* Power LCD */
+		.init_data = &vgen_init,
 	},
 };
 
@@ -260,6 +371,15 @@ static struct mc13xxx_platform_data mc13783_pdata __initdata = {
 };
 
 /* SPI */
+static int spi0_internal_chipselect[] = {
+	MXC_SPI_CS(2),
+};
+
+static const struct spi_imx_master spi0_pdata __initconst = {
+	.chipselect	= spi0_internal_chipselect,
+	.num_chipselect	= ARRAY_SIZE(spi0_internal_chipselect),
+};
+
 static int spi1_internal_chipselect[] = {
 	MXC_SPI_CS(0),
 	MXC_SPI_CS(2),
@@ -279,6 +399,12 @@ static struct spi_board_info mx31_3ds_spi_devs[] __initdata = {
 		.platform_data	= &mc13783_pdata,
 		.irq		= IOMUX_TO_IRQ(MX31_PIN_GPIO1_3),
 		.mode = SPI_CS_HIGH,
+	}, {
+		.modalias	= "l4f00242t03",
+		.max_speed_hz	= 5000000,
+		.bus_num	= 0,
+		.chip_select	= 0, /* SS2 */
+		.platform_data	= &mx31_3ds_l4f00242t03_pdata,
 	},
 };
 
@@ -461,6 +587,10 @@ static void __init mx31_3ds_init(void)
 	imx31_add_imx2_wdt(NULL);
 	imx31_add_imx_i2c0(&mx31_3ds_i2c0_data);
 	imx31_add_mxc_mmc(0, &sdhc1_pdata);
+
+	imx31_add_spi_imx0(&spi0_pdata);
+	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
+	mxc_register_device(&mx3_fb, &mx3fb_pdata);
 }
 
 static void __init mx31_3ds_timer_init(void)
-- 
1.7.1
