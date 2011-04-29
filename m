From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 28 Apr 2011 21:43:22 -0300
Subject: [PATCH v2 1/3] ARM: mx5/mx51_babbage: Move GPIO initialization for
	USB PHY Reset line to common place
Message-ID: <1304037804-4411-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB PHY Reset GPIO can be configured in the same place as the other GPIOs.

While at it rename the pin as BABBAGE_USB_PHY_RESET to make clearer its purpose.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
No changes since v1. Only added a third patch to the series

 arch/arm/mach-mx5/board-mx51_babbage.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index c7b3fab..7b919bc 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -36,7 +36,7 @@
 
 #define BABBAGE_USB_HUB_RESET	IMX_GPIO_NR(1, 7)
 #define BABBAGE_USBH1_STP	IMX_GPIO_NR(1, 27)
-#define BABBAGE_PHY_RESET	IMX_GPIO_NR(2, 5)
+#define BABBAGE_USB_PHY_RESET	IMX_GPIO_NR(2, 5)
 #define BABBAGE_FEC_PHY_RESET	IMX_GPIO_NR(2, 14)
 #define BABBAGE_POWER_KEY	IMX_GPIO_NR(2, 21)
 #define BABBAGE_ECSPI1_CS0	IMX_GPIO_NR(4, 24)
@@ -110,6 +110,9 @@ static iomux_v3_cfg_t mx51babbage_pads[] = {
 	/* USB HUB reset line*/
 	MX51_PAD_GPIO1_7__GPIO1_7,
 
+	/* USB PHY reset line */
+	MX51_PAD_EIM_D21__GPIO2_5,
+
 	/* FEC */
 	MX51_PAD_EIM_EB2__FEC_MDIO,
 	MX51_PAD_EIM_EB3__FEC_RDATA1,
@@ -172,7 +175,6 @@ static struct imxi2c_platform_data babbage_hsi2c_data = {
 static int gpio_usbh1_active(void)
 {
 	iomux_v3_cfg_t usbh1stp_gpio = MX51_PAD_USBH1_STP__GPIO1_27;
-	iomux_v3_cfg_t phyreset_gpio = MX51_PAD_EIM_D21__GPIO2_5;
 	int ret;
 
 	/* Set USBH1_STP to GPIO and toggle it */
@@ -189,14 +191,13 @@ static int gpio_usbh1_active(void)
 	gpio_free(BABBAGE_USBH1_STP);
 
 	/* De-assert USB PHY RESETB */
-	mxc_iomux_v3_setup_pad(phyreset_gpio);
-	ret = gpio_request(BABBAGE_PHY_RESET, "phy_reset");
+	ret = gpio_request(BABBAGE_USB_PHY_RESET, "phy_reset");
 
 	if (ret) {
 		pr_debug("failed to get MX51_PAD_EIM_D21__GPIO_2_5: %d\n", ret);
 		return ret;
 	}
-	gpio_direction_output(BABBAGE_PHY_RESET, 1);
+	gpio_direction_output(BABBAGE_USB_PHY_RESET, 1);
 	return 0;
 }
 
-- 
1.6.0.4
