From: festevam@gmail.com (Fabio Estevam)
Date: Thu,  9 Feb 2017 21:37:59 -0200
Subject: [PATCH] ARM: dts: imx25-pdk: Allow USB OTG to work in host mode
Message-ID: <1486683479-5997-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

USBOTG_PWR pin is connected to the enable pin of the RT9706 power
switch.

Configure the IOMUX of the USBOTG_PWR pin so that it can go to zero
when the USB OTG is in host mode, which allows the power switch to
provide the USB_5V_VBUS_OTG signal.

This allows the USB OTG port to work in USB host mode.

Also tested USB OTG in gadget functionality via g_ether.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx25-pdk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index 7029210..aff929a 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -248,6 +248,12 @@
 				MX25_PAD_UART1_RXD__UART1_RXD		0xc0
 			>;
 		};
+
+		pinctrl_usbotg: usbotggrp {
+			fsl,pins = <
+				MX25_PAD_GPIO_A__USBOTG_PWR		0xc0
+			>;
+		};
 	};
 };
 
@@ -309,6 +315,8 @@
 };
 
 &usbotg {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
 	phy_type = "utmi";
 	dr_mode = "otg";
 	external-vbus-divider;
-- 
2.7.4
