From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 17 Apr 2017 23:39:37 +0200
Subject: [PATCH 1/2] ARM: dts: meson: organize devices in their corresponding
 busses
In-Reply-To: <20170417213938.22626-1-martin.blumenstingl@googlemail.com>
References: <20170417213938.22626-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170417213938.22626-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson SoCs have most of the internal peripherals organized
in busses. Use them to make the dts easier to read and to avoid
duplicated register (bus) offset definitions.

The bus information is taken from the vendor kernel:
	#define IO_CBUS_PHY_BASE        0xc1100000  ///2M
	#define IO_AOBUS_PHY_BASE       0xc8100000  ///1M

There are more internal busses (such as the abp bus which seems to
contain audio, HDMI and Mali registers), but since we don't have
drivers for them yet these are not added (yet).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson.dtsi  | 180 ++++++++++++++++++++++--------------------
 arch/arm/boot/dts/meson6.dtsi |   2 -
 arch/arm/boot/dts/meson8.dtsi | 116 ++++++++++++++++++---------
 3 files changed, 171 insertions(+), 127 deletions(-)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 8c77c87660cd..9701bd1bc298 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -65,110 +65,116 @@
 		#interrupt-cells = <3>;
 	};
 
-	timer at c1109940 {
-		compatible = "amlogic,meson6-timer";
-		reg = <0xc1109940 0x18>;
-		interrupts = <0 10 1>;
-	};
-
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
 
-		wdt: watchdog at c1109900 {
-			compatible = "amlogic,meson6-wdt";
-			reg = <0xc1109900 0x8>;
-			interrupts = <0 0 1>;
-		};
-
-		uart_AO: serial at c81004c0 {
-			compatible = "amlogic,meson-uart";
-			reg = <0xc81004c0 0x18>;
-			interrupts = <0 90 1>;
-			clocks = <&clk81>;
-			status = "disabled";
-		};
-
-		uart_A: serial at c11084c0 {
-			compatible = "amlogic,meson-uart";
-			reg = <0xc11084c0 0x18>;
-			interrupts = <0 26 1>;
-			clocks = <&clk81>;
-			status = "disabled";
-		};
-
-		uart_B: serial at c11084dc {
-			compatible = "amlogic,meson-uart";
-			reg = <0xc11084dc 0x18>;
-			interrupts = <0 75 1>;
-			clocks = <&clk81>;
-			status = "disabled";
-		};
-
-		uart_C: serial at c1108700 {
-			compatible = "amlogic,meson-uart";
-			reg = <0xc1108700 0x18>;
-			interrupts = <0 93 1>;
-			clocks = <&clk81>;
-			status = "disabled";
-		};
-
-		i2c_AO: i2c at c8100500 {
-			compatible = "amlogic,meson6-i2c";
-			reg = <0xc8100500 0x20>;
-			interrupts = <0 92 1>;
-			clocks = <&clk81>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c_A: i2c at c1108500 {
-			compatible = "amlogic,meson6-i2c";
-			reg = <0xc1108500 0x20>;
-			interrupts = <0 21 1>;
-			clocks = <&clk81>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c_B: i2c at c11087c0 {
-			compatible = "amlogic,meson6-i2c";
-			reg = <0xc11087c0 0x20>;
-			interrupts = <0 128 1>;
-			clocks = <&clk81>;
+		cbus: cbus at c1100000 {
+			compatible = "simple-bus";
+			reg = <0xc1100000 0x200000>;
 			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
+			#size-cells = <1>;
+			ranges = <0x0 0xc1100000 0x200000>;
+
+			uart_A: serial at 84c0 {
+				compatible = "amlogic,meson-uart";
+				reg = <0x84c0 0x18>;
+				interrupts = <0 26 1>;
+				status = "disabled";
+			};
+
+			uart_B: serial at 84dc {
+				compatible = "amlogic,meson-uart";
+				reg = <0x84dc 0x18>;
+				interrupts = <0 75 1>;
+				status = "disabled";
+			};
+
+			i2c_A: i2c at 8500 {
+				compatible = "amlogic,meson6-i2c";
+				reg = <0x8500 0x20>;
+				interrupts = <0 21 1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart_C: serial at 8700 {
+				compatible = "amlogic,meson-uart";
+				reg = <0x8700 0x18>;
+				interrupts = <0 93 1>;
+				status = "disabled";
+			};
+
+			i2c_B: i2c at 87c0 {
+				compatible = "amlogic,meson6-i2c";
+				reg = <0x87c0 0x20>;
+				interrupts = <0 128 1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spifc: spi at 8c80 {
+				compatible = "amlogic,meson6-spifc";
+				reg = <0x8c80 0x80>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			wdt: watchdog at 9900 {
+				compatible = "amlogic,meson6-wdt";
+				reg = <0x9900 0x8>;
+				interrupts = <0 0 1>;
+			};
+
+			timer at 9940 {
+				compatible = "amlogic,meson6-timer";
+				reg = <0x9940 0x18>;
+				interrupts = <0 10 1>;
+			};
 		};
 
-		ir_receiver: ir-receiver at c8100480 {
-			compatible= "amlogic,meson6-ir";
-			reg = <0xc8100480 0x20>;
-			interrupts = <0 15 1>;
-			status = "disabled";
-		};
-
-		spifc: spi at c1108c80 {
-			compatible = "amlogic,meson6-spifc";
-			reg = <0xc1108c80 0x80>;
+		aobus: aobus at c8100000 {
+			compatible = "simple-bus";
+			reg = <0xc8100000 0x100000>;
 			#address-cells = <1>;
-			#size-cells = <0>;
-			clocks = <&clk81>;
-			status = "disabled";
+			#size-cells = <1>;
+			ranges = <0x0 0xc8100000 0x100000>;
+
+			ir_receiver: ir-receiver at 480 {
+				compatible= "amlogic,meson6-ir";
+				reg = <0x480 0x20>;
+				interrupts = <0 15 1>;
+				status = "disabled";
+			};
+
+			uart_AO: serial at 4c0 {
+				compatible = "amlogic,meson-uart";
+				reg = <0x4c0 0x18>;
+				interrupts = <0 90 1>;
+				status = "disabled";
+			};
+
+			i2c_AO: i2c at 500 {
+				compatible = "amlogic,meson6-i2c";
+				reg = <0x500 0x20>;
+				interrupts = <0 92 1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		ethmac: ethernet at c9410000 {
 			compatible = "amlogic,meson6-dwmac", "snps,dwmac";
 			reg = <0xc9410000 0x10000
-			       0xc1108108 0x4>;
+			0xc1108108 0x4>;
 			interrupts = <0 8 1>;
 			interrupt-names = "macirq";
-			clocks = <&clk81>;
-			clock-names = "stmmaceth";
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
index 8b33be15af94..b0fc91ffd6a1 100644
--- a/arch/arm/boot/dts/meson6.dtsi
+++ b/arch/arm/boot/dts/meson6.dtsi
@@ -51,8 +51,6 @@
 	model = "Amlogic Meson6 SoC";
 	compatible = "amlogic,meson6";
 
-	interrupt-parent = <&gic>;
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index ebc763eab195..5eaaf067c76a 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -50,8 +50,6 @@
 	model = "Amlogic Meson8 SoC";
 	compatible = "amlogic,meson8";
 
-	interrupt-parent = <&gic>;
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -91,18 +89,55 @@
 		clock-frequency = <141666666>;
 	};
 
-	pinctrl_cbus: pinctrl at c1109880 {
+}; /* end of / */
+
+&aobus {
+	pinctrl_aobus: pinctrl at 84 {
+		compatible = "amlogic,meson8-aobus-pinctrl";
+		reg = <0x84 0xc>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gpio_ao: ao-bank at 14 {
+			reg = <0x14 0x4>,
+			      <0x2c 0x4>,
+			      <0x24 0x8>;
+			reg-names = "mux", "pull", "gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_aobus 0 120 16>;
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
+};
+
+&cbus {
+	pinctrl_cbus: pinctrl at 9880 {
 		compatible = "amlogic,meson8-cbus-pinctrl";
-		reg = <0xc1109880 0x10>;
+		reg = <0x9880 0x10>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
 
-		gpio: banks at c11080b0 {
-			reg = <0xc11080b0 0x28>,
-			      <0xc11080e8 0x18>,
-			      <0xc1108120 0x18>,
-			      <0xc1108030 0x30>;
+		gpio: banks at 80b0 {
+			reg = <0x80b0 0x28>,
+			      <0x80e8 0x18>,
+			      <0x8120 0x18>,
+			      <0x8030 0x30>;
 			reg-names = "mux", "pull", "pull-enable", "gpio";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -134,36 +169,41 @@
 			};
 		};
 	};
+};
 
-	pinctrl_aobus: pinctrl at c8100084 {
-		compatible = "amlogic,meson8-aobus-pinctrl";
-		reg = <0xc8100084 0xc>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
+&ethmac {
+	clocks = <&clk81>;
+	clock-names = "stmmaceth";
+};
 
-		gpio_ao: ao-bank at c1108030 {
-			reg = <0xc8100014 0x4>,
-			      <0xc810002c 0x4>,
-			      <0xc8100024 0x8>;
-			reg-names = "mux", "pull", "gpio";
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-ranges = <&pinctrl_aobus 0 120 16>;
-		};
+&i2c_AO {
+	clocks = <&clk81>;
+};
 
-		uart_ao_a_pins: uart_ao_a {
-			mux {
-				groups = "uart_tx_ao_a", "uart_rx_ao_a";
-				function = "uart_ao";
-			};
-		};
+&i2c_A {
+	clocks = <&clk81>;
+};
 
-		i2c_ao_pins: i2c_mst_ao {
-			mux {
-				groups = "i2c_mst_sck_ao", "i2c_mst_sda_ao";
-				function = "i2c_mst_ao";
-			};
-		};
-	};
-}; /* end of / */
+&i2c_B {
+	clocks = <&clk81>;
+};
+
+&spifc {
+	clocks = <&clk81>;
+};
+
+&uart_AO {
+	clocks = <&clk81>;
+};
+
+&uart_A {
+	clocks = <&clk81>;
+};
+
+&uart_B {
+	clocks = <&clk81>;
+};
+
+&uart_C {
+	clocks = <&clk81>;
+};
-- 
2.12.2
