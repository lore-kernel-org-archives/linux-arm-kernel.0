From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 22 Jun 2011 09:25:25 -0300
Subject: [PATCH v2 3/6] ARM: mach-imx/mx27_3ds: Add LCD support
In-Reply-To: <1308745528-22089-2-git-send-email-fabio.estevam@freescale.com>
References: <1308745528-22089-1-git-send-email-fabio.estevam@freescale.com>
	<1308745528-22089-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1308745528-22089-3-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On mx27_3ds board there is a l4f00242t03 LCD that is controlled via CSPI1.

Add support for CSPI1 and LCD.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Rebased on Sascha's for-next branch
- Place GPIOs IOMUX into static array

 arch/arm/mach-imx/Kconfig         |    1 +
 arch/arm/mach-imx/mach-mx27_3ds.c |   92 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index e8dd22f..0519dd7 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -278,6 +278,7 @@ config MACH_MX27_3DS
 	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index eb66310..838421c 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -29,6 +29,7 @@
 #include <linux/mfd/mc13783.h>
 #include <linux/spi/spi.h>
 #include <linux/regulator/machine.h>
+#include <linux/spi/l4f00242t03.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -47,6 +48,9 @@
 #define SPI2_SS0		IMX_GPIO_NR(4, 21)
 #define EXPIO_PARENT_INT	gpio_to_irq(IMX_GPIO_NR(3, 28))
 #define PMIC_INT		IMX_GPIO_NR(3, 14)
+#define SPI1_SS0		IMX_GPIO_NR(4, 28)
+#define LCD_RESET		IMX_GPIO_NR(1, 3)
+#define LCD_ENABLE		IMX_GPIO_NR(1, 31)
 
 static const int mx27pdk_pins[] __initconst = {
 	/* UART1 */
@@ -95,6 +99,12 @@ static const int mx27pdk_pins[] __initconst = {
 	PE2_PF_USBOTG_DIR,
 	PE24_PF_USBOTG_CLK,
 	PE25_PF_USBOTG_DATA7,
+	/* CSPI1 */
+	PD31_PF_CSPI1_MOSI,
+	PD30_PF_CSPI1_MISO,
+	PD29_PF_CSPI1_SCLK,
+	PD25_PF_CSPI1_RDY,
+	SPI1_SS0 | GPIO_GPIO | GPIO_OUT,
 	/* CSPI2 */
 	PD22_PF_CSPI2_SCLK,
 	PD23_PF_CSPI2_MISO,
@@ -105,6 +115,31 @@ static const int mx27pdk_pins[] __initconst = {
 	PD18_PF_I2C_CLK,
 	/* PMIC INT */
 	PMIC_INT | GPIO_GPIO | GPIO_IN,
+	/* LCD */
+	PA5_PF_LSCLK,
+	PA6_PF_LD0,
+	PA7_PF_LD1,
+	PA8_PF_LD2,
+	PA9_PF_LD3,
+	PA10_PF_LD4,
+	PA11_PF_LD5,
+	PA12_PF_LD6,
+	PA13_PF_LD7,
+	PA14_PF_LD8,
+	PA15_PF_LD9,
+	PA16_PF_LD10,
+	PA17_PF_LD11,
+	PA18_PF_LD12,
+	PA19_PF_LD13,
+	PA20_PF_LD14,
+	PA21_PF_LD15,
+	PA22_PF_LD16,
+	PA23_PF_LD17,
+	PA28_PF_HSYNC,
+	PA29_PF_VSYNC,
+	PA30_PF_CONTRAST,
+	LCD_ENABLE | GPIO_GPIO | GPIO_OUT,
+	LCD_RESET | GPIO_GPIO | GPIO_OUT,
 };
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
@@ -261,6 +296,13 @@ static struct mc13xxx_platform_data mc13783_pdata = {
 };
 
 /* SPI */
+static int spi1_chipselect[] = {SPI1_SS0};
+
+static const struct spi_imx_master spi1_pdata __initconst = {
+	.chipselect	= spi1_chipselect,
+	.num_chipselect	= ARRAY_SIZE(spi1_chipselect),
+};
+
 static int spi2_internal_chipselect[] = {SPI2_SS0};
 
 static const struct spi_imx_master spi2_pdata __initconst = {
@@ -268,6 +310,46 @@ static const struct spi_imx_master spi2_pdata __initconst = {
 	.num_chipselect	= ARRAY_SIZE(spi2_internal_chipselect),
 };
 
+static struct imx_fb_videomode mx27_3ds_modes[] = {
+	{	/* 480x640 @ 60 Hz */
+		.mode = {
+			.name		= "Epson-VGA",
+			.refresh	= 60,
+			.xres		= 480,
+			.yres		= 640,
+			.pixclock	= 41701,
+			.left_margin	= 20,
+			.right_margin	= 41,
+			.upper_margin	= 10,
+			.lower_margin	= 5,
+			.hsync_len	= 20,
+			.vsync_len	= 10,
+			.sync		= FB_SYNC_OE_ACT_HIGH |
+						FB_SYNC_CLK_INVERT,
+			.vmode		= FB_VMODE_NONINTERLACED,
+			.flag		= 0,
+		},
+		.bpp		= 16,
+		.pcr		= 0xFAC08B82,
+	},
+};
+
+static const struct imx_fb_platform_data mx27_3ds_fb_data __initconst = {
+	.mode = mx27_3ds_modes,
+	.num_modes = ARRAY_SIZE(mx27_3ds_modes),
+	.pwmr		= 0x00A903FF,
+	.lscr1		= 0x00120300,
+	.dmacr		= 0x00020010,
+};
+
+/* LCD */
+static struct l4f00242t03_pdata mx27_3ds_lcd_pdata = {
+	.reset_gpio		= LCD_RESET,
+	.data_enable_gpio	= LCD_ENABLE,
+	.core_supply		= "lcd_2v8",
+	.io_supply		= "vdd_lcdio",
+};
+
 static struct spi_board_info mx27_3ds_spi_devs[] __initdata = {
 	{
 		.modalias	= "mc13783",
@@ -277,7 +359,13 @@ static struct spi_board_info mx27_3ds_spi_devs[] __initdata = {
 		.platform_data	= &mc13783_pdata,
 		.irq = IRQ_GPIOC(14),
 		.mode = SPI_CS_HIGH,
-	},
+	}, {
+		.modalias	= "l4f00242t03",
+		.max_speed_hz	= 5000000,
+		.bus_num	= 0,
+		.chip_select	= 0, /* SS0 */
+		.platform_data	= &mx27_3ds_lcd_pdata,
+	},
 };
 
 static const struct imxi2c_platform_data mx27_3ds_i2c0_data __initconst = {
@@ -310,12 +398,14 @@ static void __init mx27pdk_init(void)
 		imx27_add_fsl_usb2_udc(&otg_device_pdata);
 
 	imx27_add_spi_imx1(&spi2_pdata);
+	imx27_add_spi_imx0(&spi1_pdata);
 	spi_register_board_info(mx27_3ds_spi_devs,
 						ARRAY_SIZE(mx27_3ds_spi_devs));
 
 	if (mxc_expio_init(MX27_CS5_BASE_ADDR, EXPIO_PARENT_INT))
 		pr_warn("Init of the debugboard failed, all devices on the debugboard are unusable.\n");
 	imx27_add_imx_i2c(0, &mx27_3ds_i2c0_data);
+	imx27_add_imx_fb(&mx27_3ds_fb_data);
 }
 
 static void __init mx27pdk_timer_init(void)
-- 
1.6.0.4
