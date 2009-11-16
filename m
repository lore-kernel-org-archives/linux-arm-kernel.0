From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Nov 2009 21:35:07 +0100
Subject: [PATCH 24/25] imx/pcm037: use new nand device registration
In-Reply-To: <1258403708-10287-23-git-send-email-u.kleine-koenig@pengutronix.de>
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
	<1258403708-10287-21-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-22-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-23-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1258403708-10287-24-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/pcm037.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mx3/pcm037.c b/arch/arm/mach-mx3/pcm037.c
index 6cbaabe..2b93c87 100644
--- a/arch/arm/mach-mx3/pcm037.c
+++ b/arch/arm/mach-mx3/pcm037.c
@@ -50,7 +50,6 @@
 #include <mach/mmc.h>
 #include <mach/mx3_camera.h>
 #include <mach/mx3fb.h>
-#include <mach/mxc_nand.h>
 
 #include "devices.h"
 #include "pcm037.h"
@@ -296,11 +295,6 @@ static struct platform_device pcm037_sram_device = {
 	.resource = &pcm038_sram_resource,
 };
 
-static struct mxc_nand_platform_data pcm037_nand_board_info = {
-	.width = 1,
-	.hw_ecc = 1,
-};
-
 static struct imxi2c_platform_data pcm037_i2c_1_data = {
 	.bitrate = 100000,
 };
@@ -548,6 +542,10 @@ static struct platform_device pcm970_sja1000 = {
  */
 static void __init mxc_board_init(void)
 {
+	struct mxc_nand_platform_data mxc_nand_pdata = {
+		.width = 1,
+		.hw_ecc = 1,
+	};
 	int ret;
 
 	mxc_iomux_setup_multiple_pins(pcm037_pins, ARRAY_SIZE(pcm037_pins),
@@ -586,7 +584,7 @@ static void __init mxc_board_init(void)
 	mxc_register_device(&mxc_i2c_device1, &pcm037_i2c_1_data);
 	mxc_register_device(&mxc_i2c_device2, &pcm037_i2c_2_data);
 
-	mxc_register_device(&mxc_nand_device, &pcm037_nand_board_info);
+	imx31_add_mxc_nand(&mxc_nand_pdata);
 	mxc_register_device(&mxcsdhc_device0, &sdhc_pdata);
 	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
 	mxc_register_device(&mx3_fb, &mx3fb_pdata);
-- 
1.6.5.2
