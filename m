From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 30 Dec 2016 09:33:32 -0200
Subject: [PATCH v2 5/6] ARM: mach-pcm037: Remove camera support
In-Reply-To: <1483097613-21481-1-git-send-email-festevam@gmail.com>
References: <1483097613-21481-1-git-send-email-festevam@gmail.com>
Message-ID: <1483097613-21481-5-git-send-email-festevam@gmail.com>
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

 arch/arm/mach-imx/mach-pcm037.c | 115 ----------------------------------------
 1 file changed, 115 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index 9f0f55b..b787ba6 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -31,17 +31,13 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 #include <linux/gfp.h>
-#include <linux/memblock.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
 
-#include <media/soc_camera.h>
-
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
-#include <asm/memblock.h>
 
 #include "common.h"
 #include "devices-imx31.h"
@@ -150,22 +146,6 @@ static unsigned int pcm037_pins[] = {
 	MX31_PIN_D3_SPL__D3_SPL,
 	MX31_PIN_D3_CLS__D3_CLS,
 	MX31_PIN_LCS0__GPIO3_23,
-	/* CSI */
-	IOMUX_MODE(MX31_PIN_CSI_D5, IOMUX_CONFIG_GPIO),
-	MX31_PIN_CSI_D6__CSI_D6,
-	MX31_PIN_CSI_D7__CSI_D7,
-	MX31_PIN_CSI_D8__CSI_D8,
-	MX31_PIN_CSI_D9__CSI_D9,
-	MX31_PIN_CSI_D10__CSI_D10,
-	MX31_PIN_CSI_D11__CSI_D11,
-	MX31_PIN_CSI_D12__CSI_D12,
-	MX31_PIN_CSI_D13__CSI_D13,
-	MX31_PIN_CSI_D14__CSI_D14,
-	MX31_PIN_CSI_D15__CSI_D15,
-	MX31_PIN_CSI_HSYNC__CSI_HSYNC,
-	MX31_PIN_CSI_MCLK__CSI_MCLK,
-	MX31_PIN_CSI_PIXCLK__CSI_PIXCLK,
-	MX31_PIN_CSI_VSYNC__CSI_VSYNC,
 	/* GPIO */
 	IOMUX_MODE(MX31_PIN_ATA_DMACK, IOMUX_CONFIG_GPIO),
 	/* OTG */
@@ -289,34 +269,6 @@ static struct at24_platform_data board_eeprom = {
 	.flags = AT24_FLAG_ADDR16,
 };
 
-static int pcm037_camera_power(struct device *dev, int on)
-{
-	/* disable or enable the camera in X7 or X8 PCM970 connector */
-	gpio_set_value(IOMUX_TO_GPIO(MX31_PIN_CSI_D5), !on);
-	return 0;
-}
-
-static struct i2c_board_info pcm037_i2c_camera[] = {
-	{
-		I2C_BOARD_INFO("mt9t031", 0x5d),
-	}, {
-		I2C_BOARD_INFO("mt9v022", 0x48),
-	},
-};
-
-static struct soc_camera_link iclink_mt9v022 = {
-	.bus_id		= 0,		/* Must match with the camera ID */
-	.board_info	= &pcm037_i2c_camera[1],
-	.i2c_adapter_id	= 2,
-};
-
-static struct soc_camera_link iclink_mt9t031 = {
-	.bus_id		= 0,		/* Must match with the camera ID */
-	.power		= pcm037_camera_power,
-	.board_info	= &pcm037_i2c_camera[0],
-	.i2c_adapter_id	= 2,
-};
-
 static struct i2c_board_info pcm037_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("at24", 0x52), /* E0=0, E1=1, E2=0 */
@@ -326,22 +278,6 @@ static struct i2c_board_info pcm037_i2c_devices[] = {
 	}
 };
 
-static struct platform_device pcm037_mt9t031 = {
-	.name	= "soc-camera-pdrv",
-	.id	= 0,
-	.dev	= {
-		.platform_data = &iclink_mt9t031,
-	},
-};
-
-static struct platform_device pcm037_mt9v022 = {
-	.name	= "soc-camera-pdrv",
-	.id	= 1,
-	.dev	= {
-		.platform_data = &iclink_mt9v022,
-	},
-};
-
 /* Not connected by default */
 #ifdef PCM970_SDHC_RW_SWITCH
 static int pcm970_sdhc1_get_ro(struct device *dev)
@@ -403,42 +339,9 @@ static const struct imxmmc_platform_data sdhc_pdata __initconst = {
 	.exit = pcm970_sdhc1_exit,
 };
 
-struct mx3_camera_pdata camera_pdata __initdata = {
-	.flags		= MX3_CAMERA_DATAWIDTH_8 | MX3_CAMERA_DATAWIDTH_10,
-	.mclk_10khz	= 2000,
-};
-
-static phys_addr_t mx3_camera_base __initdata;
-#define MX3_CAMERA_BUF_SIZE SZ_4M
-
-static int __init pcm037_init_camera(void)
-{
-	int dma, ret = -ENOMEM;
-	struct platform_device *pdev = imx31_alloc_mx3_camera(&camera_pdata);
-
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
-
-	dma = dma_declare_coherent_memory(&pdev->dev,
-					mx3_camera_base, mx3_camera_base,
-					MX3_CAMERA_BUF_SIZE,
-					DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
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
 static struct platform_device *devices[] __initdata = {
 	&pcm037_flash,
 	&pcm037_sram_device,
-	&pcm037_mt9t031,
-	&pcm037_mt9v022,
 };
 
 static const struct fb_videomode fb_modedb[] = {
@@ -651,13 +554,6 @@ static void __init pcm037_timer_init(void)
 	mx31_clocks_init(26000000);
 }
 
-static void __init pcm037_reserve(void)
-{
-	/* reserve 4 MiB for mx3-camera */
-	mx3_camera_base = arm_memblock_steal(MX3_CAMERA_BUF_SIZE,
-			MX3_CAMERA_BUF_SIZE);
-}
-
 static void __init pcm037_init_late(void)
 {
 	int ret;
@@ -677,16 +573,6 @@ static void __init pcm037_init_late(void)
 
 	imx31_add_mxc_mmc(0, &sdhc_pdata);
 
-	/* CSI */
-	/* Camera power: default - off */
-	ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_CSI_D5), "mt9t031-power");
-	if (!ret)
-		gpio_direction_output(IOMUX_TO_GPIO(MX31_PIN_CSI_D5), 1);
-	else
-		iclink_mt9t031.power = NULL;
-
-	pcm037_init_camera();
-
 	pcm970_sja1000_resources[1].start =
 			gpio_to_irq(IOMUX_TO_GPIO(IOMUX_PIN(48, 105)));
 	pcm970_sja1000_resources[1].end =
@@ -699,7 +585,6 @@ static void __init pcm037_init_late(void)
 MACHINE_START(PCM037, "Phytec Phycore pcm037")
 	/* Maintainer: Pengutronix */
 	.atag_offset = 0x100,
-	.reserve = pcm037_reserve,
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
-- 
2.7.4
