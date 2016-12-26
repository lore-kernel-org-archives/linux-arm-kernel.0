From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 26 Dec 2016 10:56:27 -0200
Subject: [PATCH 6/6] ARM: mach-mx27_3ds: Remove camera support
In-Reply-To: <1482756987-12414-1-git-send-email-festevam@gmail.com>
References: <1482756987-12414-1-git-send-email-festevam@gmail.com>
Message-ID: <1482756987-12414-6-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>>

Since commit 6b879edf75b316 ("[media] staging/media: remove deprecated
mx2 driver") the mx2 camera driver has been removed, so remove the camera
support from the board file as well.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/mach-imx/mach-mx27_3ds.c | 90 ---------------------------------------
 1 file changed, 90 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 7ba651a..fcc55fc 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -31,7 +31,6 @@
 #include <linux/regulator/machine.h>
 #include <linux/spi/l4f00242t03.h>
 
-#include <media/soc_camera.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -166,11 +165,6 @@ static const int mx27pdk_pins[] __initconst = {
 	PC19_PF_SSI4_CLK,
 };
 
-static struct gpio mx27_3ds_camera_gpios[] = {
-	{ CSI_PWRDWN, GPIOF_OUT_INIT_HIGH, "camera-power" },
-	{ CSI_RESET, GPIOF_OUT_INIT_HIGH, "camera-reset" },
-};
-
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
@@ -270,7 +264,6 @@ static struct regulator_init_data gpo_init = {
 
 static struct regulator_consumer_supply vmmc1_consumers[] = {
 	REGULATOR_SUPPLY("vcore", "spi0.0"),
-	REGULATOR_SUPPLY("cmos_2v8", "soc-camera-pdrv.0"),
 };
 
 static struct regulator_init_data vmmc1_init = {
@@ -299,22 +292,6 @@ static struct regulator_init_data vgen_init = {
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
 static struct mc13xxx_regulator_init_data mx27_3ds_regulators[] = {
 	{
 		.id = MC13783_REG_VMMC1,
@@ -328,9 +305,6 @@ static struct mc13xxx_regulator_init_data mx27_3ds_regulators[] = {
 	}, {
 		.id = MC13783_REG_GPO3, /* Turn on 3.3V */
 		.init_data = &gpo_init,
-	}, {
-		.id = MC13783_REG_VVIB,  /* Power OV2640 */
-		.init_data = &vvib_init,
 	},
 };
 
@@ -370,51 +344,6 @@ static const struct spi_imx_master spi2_pdata __initconst = {
 	.num_chipselect	= ARRAY_SIZE(spi2_chipselect),
 };
 
-static int mx27_3ds_camera_power(struct device *dev, int on)
-{
-	/* enable or disable the camera */
-	pr_debug("%s: %s the camera\n", __func__, on ? "ENABLE" : "DISABLE");
-	gpio_set_value(CSI_PWRDWN, on ? 0 : 1);
-
-	if (!on)
-		goto out;
-
-	/* If enabled, give a reset impulse */
-	gpio_set_value(CSI_RESET, 0);
-	msleep(20);
-	gpio_set_value(CSI_RESET, 1);
-	msleep(100);
-
-out:
-	return 0;
-}
-
-static struct i2c_board_info mx27_3ds_i2c_camera = {
-	I2C_BOARD_INFO("ov2640", 0x30),
-};
-
-static struct regulator_bulk_data mx27_3ds_camera_regs[] = {
-	{ .supply = "cmos_vcore" },
-	{ .supply = "cmos_2v8" },
-};
-
-static struct soc_camera_link iclink_ov2640 = {
-	.bus_id		= 0,
-	.board_info	= &mx27_3ds_i2c_camera,
-	.i2c_adapter_id	= 0,
-	.power		= mx27_3ds_camera_power,
-	.regulators	= mx27_3ds_camera_regs,
-	.num_regulators	= ARRAY_SIZE(mx27_3ds_camera_regs),
-};
-
-static struct platform_device mx27_3ds_ov2640 = {
-	.name	= "soc-camera-pdrv",
-	.id	= 0,
-	.dev	= {
-		.platform_data = &iclink_ov2640,
-	},
-};
-
 static struct imx_fb_videomode mx27_3ds_modes[] = {
 	{	/* 480x640 @ 60 Hz */
 		.mode = {
@@ -471,14 +400,6 @@ static struct spi_board_info mx27_3ds_spi_devs[] __initdata = {
 	},
 };
 
-static struct platform_device *devices[] __initdata = {
-	&mx27_3ds_ov2640,
-};
-
-static const struct mx2_camera_platform_data mx27_3ds_cam_pdata __initconst = {
-	.clk = 26000000,
-};
-
 static const struct imxi2c_platform_data mx27_3ds_i2c0_data __initconst = {
 	.bitrate = 100000,
 };
@@ -498,7 +419,6 @@ static void __init mx27pdk_init(void)
 	imx27_add_spi_imx0(&spi1_pdata);
 
 	imx27_add_imx_i2c(0, &mx27_3ds_i2c0_data);
-	platform_add_devices(devices, ARRAY_SIZE(devices));
 	imx27_add_imx_fb(&mx27_3ds_fb_data);
 
 	imx27_add_imx_ssi(0, &mx27_3ds_ssi_pdata);
@@ -506,8 +426,6 @@ static void __init mx27pdk_init(void)
 
 static void __init mx27pdk_late_init(void)
 {
-	int ret;
-
 	mx27_3ds_sdhc1_enable_level_translator();
 	imx27_add_mxc_mmc(0, &sdhc1_pdata);
 
@@ -531,14 +449,6 @@ static void __init mx27pdk_late_init(void)
 	if (mxc_expio_init(MX27_CS5_BASE_ADDR, IMX_GPIO_NR(3, 28)))
 		pr_warn("Init of the debugboard failed, all devices on the debugboard are unusable.\n");
 
-	ret = gpio_request_array(mx27_3ds_camera_gpios,
-				 ARRAY_SIZE(mx27_3ds_camera_gpios));
-	if (ret) {
-		pr_err("Failed to request camera gpios");
-		iclink_ov2640.power = NULL;
-	}
-
-	imx27_add_mx2_camera(&mx27_3ds_cam_pdata);
 
 	imx_add_platform_device("imx_mc13783", 0, NULL, 0, NULL, 0);
 }
-- 
2.7.4
