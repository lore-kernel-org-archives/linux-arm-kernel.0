From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Nov 2009 21:35:05 +0100
Subject: [PATCH 22/25] imx/armadillo5x0: use new nand device registration
In-Reply-To: <1258403708-10287-21-git-send-email-u.kleine-koenig@pengutronix.de>
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
Message-ID: <1258403708-10287-22-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/armadillo5x0.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-mx3/armadillo5x0.c b/arch/arm/mach-mx3/armadillo5x0.c
index 776c0ee..e2d36b4 100644
--- a/arch/arm/mach-mx3/armadillo5x0.c
+++ b/arch/arm/mach-mx3/armadillo5x0.c
@@ -48,7 +48,6 @@
 #include <mach/mmc.h>
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
-#include <mach/mxc_nand.h>
 
 #include "devices.h"
 #include "crm_regs.h"
@@ -100,14 +99,6 @@ static int armadillo5x0_pins[] = {
 };
 
 /*
- * NAND Flash
- */
-static struct mxc_nand_platform_data armadillo5x0_nand_flash_pdata = {
-	.width		= 1,
-	.hw_ecc		= 1,
-};
-
-/*
  * MTD NOR Flash
  */
 static struct mtd_partition armadillo5x0_nor_flash_partitions[] = {
@@ -307,6 +298,11 @@ static struct platform_device *devices[] __initdata = {
  */
 static void __init armadillo5x0_init(void)
 {
+	struct mxc_nand_platform_data mxc_nand_pdata = {
+		.width = 1,
+		.hw_ecc = 1,
+	};
+
 	mxc_iomux_setup_multiple_pins(armadillo5x0_pins,
 			ARRAY_SIZE(armadillo5x0_pins), "armadillo5x0");
 
@@ -331,7 +327,7 @@ static void __init armadillo5x0_init(void)
 			    &armadillo5x0_nor_flash_pdata);
 
 	/* Register NAND Flash */
-	mxc_register_device(&mxc_nand_device, &armadillo5x0_nand_flash_pdata);
+	imx31_add_mxc_nand(&mxc_nand_pdata);
 
 	/* set NAND page size to 2k if not configured via boot mode pins */
 	__raw_writel(__raw_readl(MXC_CCM_RCSR) | (1 << 30), MXC_CCM_RCSR);
-- 
1.6.5.2
