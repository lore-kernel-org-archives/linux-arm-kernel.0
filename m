From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Nov 2009 21:35:01 +0100
Subject: [PATCH 18/25] imx/mx21ads: use new nand device registration
In-Reply-To: <1258403708-10287-17-git-send-email-u.kleine-koenig@pengutronix.de>
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
Message-ID: <1258403708-10287-18-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/mx21ads.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mx2/mx21ads.c b/arch/arm/mach-mx2/mx21ads.c
index cf5f77c..ae7ff28 100644
--- a/arch/arm/mach-mx2/mx21ads.c
+++ b/arch/arm/mach-mx2/mx21ads.c
@@ -31,7 +31,6 @@
 #include <mach/imx-uart.h>
 #include <mach/imxfb.h>
 #include <mach/iomux.h>
-#include <mach/mxc_nand.h>
 #include <mach/mmc.h>
 #include <mach/board-mx21ads.h>
 
@@ -227,11 +226,6 @@ static struct imxmmc_platform_data mx21ads_sdhc_pdata = {
 	.exit = mx21ads_sdhc_exit,
 };
 
-static struct mxc_nand_platform_data mx21ads_nand_board_info = {
-	.width = 1,
-	.hw_ecc = 1,
-};
-
 static struct map_desc mx21ads_io_desc[] __initdata = {
 	/*
 	 * Memory-mapped I/O on MX21ADS Base board:
@@ -260,6 +254,11 @@ static struct platform_device *platform_devices[] __initdata = {
 
 static void __init mx21ads_board_init(void)
 {
+	struct mxc_nand_platform_data mxc_nand_pdata = {
+		.width = 1,
+		.hw_ecc = 1,
+	};
+
 	mxc_gpio_setup_multiple_pins(mx21ads_pins, ARRAY_SIZE(mx21ads_pins),
 			"mx21ads");
 
@@ -268,7 +267,7 @@ static void __init mx21ads_board_init(void)
 	mxc_register_device(&mxc_uart_device3, &uart_pdata);
 	mxc_register_device(&mxc_fb_device, &mx21ads_fb_data);
 	mxc_register_device(&mxc_sdhc_device0, &mx21ads_sdhc_pdata);
-	mxc_register_device(&mxc_nand_device, &mx21ads_nand_board_info);
+	imx21_add_mxc_nand(&mxc_nand_pdata);
 
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
-- 
1.6.5.2
