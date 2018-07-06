From: andre.przywara@arm.com (Andre Przywara)
Date: Fri,  6 Jul 2018 09:52:05 +0100
Subject: [PATCH 05/10] arm64: dts: allwinner: a64: Olinuxino: enable USB
In-Reply-To: <20180706085210.17952-1-andre.przywara@arm.com>
References: <20180706085210.17952-1-andre.przywara@arm.com>
Message-ID: <20180706085210.17952-6-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Olinuxino has two USB socket:
USB0 is connected to a micro B socket. As it has the ID pin wired, we
describe it as a proper OTG socket, which switches between host and
device automatically.
USB1 is connected to a normal USB A socket. PG9 enables the power line,
so add the required regulator as well.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index 73ddb665a995..0485a10a0114 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -62,6 +62,25 @@
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
 	};
+
+	reg_usb0_vbus: usb0-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb0-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&pio 6 9 GPIO_ACTIVE_HIGH>; /* PG9 */
+		status = "okay";
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
 };
 
 &emac {
@@ -108,6 +127,14 @@
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
 
@@ -241,3 +268,13 @@
 	pinctrl-0 = <&uart0_pins_a>;
 	status = "okay";
 };
+
+&usb_otg {
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+	usb0_id_det-gpios = <&pio 7 6 GPIO_ACTIVE_HIGH>; /* PH6 */
+	usb0_vbus-supply = <&reg_usb0_vbus>;
+};
-- 
2.14.4
