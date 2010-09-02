From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  2 Sep 2010 16:42:03 +0200
Subject: [PATCH 6/6] ARM: mx5/mx51_babbage: Add spi support
In-Reply-To: <20100902143908.GK14214@pengutronix.de>
References: <20100902143908.GK14214@pengutronix.de>
Message-ID: <1283438523-19697-6-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/Kconfig              |    1 +
 arch/arm/mach-mx5/board-mx51_babbage.c |   31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 0848db5..f55b0f5 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -10,6 +10,7 @@ comment "MX5 platforms:"
 
 config MACH_MX51_BABBAGE
 	bool "Support MX51 BABBAGE platforms"
+	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
 	  Include support for MX51 Babbage platform, also known as MX51EVK in
 	  u-boot. This includes specific configurations for the board and its
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 6e384d9..4ed0a9a 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/fsl_devices.h>
+#include <linux/spi/spi.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
@@ -31,6 +32,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 
+#include "devices-imx51.h"
 #include "devices.h"
 
 #define BABBAGE_USB_HUB_RESET	(0*32 + 7)	/* GPIO_1_7 */
@@ -240,6 +242,31 @@ static int __init babbage_otg_mode(char *options)
 }
 __setup("otg_mode=", babbage_otg_mode);
 
+#define BABBAGE_ECSPI1_CS0	(3 * 32 + 24)
+#define BABBAGE_ECSPI1_CS1	(3 * 32 + 25)
+
+static const struct spi_board_info mx51_babbage_spi_board_info[] __initconst = {
+	{
+		/* mc13892 */
+		.modalias = "spidev",
+		.max_speed_hz = 300000,
+		.bus_num = 0,
+		.chip_select = 0,
+	}, {
+		.modalias = "spidev",
+		.max_speed_hz = 300000,
+		.bus_num = 0,
+		.chip_select = 1,
+	},
+};
+
+static int mx51_babbage_ecspi0_cs[] = {BABBAGE_ECSPI1_CS0, BABBAGE_ECSPI1_CS1};
+
+static const struct spi_imx_master mx51_babbage_ecspi0_data __initconst = {
+	.chipselect = mx51_babbage_ecspi0_cs,
+	.num_chipselect = ARRAY_SIZE(mx51_babbage_ecspi0_cs),
+};
+
 /*
  * Board specific initialization.
  */
@@ -268,6 +295,10 @@ static void __init mxc_board_init(void)
 	/* setback USBH1_STP to be function */
 	mxc_iomux_v3_setup_pad(&usbh1stp);
 	babbage_usbhub_reset();
+
+	spi_register_board_info(mx51_babbage_spi_board_info,
+			ARRAY_SIZE(mx51_babbage_spi_board_info));
+	imx51_add_ecspi_imx(0, &mx51_babbage_ecspi0_data);
 }
 
 static void __init mx51_babbage_timer_init(void)
-- 
1.7.1
