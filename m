From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Nov 2009 21:35:02 +0100
Subject: [PATCH 19/25] imx/mx27ads: use new nand device registration
In-Reply-To: <1258403708-10287-18-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091116203406.GA6546@pengutronix.de>
	<1258403708-10287-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-16-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-17-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-18-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1258403708-10287-19-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/mx27ads.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mx2/mx27ads.c b/arch/arm/mach-mx2/mx27ads.c
index 83e412b..3710a84 100644
--- a/arch/arm/mach-mx2/mx27ads.c
+++ b/arch/arm/mach-mx2/mx27ads.c
@@ -35,7 +35,6 @@
 #include <mach/imx-uart.h>
 #include <mach/iomux.h>
 #include <mach/board-mx27ads.h>
-#include <mach/mxc_nand.h>
 #include <mach/i2c.h>
 #include <mach/imxfb.h>
 #include <mach/mmc.h>
@@ -141,11 +140,6 @@ static unsigned int mx27ads_pins[] = {
 	PB9_PF_SD2_CLK,
 };
 
-static struct mxc_nand_platform_data mx27ads_nand_board_info = {
-	.width = 1,
-	.hw_ecc = 1,
-};
-
 /* ADS's NOR flash */
 static struct physmap_flash_data mx27ads_flash_data = {
 	.width = 2,
@@ -281,6 +275,11 @@ static struct imxuart_platform_data uart_pdata[] = {
 
 static void __init mx27ads_board_init(void)
 {
+	struct mxc_nand_platform_data mxc_nand_pdata = {
+		.width = 1,
+		.hw_ecc = 1,
+	};
+
 	mxc_gpio_setup_multiple_pins(mx27ads_pins, ARRAY_SIZE(mx27ads_pins),
 			"mx27ads");
 
@@ -290,7 +289,7 @@ static void __init mx27ads_board_init(void)
 	mxc_register_device(&mxc_uart_device3, &uart_pdata[3]);
 	mxc_register_device(&mxc_uart_device4, &uart_pdata[4]);
 	mxc_register_device(&mxc_uart_device5, &uart_pdata[5]);
-	mxc_register_device(&mxc_nand_device, &mx27ads_nand_board_info);
+	imx27_add_mxc_nand(&mxc_nand_pdata);
 
 	/* only the i2c master 1 is used on this CPU card */
 	i2c_register_board_info(1, mx27ads_i2c_devices,
-- 
1.6.5.2
