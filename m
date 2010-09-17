From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 17 Sep 2010 11:54:34 +0200
Subject: [PATCH 16/16] ARM: mx5/mx51_3ds: add SPI NOR flash in the board init
	stage
In-Reply-To: <20100917095247.GB30441@pengutronix.de>
References: <20100917095247.GB30441@pengutronix.de>
Message-ID: <1284717274-12850-16-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Wang <jason77.wang@gmail.com>

A 2M bytes SPI NOR flash(sst25vf016b) is soldered on the mx51_3ds
board.  So add the corresponding device for it.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/board-mx51_3ds.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index c9c4128..b9d3331 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -13,6 +13,7 @@
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/input/matrix_keypad.h>
+#include <linux/spi/spi.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -145,6 +146,16 @@ static const struct spi_imx_master mx51_3ds_ecspi2_pdata __initconst = {
 	.num_chipselect	= ARRAY_SIZE(mx51_3ds_spi2_cs),
 };
 
+static struct spi_board_info mx51_3ds_spi_nor_device[] = {
+	{
+	 .modalias = "m25p80",
+	 .max_speed_hz = 25000000,	/* max spi clock (SCK) speed in HZ */
+	 .bus_num = 1,
+	 .chip_select = 1,
+	 .mode = SPI_MODE_0,
+	 .platform_data = NULL,},
+};
+
 /*
  * Board specific initialization.
  */
@@ -155,6 +166,8 @@ static void __init mxc_board_init(void)
 	mxc_init_imx_uart();
 
 	imx51_add_ecspi(1, &mx51_3ds_ecspi2_pdata);
+	spi_register_board_info(mx51_3ds_spi_nor_device,
+				ARRAY_SIZE(mx51_3ds_spi_nor_device));
 
 	if (mxc_expio_init(MX51_CS5_BASE_ADDR, EXPIO_PARENT_INT))
 		printk(KERN_WARNING "Init of the debugboard failed, all "
-- 
1.7.2.3
