From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 May 2018 10:03:38 +0800
Subject: [PATCH 1/3] arm64: dts: hi3798cv200: enable PCIe support for poplar
 board
Message-ID: <1526004220-17030-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds combophy devices under peripheral controller and enables PCIe
support for Hi3798CV200 Poplar board.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../boot/dts/hisilicon/hi3798cv200-poplar.dts      | 15 ++++++
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi     | 63 ++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
index 4d5d644abb12..c4382e1f3c92 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
@@ -61,6 +61,15 @@
 			default-state = "off";
 		};
 	};
+
+	reg_pcie: regulator-pcie {
+		compatible = "regulator-fixed";
+		regulator-name = "3V3_PCIE0";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio6 7 0>;
+		enable-active-high;
+	};
 };
 
 &gmac1 {
@@ -146,6 +155,12 @@
 	status = "okay";
 };
 
+&pcie {
+	reset-gpios = <&gpio4 4 GPIO_ACTIVE_HIGH>;
+	vpcie-supply = <&reg_pcie>;
+	status = "okay";
+};
+
 &sd0 {
 	bus-width = <4>;
 	cap-sd-highspeed;
diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index 962bd79139e4..5b73403551e6 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -8,7 +8,9 @@
  */
 
 #include <dt-bindings/clock/histb-clock.h>
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/reset/ti-syscon.h>
 
 / {
@@ -106,6 +108,37 @@
 			#reset-cells = <2>;
 		};
 
+		perictrl: peripheral-controller at 8a20000 {
+			compatible = "hisilicon,hi3798cv200-perictrl", "syscon",
+				     "simple-mfd";
+			reg = <0x8a20000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x8a20000 0x1000>;
+
+			combphy0: phy at 850 {
+				compatible = "hisilicon,hi3798cv200-combphy";
+				reg = <0x850 0x8>;
+				#phy-cells = <1>;
+				clocks = <&crg HISTB_COMBPHY0_CLK>;
+				resets = <&crg 0x188 4>;
+				assigned-clocks = <&crg HISTB_COMBPHY0_CLK>;
+				assigned-clock-rates = <100000000>;
+				hisilicon,fixed-mode = <PHY_TYPE_USB3>;
+			};
+
+			combphy1: phy at 858 {
+				compatible = "hisilicon,hi3798cv200-combphy";
+				reg = <0x858 0x8>;
+				#phy-cells = <1>;
+				clocks = <&crg HISTB_COMBPHY1_CLK>;
+				resets = <&crg 0x188 12>;
+				assigned-clocks = <&crg HISTB_COMBPHY1_CLK>;
+				assigned-clock-rates = <100000000>;
+				hisilicon,mode-select-bits = <0x0008 11 (0x3 << 11)>;
+			};
+		};
+
 		uart0: serial at 8b00000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x8b00000 0x1000>;
@@ -419,5 +452,35 @@
 			clocks = <&sysctrl HISTB_IR_CLK>;
 			status = "disabled";
 		};
+
+		pcie: pcie at 9860000 {
+			compatible = "hisilicon,hi3798cv200-pcie";
+			reg = <0x9860000 0x1000>,
+			      <0x0 0x2000>,
+			      <0x2000000 0x01000000>;
+			reg-names = "control", "rc-dbi", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			bus-range = <0 15>;
+			num-lanes = <1>;
+			ranges = <0x81000000 0x0 0x00000000 0x4f00000 0x0 0x100000
+				  0x82000000 0x0 0x3000000 0x3000000 0x0 0x01f00000>;
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic 0 131 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HISTB_PCIE_AUX_CLK>,
+				 <&crg HISTB_PCIE_PIPE_CLK>,
+				 <&crg HISTB_PCIE_SYS_CLK>,
+				 <&crg HISTB_PCIE_BUS_CLK>;
+			clock-names = "aux", "pipe", "sys", "bus";
+			resets = <&crg 0x18c 6>, <&crg 0x18c 5>, <&crg 0x18c 4>;
+			reset-names = "soft", "sys", "bus";
+			phys = <&combphy1 PHY_TYPE_PCIE>;
+			phy-names = "phy";
+			status = "disabled";
+		};
 	};
 };
-- 
1.9.1
