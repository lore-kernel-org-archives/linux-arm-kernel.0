From: jason77.wang@gmail.com (Jason Wang)
Date: Thu,  2 Sep 2010 15:52:03 +0800
Subject: [PATCH 5/6] mx51_3ds: add eCSPI2 support on the imx51_3ds board
In-Reply-To: <1283413924-14210-5-git-send-email-jason77.wang@gmail.com>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-2-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-3-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-4-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-5-git-send-email-jason77.wang@gmail.com>
Message-ID: <1283413924-14210-6-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add platform data for eCSPI2 and register it through spi_imx dynamical
register interface.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 arch/arm/mach-mx5/board-mx51_3ds.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index f95c2fd..0cf4e14 100644
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
+static struct spi_imx_master mx51_3ds_spi2_pdata = {
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
 
+	imx51_add_spi_imx1(&mx51_3ds_spi2_pdata);
+
 	if (mxc_expio_init(MX51_CS5_BASE_ADDR, EXPIO_PARENT_INT))
 		printk(KERN_WARNING "Init of the debugboard failed, all "
 				    "devices on the board are unusable.\n");
-- 
1.5.6.5
