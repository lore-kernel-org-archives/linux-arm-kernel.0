From: andre.przywara@arm.com (Andre Przywara)
Date: Tue,  9 Aug 2016 12:53:02 +0100
Subject: [RFC PATCH 4/5] arm64: dts: sunxi: add SCPI driven clocks and nodes
 for A64 MMC
In-Reply-To: <20160809115303.17032-1-andre.przywara@arm.com>
References: <20160809115303.17032-1-andre.przywara@arm.com>
Message-ID: <20160809115303.17032-5-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMC controllers in the Allwinner A64 SoC are somewhat compatible
with the versions used in other Allwinner SoCs.
Tell Linux about the three MMC clocks that the firmware implements and
add nodes to represent the MMC controllers.
The actual hardware is capable of new transfer modes, which the driver
does not fully support yet, also the clock part has changed, but it
works like this at least for SD card accesses.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 61 +++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 9fc540e..0f6044b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -157,6 +157,19 @@
 		compatible = "arm,scpi";
 		mboxes = <&mailbox 0>;
 		shmem = <&cpu_scp_mem>;
+
+		clocks {
+			compatible = "arm,scpi-clocks";
+
+			scpi_clk: scpi_clocks {
+				compatible = "arm,scpi-variable-clocks";
+				#clock-cells = <1>;
+				clock-indices = <0>, <1>,
+						<2>;
+				clock-output-names = "mmc0_clk", "mmc1_clk",
+						     "mmc2_clk";
+			};
+		};
 	};
 
 	soc {
@@ -165,6 +178,54 @@
 		#size-cells = <1>;
 		ranges;
 
+		mmc0: mmc at 1c0f000 {
+			compatible = "allwinner,sun50i-a64-mmc",
+				     "allwinner,sun5i-a13-mmc";
+			reg = <0x01c0f000 0x1000>;
+			clocks = <&bus_gates 8>, <&scpi_clk 0>,
+				 <&scpi_clk 0>, <&scpi_clk 0>;
+			clock-names = "ahb", "mmc",
+				      "output", "sample";
+			resets = <&ahb_rst 8>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc1: mmc at 1c10000 {
+			compatible = "allwinner,sun50i-a64-mmc",
+				     "allwinner,sun5i-a13-mmc";
+			reg = <0x01c10000 0x1000>;
+			clocks = <&bus_gates 9>, <&scpi_clk 1>,
+				 <&scpi_clk 1>, <&scpi_clk 1>;
+			clock-names = "ahb", "mmc",
+				      "output", "sample";
+			resets = <&ahb_rst 9>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc2: mmc at 1c11000 {
+			compatible = "allwinner,sun50i-a64-mmc",
+				     "allwinner,sun5i-a13-mmc";
+			reg = <0x01c11000 0x1000>;
+			clocks = <&bus_gates 10>, <&scpi_clk 2>,
+				 <&scpi_clk 2>, <&scpi_clk 2>;
+			clock-names = "ahb", "mmc",
+				      "output", "sample";
+			resets = <&ahb_rst 10>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		pio: pinctrl at 1c20800 {
 			compatible = "allwinner,sun50i-a64-pinctrl";
 			reg = <0x01c20800 0x400>;
-- 
2.9.0
