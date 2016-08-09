From: andre.przywara@arm.com (Andre Przywara)
Date: Tue,  9 Aug 2016 12:53:03 +0100
Subject: [RFC PATCH 5/5] arm64: dts: sunxi: add MMC nodes to Pine64 and
 BPi-M64 .dts
In-Reply-To: <20160809115303.17032-1-andre.przywara@arm.com>
References: <20160809115303.17032-1-andre.przywara@arm.com>
Message-ID: <20160809115303.17032-6-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Those two boards connect a microSD card slot to the MMC0 controller.
Add the dummy regulator and enable MMC0 to allow accessing the SD card.

The BananaPi M64 has an on-board eMMC chip connected to the MMC2
controller, but the existing MMC driver does not support this properly
yet, so keep this one disabled for now.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 29 ++++++++++++++++++++++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 20 +++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index bc0ed4c..f98c351 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -59,6 +59,35 @@
 	aliases {
 		serial0 = &uart0;
 	};
+
+	soc {
+		reg_vcc3v3: vcc3v3 {
+			compatible = "regulator-fixed";
+			regulator-name = "vcc3v3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+	};
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>, <&mmc0_default_cd_pin>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_vcc3v3>;
+	cd-gpios = <&pio 5 6 0>;
+	cd-inverted;
+	disable-wp;
+	status = "okay";
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+	bus-width = <8>;
+	vmmc-supply = <&reg_vcc3v3>;
+	non-removable;
+	status = "disabled";
 };
 
 &uart0 {
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 077a56f..a3957ca 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -59,6 +59,26 @@
 	aliases {
 		serial0 = &uart0;
 	};
+
+	soc {
+		reg_vcc3v3: vcc3v3 {
+			compatible = "regulator-fixed";
+			regulator-name = "vcc3v3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+	};
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>, <&mmc0_default_cd_pin>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_vcc3v3>;
+	cd-gpios = <&pio 5 6 0>;
+	cd-inverted;
+	disable-wp;
+	status = "okay";
 };
 
 &uart0 {
-- 
2.9.0
