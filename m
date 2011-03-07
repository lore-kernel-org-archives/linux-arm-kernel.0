From: alberto@amarulasolutions.com (Alberto Panizzo)
Date: Mon, 07 Mar 2011 11:13:37 +0100
Subject: [PATCHv2 4/4] mach-mx31_3ds: Add support for the camera device on
	the personality board
In-Reply-To: <1299492598.2468.30.camel@realization>
References: <1299492598.2468.30.camel@realization>
Message-ID: <1299492817.2468.35.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Signed-off-by: Alberto Panizzo <alberto@amarulasolutions.com>
---
 arch/arm/mach-mx3/mach-mx31_3ds.c |  156 +++++++++++++++++++++++++++++++++++++
 1 files changed, 156 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index bb7e432..7fc9ec6 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -25,6 +25,9 @@
 #include <linux/regulator/machine.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
+#include <linux/memblock.h>
+
+#include <media/soc_camera.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -39,6 +42,7 @@
 #include <mach/mmc.h>
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
+#include <mach/mx3_camera.h>
 
 #include "devices-imx31.h"
 #include "devices.h"
@@ -141,6 +145,106 @@ static int mx31_3ds_pins[] = {
 	MX31_PIN_HSYNC__HSYNC,
 	MX31_PIN_FPSHIFT__FPSHIFT,
 	MX31_PIN_CONTRAST__CONTRAST,
+	/* CSI */
+	MX31_PIN_CSI_D6__CSI_D6,
+	MX31_PIN_CSI_D7__CSI_D7,
+	MX31_PIN_CSI_D8__CSI_D8,
+	MX31_PIN_CSI_D9__CSI_D9,
+	MX31_PIN_CSI_D10__CSI_D10,
+	MX31_PIN_CSI_D11__CSI_D11,
+	MX31_PIN_CSI_D12__CSI_D12,
+	MX31_PIN_CSI_D13__CSI_D13,
+	MX31_PIN_CSI_D14__CSI_D14,
+	MX31_PIN_CSI_D15__CSI_D15,
+	MX31_PIN_CSI_HSYNC__CSI_HSYNC,
+	MX31_PIN_CSI_MCLK__CSI_MCLK,
+	MX31_PIN_CSI_PIXCLK__CSI_PIXCLK,
+	MX31_PIN_CSI_VSYNC__CSI_VSYNC,
+	MX31_PIN_CSI_D5__GPIO3_5, /* CMOS PWDN */
+	IOMUX_MODE(MX31_PIN_RI_DTE1, IOMUX_CONFIG_GPIO), /* CMOS reset */
+};
+
+/*
+ * Camera support
+ */
+static phys_addr_t mx3_camera_base __initdata;
+#define MX31_3DS_CAMERA_BUF_SIZE SZ_8M
+
+#define MX31_3DS_GPIO_CAMERA_PW IOMUX_TO_GPIO(MX31_PIN_CSI_D5)
+#define MX31_3DS_GPIO_CAMERA_RST IOMUX_TO_GPIO(MX31_PIN_RI_DTE1)
+
+static struct gpio mx31_3ds_camera_gpios[] = {
+	{ MX31_3DS_GPIO_CAMERA_PW, GPIOF_OUT_INIT_HIGH, "camera-power" },
+	{ MX31_3DS_GPIO_CAMERA_RST, GPIOF_OUT_INIT_HIGH, "camera-reset" },
+};
+
+static int __init mx31_3ds_camera_alloc_dma(void)
+{
+	int dma;
+
+	if (!mx3_camera_base)
+		return -ENOMEM;
+
+	dma = dma_declare_coherent_memory(&mx3_camera.dev,
+					mx3_camera_base, mx3_camera_base,
+					MX31_3DS_CAMERA_BUF_SIZE,
+					DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
+
+	if (!(dma & DMA_MEMORY_MAP))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int mx31_3ds_camera_power(struct device *dev, int on)
+{
+	/* enable or disable the camera */
+	pr_debug("%s: %s the camera\n", __func__, on ? "ENABLE" : "DISABLE");
+	gpio_set_value(MX31_3DS_GPIO_CAMERA_PW, on ? 0 : 1);
+
+	if (!on)
+		goto out;
+
+	/* If enabled, give a reset impulse */
+	gpio_set_value(MX31_3DS_GPIO_CAMERA_RST, 0);
+	msleep(20);
+	gpio_set_value(MX31_3DS_GPIO_CAMERA_RST, 1);
+	msleep(100);
+
+out:
+	return 0;
+}
+
+static struct i2c_board_info mx31_3ds_i2c_camera = {
+	I2C_BOARD_INFO("ov2640", 0x30),
+};
+
+static struct regulator_bulk_data mx31_3ds_camera_regs[] = {
+	{ .supply = "cmos_vcore" },
+	{ .supply = "cmos_2v8" },
+};
+
+static struct soc_camera_link iclink_ov2640 = {
+	.bus_id		= 0,
+	.board_info	= &mx31_3ds_i2c_camera,
+	.i2c_adapter_id	= 0,
+	.power		= mx31_3ds_camera_power,
+	.regulators	= mx31_3ds_camera_regs,
+	.num_regulators	= ARRAY_SIZE(mx31_3ds_camera_regs),
+};
+
+static struct platform_device mx31_3ds_ov2640 = {
+	.name	= "soc-camera-pdrv",
+	.id	= 0,
+	.dev	= {
+		.platform_data = &iclink_ov2640,
+	},
+};
+
+struct mx3_camera_pdata mx31_3ds_camera_pdata = {
+	.dma_dev	= &mx3_ipu.dev,
+	.flags		= MX3_CAMERA_DATAWIDTH_10,
+	.mclk_10khz	= 2600,
 };
 
 /*
@@ -307,6 +411,7 @@ static struct regulator_init_data vmmc2_init = {
 
 static struct regulator_consumer_supply vmmc1_consumers[] = {
 	REGULATOR_SUPPLY("lcd_2v8", NULL),
+	REGULATOR_SUPPLY("cmos_2v8", "soc-camera-pdrv.0"),
 };
 
 static struct regulator_init_data vmmc1_init = {
@@ -337,6 +442,22 @@ static struct regulator_init_data vgen_init = {
 	.consumer_supplies = vgen_consumers,
 };
 
+static struct regulator_consumer_supply vvib_consumers[] = {
+	REGULATOR_SUPPLY("cmos_vcore", "soc-camera-pdrv.0"),
+};
+
+static struct regulator_init_data vvib_init = {
+	.constraints = {
+		.min_uV = 1300000,
+		.max_uV = 1300000,
+		.apply_uV = 1,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+				  REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(vvib_consumers),
+	.consumer_supplies = vvib_consumers,
+};
+
 static struct mc13xxx_regulator_init_data mx31_3ds_regulators[] = {
 	{
 		.id = MC13783_REG_PWGT1SPI, /* Power Gate for ARM core. */
@@ -360,6 +481,9 @@ static struct mc13xxx_regulator_init_data mx31_3ds_regulators[] = {
 	}, {
 		.id = MC13783_REG_VGEN,  /* Power LCD */
 		.init_data = &vgen_init,
+	}, {
+		.id = MC13783_REG_VVIB,  /* Power CMOS */
+		.init_data = &vvib_init,
 	},
 };
 
@@ -552,8 +676,14 @@ static const struct imxi2c_platform_data mx31_3ds_i2c0_data __initconst = {
 	.bitrate = 100000,
 };
 
+static struct platform_device *devices[] __initdata = {
+	&mx31_3ds_ov2640,
+};
+
 static void __init mx31_3ds_init(void)
 {
+	int ret;
+
 	mxc_iomux_setup_multiple_pins(mx31_3ds_pins, ARRAY_SIZE(mx31_3ds_pins),
 				      "mx31_3ds");
 
@@ -564,6 +694,8 @@ static void __init mx31_3ds_init(void)
 	spi_register_board_info(mx31_3ds_spi_devs,
 						ARRAY_SIZE(mx31_3ds_spi_devs));
 
+	platform_add_devices(devices, ARRAY_SIZE(devices));
+
 	imx31_add_imx_keypad(&mx31_3ds_keymap_data);
 
 	mx31_3ds_usbotg_init();
@@ -591,6 +723,20 @@ static void __init mx31_3ds_init(void)
 	imx31_add_spi_imx0(&spi0_pdata);
 	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
 	mxc_register_device(&mx3_fb, &mx3fb_pdata);
+
+	/* CSI */
+	/* Camera power: default - off */
+	ret = gpio_request_array(mx31_3ds_camera_gpios,
+				 ARRAY_SIZE(mx31_3ds_camera_gpios));
+	if (ret) {
+		pr_err("Failed to request camera gpios");
+		iclink_ov2640.power = NULL;
+	}
+
+	if (!mx31_3ds_camera_alloc_dma())
+		mxc_register_device(&mx3_camera, &mx31_3ds_camera_pdata);
+	else
+		pr_err("Failed to allocate dma memory for camera");
 }
 
 static void __init mx31_3ds_timer_init(void)
@@ -602,6 +748,15 @@ static struct sys_timer mx31_3ds_timer = {
 	.init	= mx31_3ds_timer_init,
 };
 
+static void __init mx31_3ds_reserve(void)
+{
+	/* reserve MX31_3DS_CAMERA_BUF_SIZE bytes for mx3-camera */
+	mx3_camera_base = memblock_alloc(MX31_3DS_CAMERA_BUF_SIZE,
+					 MX31_3DS_CAMERA_BUF_SIZE);
+	memblock_free(mx3_camera_base, MX31_3DS_CAMERA_BUF_SIZE);
+	memblock_remove(mx3_camera_base, MX31_3DS_CAMERA_BUF_SIZE);
+}
+
 MACHINE_START(MX31_3DS, "Freescale MX31PDK (3DS)")
 	/* Maintainer: Freescale Semiconductor, Inc. */
 	.boot_params = MX3x_PHYS_OFFSET + 0x100,
@@ -610,4 +765,5 @@ MACHINE_START(MX31_3DS, "Freescale MX31PDK (3DS)")
 	.init_irq = mx31_init_irq,
 	.timer = &mx31_3ds_timer,
 	.init_machine = mx31_3ds_init,
+	.reserve = mx31_3ds_reserve,
 MACHINE_END
-- 
1.7.1
