From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 17 Sep 2010 11:54:33 +0200
Subject: [PATCH 15/16] ARM: mx5/mx51_3ds: add eCSPI2 support on the imx51_3ds
	board
In-Reply-To: <20100917095247.GB30441@pengutronix.de>
References: <20100917095247.GB30441@pengutronix.de>
Message-ID: <1284717274-12850-15-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Wang <jason77.wang@gmail.com>

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/Kconfig          |    1 +
 arch/arm/mach-mx5/board-mx51_3ds.c |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 0848db5..d4d5feb 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -17,6 +17,7 @@ config MACH_MX51_BABBAGE
 
 config MACH_MX51_3DS
 	bool "Support MX51PDK (3DS)"
+	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_DEBUG_BOARD
 	help
 	  Include support for MX51PDK (3DS) platform. This includes specific
diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index f95c2fd..c9c4128 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -24,9 +24,11 @@
 #include <mach/imx-uart.h>
 #include <mach/3ds_debugboard.h>
 
+#include "devices-imx51.h"
 #include "devices.h"
 
 #define EXPIO_PARENT_INT	(MXC_INTERNAL_IRQS + GPIO_PORTA + 6)
+#define MX51_3DS_ECSPI2_CS	(GPIO_PORTC + 28)
 
 static struct pad_desc mx51_3ds_pads[] = {
 	/* UART1 */
@@ -61,6 +63,12 @@ static struct pad_desc mx51_3ds_pads[] = {
 	MX51_PAD_KEY_COL3__KEY_COL3,
 	MX51_PAD_KEY_COL4__KEY_COL4,
 	MX51_PAD_KEY_COL5__KEY_COL5,
+
+	/* eCSPI2 */
+	MX51_PAD_NANDF_RB2__ECSPI2_SCLK,
+	MX51_PAD_NANDF_RB3__ECSPI2_MISO,
+	MX51_PAD_NANDF_D15__ECSPI2_MOSI,
+	MX51_PAD_NANDF_D12__GPIO_3_28,
 };
 
 /* Serial ports */
@@ -127,6 +135,16 @@ static inline void mxc_init_keypad(void)
 }
 #endif
 
+static int mx51_3ds_spi2_cs[] = {
+	MXC_SPI_CS(0),
+	MX51_3DS_ECSPI2_CS,
+};
+
+static const struct spi_imx_master mx51_3ds_ecspi2_pdata __initconst = {
+	.chipselect	= mx51_3ds_spi2_cs,
+	.num_chipselect	= ARRAY_SIZE(mx51_3ds_spi2_cs),
+};
+
 /*
  * Board specific initialization.
  */
@@ -136,6 +154,8 @@ static void __init mxc_board_init(void)
 					ARRAY_SIZE(mx51_3ds_pads));
 	mxc_init_imx_uart();
 
+	imx51_add_ecspi(1, &mx51_3ds_ecspi2_pdata);
+
 	if (mxc_expio_init(MX51_CS5_BASE_ADDR, EXPIO_PARENT_INT))
 		printk(KERN_WARNING "Init of the debugboard failed, all "
 				    "devices on the board are unusable.\n");
-- 
1.7.2.3
