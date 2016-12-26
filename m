From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 26 Dec 2016 10:56:22 -0200
Subject: [PATCH 1/6] ARM: mach-mx31_3ds: Remove camera support
Message-ID: <1482756987-12414-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Since commit c93cc61475ebbe6e66 ("[media] staging/media: remove deprecated
mx3 driver") the mx3 camera driver has been removed, so remove the camera
support from the board file as well.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/mach-imx/mach-mx31_3ds.c | 145 --------------------------------------
 1 file changed, 145 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 12b8a52..ada29d0 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -26,16 +26,12 @@
 #include <linux/regulator/machine.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
-#include <linux/memblock.h>
-
-#include <media/soc_camera.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/memory.h>
 #include <asm/mach/map.h>
-#include <asm/memblock.h>
 
 #include "3ds_debugboard.h"
 #include "common.h"
@@ -152,8 +148,6 @@ static int mx31_3ds_pins[] = {
 	MX31_PIN_CSI_MCLK__CSI_MCLK,
 	MX31_PIN_CSI_PIXCLK__CSI_PIXCLK,
 	MX31_PIN_CSI_VSYNC__CSI_VSYNC,
-	MX31_PIN_CSI_D5__GPIO3_5, /* CMOS PWDN */
-	IOMUX_MODE(MX31_PIN_RI_DTE1, IOMUX_CONFIG_GPIO), /* CMOS reset */
 	/* SSI */
 	MX31_PIN_STXD4__STXD4,
 	MX31_PIN_SRXD4__SRXD4,
@@ -162,98 +156,6 @@ static int mx31_3ds_pins[] = {
 };
 
 /*
- * Camera support
- */
-static phys_addr_t mx3_camera_base __initdata;
-#define MX31_3DS_CAMERA_BUF_SIZE SZ_8M
-
-#define MX31_3DS_GPIO_CAMERA_PW IOMUX_TO_GPIO(MX31_PIN_CSI_D5)
-#define MX31_3DS_GPIO_CAMERA_RST IOMUX_TO_GPIO(MX31_PIN_RI_DTE1)
-
-static struct gpio mx31_3ds_camera_gpios[] = {
-	{ MX31_3DS_GPIO_CAMERA_PW, GPIOF_OUT_INIT_HIGH, "camera-power" },
-	{ MX31_3DS_GPIO_CAMERA_RST, GPIOF_OUT_INIT_HIGH, "camera-reset" },
-};
-
-static const struct mx3_camera_pdata mx31_3ds_camera_pdata __initconst = {
-	.flags = MX3_CAMERA_DATAWIDTH_10,
-	.mclk_10khz = 2600,
-};
-
-static int __init mx31_3ds_init_camera(void)
-{
-	int dma, ret = -ENOMEM;
-	struct platform_device *pdev =
-		imx31_alloc_mx3_camera(&mx31_3ds_camera_pdata);
-
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
-
-	if (!mx3_camera_base)
-		goto err;
-
-	dma = dma_declare_coherent_memory(&pdev->dev,
-					mx3_camera_base, mx3_camera_base,
-					MX31_3DS_CAMERA_BUF_SIZE,
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
-static int mx31_3ds_camera_power(struct device *dev, int on)
-{
-	/* enable or disable the camera */
-	pr_debug("%s: %s the camera\n", __func__, on ? "ENABLE" : "DISABLE");
-	gpio_set_value(MX31_3DS_GPIO_CAMERA_PW, on ? 0 : 1);
-
-	if (!on)
-		goto out;
-
-	/* If enabled, give a reset impulse */
-	gpio_set_value(MX31_3DS_GPIO_CAMERA_RST, 0);
-	msleep(20);
-	gpio_set_value(MX31_3DS_GPIO_CAMERA_RST, 1);
-	msleep(100);
-
-out:
-	return 0;
-}
-
-static struct i2c_board_info mx31_3ds_i2c_camera = {
-	I2C_BOARD_INFO("ov2640", 0x30),
-};
-
-static struct regulator_bulk_data mx31_3ds_camera_regs[] = {
-	{ .supply = "cmos_vcore" },
-	{ .supply = "cmos_2v8" },
-};
-
-static struct soc_camera_link iclink_ov2640 = {
-	.bus_id		= 0,
-	.board_info	= &mx31_3ds_i2c_camera,
-	.i2c_adapter_id	= 0,
-	.power		= mx31_3ds_camera_power,
-	.regulators	= mx31_3ds_camera_regs,
-	.num_regulators	= ARRAY_SIZE(mx31_3ds_camera_regs),
-};
-
-static struct platform_device mx31_3ds_ov2640 = {
-	.name	= "soc-camera-pdrv",
-	.id	= 0,
-	.dev	= {
-		.platform_data = &iclink_ov2640,
-	},
-};
-
-/*
  * FB support
  */
 static const struct fb_videomode fb_modedb[] = {
@@ -410,7 +312,6 @@ static struct regulator_init_data vmmc2_init = {
 
 static struct regulator_consumer_supply vmmc1_consumers[] = {
 	REGULATOR_SUPPLY("vcore", "spi0.0"),
-	REGULATOR_SUPPLY("cmos_2v8", "soc-camera-pdrv.0"),
 };
 
 static struct regulator_init_data vmmc1_init = {
@@ -441,22 +342,6 @@ static struct regulator_init_data vgen_init = {
 	.consumer_supplies = vgen_consumers,
 };
 
-static struct regulator_consumer_supply vvib_consumers[] = {
-	REGULATOR_SUPPLY("cmos_vcore", "soc-camera-pdrv.0"),
-};
-
-static struct regulator_init_data vvib_init = {
-	.constraints = {
-		.min_uV = 1300000,
-		.max_uV = 1300000,
-		.apply_uV = 1,
-		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
-				  REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies = ARRAY_SIZE(vvib_consumers),
-	.consumer_supplies = vvib_consumers,
-};
-
 static struct mc13xxx_regulator_init_data mx31_3ds_regulators[] = {
 	{
 		.id = MC13783_REG_PWGT1SPI, /* Power Gate for ARM core. */
@@ -480,9 +365,6 @@ static struct mc13xxx_regulator_init_data mx31_3ds_regulators[] = {
 	}, {
 		.id = MC13783_REG_VGEN,  /* Power LCD */
 		.init_data = &vgen_init,
-	}, {
-		.id = MC13783_REG_VVIB,  /* Power CMOS */
-		.init_data = &vvib_init,
 	},
 };
 
@@ -688,10 +570,6 @@ static const struct imxi2c_platform_data mx31_3ds_i2c0_data __initconst = {
 	.bitrate = 100000,
 };
 
-static struct platform_device *devices[] __initdata = {
-	&mx31_3ds_ov2640,
-};
-
 static void __init mx31_3ds_init(void)
 {
 	imx31_soc_init();
@@ -723,14 +601,10 @@ static void __init mx31_3ds_init(void)
 
 static void __init mx31_3ds_late(void)
 {
-	int ret;
-
 	mx31_3ds_spi_devs[0].irq = gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3));
 	spi_register_board_info(mx31_3ds_spi_devs,
 				ARRAY_SIZE(mx31_3ds_spi_devs));
 
-	platform_add_devices(devices, ARRAY_SIZE(devices));
-
 	mx31_3ds_usbotg_init();
 	if (otg_mode_host) {
 		otg_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
@@ -751,17 +625,6 @@ static void __init mx31_3ds_late(void)
 		       "devices on the debug board are unusable.\n");
 
 	imx31_add_mxc_mmc(0, &sdhc1_pdata);
-
-	/* CSI */
-	/* Camera power: default - off */
-	ret = gpio_request_array(mx31_3ds_camera_gpios,
-				 ARRAY_SIZE(mx31_3ds_camera_gpios));
-	if (ret) {
-		pr_err("Failed to request camera gpios");
-		iclink_ov2640.power = NULL;
-	}
-
-	mx31_3ds_init_camera();
 }
 
 static void __init mx31_3ds_timer_init(void)
@@ -769,13 +632,6 @@ static void __init mx31_3ds_timer_init(void)
 	mx31_clocks_init(26000000);
 }
 
-static void __init mx31_3ds_reserve(void)
-{
-	/* reserve MX31_3DS_CAMERA_BUF_SIZE bytes for mx3-camera */
-	mx3_camera_base = arm_memblock_steal(MX31_3DS_CAMERA_BUF_SIZE,
-					 MX31_3DS_CAMERA_BUF_SIZE);
-}
-
 MACHINE_START(MX31_3DS, "Freescale MX31PDK (3DS)")
 	/* Maintainer: Freescale Semiconductor, Inc. */
 	.atag_offset = 0x100,
@@ -785,6 +641,5 @@ MACHINE_START(MX31_3DS, "Freescale MX31PDK (3DS)")
 	.init_time	= mx31_3ds_timer_init,
 	.init_machine = mx31_3ds_init,
 	.init_late	= mx31_3ds_late,
-	.reserve = mx31_3ds_reserve,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
2.7.4
