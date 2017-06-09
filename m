From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 10 Jun 2017 00:05:48 +0800
Subject: [PATCH] ARM: sun6i: a31s: primo81: Change USB OTG to OTG mode
Message-ID: <20170609160549.3566-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have support for the AXP221 PMIC's USB VBUS detection and
DRIVEVBUS vbus control, we can use the USB OTG port in proper OTG mode.

This patch enables the aforementioned PMIC functions, adds the OTG ID
detection pin to the USB PHY node, and changes the mode of USB OTG to
"otg".

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31s-primo81.dts | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
index f3712753fa42..73b163a7d9dd 100644
--- a/arch/arm/boot/dts/sun6i-a31s-primo81.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
@@ -158,6 +158,7 @@
 		reg = <0x68>;
 		interrupt-parent = <&nmi_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		x-powers,drive-vbus-en;
 	};
 };
 
@@ -226,6 +227,11 @@
 	regulator-name = "vddio-csi";
 };
 
+&reg_drivevbus {
+	regulator-name = "usb0-vbus";
+	status = "okay";
+};
+
 &reg_eldo3 {
 	regulator-min-microvolt = <1080000>;
 	regulator-max-microvolt = <1320000>;
@@ -238,12 +244,18 @@
 };
 
 &usb_otg {
-	/* otg support requires support for AXP221 usb-power-supply and GPIO */
-	dr_mode = "host";
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb_power_supply {
 	status = "okay";
 };
 
 &usbphy {
+	usb0_id_det-gpio = <&pio 0 15 GPIO_ACTIVE_HIGH>; /* PA15 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
+	usb0_vbus-supply = <&reg_drivevbus>;
 	usb1_vbus-supply = <&reg_dldo1>;
 	status = "okay";
 };
-- 
2.11.0
