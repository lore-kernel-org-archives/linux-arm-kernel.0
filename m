From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 27 Nov 2012 11:21:49 -0200
Subject: [PATCH] ARM: mx25_3ds: Add camera support
Message-ID: <1354022509-20505-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx25_3ds board has a OV2640 camera sensor.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-mx25_3ds.c |   85 +++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index b1b03aa..ae25f01 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -37,6 +37,8 @@
 #include <asm/memory.h>
 #include <asm/mach/map.h>
 
+#include <media/soc_camera.h>
+
 #include "common.h"
 #include "devices-imx25.h"
 #include "hardware.h"
@@ -115,12 +117,85 @@ static iomux_v3_cfg_t mx25pdk_pads[] = {
 	MX25_PAD_GPIO_A__CAN1_TX,
 	MX25_PAD_GPIO_B__CAN1_RX,
 	MX25_PAD_D14__GPIO_4_6,	/* CAN_PWDN */
+
+	/* CSI */
+	MX25_PAD_CSI_D2__CSI_D2,
+	MX25_PAD_CSI_D3__CSI_D3,
+	MX25_PAD_CSI_D4__CSI_D4,
+	MX25_PAD_CSI_D5__CSI_D5,
+	MX25_PAD_CSI_D6__CSI_D6,
+	MX25_PAD_CSI_D7__CSI_D7,
+	MX25_PAD_CSI_D8__CSI_D8,
+	MX25_PAD_CSI_D9__CSI_D9,
+	MX25_PAD_CSI_HSYNC__CSI_HSYNC,
+	MX25_PAD_CSI_MCLK__CSI_MCLK,
+	MX25_PAD_CSI_PIXCLK__CSI_PIXCLK,
+	MX25_PAD_CSI_VSYNC__CSI_VSYNC,
+	MX25_PAD_A19__GPIO_2_5,		/* CSI_PWDN */
+	MX25_PAD_A20__GPIO_2_6,		/* CMOS_RESET_B */
+};
+
+#define MX25_3DS_GPIO_CAMERA_PW	IMX_GPIO_NR(2, 5)
+#define MX25_3DS_GPIO_CAMERA_RST	IMX_GPIO_NR(2, 6)
+
+static struct gpio mx25_3ds_camera_gpios[] = {
+	{ MX25_3DS_GPIO_CAMERA_PW, GPIOF_OUT_INIT_HIGH, "camera-power" },
+	{ MX25_3DS_GPIO_CAMERA_RST, GPIOF_OUT_INIT_HIGH, "camera-reset" },
+};
+
+static const struct mx2_camera_platform_data mx25pdk_camera_pdata = {
+	.flags =  MX2_CAMERA_HSYNC_HIGH |
+		  MX2_CAMERA_GATED_CLOCK |
+		  MX2_CAMERA_PCLK_SAMPLE_RISING,
+	.clk = 13000000,
 };
 
 static const struct fec_platform_data mx25_fec_pdata __initconst = {
 	.phy    = PHY_INTERFACE_MODE_RMII,
 };
 
+static int mx25_3ds_camera_power(struct device *dev, int on)
+{
+	gpio_set_value(MX25_3DS_GPIO_CAMERA_PW, on ? 0 : 1);
+
+	if (!on)
+		goto out;
+
+	/* If enabled, give a reset impulse */
+	gpio_set_value(MX25_3DS_GPIO_CAMERA_RST, 0);
+	msleep(20);
+	gpio_set_value(MX25_3DS_GPIO_CAMERA_RST, 1);
+	msleep(100);
+
+out:
+	return 0;
+}
+
+static struct i2c_board_info mx25_3ds_i2c_camera = {
+	I2C_BOARD_INFO("ov2640", 0x30),
+};
+
+static struct soc_camera_link iclink_ov2640 = {
+	.bus_id		= 0,
+	.board_info	= &mx25_3ds_i2c_camera,
+	.i2c_adapter_id	= 0,
+	.power		= mx25_3ds_camera_power,
+	.regulators	= NULL,
+	.num_regulators	= 0,
+};
+
+static struct platform_device mx25_3ds_ov2640 = {
+	.name	= "soc-camera-pdrv",
+	.id	= 0,
+	.dev	= {
+		.platform_data = &iclink_ov2640,
+	},
+};
+
+static struct platform_device *devices[] __initdata = {
+	&mx25_3ds_ov2640,
+};
+
 #define FEC_ENABLE_GPIO		IMX_GPIO_NR(2, 3)
 #define FEC_RESET_B_GPIO	IMX_GPIO_NR(4, 8)
 
@@ -250,6 +325,16 @@ static void __init mx25pdk_init(void)
 
 	gpio_request_one(MX25PDK_CAN_PWDN, GPIOF_OUT_INIT_LOW, "can-pwdn");
 	imx25_add_flexcan0(NULL);
+
+	platform_add_devices(devices, ARRAY_SIZE(devices));
+
+	/* CSI */
+	if (gpio_request_array(mx25_3ds_camera_gpios,
+			       ARRAY_SIZE(mx25_3ds_camera_gpios))) {
+		pr_err("Failed to request camera gpios");
+		iclink_ov2640.power = NULL;
+	} else
+		imx25_add_mx2_camera(&mx25pdk_camera_pdata);
 }
 
 static void __init mx25pdk_timer_init(void)
-- 
1.7.9.5
