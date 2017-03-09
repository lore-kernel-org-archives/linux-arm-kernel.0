From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  9 Mar 2017 11:39:06 +0100
Subject: [PATCH 1/3] ARM64: dts: meson-gx: Finally move common nodes to GX dtsi
In-Reply-To: <1489055948-10656-1-git-send-email-narmstrong@baylibre.com>
References: <1489055948-10656-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1489055948-10656-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 24 ++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 43 ++++++-----------------------
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  |  8 ++++++
 3 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 5d995f7..2d8dc6f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -296,6 +296,14 @@
 				status = "disabled";
 			};
 
+			spifc: spi at 8c80 {
+				compatible = "amlogic,meson-gxbb-spifc";
+				reg = <0x0 0x08c80 0x0 0x80>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			watchdog at 98d0 {
 				compatible = "amlogic,meson-gx-wdt", "amlogic,meson-gxbb-wdt";
 				reg = <0x0 0x098d0 0x0 0x10>;
@@ -342,6 +350,13 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xc8100000 0x0 0x100000>;
 
+			clkc_AO: clock-controller at 040 {
+				compatible = "amlogic,gx-aoclkc", "amlogic,gxbb-aoclkc";
+				reg = <0x0 0x00040 0x0 0x4>;
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
 			uart_AO: serial at 4c0 {
 				compatible = "amlogic,meson-uart";
 				reg = <0x0 0x004c0 0x0 0x14>;
@@ -358,6 +373,15 @@
 				status = "disabled";
 			};
 
+			i2c_AO: i2c at 500 {
+				compatible = "amlogic,meson-gx-i2c", "amlogic,meson-gxbb-i2c";
+				reg = <0x0 0x500 0x0 0x20>;
+				interrupts = <GIC_SPI 195 IRQ_TYPE_EDGE_RISING>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			pwm_AO_ab: pwm at 550 {
 				compatible = "amlogic,meson-gx-pwm", "amlogic,meson-gxbb-pwm";
 				reg = <0x0 0x00550 0x0 0x10>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 04b3324..c2c41aa 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -97,17 +97,6 @@
 	};
 };
 
-&cbus {
-	spifc: spi at 8c80 {
-		compatible = "amlogic,meson-gxbb-spifc";
-		reg = <0x0 0x08c80 0x0 0x80>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&clkc CLKID_SPI>;
-		status = "disabled";
-	};
-};
-
 &ethmac {
 	clocks = <&clkc CLKID_ETH>,
 		 <&clkc CLKID_FCLK_DIV2>,
@@ -204,30 +193,6 @@
 			};
 		};
 	};
-
-	clkc_AO: clock-controller at 040 {
-		compatible = "amlogic,gxbb-aoclkc";
-		reg = <0x0 0x00040 0x0 0x4>;
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-	pwm_ab_AO: pwm at 550 {
-		compatible = "amlogic,meson-gxbb-pwm";
-		reg = <0x0 0x0550 0x0 0x10>;
-		#pwm-cells = <3>;
-		status = "disabled";
-	};
-
-	i2c_AO: i2c at 500 {
-		compatible = "amlogic,meson-gxbb-i2c";
-		reg = <0x0 0x500 0x0 0x20>;
-		interrupts = <GIC_SPI 195 IRQ_TYPE_EDGE_RISING>;
-		clocks = <&clkc CLKID_AO_I2C>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
 };
 
 &periphs {
@@ -482,6 +447,10 @@
 	clocks = <&clkc CLKID_I2C>;
 };
 
+&i2c_AO {
+	clocks = <&clkc CLKID_AO_I2C>;
+};
+
 &i2c_B {
 	clocks = <&clkc CLKID_I2C>;
 };
@@ -521,6 +490,10 @@
 	clock-names = "core", "clkin0", "clkin1";
 };
 
+&spifc {
+	clocks = <&clkc CLKID_SPI>;
+};
+
 &vpu {
 	compatible = "amlogic,meson-gxbb-vpu", "amlogic,meson-gx-vpu";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 17cd546..37ed7a0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -427,6 +427,10 @@
 	clocks = <&clkc CLKID_I2C>;
 };
 
+&i2c_AO {
+	clocks = <&clkc CLKID_AO_I2C>;
+};
+
 &i2c_B {
 	clocks = <&clkc CLKID_I2C>;
 };
@@ -466,6 +470,10 @@
 	clock-names = "core", "clkin0", "clkin1";
 };
 
+&spifc {
+	clocks = <&clkc CLKID_SPI>;
+};
+
 &vpu {
 	compatible = "amlogic,meson-gxl-vpu", "amlogic,meson-gx-vpu";
 };
-- 
1.9.1
