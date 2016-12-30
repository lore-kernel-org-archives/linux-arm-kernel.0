From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 30 Dec 2016 09:33:29 -0200
Subject: [PATCH v2 2/6] ARM: mx31moboard-marxbot: Remove camera support
In-Reply-To: <1483097613-21481-1-git-send-email-festevam@gmail.com>
References: <1483097613-21481-1-git-send-email-festevam@gmail.com>
Message-ID: <1483097613-21481-2-git-send-email-festevam@gmail.com>
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

 arch/arm/mach-imx/mx31moboard-marxbot.c | 92 ---------------------------------
 1 file changed, 92 deletions(-)

diff --git a/arch/arm/mach-imx/mx31moboard-marxbot.c b/arch/arm/mach-imx/mx31moboard-marxbot.c
index 2e895a8..922d491 100644
--- a/arch/arm/mach-imx/mx31moboard-marxbot.c
+++ b/arch/arm/mach-imx/mx31moboard-marxbot.c
@@ -24,8 +24,6 @@
 
 #include <linux/usb/otg.h>
 
-#include <media/soc_camera.h>
-
 #include "common.h"
 #include "devices-imx31.h"
 #include "ehci.h"
@@ -39,17 +37,6 @@ static unsigned int marxbot_pins[] = {
 	MX31_PIN_PC_READY__SD2_DATA1, MX31_PIN_PC_WAIT_B__SD2_DATA0,
 	MX31_PIN_PC_CD2_B__SD2_CLK, MX31_PIN_PC_CD1_B__SD2_CMD,
 	MX31_PIN_ATA_DIOR__GPIO3_28, MX31_PIN_ATA_DIOW__GPIO3_29,
-	/* CSI */
-	MX31_PIN_CSI_D6__CSI_D6, MX31_PIN_CSI_D7__CSI_D7,
-	MX31_PIN_CSI_D8__CSI_D8, MX31_PIN_CSI_D9__CSI_D9,
-	MX31_PIN_CSI_D10__CSI_D10, MX31_PIN_CSI_D11__CSI_D11,
-	MX31_PIN_CSI_D12__CSI_D12, MX31_PIN_CSI_D13__CSI_D13,
-	MX31_PIN_CSI_D14__CSI_D14, MX31_PIN_CSI_D15__CSI_D15,
-	MX31_PIN_CSI_HSYNC__CSI_HSYNC, MX31_PIN_CSI_MCLK__CSI_MCLK,
-	MX31_PIN_CSI_PIXCLK__CSI_PIXCLK, MX31_PIN_CSI_VSYNC__CSI_VSYNC,
-	MX31_PIN_CSI_D4__GPIO3_4, MX31_PIN_CSI_D5__GPIO3_5,
-	MX31_PIN_GPIO3_0__GPIO3_0, MX31_PIN_GPIO3_1__GPIO3_1,
-	MX31_PIN_TXD2__GPIO1_28,
 	/* dsPIC resets */
 	MX31_PIN_STXD5__GPIO1_21, MX31_PIN_SRXD5__GPIO1_22,
 	/*battery detection */
@@ -143,82 +130,6 @@ static struct spi_board_info marxbot_spi_board_info[] __initdata = {
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
@@ -356,9 +267,6 @@ void __init mx31moboard_marxbot_init(void)
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
