From: manjunath.hadli@ti.com (Manjunath Hadli)
Date: Tue, 13 Dec 2011 16:53:32 +0530
Subject: [PATCH v5 08/11] davinci: dm644x: change vpfe capture structure
 variables for consistency
In-Reply-To: <1323775415-24504-1-git-send-email-manjunath.hadli@ti.com>
References: <1323775415-24504-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <1323775415-24504-9-git-send-email-manjunath.hadli@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SoC and board prefixes to variable names so that it is
consistent with the rest of the file.

Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
Acked-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c |   24 ++++++++++++------------
 arch/arm/mach-davinci/dm644x.c           |   12 ++++++------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 00e8599..fbd3856 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -189,7 +189,7 @@ static struct platform_device davinci_fb_device = {
 	.num_resources = 0,
 };
 
-static struct tvp514x_platform_data tvp5146_pdata = {
+static struct tvp514x_platform_data dm644xevm_tvp5146_pdata = {
 	.clk_polarity = 0,
 	.hs_polarity = 1,
 	.vs_polarity = 1
@@ -197,7 +197,7 @@ static struct tvp514x_platform_data tvp5146_pdata = {
 
 #define TVP514X_STD_ALL	(V4L2_STD_NTSC | V4L2_STD_PAL)
 /* Inputs available at the TVP5146 */
-static struct v4l2_input tvp5146_inputs[] = {
+static struct v4l2_input dm644xevm_tvp5146_inputs[] = {
 	{
 		.index = 0,
 		.name = "Composite",
@@ -217,7 +217,7 @@ static struct v4l2_input tvp5146_inputs[] = {
  * ouput that goes to vpfe. There is a one to one correspondence
  * with tvp5146_inputs
  */
-static struct vpfe_route tvp5146_routes[] = {
+static struct vpfe_route dm644xevm_tvp5146_routes[] = {
 	{
 		.input = INPUT_CVBS_VI2B,
 		.output = OUTPUT_10BIT_422_EMBEDDED_SYNC,
@@ -228,13 +228,13 @@ static struct vpfe_route tvp5146_routes[] = {
 	},
 };
 
-static struct vpfe_subdev_info vpfe_sub_devs[] = {
+static struct vpfe_subdev_info dm644xevm_vpfe_sub_devs[] = {
 	{
 		.name = "tvp5146",
 		.grp_id = 0,
-		.num_inputs = ARRAY_SIZE(tvp5146_inputs),
-		.inputs = tvp5146_inputs,
-		.routes = tvp5146_routes,
+		.num_inputs = ARRAY_SIZE(dm644xevm_tvp5146_inputs),
+		.inputs = dm644xevm_tvp5146_inputs,
+		.routes = dm644xevm_tvp5146_routes,
 		.can_route = 1,
 		.ccdc_if_params = {
 			.if_type = VPFE_BT656,
@@ -243,15 +243,15 @@ static struct vpfe_subdev_info vpfe_sub_devs[] = {
 		},
 		.board_info = {
 			I2C_BOARD_INFO("tvp5146", 0x5d),
-			.platform_data = &tvp5146_pdata,
+			.platform_data = &dm644xevm_tvp5146_pdata,
 		},
 	},
 };
 
-static struct vpfe_config vpfe_cfg = {
-	.num_subdevs = ARRAY_SIZE(vpfe_sub_devs),
+static struct vpfe_config dm644xevm_capture_cfg = {
+	.num_subdevs = ARRAY_SIZE(dm644xevm_vpfe_sub_devs),
 	.i2c_adapter_id = 1,
-	.sub_devs = vpfe_sub_devs,
+	.sub_devs = dm644xevm_vpfe_sub_devs,
 	.card_name = "DM6446 EVM",
 	.ccdc = "DM6446 CCDC",
 };
@@ -625,7 +625,7 @@ static void __init
 davinci_evm_map_io(void)
 {
 	/* setup input configuration for VPFE input devices */
-	dm644x_set_vpfe_config(&vpfe_cfg);
+	dm644x_set_vpfe_config(&dm644xevm_capture_cfg);
 	dm644x_init();
 }
 
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 3802b59..1d9be87 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -614,7 +614,7 @@ static struct platform_device dm644x_vpss_device = {
 	.resource		= dm644x_vpss_resources,
 };
 
-static struct resource vpfe_resources[] = {
+static struct resource dm644x_vpfe_resources[] = {
 	{
 		.start          = IRQ_VDINT0,
 		.end            = IRQ_VDINT0,
@@ -648,11 +648,11 @@ static struct platform_device dm644x_ccdc_dev = {
 	},
 };
 
-static struct platform_device vpfe_capture_dev = {
+static struct platform_device dm644x_vpfe_dev = {
 	.name		= CAPTURE_DRV_NAME,
 	.id		= -1,
-	.num_resources	= ARRAY_SIZE(vpfe_resources),
-	.resource	= vpfe_resources,
+	.num_resources	= ARRAY_SIZE(dm644x_vpfe_resources),
+	.resource	= dm644x_vpfe_resources,
 	.dev = {
 		.dma_mask		= &vpfe_capture_dma_mask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
@@ -661,7 +661,7 @@ static struct platform_device vpfe_capture_dev = {
 
 void dm644x_set_vpfe_config(struct vpfe_config *cfg)
 {
-	vpfe_capture_dev.dev.platform_data = cfg;
+	dm644x_vpfe_dev.dev.platform_data = cfg;
 }
 
 /*----------------------------------------------------------------------*/
@@ -809,7 +809,7 @@ static int __init dm644x_init_devices(void)
 
 	platform_device_register(&dm644x_vpss_device);
 	platform_device_register(&dm644x_ccdc_dev);
-	platform_device_register(&vpfe_capture_dev);
+	platform_device_register(&dm644x_vpfe_dev);
 
 	return 0;
 }
-- 
1.6.2.4
