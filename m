From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Nov 2009 21:35:04 +0100
Subject: [PATCH 21/25] imx/pcm038: use new nand device registration
In-Reply-To: <1258403708-10287-20-git-send-email-u.kleine-koenig@pengutronix.de>
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
	<1258403708-10287-19-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-20-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1258403708-10287-21-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/pcm038.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mx2/pcm038.c b/arch/arm/mach-mx2/pcm038.c
index 906d59b..0f2211c 100644
--- a/arch/arm/mach-mx2/pcm038.c
+++ b/arch/arm/mach-mx2/pcm038.c
@@ -38,7 +38,6 @@
 #include <mach/i2c.h>
 #include <mach/iomux.h>
 #include <mach/imx-uart.h>
-#include <mach/mxc_nand.h>
 #include <mach/spi.h>
 
 #include "devices.h"
@@ -157,11 +156,6 @@ static struct imxuart_platform_data uart_pdata[] = {
 	},
 };
 
-static struct mxc_nand_platform_data pcm038_nand_board_info = {
-	.width = 1,
-	.hw_ecc = 1,
-};
-
 static struct platform_device *platform_devices[] __initdata = {
 	&pcm038_nor_mtd_device,
 	&mxc_w1_master_device,
@@ -281,6 +275,11 @@ static struct spi_board_info pcm038_spi_board_info[] __initdata = {
 
 static void __init pcm038_init(void)
 {
+	struct mxc_nand_platform_data mxc_nand_pdata = {
+		.width = 1,
+		.hw_ecc = 1,
+	};
+
 	mxc_gpio_setup_multiple_pins(pcm038_pins, ARRAY_SIZE(pcm038_pins),
 			"PCM038");
 
@@ -291,7 +290,7 @@ static void __init pcm038_init(void)
 	mxc_register_device(&mxc_uart_device2, &uart_pdata[2]);
 
 	mxc_gpio_mode(PE16_AF_OWIRE);
-	mxc_register_device(&mxc_nand_device, &pcm038_nand_board_info);
+	imx27_add_mxc_nand(&mxc_nand_pdata);
 
 	/* only the i2c master 1 is used on this CPU card */
 	i2c_register_board_info(1, pcm038_i2c_devices,
-- 
1.6.5.2
