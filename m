From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Nov 2009 21:35:03 +0100
Subject: [PATCH 20/25] imx/pca100: use new nand device registration
In-Reply-To: <1258403708-10287-19-git-send-email-u.kleine-koenig@pengutronix.de>
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
Message-ID: <1258403708-10287-20-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/pca100.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mx2/pca100.c b/arch/arm/mach-mx2/pca100.c
index fe5b165..a828ed9 100644
--- a/arch/arm/mach-mx2/pca100.c
+++ b/arch/arm/mach-mx2/pca100.c
@@ -38,7 +38,6 @@
 #include <mach/spi.h>
 #endif
 #include <mach/imx-uart.h>
-#include <mach/mxc_nand.h>
 #include <mach/irqs.h>
 #include <mach/mmc.h>
 
@@ -98,11 +97,6 @@ static struct imxuart_platform_data uart_pdata = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-static struct mxc_nand_platform_data pca100_nand_board_info = {
-	.width = 1,
-	.hw_ecc = 1,
-};
-
 static struct platform_device *platform_devices[] __initdata = {
 	&mxc_w1_master_device,
 	&mxc_fec_device,
@@ -184,6 +178,10 @@ static struct imxmmc_platform_data sdhc_pdata = {
 
 static void __init pca100_init(void)
 {
+	struct mxc_nand_platform_data mxc_nand_pdata = {
+		.width = 1,
+		.hw_ecc = 1,
+	};
 	int ret;
 
 	ret = mxc_gpio_setup_multiple_pins(pca100_pins,
@@ -196,7 +194,7 @@ static void __init pca100_init(void)
 	mxc_gpio_mode(GPIO_PORTC | 29 | GPIO_GPIO | GPIO_IN);
 	mxc_register_device(&mxc_sdhc_device1, &sdhc_pdata);
 
-	mxc_register_device(&mxc_nand_device, &pca100_nand_board_info);
+	imx27_add_mxc_nand(&mxc_nand_pdata);
 
 	/* only the i2c master 1 is used on this CPU card */
 	i2c_register_board_info(1, pca100_i2c_devices,
-- 
1.6.5.2
