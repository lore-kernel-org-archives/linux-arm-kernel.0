From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 14 Apr 2015 20:37:26 +0000
Subject: [PATCH] ARM: dts: imx23-olinuxino: Fix dr_mode of usb0
Message-ID: <1429043846-28731-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dr_mode of usb0 on imx233-olinuxino is left to default "otg".
Since the green LED (GPIO2_1) on imx233-olinuxino is connected to the
same pin as USB_OTG_ID it's possible to disable USB host by LED toggling:

echo 0 > /sys/class/leds/green/brightness
[ 1068.890000] ci_hdrc ci_hdrc.0: remove, state 1
[ 1068.890000] usb usb1: USB disconnect, device number 1
[ 1068.920000] usb 1-1: USB disconnect, device number 2
[ 1068.920000] usb 1-1.1: USB disconnect, device number 3
[ 1069.070000] usb 1-1.2: USB disconnect, device number 4
[ 1069.450000] ci_hdrc ci_hdrc.0: USB bus 1 deregistered
[ 1074.460000] ci_hdrc ci_hdrc.0: timeout waiting for 00000800 in 11

This patch fixes the issue by setting dr_mode to "host" in the dts file.

Reported-by: Harald Geyer <harald@ccbib.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx23-olinuxino.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
index 7e6eef2..3b2d74d 100644
--- a/arch/arm/boot/dts/imx23-olinuxino.dts
+++ b/arch/arm/boot/dts/imx23-olinuxino.dts
@@ -93,6 +93,7 @@
 
 	ahb at 80080000 {
 		usb0: usb at 80080000 {
+			dr_mode = "host";
 			vbus-supply = <&reg_usb0_vbus>;
 			status = "okay";
 		};
-- 
1.7.9.5
