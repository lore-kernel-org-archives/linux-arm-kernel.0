From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 24 Nov 2016 19:29:08 +0800
Subject: [PATCH] ARM: dts: sun6i: hummingbird: Enable USB OTG
Message-ID: <20161124112908.4796-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 Hummingbird has a mini USB OTG port, and uses GPIO pins from the
SoC for ID pin and VBUS detection and VBUS control. The PMIC can also do
VBUS detection and control.

Here we prefer to use the PMIC's DRIVEVBUS function to control VBUS for
USB OTG, as that is the hardware default.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 83643bbd51dc..f094eeb6c499 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -248,6 +248,7 @@
 		reg = <0x68>;
 		interrupt-parent = <&nmi_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		x-powers,drive-vbus-en;
 	};
 };
 
@@ -306,6 +307,11 @@
 	regulator-name = "vcc-dram";
 };
 
+&reg_drivevbus {
+	regulator-name = "usb0-vbus";
+	status = "okay";
+};
+
 &reg_usb1_vbus {
 	gpio = <&pio 7 24 GPIO_ACTIVE_HIGH>; /* PH24 */
 	status = "okay";
@@ -330,12 +336,25 @@
 	status = "okay";
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb_power_supply {
+	status = "okay";
+};
+
 &usb1_vbus_pin_a {
 	/* different pin from sunxi-common-regulators */
 	pins = "PH24";
 };
 
 &usbphy {
+	usb0_id_det-gpio = <&pio 0 15 GPIO_ACTIVE_HIGH>; /* PA15 */
+	usb0_vbus_det-gpio = <&pio 0 16 GPIO_ACTIVE_HIGH>; /* PA16 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
+	usb0_vbus-supply = <&reg_drivevbus>;
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	status = "okay";
 };
-- 
2.10.2
