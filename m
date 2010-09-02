From: jason77.wang@gmail.com (Jason Wang)
Date: Thu,  2 Sep 2010 15:52:04 +0800
Subject: [PATCH 6/6] mx51_3ds: add SPI NOR flash in the board init stage
In-Reply-To: <1283413924-14210-6-git-send-email-jason77.wang@gmail.com>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-2-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-3-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-4-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-5-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-6-git-send-email-jason77.wang@gmail.com>
Message-ID: <1283413924-14210-7-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A 2M bytes SPI NOR flash(sst25vf016b) is soldered on the mx51_3ds
board, Now add registration for it in the board init stage.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 arch/arm/mach-mx5/board-mx51_3ds.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index 0cf4e14..8f1631d 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -13,6 +13,7 @@
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/input/matrix_keypad.h>
+#include <linux/spi/spi.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -145,6 +146,16 @@ static struct spi_imx_master mx51_3ds_spi2_pdata = {
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
 
 	imx51_add_spi_imx1(&mx51_3ds_spi2_pdata);
+	spi_register_board_info(mx51_3ds_spi_nor_device,
+				ARRAY_SIZE(mx51_3ds_spi_nor_device));
 
 	if (mxc_expio_init(MX51_CS5_BASE_ADDR, EXPIO_PARENT_INT))
 		printk(KERN_WARNING "Init of the debugboard failed, all "
-- 
1.5.6.5
