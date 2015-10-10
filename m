From: ats@offog.org (Adam Sampson)
Date: Sat, 10 Oct 2015 13:52:52 +0100
Subject: [PATCH v2] ARM: dts: sun7i: Correct USB regulators on pcDuino v3 Nano
Message-ID: <1444481572-13617-1-git-send-email-ats@offog.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LinkSprite pcDuino v3 Nano's two USB host ports are powered by a
single RT9701GB regulator, which has its enable input tied to the A20's
PD2 pin, pulled up to 3v3 via a 10k resistor.

However, the script.bin that shipped with the device listed PH11 and PH3
as Vbus control pins for the two USB ports. Neither of these are
actually connected to anything.

Siarhei Siamashka spotted this problem while reviewing the other
LinkSprite boards. This patch fixes it by only defining a single
regulator, controlled by PD2. Testing shows that the USB ports are now
(correctly) only powered up once the USB PHY driver is loaded.

Reported-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Signed-off-by: Adam Sampson <ats@offog.org>
---
Changes in v2:
- Add Reported-by line
- Remove redundant pinctrl-names entries
---
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
index 5361fce..b304778 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
@@ -158,7 +158,7 @@
 	};
 
 	usb1_vbus_pin_pcduino3_nano: usb1_vbus_pin at 0 {
-		allwinner,pins = "PH11";
+		allwinner,pins = "PD2";
 		allwinner,function = "gpio_out";
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
@@ -171,13 +171,10 @@
 	status = "okay";
 };
 
+/* A single regulator (U24) powers both USB host ports. */
 &reg_usb1_vbus {
 	pinctrl-0 = <&usb1_vbus_pin_pcduino3_nano>;
-	gpio = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
-	status = "okay";
-};
-
-&reg_usb2_vbus {
+	gpio = <&pio 3 2 GPIO_ACTIVE_HIGH>; /* PD2 */
 	status = "okay";
 };
 
@@ -189,6 +186,6 @@
 
 &usbphy {
 	usb1_vbus-supply = <&reg_usb1_vbus>;
-	usb2_vbus-supply = <&reg_usb2_vbus>;
+	usb2_vbus-supply = <&reg_usb1_vbus>;
 	status = "okay";
 };
-- 
2.1.4
