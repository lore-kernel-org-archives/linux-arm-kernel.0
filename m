From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  1 Aug 2011 11:38:27 +0200
Subject: [PATCH 6/8] ARM: imx/mx1ads: dynamically allocate physmap-flash device
In-Reply-To: <1312191509-21895-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110801093759.GD9250@pengutronix.de>
	<1312191509-21895-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1312191509-21895-6-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/mach-mx1ads.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx1ads.c b/arch/arm/mach-imx/mach-mx1ads.c
index 5cd8bee..e8867ff 100644
--- a/arch/arm/mach-imx/mach-mx1ads.c
+++ b/arch/arm/mach-imx/mach-mx1ads.c
@@ -68,23 +68,16 @@ static const struct imxuart_platform_data uart1_pdata __initconst = {
  * Physmap flash
  */
 
-static struct physmap_flash_data mx1ads_flash_data = {
+static const struct physmap_flash_data mx1ads_flash_data __initconst = {
 	.width		= 4,		/* bankwidth in bytes */
 };
 
-static struct resource flash_resource = {
+static const struct resource flash_resource __initconst = {
 	.start	= MX1_CS0_PHYS,
 	.end	= MX1_CS0_PHYS + SZ_32M - 1,
 	.flags	= IORESOURCE_MEM,
 };
 
-static struct platform_device flash_device = {
-	.name	= "physmap-flash",
-	.id	= 0,
-	.resource = &flash_resource,
-	.num_resources = 1,
-};
-
 /*
  * I2C
  */
@@ -125,7 +118,9 @@ static void __init mx1ads_init(void)
 	imx1_add_imx_uart1(&uart1_pdata);
 
 	/* Physmap flash */
-	mxc_register_device(&flash_device, &mx1ads_flash_data);
+	platform_device_register_resndata(NULL, "physmap-flash", 0,
+			&flash_resource, 1,
+			&mx1ads_flash_data, sizeof(mx1ads_flash_data));
 
 	/* I2C */
 	i2c_register_board_info(0, mx1ads_i2c_devices,
-- 
1.7.5.4
