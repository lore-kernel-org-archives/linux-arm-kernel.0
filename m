From: carlo@caione.org (Carlo Caione)
Date: Tue,  1 Mar 2016 23:04:35 +0100
Subject: [PATCH 3/4] ARM: dts: amlogic: Split pinctrl device for Meson8 /
 Meson8b
In-Reply-To: <1456869876-19320-1-git-send-email-carlo@caione.org>
References: <1456869876-19320-1-git-send-email-carlo@caione.org>
Message-ID: <1456869876-19320-4-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm/boot/dts/meson8.dtsi  | 57 ++++++++++++++++++++++++------------------
 arch/arm/boot/dts/meson8b.dtsi | 12 +++++++--
 2 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index a2ddcb8..45619f6 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -91,8 +91,8 @@
 		clock-frequency = <141666666>;
 	};
 
-	pinctrl: pinctrl at c1109880 {
-		compatible = "amlogic,meson8-pinctrl";
+	pinctrl_cbus: pinctrl at c1109880 {
+		compatible = "amlogic,meson8-cbus-pinctrl";
 		reg = <0xc1109880 0x10>;
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -108,29 +108,6 @@
 			#gpio-cells = <2>;
 		};
 
-		gpio_ao: ao-bank at c1108030 {
-			reg = <0xc8100014 0x4>,
-			      <0xc810002c 0x4>,
-			      <0xc8100024 0x8>;
-			reg-names = "mux", "pull", "gpio";
-			gpio-controller;
-			#gpio-cells = <2>;
-		};
-
-		uart_ao_a_pins: uart_ao_a {
-			mux {
-				groups = "uart_tx_ao_a", "uart_rx_ao_a";
-				function = "uart_ao";
-			};
-		};
-
-		i2c_ao_pins: i2c_mst_ao {
-			mux {
-				groups = "i2c_mst_sck_ao", "i2c_mst_sda_ao";
-				function = "i2c_mst_ao";
-			};
-		};
-
 		spi_nor_pins: nor {
 			mux {
 				groups = "nor_d", "nor_q", "nor_c", "nor_cs";
@@ -157,4 +134,34 @@
 		};
 	};
 
+	pinctrl_aobus: pinctrl at c8100084 {
+		compatible = "amlogic,meson8-aobus-pinctrl";
+		reg = <0xc8100084 0xc>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gpio_ao: ao-bank at c1108030 {
+			reg = <0xc8100014 0x4>,
+			      <0xc810002c 0x4>,
+			      <0xc8100024 0x8>;
+			reg-names = "mux", "pull", "gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		uart_ao_a_pins: uart_ao_a {
+			mux {
+				groups = "uart_tx_ao_a", "uart_rx_ao_a";
+				function = "uart_ao";
+			};
+		};
+
+		i2c_ao_pins: i2c_mst_ao {
+			mux {
+				groups = "i2c_mst_sck_ao", "i2c_mst_sda_ao";
+				function = "i2c_mst_ao";
+			};
+		};
+	};
 }; /* end of / */
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 8bad557..2bfe401 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -155,8 +155,8 @@
 			reg = <0xc1108000 0x4>, <0xc1104000 0x460>;
 		};
 
-		pinctrl: pinctrl at c1109880 {
-			compatible = "amlogic,meson8b-pinctrl";
+		pinctrl_cbus: pinctrl at c1109880 {
+			compatible = "amlogic,meson8b-cbus-pinctrl";
 			reg = <0xc1109880 0x10>;
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -171,6 +171,14 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 			};
+		};
+
+		pinctrl_aobus: pinctrl at c8100084 {
+			compatible = "amlogic,meson8b-aobus-pinctrl";
+			reg = <0xc8100084 0xc>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
 
 			gpio_ao: ao-bank at c1108030 {
 				reg = <0xc8100014 0x4>,
-- 
1.9.1
