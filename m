From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 26 Dec 2016 10:56:23 -0200
Subject: [PATCH 2/6] ARM: mx31moboard-marxbot: Remove camera support
In-Reply-To: <1482756987-12414-1-git-send-email-festevam@gmail.com>
References: <1482756987-12414-1-git-send-email-festevam@gmail.com>
Message-ID: <1482756987-12414-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Since commit c93cc61475ebbe6e66 ("[media] staging/media: remove deprecated
mx3 driver") the mx3 camera driver has been removed, so remove the camera
support from the board file as well.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/mach-imx/mx31moboard-marxbot.c | 81 ---------------------------------
 1 file changed, 81 deletions(-)

diff --git a/arch/arm/mach-imx/mx31moboard-marxbot.c b/arch/arm/mach-imx/mx31moboard-marxbot.c
index 2e895a8..0281fd2 100644
--- a/arch/arm/mach-imx/mx31moboard-marxbot.c
+++ b/arch/arm/mach-imx/mx31moboard-marxbot.c
@@ -24,8 +24,6 @@
 
 #include <linux/usb/otg.h>
 
-#include <media/soc_camera.h>
-
 #include "common.h"
 #include "devices-imx31.h"
 #include "ehci.h"
@@ -143,82 +141,6 @@ static struct spi_board_info marxbot_spi_board_info[] __initdata = {
 	},
 };
 
-#define TURRETCAM_POWER	IOMUX_TO_GPIO(MX31_PIN_GPIO3_1)
-#define BASECAM_POWER	IOMUX_TO_GPIO(MX31_PIN_CSI_D5)
-#define TURRETCAM_RST_B	IOMUX_TO_GPIO(MX31_PIN_GPIO3_0)
-#define BASECAM_RST_B	IOMUX_TO_GPIO(MX31_PIN_CSI_D4)
-#define CAM_CHOICE	IOMUX_TO_GPIO(MX31_PIN_TXD2)
-
-static int marxbot_basecam_power(struct device *dev, int on)
-{
-	gpio_set_value(BASECAM_POWER, !on);
-	return 0;
-}
-
-static int marxbot_basecam_reset(struct device *dev)
-{
-	gpio_set_value(BASECAM_RST_B, 0);
-	udelay(100);
-	gpio_set_value(BASECAM_RST_B, 1);
-	return 0;
-}
-
-static struct i2c_board_info marxbot_i2c_devices[] = {
-	{
-		I2C_BOARD_INFO("mt9t031", 0x5d),
-	},
-};
-
-static struct soc_camera_link base_iclink = {
-	.bus_id		= 0,		/* Must match with the camera ID */
-	.power		= marxbot_basecam_power,
-	.reset		= marxbot_basecam_reset,
-	.board_info	= &marxbot_i2c_devices[0],
-	.i2c_adapter_id	= 0,
-};
-
-static struct platform_device marxbot_camera[] = {
-	{
-		.name	= "soc-camera-pdrv",
-		.id	= 0,
-		.dev	= {
-			.platform_data = &base_iclink,
-		},
-	},
-};
-
-static struct platform_device *marxbot_cameras[] __initdata = {
-	&marxbot_camera[0],
-};
-
-static int __init marxbot_cam_init(void)
-{
-	int ret = gpio_request(CAM_CHOICE, "cam-choice");
-	if (ret)
-		return ret;
-	gpio_direction_output(CAM_CHOICE, 0);
-
-	ret = gpio_request(BASECAM_RST_B, "basecam-reset");
-	if (ret)
-		return ret;
-	gpio_direction_output(BASECAM_RST_B, 1);
-	ret = gpio_request(BASECAM_POWER, "basecam-standby");
-	if (ret)
-		return ret;
-	gpio_direction_output(BASECAM_POWER, 0);
-
-	ret = gpio_request(TURRETCAM_RST_B, "turretcam-reset");
-	if (ret)
-		return ret;
-	gpio_direction_output(TURRETCAM_RST_B, 1);
-	ret = gpio_request(TURRETCAM_POWER, "turretcam-standby");
-	if (ret)
-		return ret;
-	gpio_direction_output(TURRETCAM_POWER, 0);
-
-	return 0;
-}
-
 #define SEL0 IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1)
 #define SEL1 IOMUX_TO_GPIO(MX31_PIN_DSR_DCE1)
 #define SEL2 IOMUX_TO_GPIO(MX31_PIN_RI_DCE1)
@@ -356,9 +278,6 @@ void __init mx31moboard_marxbot_init(void)
 	spi_register_board_info(marxbot_spi_board_info,
 		ARRAY_SIZE(marxbot_spi_board_info));
 
-	marxbot_cam_init();
-	platform_add_devices(marxbot_cameras, ARRAY_SIZE(marxbot_cameras));
-
 	/* battery present pin */
 	gpio_request(IOMUX_TO_GPIO(MX31_PIN_LCS0), "bat-present");
 	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_LCS0));
-- 
2.7.4
