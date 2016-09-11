From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 11 Sep 2016 15:41:10 +0200
Subject: [PATCH v2 5/6] ARM64: meson-gxbb-p20x: Enable USB Nodes
In-Reply-To: <20160911134111.31141-1-martin.blumenstingl@googlemail.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20160911134111.31141-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160911134111.31141-6-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jerome Brunet <jbrunet@baylibre.com>

Enable both gxbb USB controller and add a 5V regulator for the OTG port
VBUS

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi | 29 ++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index ce105fe..4493bce 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -93,6 +93,18 @@
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
 	};
+
+	usb_vbus: regulator-usb0-vbus {
+		compatible = "regulator-fixed";
+
+		regulator-name = "USB0_VBUS";
+
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+
+		gpio = <&gpio GPIODV_24 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 /* This UART is brought out to the DB9 connector */
@@ -149,3 +161,20 @@
 	vmmc-supply = <&vcc_3v3>;
 	vmmcq-sumpply = <&vddio_boot>;
 };
+
+&usb0_phy {
+	status = "okay";
+	phy-supply = <&usb_vbus>;
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
-- 
2.9.3
