From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 26 Dec 2016 10:56:24 -0200
Subject: [PATCH 3/6] ARM: mx31moboard-smartbot: Remove camera support
In-Reply-To: <1482756987-12414-1-git-send-email-festevam@gmail.com>
References: <1482756987-12414-1-git-send-email-festevam@gmail.com>
Message-ID: <1482756987-12414-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Since commit c93cc61475ebbe6e66 ("[media] staging/media: remove deprecated
mx3 driver") the mx3 camera driver has been removed, so remove the camera
support from the board file as well.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/mach-imx/mx31moboard-smartbot.c | 64 --------------------------------
 1 file changed, 64 deletions(-)

diff --git a/arch/arm/mach-imx/mx31moboard-smartbot.c b/arch/arm/mach-imx/mx31moboard-smartbot.c
index 89fc35a..a598c0a 100644
--- a/arch/arm/mach-imx/mx31moboard-smartbot.c
+++ b/arch/arm/mach-imx/mx31moboard-smartbot.c
@@ -23,8 +23,6 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 
-#include <media/soc_camera.h>
-
 #include "board-mx31moboard.h"
 #include "common.h"
 #include "devices-imx31.h"
@@ -56,65 +54,6 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-#define CAM_POWER	IOMUX_TO_GPIO(MX31_PIN_GPIO3_1)
-#define CAM_RST_B	IOMUX_TO_GPIO(MX31_PIN_GPIO3_0)
-
-static int smartbot_cam_power(struct device *dev, int on)
-{
-	gpio_set_value(CAM_POWER, !on);
-	return 0;
-}
-
-static int smartbot_cam_reset(struct device *dev)
-{
-	gpio_set_value(CAM_RST_B, 0);
-	udelay(100);
-	gpio_set_value(CAM_RST_B, 1);
-	return 0;
-}
-
-static struct i2c_board_info smartbot_i2c_devices[] = {
-	{
-		I2C_BOARD_INFO("mt9t031", 0x5d),
-	},
-};
-
-static struct soc_camera_link base_iclink = {
-	.bus_id		= 0,		/* Must match with the camera ID */
-	.power		= smartbot_cam_power,
-	.reset		= smartbot_cam_reset,
-	.board_info	= &smartbot_i2c_devices[0],
-	.i2c_adapter_id	= 0,
-};
-
-static struct platform_device smartbot_camera[] = {
-	{
-		.name	= "soc-camera-pdrv",
-		.id	= 0,
-		.dev	= {
-			.platform_data = &base_iclink,
-		},
-	},
-};
-
-static struct platform_device *smartbot_cameras[] __initdata = {
-	&smartbot_camera[0],
-};
-
-static int __init smartbot_cam_init(void)
-{
-	int ret = gpio_request(CAM_RST_B, "cam-reset");
-	if (ret)
-		return ret;
-	gpio_direction_output(CAM_RST_B, 1);
-	ret = gpio_request(CAM_POWER, "cam-standby");
-	if (ret)
-		return ret;
-	gpio_direction_output(CAM_POWER, 0);
-
-	return 0;
-}
-
 static const struct fsl_usb2_platform_data usb_pdata __initconst = {
 	.operating_mode	= FSL_USB2_DR_DEVICE,
 	.phy_mode	= FSL_USB2_PHY_ULPI,
@@ -201,7 +140,4 @@ void __init mx31moboard_smartbot_init(int board)
 	}
 
 	smartbot_resets_init();
-
-	smartbot_cam_init();
-	platform_add_devices(smartbot_cameras, ARRAY_SIZE(smartbot_cameras));
 }
-- 
2.7.4
