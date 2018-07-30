From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 30 Jul 2018 13:31:33 +0100
Subject: [PATCH v3 15/19] arm64: dts: allwinner: a64: Olinuxino: enable USB
In-Reply-To: <20180730123137.923-1-andre.przywara@arm.com>
References: <20180730123137.923-1-andre.przywara@arm.com>
Message-ID: <20180730123137.923-16-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Olinuxino has two USB sockets:
USB0 is connected to a micro B socket. As it has the ID pin wired and
the VBUS line connected to the PMIC, we describe it as a proper OTG socket,
which switches between host and device automatically.
USB1 is connected to a normal USB A socket. PG9 enables the power line,
so add the required regulator as well.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index 26075b9a76e3..a1c2f06ed474 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -59,12 +59,31 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	reg_usb1_vbus: usb1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&pio 6 9 GPIO_ACTIVE_HIGH>; /* PG9 */
+		status = "okay";
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
 	};
 };
 
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
 &emac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii_pins>;
@@ -109,6 +128,14 @@
 	};
 };
 
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
@@ -117,6 +144,7 @@
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		x-powers,drive-vbus-en;	/* set N_VBUSEN as output pin */
 	};
 };
 
@@ -201,6 +229,11 @@
 	regulator-name = "vcc-wifi-io";
 };
 
+&reg_drivevbus {
+	regulator-name = "usb0-vbus";
+	status = "okay";
+};
+
 &reg_eldo1 {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
@@ -244,3 +277,15 @@
 	pinctrl-0 = <&uart0_pins_a>;
 	status = "okay";
 };
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+	usb0_id_det-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
+	usb0_vbus-supply = <&reg_drivevbus>;
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+};
-- 
2.14.4
