From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Mon, 20 Oct 2014 10:31:19 -0500
Subject: [PATCHv2 2/2] ARM: dts: socfpga: Add a 3.3V fixed regulator node
In-Reply-To: <1413819079-17120-1-git-send-email-dinguyen@opensource.altera.com>
References: <1413819079-17120-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1413819079-17120-3-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Without the 3.3V regulator node, the SDMMC driver will give these warnings:

dw_mmc ff704000.dwmmc0: No vmmc regulator found
dw_mmc ff704000.dwmmc0: No vqmmc regulator found

This patch adds the regulator node, and points the SD/MMC to the regulator.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
v2: Move the regulator nodes to their respective board dts file and
    correctly rename them to match the schematic
---
 arch/arm/boot/dts/socfpga_arria5.dtsi         |  2 +-
 arch/arm/boot/dts/socfpga_arria5_socdk.dts    | 14 ++++++++++++++
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts  | 11 +++++++++++
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts | 14 ++++++++++++++
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
index 03e8268..1907cc6 100644
--- a/arch/arm/boot/dts/socfpga_arria5.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
@@ -29,7 +29,7 @@
 			};
 		};
 
-		dwmmc0 at ff704000 {
+		mmc0: dwmmc0 at ff704000 {
 			num-slots = <1>;
 			broken-cd;
 			bus-width = <4>;
diff --git a/arch/arm/boot/dts/socfpga_arria5_socdk.dts b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
index 27d551c..1f64811 100644
--- a/arch/arm/boot/dts/socfpga_arria5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
@@ -37,6 +37,15 @@
 		*/
 		ethernet0 = &gmac1;
 	};
+
+	regulator_3_3v: regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &gmac1 {
@@ -68,6 +77,11 @@
 	};
 };
 
+&mmc0 {
+	vmmc-supply = <&regulator_3_3v>;
+	vqmmc-supply = <&regulator_3_3v>;
+};
+
 &usb1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
index 739c3b7..0f624a8 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
@@ -37,6 +37,15 @@
 		 */
 		ethernet0 = &gmac1;
 	};
+
+	regulator_3_3v: regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &gmac1 {
@@ -70,6 +79,8 @@
 
 &mmc0 {
 	cd = <&gpio1 18 0>;
+	vmmc-supply = <&regulator_3_3v>;
+	vqmmc-supply = <&regulator_3_3v>;
 };
 
 &usb1 {
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
index d26f155..3e0eff2 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
@@ -37,6 +37,15 @@
 		 */
 		ethernet0 = &gmac1;
 	};
+
+	regulator_3_3v: regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &gmac1 {
@@ -53,6 +62,11 @@
 	rxc-skew-ps = <2000>;
 };
 
+&mmc0 {
+	vmmc-supply = <&regulator_3_3v>;
+	vqmmc-supply = <&regulator_3_3v>;
+};
+
 &usb1 {
 	status = "okay";
 };
-- 
2.0.3
