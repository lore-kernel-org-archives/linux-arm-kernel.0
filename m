From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Sun,  4 Oct 2015 21:58:46 +0300
Subject: [PATCH 1/3] ARM: dts: sun4i: Allow to use the PH6 pin for GPIO on
 pcDuino1/2
In-Reply-To: <1443985128-23137-1-git-send-email-siarhei.siamashka@gmail.com>
References: <1443985128-23137-1-git-send-email-siarhei.siamashka@gmail.com>
Message-ID: <1443985128-23137-2-git-send-email-siarhei.siamashka@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pcDuino1 board does not use any power switches at all for its
two USB host ports and the VBUS pins are always connected to 5V.

The pcDuino2 board uses the RT9701GB power switch for its single
USB host port, but the USB_EN pin (PD2) is pulled up with a 10K
resistor. So that the USB power is still enabled by default even
if nobody bothers to configure the PD2 pin or runs the pcDuino1
firmware.

The current dts file unnecessarily meddles with the PH3 and PH6
pins. But the PH6 pin is available on the J11 expansion header
and may have a better use for other purposes. This patch fixes
the problem and now the PH6 pin can be used with the GPIO sysfs
interface. Tested on a pcDuino2 board and confirmed the voltage
on the PH6 pin with a multimeter:

    echo 230 > /sys/class/gpio/export
    echo "out" > /sys/class/gpio/gpio230/direction
    echo 0 > /sys/class/gpio/gpio230/value
    echo 1 > /sys/class/gpio/gpio230/value

USB still works as expected too.

Signed-off-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10-pcduino.dts | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
index 4e3e1b9..fdc074c 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -180,14 +180,6 @@
 	};
 };
 
-&reg_usb1_vbus {
-	status = "okay";
-};
-
-&reg_usb2_vbus {
-	status = "okay";
-};
-
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
@@ -195,7 +187,5 @@
 };
 
 &usbphy {
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	usb2_vbus-supply = <&reg_usb2_vbus>;
 	status = "okay";
 };
-- 
2.4.9
