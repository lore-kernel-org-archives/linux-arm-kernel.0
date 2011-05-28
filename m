From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 28 May 2011 10:54:36 -0300
Subject: [PATCH v3 2/2] ARM: mx5/mx51_babbage: Use gpio_request_array for
	USBH1 pins
In-Reply-To: <1306590876-20680-1-git-send-email-festevam@gmail.com>
References: <1306590876-20680-1-git-send-email-festevam@gmail.com>
Message-ID: <1306590876-20680-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using gpio_request followed by gpio_direction_output use gpio_request_array
when requesting multiple pins.

Also fixed the location of the delay for the reset and make the BABBAGE_USB_PHY_RESET to toggle.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- Use gpio_request_array
- Fix delay position
- Apply reset logic for BABBAGE_USB_PHY_RESET pin

No changes since v1. Only added a third patch to the series
 arch/arm/mach-mx5/board-mx51_babbage.c |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 7b919bc..770f74b 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -172,6 +172,11 @@ static struct imxi2c_platform_data babbage_hsi2c_data = {
 	.bitrate = 400000,
 };
 
+static struct gpio mx51_babbage_usbh1_gpios[] = {
+	{ BABBAGE_USBH1_STP, GPIOF_OUT_INIT_LOW, "usbh1_stp" },
+	{ BABBAGE_USB_PHY_RESET, GPIOF_OUT_INIT_LOW, "usbh1_phy_reset" },
+};
+
 static int gpio_usbh1_active(void)
 {
 	iomux_v3_cfg_t usbh1stp_gpio = MX51_PAD_USBH1_STP__GPIO1_27;
@@ -179,25 +184,19 @@ static int gpio_usbh1_active(void)
 
 	/* Set USBH1_STP to GPIO and toggle it */
 	mxc_iomux_v3_setup_pad(usbh1stp_gpio);
-	ret = gpio_request(BABBAGE_USBH1_STP, "usbh1_stp");
+	ret = gpio_request_array(mx51_babbage_usbh1_gpios,
+					ARRAY_SIZE(mx51_babbage_usbh1_gpios));
 
 	if (ret) {
-		pr_debug("failed to get MX51_PAD_USBH1_STP__GPIO_1_27: %d\n", ret);
+		pr_debug("failed to get USBH1 pins: %d\n", ret);
 		return ret;
 	}
-	gpio_direction_output(BABBAGE_USBH1_STP, 0);
-	gpio_set_value(BABBAGE_USBH1_STP, 1);
-	msleep(100);
-	gpio_free(BABBAGE_USBH1_STP);
-
-	/* De-assert USB PHY RESETB */
-	ret = gpio_request(BABBAGE_USB_PHY_RESET, "phy_reset");
 
-	if (ret) {
-		pr_debug("failed to get MX51_PAD_EIM_D21__GPIO_2_5: %d\n", ret);
-		return ret;
-	}
-	gpio_direction_output(BABBAGE_USB_PHY_RESET, 1);
+	msleep(100);
+	gpio_set_value(BABBAGE_USBH1_STP, 1);
+	gpio_set_value(BABBAGE_USB_PHY_RESET, 1);
+	gpio_free_array(mx51_babbage_usbh1_gpios,
+					ARRAY_SIZE(mx51_babbage_usbh1_gpios));
 	return 0;
 }
 
-- 
1.6.0.4
