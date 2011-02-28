From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 28 Feb 2011 11:00:29 +0100
Subject: [PATCH 8/8] ARM i.MX51 babbage: Add framebuffer support
In-Reply-To: <1298887229-7987-1-git-send-email-s.hauer@pengutronix.de>
References: <1298887229-7987-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1298887229-7987-9-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/Kconfig              |    1 +
 arch/arm/mach-mx5/board-mx51_babbage.c |   82 ++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index de4fa992f..89e71da 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -42,6 +42,7 @@ config MACH_MX51_BABBAGE
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select IMX_HAVE_PLATFORM_SPI_IMX
+	select IMX_HAVE_PLATFORM_IMX_IPUV3
 	help
 	  Include support for MX51 Babbage platform, also known as MX51EVK in
 	  u-boot. This includes specific configurations for the board and its
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 1d231e8..31efd06 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -22,11 +22,13 @@
 #include <linux/input.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
+#include <video/imx-ipu-v3.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx51.h>
 #include <mach/mxc_ehci.h>
+#include <mach/ipu-v3.h>
 
 #include <asm/irq.h>
 #include <asm/setup.h>
@@ -158,6 +160,40 @@ static iomux_v3_cfg_t mx51babbage_pads[] = {
 	MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK,
 	MX51_PAD_CSPI1_SS0__GPIO4_24,
 	MX51_PAD_CSPI1_SS1__GPIO4_25,
+
+	/* Display */
+	MX51_PAD_DISPB2_SER_DIN__GPIO3_5,
+	MX51_PAD_DISPB2_SER_DIO__GPIO3_6,
+	MX51_PAD_NANDF_D12__GPIO3_28,
+
+	MX51_PAD_DISP1_DAT0__DISP1_DAT0,
+	MX51_PAD_DISP1_DAT1__DISP1_DAT1,
+	MX51_PAD_DISP1_DAT2__DISP1_DAT2,
+	MX51_PAD_DISP1_DAT3__DISP1_DAT3,
+	MX51_PAD_DISP1_DAT4__DISP1_DAT4,
+	MX51_PAD_DISP1_DAT5__DISP1_DAT5,
+	MX51_PAD_DISP1_DAT6__DISP1_DAT6,
+	MX51_PAD_DISP1_DAT7__DISP1_DAT7,
+	MX51_PAD_DISP1_DAT8__DISP1_DAT8,
+	MX51_PAD_DISP1_DAT9__DISP1_DAT9,
+	MX51_PAD_DISP1_DAT10__DISP1_DAT10,
+	MX51_PAD_DISP1_DAT11__DISP1_DAT11,
+	MX51_PAD_DISP1_DAT12__DISP1_DAT12,
+	MX51_PAD_DISP1_DAT13__DISP1_DAT13,
+	MX51_PAD_DISP1_DAT14__DISP1_DAT14,
+	MX51_PAD_DISP1_DAT15__DISP1_DAT15,
+	MX51_PAD_DISP1_DAT16__DISP1_DAT16,
+	MX51_PAD_DISP1_DAT17__DISP1_DAT17,
+	MX51_PAD_DISP1_DAT18__DISP1_DAT18,
+	MX51_PAD_DISP1_DAT19__DISP1_DAT19,
+	MX51_PAD_DISP1_DAT20__DISP1_DAT20,
+	MX51_PAD_DISP1_DAT21__DISP1_DAT21,
+	MX51_PAD_DISP1_DAT22__DISP1_DAT22,
+	MX51_PAD_DISP1_DAT23__DISP1_DAT23,
+	MX51_PAD_DI_GP4__DI2_PIN15,
+
+	/* I2C DVI enable */
+	MX51_PAD_CSI2_HSYNC__GPIO4_14,
 };
 
 /* Serial ports */
@@ -346,6 +382,50 @@ static const struct spi_imx_master mx51_babbage_spi_pdata __initconst = {
 	.num_chipselect = ARRAY_SIZE(mx51_babbage_spi_cs),
 };
 
+static struct ipuv3_fb_platform_data babbage_fb0_data = {
+	.interface_pix_fmt = IPU_PIX_FMT_RGB24,
+	.flags = IMX_IPU_FB_USE_MODEDB | IMX_IPU_FB_USE_OVERLAY,
+	.display = 0,
+};
+
+static struct ipuv3_fb_platform_data babbage_fb1_data = {
+	.interface_pix_fmt = IPU_PIX_FMT_RGB565,
+	.flags = IMX_IPU_FB_USE_MODEDB,
+	.display = 1,
+};
+
+static struct imx_ipuv3_platform_data ipu_data = {
+	.fb_head0_platform_data = &babbage_fb0_data,
+	.fb_head1_platform_data = &babbage_fb1_data,
+};
+
+#define GPIO_DVI_DETECT	IMX_GPIO_NR(3, 28)
+#define GPIO_DVI_RESET	IMX_GPIO_NR(3, 5)
+#define GPIO_DVI_PWRDN	IMX_GPIO_NR(3, 6)
+#define GPIO_DVI_I2C	IMX_GPIO_NR(4, 14)
+
+static void mx51_babbage_fb_init(void)
+{
+	int ret;
+	struct gpio gpios[] = {
+		{
+			.gpio = GPIO_DVI_RESET,
+			.flags = GPIOF_OUT_INIT_LOW,
+			.label = "dvi reset",
+		}, {
+			.gpio = GPIO_DVI_PWRDN,
+			.flags = GPIOF_OUT_INIT_HIGH,
+			.label = "dvi powerdown",
+		},
+	};
+
+	ret = gpio_request_array(gpios, ARRAY_SIZE(gpios));
+	if (ret)
+		return;
+
+	imx51_add_ipuv3(&ipu_data);
+}
+
 /*
  * Board specific initialization.
  */
@@ -392,6 +472,8 @@ static void __init mxc_board_init(void)
 		ARRAY_SIZE(mx51_babbage_spi_board_info));
 	imx51_add_ecspi(0, &mx51_babbage_spi_pdata);
 	imx51_add_imx2_wdt(0, NULL);
+
+	mx51_babbage_fb_init();
 }
 
 static void __init mx51_babbage_timer_init(void)
-- 
1.7.2.3
