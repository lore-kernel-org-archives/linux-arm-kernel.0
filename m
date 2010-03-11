From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Thu, 11 Mar 2010 08:55:17 +0000
Subject: [PATCH] omap: Add DSI regulator supply to OMAP3EVM board file
Message-ID: <mailman.234.1268351921.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With recent changes happened in OMAP2/3 DSS library for regulator interface, it
is required to define DSI regulator supply, without this DSS (in turn Fbdev)
fails to get regulator.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 017bb2f..a05de10 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -514,9 +514,15 @@ static struct regulator_init_data omap3_evm_vdac = {
 };
 
 /* VPLL2 for digital video outputs */
-static struct regulator_consumer_supply omap3_evm_vpll2_supply = {
-	.supply		= "vdvi",
-	.dev		= &omap3_evm_lcd_device.dev,
+static struct regulator_consumer_supply omap3_evm_vpll2_supplies[] = {
+	{
+		.supply		= "vdvi",
+		.dev		= &omap3_evm_lcd_device.dev,
+	},
+	{
+		.supply		= "vdds_dsi",
+		.dev		= &omap3_evm_dss_device.dev,
+	},
 };
 
 static struct regulator_init_data omap3_evm_vpll2 = {
@@ -530,8 +536,8 @@ static struct regulator_init_data omap3_evm_vpll2 = {
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &omap3_evm_vpll2_supply,
+	.num_consumer_supplies	= ARRAY_SIZE(omap3_evm_vpll2_supplies),
+	.consumer_supplies	= omap3_evm_vpll2_supplies,
 };
 
 static struct twl4030_platform_data omap3evm_twldata = {
