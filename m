From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 17 Oct 2016 14:39:59 +0200
Subject: [RFC PATCH 1/3] ARM: dts: Add support for OX820 and Pogoplug V3
In-Reply-To: <20161017124001.23820-1-narmstrong@baylibre.com>
References: <20161017124001.23820-1-narmstrong@baylibre.com>
Message-ID: <20161017124001.23820-2-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree for the Oxford Seminconductor OX820 SoC and the
Cloud Engines PogoPlug v3 board.
Add the SoC and board compatible strings to oxnas bindings.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/oxnas.txt    |   5 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 .../boot/dts/cloudengines-pogoplug-series-3.dts    |  60 +++++
 arch/arm/boot/dts/ox820.dtsi                       | 259 +++++++++++++++++++++
 4 files changed, 326 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/cloudengines-pogoplug-series-3.dts
 create mode 100644 arch/arm/boot/dts/ox820.dtsi

diff --git a/Documentation/devicetree/bindings/arm/oxnas.txt b/Documentation/devicetree/bindings/arm/oxnas.txt
index b9e4971..ac64e60 100644
--- a/Documentation/devicetree/bindings/arm/oxnas.txt
+++ b/Documentation/devicetree/bindings/arm/oxnas.txt
@@ -5,5 +5,10 @@ Boards with the OX810SE SoC shall have the following properties:
   Required root node property:
     compatible: "oxsemi,ox810se"
 
+Boards with the OX820 SoC shall have the following properties:
+  Required root node property:
+    compatible: "oxsemi,ox820"
+
 Board compatible values:
   - "wd,mbwe" (OX810SE)
+  - "cloudengines,pogoplugv3" (OX820)
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index faacd52..5d9e8d5 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -588,7 +588,8 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
 dtb-$(CONFIG_ARCH_PRIMA2) += \
 	prima2-evb.dtb
 dtb-$(CONFIG_ARCH_OXNAS) += \
-	wd-mbwe.dtb
+	wd-mbwe.dtb \
+	cloudengines-pogoplug-series-3.dtb
 dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8060-dragonboard.dtb \
 	qcom-apq8064-arrow-sd-600eval.dtb \
diff --git a/arch/arm/boot/dts/cloudengines-pogoplug-series-3.dts b/arch/arm/boot/dts/cloudengines-pogoplug-series-3.dts
new file mode 100644
index 0000000..78d9149
--- /dev/null
+++ b/arch/arm/boot/dts/cloudengines-pogoplug-series-3.dts
@@ -0,0 +1,60 @@
+/*
+ * cloudengines-pogoplug-series-3.dtsi - Device tree file for Cloud Engines PogoPlug Series 3
+ *
+ * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * Licensed under GPLv2 or later
+ */
+
+/dts-v1/;
+#include "ox820.dtsi"
+
+/ {
+	model = "Cloud Engines PogoPlug Series 3";
+
+	compatible = "cloudengines,pogoplugv3", "oxsemi,ox820";
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk=serial";
+	};
+
+	memory {
+		/* 128Mbytes DDR */
+		reg = <0x60000000 0x8000000>;
+	};
+
+	aliases {
+		serial0 = &uart0;
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		blue {
+			label = "pogoplug:blue";
+			gpios = <&gpio0 2 0>;
+			default-state = "keep";
+		};
+
+		orange {
+			label = "pogoplug:orange";
+			gpios = <&gpio1 16 1>;
+			default-state = "keep";
+		};
+
+		green {
+			label = "pogoplug:green";
+			gpios = <&gpio1 17 1>;
+			default-state = "keep";
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0>;
+};
diff --git a/arch/arm/boot/dts/ox820.dtsi b/arch/arm/boot/dts/ox820.dtsi
new file mode 100644
index 0000000..fe251f180
--- /dev/null
+++ b/arch/arm/boot/dts/ox820.dtsi
@@ -0,0 +1,259 @@
+/*
+ * ox820.dtsi - Device tree file for Oxford Semiconductor OX820 SoC
+ *
+ * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * Licensed under GPLv2 or later
+ */
+
+/include/ "skeleton.dtsi"
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/oxsemi,ox820.h>
+#include <dt-bindings/reset/oxsemi,ox820.h>
+
+/ {
+	compatible = "oxsemi,ox820";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "oxsemi,ox820-smp";
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,arm11mpcore";
+			clocks = <&armclk>;
+			reg = <0>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,arm11mpcore";
+			clocks = <&armclk>;
+			reg = <1>;
+		};
+	};
+
+	memory {
+		/* Max 512MB @ 0x60000000 */
+		reg = <0x60000000 0x20000000>;
+	};
+
+	clocks {
+		osc: oscillator {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <25000000>;
+		};
+
+		gmacclk: gmacclk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <125000000>;
+		};
+
+		sysclk: sysclk {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clock-div = <4>;
+			clock-mult = <1>;
+			clocks = <&osc>;
+		};
+
+		plla: plla {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <850000000>;
+		};
+
+		armclk: armclk {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clocks = <&plla>;
+		};
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+		interrupt-parent = <&gic>;
+
+		apb-bridge at 44000000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			ranges = <0 0x44000000 0x1000000>;
+
+			pinctrl: pinctrl {
+				compatible = "oxsemi,ox820-pinctrl";
+
+				/* Regmap for sys registers */
+				oxsemi,sys-ctrl = <&sys>;
+
+				pinctrl_uart0: uart0 {
+					uart0 {
+						pins = "gpio30", "gpio31";
+						function = "fct5";
+					};
+				};
+
+				pinctrl_uart0_modem: uart0_modem {
+					uart0_modem_a {
+						pins = "gpio24", "gpio24", "gpio26", "gpio27";
+						function = "fct4";
+					};
+					uart0_modem_b {
+						pins = "gpio28", "gpio29";
+						function = "fct5";
+					};
+				};
+
+				pinctrl_uart1: uart1 {
+					uart1 {
+						pins = "gpio7", "gpio8";
+						function = "fct4";
+					};
+				};
+
+				pinctrl_uart1_modem: uart1_modem {
+					uart1_modem {
+						pins = "gpio5", "gpio6", "gpio40", "gpio41", "gpio42", "gpio43";
+						function = "fct4";
+					};
+				};
+
+				pinctrl_etha_mdio: etha_mdio {
+					etha_mdio {
+						pins = "gpio3", "gpio4";
+						function = "fct1";
+					};
+				};
+			};
+
+			gpio0: gpio at 000000 {
+				compatible = "oxsemi,ox820-gpio";
+				reg = <0x000000 0x100000>;
+				interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				ngpios = <32>;
+				oxsemi,gpio-bank = <0>;
+				gpio-ranges = <&pinctrl 0 0 32>;
+			};
+
+			gpio1: gpio at 100000 {
+				compatible = "oxsemi,ox820-gpio";
+				reg = <0x100000 0x100000>;
+				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				ngpios = <18>;
+				oxsemi,gpio-bank = <1>;
+				gpio-ranges = <&pinctrl 0 32 18>;
+			};
+
+			uart0: serial at 200000 {
+			       compatible = "ns16550a";
+			       reg = <0x200000 0x100000>;
+			       interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			       reg-shift = <0>;
+			       fifo-size = <16>;
+			       reg-io-width = <1>;
+			       current-speed = <115200>;
+			       no-loopback-test;
+			       status = "disabled";
+			       clocks = <&sysclk>;
+			       resets = <&reset RESET_UART1>;
+			};
+
+			uart1: serial at 300000 {
+			       compatible = "ns16550a";
+			       reg = <0x200000 0x100000>;
+			       interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			       reg-shift = <0>;
+			       fifo-size = <16>;
+			       reg-io-width = <1>;
+			       current-speed = <115200>;
+			       no-loopback-test;
+			       status = "disabled";
+			       clocks = <&sysclk>;
+			       resets = <&reset RESET_UART2>;
+			};
+
+			rps at 400000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "simple-bus";
+				ranges = <0 0x400000 0x100000>;
+
+				intc: interrupt-controller at 0 {
+					compatible = "oxsemi,ox820-rps-irq", "oxsemi,ox810se-rps-irq";
+					interrupt-controller;
+					reg = <0 0x200>;
+					interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+					#interrupt-cells = <1>;
+					valid-mask = <0xFFFFFFFF>;
+					clear-mask = <0>;
+				};
+
+				timer0: timer at 200 {
+					compatible = "oxsemi,ox820-rps-timer";
+					reg = <0x200 0x40>;
+					clocks = <&sysclk>;
+					interrupt-parent = <&intc>;
+					interrupts = <4>;
+				};
+			};
+
+			sys: sys-ctrl at e00000 {
+				compatible = "oxsemi,ox820-sys-ctrl", "syscon", "simple-mfd";
+				reg = <0xe00000 0x200000>;
+
+				reset: reset-controller {
+					compatible = "oxsemi,ox820-reset", "oxsemi,ox810se-reset";
+					#reset-cells = <1>;
+				};
+
+				stdclk: stdclk {
+					compatible = "oxsemi,ox820-stdclk", "oxsemi,ox810se-stdclk";
+					#clock-cells = <1>;
+				};
+			};
+		};
+
+		apb-bridge at 47000000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			ranges = <0 0x47000000 0x1000000>;
+
+			scu: scu at 0 {
+				compatible = "arm,arm11mp-scu";
+				reg = <0x0 0x100>;
+			};
+
+			local-timer at 600 {
+				compatible = "arm,arm11mp-twd-timer";
+				reg = <0x600 0x20>;
+				interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(3)|IRQ_TYPE_LEVEL_HIGH)>;
+				clocks = <&armclk>;
+			};
+
+			gic: gic at 1000 {
+				compatible = "arm,arm11mp-gic";
+				interrupt-controller;
+				#interrupt-cells = <3>;
+				reg = <0x1000 0x1000>,
+				      <0x100 0x500>;
+			};
+		};
+	};
+};
-- 
2.7.0
