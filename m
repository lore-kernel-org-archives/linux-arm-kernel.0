From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Nov 2009 21:35:00 +0100
Subject: [PATCH 17/25] imx/eukrea_cpuimx27: use new nand device registration
In-Reply-To: <1258403708-10287-16-git-send-email-u.kleine-koenig@pengutronix.de>
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
Message-ID: <1258403708-10287-17-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/eukrea_cpuimx27.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mx2/eukrea_cpuimx27.c b/arch/arm/mach-mx2/eukrea_cpuimx27.c
index 7b18760..1a7ce75 100644
--- a/arch/arm/mach-mx2/eukrea_cpuimx27.c
+++ b/arch/arm/mach-mx2/eukrea_cpuimx27.c
@@ -38,7 +38,6 @@
 #include <mach/i2c.h>
 #include <mach/iomux.h>
 #include <mach/imx-uart.h>
-#include <mach/mxc_nand.h>
 
 #include "devices.h"
 
@@ -119,11 +118,6 @@ static struct imxuart_platform_data uart_pdata[] = {
 	},
 };
 
-static struct mxc_nand_platform_data eukrea_cpuimx27_nand_board_info = {
-	.width = 1,
-	.hw_ecc = 1,
-};
-
 static struct platform_device *platform_devices[] __initdata = {
 	&eukrea_cpuimx27_nor_mtd_device,
 	&mxc_fec_device,
@@ -184,12 +178,17 @@ static struct platform_device serial_device = {
 
 static void __init eukrea_cpuimx27_init(void)
 {
+	struct mxc_nand_platform_data mxc_nand_pdata = {
+		.width = 1,
+		.hw_ecc = 1,
+	};
+
 	mxc_gpio_setup_multiple_pins(eukrea_cpuimx27_pins,
 		ARRAY_SIZE(eukrea_cpuimx27_pins), "CPUIMX27");
 
 	mxc_register_device(&mxc_uart_device0, &uart_pdata[0]);
 
-	mxc_register_device(&mxc_nand_device, &eukrea_cpuimx27_nand_board_info);
+	imx27_add_mxc_nand(&mxc_nand_pdata);
 
 	i2c_register_board_info(0, eukrea_cpuimx27_i2c_devices,
 				ARRAY_SIZE(eukrea_cpuimx27_i2c_devices));
-- 
1.6.5.2
