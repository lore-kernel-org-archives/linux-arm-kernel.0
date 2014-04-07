From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon,  7 Apr 2014 16:29:25 +0200
Subject: [PATCH 2/4] ARM: dts: imx6: edmqmx6: Do not use the OTG switch as
 VBUS regulator
In-Reply-To: <1396880967-16319-1-git-send-email-l.stach@pengutronix.de>
References: <1396880967-16319-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1396880967-16319-2-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

GPIO7_12 switches the D+/D- USB lines on and off. When we use this as
VBUS regulator it means that USB device mode can never work as VBUS is
never turned on in Device mode.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index 39ffa766384f..af32944cf9ae 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -40,13 +40,15 @@
 			regulator-always-on;
 		};
 
-		reg_usb_otg_vbus: regulator at 1 {
+		reg_usb_otg_switch: regulator at 1 {
 			compatible = "regulator-fixed";
 			reg = <1>;
-			regulator-name = "usb_otg_vbus";
+			regulator-name = "usb_otg_switch";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			gpio = <&gpio7 12 0>;
+			regulator-boot-on;
+			regulator-always-on;
 		};
 
 		reg_usb_host1: regulator at 2 {
@@ -348,7 +350,6 @@
 };
 
 &usbotg {
-	vbus-supply = <&reg_usb_otg_vbus>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbotg>;
 	disable-over-current;
-- 
1.9.1
