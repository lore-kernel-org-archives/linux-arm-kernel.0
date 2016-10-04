From: brian.kim@hardkernel.com (Brian Kim)
Date: Tue,  4 Oct 2016 16:06:43 +0900
Subject: [PATCH v2] ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes
Message-ID: <1475564803-9616-1-git-send-email-brian.kim@hardkernel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable both gxbb USB controller and add a 5V regulator for the OTG port
VBUS

Signed-off-by: Brian Kim <brian.kim@hardkernel.com>
---
This patch was written on Kevin Hilman's repository[1] and branch[2]:
[1] https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git
[2] v4.8/integ

Chnages since v1:
- rename the usb_pwr node to usb_otg_pwr
- rename the regulator-name "USB_PWR" to "USB_OTG_PWR"

 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 8d89edc..bfacaf7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -64,6 +64,18 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
+	usb_otg_pwr: regulator-usb-pwrs {
+		compatible = "regulator-fixed";
+
+		regulator-name = "USB_OTG_PWR";
+
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+
+		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		blue {
@@ -149,6 +161,23 @@
 	pinctrl-names = "default";
 };
 
+&usb0_phy {
+	status = "okay";
+	phy-supply = <&usb_otg_pwr>;
+};
+
+&usb1_phy {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
 /* SD */
 &sd_emmc_b {
 	status = "okay";
-- 
2.7.4
