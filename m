From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  1 Aug 2011 11:38:28 +0200
Subject: [PATCH 7/8] ARM: imx/armadillo5x0: dynamically allocate physmap-flash
	device
In-Reply-To: <1312191509-21895-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110801093759.GD9250@pengutronix.de>
	<1312191509-21895-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1312191509-21895-7-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/mach-imx/mach-armadillo5x0.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
index ede2710..83e5e3a 100644
--- a/arch/arm/mach-imx/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -314,25 +314,19 @@ static struct mtd_partition armadillo5x0_nor_flash_partitions[] = {
 	},
 };
 
-static struct physmap_flash_data armadillo5x0_nor_flash_pdata = {
+static const struct physmap_flash_data
+		armadillo5x0_nor_flash_pdata __initconst = {
 	.width		= 2,
 	.parts		= armadillo5x0_nor_flash_partitions,
 	.nr_parts	= ARRAY_SIZE(armadillo5x0_nor_flash_partitions),
 };
 
-static struct resource armadillo5x0_nor_flash_resource = {
+static const struct resource armadillo5x0_nor_flash_resource __initconst = {
 	.flags		= IORESOURCE_MEM,
 	.start		= MX31_CS0_BASE_ADDR,
 	.end		= MX31_CS0_BASE_ADDR + SZ_64M - 1,
 };
 
-static struct platform_device armadillo5x0_nor_flash = {
-	.name			= "physmap-flash",
-	.id			= -1,
-	.num_resources		= 1,
-	.resource		= &armadillo5x0_nor_flash_resource,
-};
-
 /*
  * FB support
  */
@@ -514,8 +508,10 @@ static void __init armadillo5x0_init(void)
 	imx31_add_mx3_sdc_fb(&mx3fb_pdata);
 
 	/* Register NOR Flash */
-	mxc_register_device(&armadillo5x0_nor_flash,
-			    &armadillo5x0_nor_flash_pdata);
+	platform_device_register_resndata(NULL, "physmap-flash", -1,
+			&armadillo5x0_nor_flash_resource, 1,
+			&armadillo5x0_nor_flash_pdata,
+			sizeof(armadillo5x0_nor_flash_pdata));
 
 	/* Register NAND Flash */
 	imx31_add_mxc_nand(&armadillo5x0_nand_board_info);
-- 
1.7.5.4
