From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 30 Dec 2016 09:33:31 -0200
Subject: [PATCH v2 4/6] ARM: mach-mx35_3ds: Remove camera support
In-Reply-To: <1483097613-21481-1-git-send-email-festevam@gmail.com>
References: <1483097613-21481-1-git-send-email-festevam@gmail.com>
Message-ID: <1483097613-21481-4-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Since commit c93cc61475ebbe6e66 ("[media] staging/media: remove deprecated
mx3 driver") the mx3 camera driver has been removed, so remove the camera
support from the board file as well.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Also remove CSI pins from IOMUX definition

 arch/arm/mach-imx/mach-mx35_3ds.c | 103 --------------------------------------
 1 file changed, 103 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index c8c2e09..1c33a6c 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -41,12 +41,9 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
-#include <asm/memblock.h>
 
 #include <video/platform_lcd.h>
 
-#include <media/soc_camera.h>
-
 #include "3ds_debugboard.h"
 #include "common.h"
 #include "devices-imx35.h"
@@ -233,83 +230,10 @@ static const iomux_v3_cfg_t mx35pdk_pads[] __initconst = {
 	MX35_PAD_D3_VSYNC__IPU_DISPB_D3_VSYNC,
 	MX35_PAD_D3_REV__IPU_DISPB_D3_REV,
 	MX35_PAD_D3_CLS__IPU_DISPB_D3_CLS,
-	/* CSI */
-	MX35_PAD_TX1__IPU_CSI_D_6,
-	MX35_PAD_TX0__IPU_CSI_D_7,
-	MX35_PAD_CSI_D8__IPU_CSI_D_8,
-	MX35_PAD_CSI_D9__IPU_CSI_D_9,
-	MX35_PAD_CSI_D10__IPU_CSI_D_10,
-	MX35_PAD_CSI_D11__IPU_CSI_D_11,
-	MX35_PAD_CSI_D12__IPU_CSI_D_12,
-	MX35_PAD_CSI_D13__IPU_CSI_D_13,
-	MX35_PAD_CSI_D14__IPU_CSI_D_14,
-	MX35_PAD_CSI_D15__IPU_CSI_D_15,
-	MX35_PAD_CSI_HSYNC__IPU_CSI_HSYNC,
-	MX35_PAD_CSI_MCLK__IPU_CSI_MCLK,
-	MX35_PAD_CSI_PIXCLK__IPU_CSI_PIXCLK,
-	MX35_PAD_CSI_VSYNC__IPU_CSI_VSYNC,
 	/*PMIC IRQ*/
 	MX35_PAD_GPIO2_0__GPIO2_0,
 };
 
-/*
- * Camera support
-*/
-static phys_addr_t mx3_camera_base __initdata;
-#define MX35_3DS_CAMERA_BUF_SIZE SZ_8M
-
-static const struct mx3_camera_pdata mx35_3ds_camera_pdata __initconst = {
-	.flags = MX3_CAMERA_DATAWIDTH_8,
-	.mclk_10khz = 2000,
-};
-
-static int __init imx35_3ds_init_camera(void)
-{
-	int dma, ret = -ENOMEM;
-	struct platform_device *pdev =
-		imx35_alloc_mx3_camera(&mx35_3ds_camera_pdata);
-
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
-
-	if (!mx3_camera_base)
-		goto err;
-
-	dma = dma_declare_coherent_memory(&pdev->dev,
-					mx3_camera_base, mx3_camera_base,
-					MX35_3DS_CAMERA_BUF_SIZE,
-					DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
-
-	if (!(dma & DMA_MEMORY_MAP))
-		goto err;
-
-	ret = platform_device_add(pdev);
-	if (ret)
-err:
-		platform_device_put(pdev);
-
-	return ret;
-}
-
-static struct i2c_board_info mx35_3ds_i2c_camera = {
-	I2C_BOARD_INFO("ov2640", 0x30),
-};
-
-static struct soc_camera_link iclink_ov2640 = {
-	.bus_id		= 0,
-	.board_info	= &mx35_3ds_i2c_camera,
-	.i2c_adapter_id	= 0,
-	.power		= NULL,
-};
-
-static struct platform_device mx35_3ds_ov2640 = {
-	.name	= "soc-camera-pdrv",
-	.id	= 0,
-	.dev	= {
-		.platform_data = &iclink_ov2640,
-	},
-};
-
 static struct regulator_consumer_supply sw1_consumers[] = {
 	{
 		.supply = "cpu_vcc",
@@ -321,10 +245,6 @@ static struct regulator_consumer_supply vcam_consumers[] = {
 	REGULATOR_SUPPLY("VDDA", "0-000a"),
 };
 
-static struct regulator_consumer_supply vaudio_consumers[] = {
-	REGULATOR_SUPPLY("cmos_vio", "soc-camera-pdrv.0"),
-};
-
 static struct regulator_init_data sw1_init = {
 	.constraints = {
 		.name = "SW1",
@@ -405,18 +325,6 @@ static struct regulator_init_data vvideo_init = {
 	}
 };
 
-static struct regulator_init_data vaudio_init = {
-	.constraints = {
-		.name = "VAUDIO",
-		.min_uV = 2300000,
-		.max_uV = 3000000,
-		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
-		.boot_on = 1
-	},
-	.num_consumer_supplies = ARRAY_SIZE(vaudio_consumers),
-	.consumer_supplies = vaudio_consumers,
-};
-
 static struct regulator_init_data vcam_init = {
 	.constraints = {
 		.name = "VCAM",
@@ -460,7 +368,6 @@ static struct mc13xxx_regulator_init_data mx35_3ds_regulators[] = {
 	{ .id = MC13892_VDIG, .init_data = &vdig_init },
 	{ .id = MC13892_VUSB2, .init_data = &vusb2_init },
 	{ .id = MC13892_VVIDEO, .init_data = &vvideo_init },
-	{ .id = MC13892_VAUDIO, .init_data = &vaudio_init },
 	{ .id = MC13892_VCAM, .init_data = &vcam_init },
 	{ .id = MC13892_VGEN1, .init_data = &vgen1_init },
 	{ .id = MC13892_VGEN2, .init_data = &vgen2_init },
@@ -583,8 +490,6 @@ static void __init mx35_3ds_init(void)
 		0, i2c_devices_3ds, ARRAY_SIZE(i2c_devices_3ds));
 
 	imx35_add_ipu_core();
-	platform_device_register(&mx35_3ds_ov2640);
-	imx35_3ds_init_camera();
 }
 
 static void __init mx35_3ds_late_init(void)
@@ -607,13 +512,6 @@ static void __init mx35pdk_timer_init(void)
 	mx35_clocks_init();
 }
 
-static void __init mx35_3ds_reserve(void)
-{
-	/* reserve MX35_3DS_CAMERA_BUF_SIZE bytes for mx3-camera */
-	mx3_camera_base = arm_memblock_steal(MX35_3DS_CAMERA_BUF_SIZE,
-					 MX35_3DS_CAMERA_BUF_SIZE);
-}
-
 MACHINE_START(MX35_3DS, "Freescale MX35PDK")
 	/* Maintainer: Freescale Semiconductor, Inc */
 	.atag_offset = 0x100,
@@ -623,6 +521,5 @@ MACHINE_START(MX35_3DS, "Freescale MX35PDK")
 	.init_time	= mx35pdk_timer_init,
 	.init_machine = mx35_3ds_init,
 	.init_late	= mx35_3ds_late_init,
-	.reserve = mx35_3ds_reserve,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
2.7.4
