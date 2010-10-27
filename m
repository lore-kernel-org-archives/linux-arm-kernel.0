From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Wed, 27 Oct 2010 10:29:24 -0700 (PDT)
Subject: [PATCH 1/2] mx31_3ds: Add LCD support
Message-ID: <342550.68252.qm@web51003.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add l4f00242t03 LCD support for mx31_3ds board.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>

---

Sascha, 

This patch should be applied after this one: 
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-October/030048.html

 arch/arm/mach-mx3/mach-mx31_3ds.c |? 119 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 116 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 8ad2ef5..71fe05b 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/mfd/mc13783.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/l4f00242t03.h>
 #include <linux/regulator/machine.h>
 #include <linux/fsl_devices.h>
 #include <linux/input/matrix_keypad.h>
@@ -35,6 +36,8 @@
 #include <mach/iomux-mx3.h>
 #include <mach/3ds_debugboard.h>
 #include <mach/mmc.h>
+#include <mach/ipu.h>
+#include <mach/mx3fb.h>
 
 #include "devices-imx31.h"
 #include "devices.h"
@@ -56,7 +59,13 @@ static int mx31_3ds_pins[] = {
 ??? MX31_PIN_TXD1__TXD1,
 ??? MX31_PIN_RXD1__RXD1,
 ??? IOMUX_MODE(MX31_PIN_GPIO1_1, IOMUX_CONFIG_GPIO),
-??? /* SPI 1 */
+??? /*SPI1 */
+??? MX31_PIN_CSPI1_SCLK__SCLK,
+??? MX31_PIN_CSPI1_MOSI__MOSI,
+??? MX31_PIN_CSPI1_MISO__MISO,
+??? MX31_PIN_CSPI1_SPI_RDY__SPI_RDY,
+??? MX31_PIN_CSPI1_SS2__SS2, /*CS for LCD */
+??? /* SPI2 */
 ??? MX31_PIN_CSPI2_SCLK__SCLK,
 ??? MX31_PIN_CSPI2_MOSI__MOSI,
 ??? MX31_PIN_CSPI2_MISO__MISO,
@@ -97,6 +106,72 @@ static int mx31_3ds_pins[] = {
 ??? MX31_PIN_SD1_CMD__SD1_CMD,
 ??? MX31_PIN_GPIO3_0__GPIO3_0,
 ??? MX31_PIN_GPIO3_1__GPIO3_1,
+??? /* LCD */
+??? MX31_PIN_LD0__LD0,
+??? MX31_PIN_LD1__LD1,
+??? MX31_PIN_LD2__LD2,
+??? MX31_PIN_LD3__LD3,
+??? MX31_PIN_LD4__LD4,
+??? MX31_PIN_LD5__LD5,
+??? MX31_PIN_LD6__LD6,
+??? MX31_PIN_LD7__LD7,
+??? MX31_PIN_LD8__LD8,
+??? MX31_PIN_LD9__LD9,
+??? MX31_PIN_LD10__LD10,
+??? MX31_PIN_LD11__LD11,
+??? MX31_PIN_LD12__LD12,
+??? MX31_PIN_LD13__LD13,
+??? MX31_PIN_LD14__LD14,
+??? MX31_PIN_LD15__LD15,
+??? MX31_PIN_LD16__LD16,
+??? MX31_PIN_LD17__LD17,
+??? MX31_PIN_VSYNC3__VSYNC3,
+??? MX31_PIN_HSYNC__HSYNC,
+??? MX31_PIN_FPSHIFT__FPSHIFT,
+??? MX31_PIN_CONTRAST__CONTRAST,
+??? MX31_PIN_LCS1,??? ??? /*LCD Reset */
+??? MX31_PIN_SER_RS,??? /*LCD Data Enable */
+};
+
+/*
+ * FB support
+ */
+static const struct fb_videomode fb_modedb[] = {
+??? {??? /* 480x640 @ 60 Hz */
+??? ??? .name??? ??? = "Epson-VGA",
+??? ??? .refresh??? = 60,
+??? ??? .xres??? ??? = 480,
+??? ??? .yres??? ??? = 640,
+??? ??? .pixclock??? = 41701,
+??? ??? .left_margin??? = 20,
+??? ??? .right_margin??? = 41,
+??? ??? .upper_margin??? = 10,
+??? ??? .lower_margin??? = 5,
+??? ??? .hsync_len??? = 20,
+??? ??? .vsync_len??? = 10,
+??? ??? .sync??? ??? = FB_SYNC_OE_ACT_HIGH | FB_SYNC_CLK_INVERT,
+??? ??? .vmode??? ??? = FB_VMODE_NONINTERLACED,
+??? ??? .flag??? ??? = 0,
+??? },
+};
+
+static struct ipu_platform_data mx3_ipu_data = {
+??? .irq_base = MXC_IPU_IRQ_START,
+};
+
+static struct mx3fb_platform_data mx3fb_pdata = {
+??? .dma_dev??? = &mx3_ipu.dev,
+??? .name??? ??? = "Epson-VGA",
+??? .mode??? ??? = fb_modedb,
+??? .num_modes??? = ARRAY_SIZE(fb_modedb),
+};
+
+/* LCD */
+static struct l4f00242t03_pdata mx31_3ds_l4f00242t03_pdata = {
+??? .reset_gpio =??? ??? IOMUX_TO_GPIO(MX31_PIN_LCS1),
+??? .data_enable_gpio =??? IOMUX_TO_GPIO(MX31_PIN_SER_RS),
+??? .core_supply =??? ??? "sdhc0_vcc",
+??? .io_supply =??? ??? "vdd_lcdio",
 };
 
 /*
@@ -130,11 +205,17 @@ static struct regulator_init_data pwgtx_init = {
 
 static struct regulator_consumer_supply sdhc_consumers[] = {
 ??? {
-??? ??? .dev??? = &mxcsdhc_device0.dev,
 ??? ??? .supply??? = "sdhc0_vcc",
 ??? },
 };
 
+static struct regulator_consumer_supply vgen_consumers[] = {
+??? {
+??? ??? .supply??? = "vdd_lcdio",
+??? },
+};
+
+
 static struct regulator_init_data sdhc_vreg_data = {
 ??? .constraints = {
 ??? ??? .always_on = 1,
@@ -144,6 +225,16 @@ static struct regulator_init_data sdhc_vreg_data = {
 ??? .consumer_supplies = sdhc_consumers,
 };
 
+static struct regulator_init_data vgen_init = {
+??? .constraints = {
+??? ??? .min_uV = 1800000,
+??? ??? .max_uV = 1800000,
+??? },
+??? .num_consumer_supplies = ARRAY_SIZE(vgen_consumers),
+??? .consumer_supplies = vgen_consumers,
+};
+
+
 static struct mc13783_regulator_init_data mx31_3ds_regulators[] = {
 ??? {
 ??? ??? .id = MC13783_REGU_PWGT1SPI, /* Power Gate for ARM core. */
@@ -154,6 +245,9 @@ static struct mc13783_regulator_init_data mx31_3ds_regulators[] = {
 ??? }, {
 ??? ??? .id = MC13783_REGU_GPO1,?????/* Power Gate for MMC1. */
 ??? ??? .init_data = &sdhc_vreg_data,
+??? }, {
+??? ??? .id = MC13783_REGU_VGEN,
+??? ??? .init_data = &vgen_init,
 ??? },
 };
 
@@ -165,6 +259,15 @@ static struct mc13783_platform_data mc13783_pdata __initdata = {
 };
 
 /* SPI */
+static int spi0_internal_chipselect[] = {
+??? MXC_SPI_CS(2),
+};
+
+static struct spi_imx_master spi0_pdata = {
+??? .chipselect??? = spi0_internal_chipselect,
+??? .num_chipselect??? = ARRAY_SIZE(spi0_internal_chipselect),
+};
+
 static int spi1_internal_chipselect[] = {
 ??? MXC_SPI_CS(0),
 ??? MXC_SPI_CS(2),
@@ -184,7 +287,13 @@ static struct spi_board_info mx31_3ds_spi_devs[] __initdata = {
 ??? ??? .platform_data??? = &mc13783_pdata,
 ??? ??? .irq??? ??? = IOMUX_TO_IRQ(MX31_PIN_GPIO1_3),
 ??? ??? .mode = SPI_CS_HIGH,
-??? },
+??? }, {
+??? ??? .modalias??? = "l4f00242t03",
+??? ??? .max_speed_hz??? = 5000000,
+??? ??? .bus_num??? = 0,
+??? ??? .chip_select??? = 0, /* SS2 */
+??? ??? .platform_data??? = &mx31_3ds_l4f00242t03_pdata,
+??? }
 };
 
 /*
@@ -316,6 +425,7 @@ static void __init mxc_board_init(void)
 ??? mx31_3ds_sdhc1_enable_card_detect();
 
 ??? imx31_add_spi_imx1(&spi1_pdata);
+??? imx31_add_spi_imx0(&spi0_pdata);
 ??? spi_register_board_info(mx31_3ds_spi_devs,
 ??? ??? ??? ??? ??? ??? ARRAY_SIZE(mx31_3ds_spi_devs));
 
@@ -328,6 +438,9 @@ static void __init mxc_board_init(void)
 ??? if (mxc_expio_init(MX31_CS5_BASE_ADDR, EXPIO_PARENT_INT))
 ??? ??? printk(KERN_WARNING "Init of the debug board failed, all "
 ??? ??? ??? ??? ? ? "devices on the debug board are unusable.\n");
+??? mxc_register_device(&mx3_ipu, &mx3_ipu_data);
+??? mxc_register_device(&mx3_fb, &mx3fb_pdata);
+
 }
 
 static void __init mx31_3ds_timer_init(void)
-- 
1.6.0.4





      
