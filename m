From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 28 Apr 2011 21:43:23 -0300
Subject: [PATCH v2 2/3] ARM: mx5/mx51_babbage: Use gpio_request_one when
	possible
In-Reply-To: <1304037804-4411-1-git-send-email-festevam@gmail.com>
References: <1304037804-4411-1-git-send-email-festevam@gmail.com>
Message-ID: <1304037804-4411-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using gpio_request followed by gpio_direction_output use gpio_request_one.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
No changes since v1. Only added a third patch to the series

 arch/arm/mach-mx5/board-mx51_babbage.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 7b919bc..00203fb 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -179,25 +179,25 @@ static int gpio_usbh1_active(void)
 
 	/* Set USBH1_STP to GPIO and toggle it */
 	mxc_iomux_v3_setup_pad(usbh1stp_gpio);
-	ret = gpio_request(BABBAGE_USBH1_STP, "usbh1_stp");
+	ret = gpio_request_one(BABBAGE_USBH1_STP,
+					GPIOF_OUT_INIT_LOW, "usbh1_stp");
 
 	if (ret) {
 		pr_debug("failed to get MX51_PAD_USBH1_STP__GPIO_1_27: %d\n", ret);
 		return ret;
 	}
-	gpio_direction_output(BABBAGE_USBH1_STP, 0);
 	gpio_set_value(BABBAGE_USBH1_STP, 1);
 	msleep(100);
 	gpio_free(BABBAGE_USBH1_STP);
 
 	/* De-assert USB PHY RESETB */
-	ret = gpio_request(BABBAGE_USB_PHY_RESET, "phy_reset");
+	ret = gpio_request_one(BABBAGE_USB_PHY_RESET,
+					GPIOF_OUT_INIT_HIGH, "phy_reset");
 
 	if (ret) {
 		pr_debug("failed to get MX51_PAD_EIM_D21__GPIO_2_5: %d\n", ret);
 		return ret;
 	}
-	gpio_direction_output(BABBAGE_USB_PHY_RESET, 1);
 	return 0;
 }
 
-- 
1.6.0.4
