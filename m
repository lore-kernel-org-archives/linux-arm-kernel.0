From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 26 Nov 2016 15:56:35 +0100
Subject: [PATCH 5/5] ARM64: dts: meson-gx-p23x-q20x: enable USB on P23x and
 Q20x boards
In-Reply-To: <20161126145635.24488-1-martin.blumenstingl@googlemail.com>
References: <20161126145635.24488-1-martin.blumenstingl@googlemail.com>
Message-ID: <20161126145635.24488-6-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All four devices are only using the dwc3 controller. The actual ports
are provided by dwc3's internal USB hub.
The implementation on P230, P231 and Q201 seems identical: the USB VBUS
supply seems to be hard-wired, while on Q200 the USB VBUS is provided
by GPIOAO_5.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi | 12 ++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts | 17 +++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
index 7a078be..360c91d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -188,3 +188,15 @@
 &ethmac {
 	status = "okay";
 };
+
+&usb2_phys {
+	status = "okay";
+};
+
+&usb3_phy0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts
index 5dbc660..6c28e87 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts
@@ -49,6 +49,19 @@
 / {
 	compatible = "amlogic,q200", "amlogic,s912", "amlogic,meson-gxm";
 	model = "Amlogic Meson GXM (S912) Q200 Development Board";
+
+	usb_pwr: regulator-usb-pwrs {
+		compatible = "regulator-fixed";
+
+		regulator-name = "USB_PWR";
+
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+
+		/* signal name in schematic: USB_PWR_EN */
+		gpio = <&gpio GPIODV_24 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 /* Q200 has exclusive choice between internal or external PHY */
@@ -75,3 +88,7 @@
 		max-speed = <1000>;
 	};
 };
+
+&usb3_phy0 {
+	phy-supply = <&usb_pwr>;
+};
-- 
2.10.2
