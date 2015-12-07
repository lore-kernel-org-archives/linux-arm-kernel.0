From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon,  7 Dec 2015 12:11:04 +0000
Subject: [PATCH v5 3/4] arm64: Juno: Add HDLCD support to the Juno boards.
In-Reply-To: <1449490265-6752-1-git-send-email-Liviu.Dudau@arm.com>
References: <1449490265-6752-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1449490265-6752-4-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM's Juno board has two HDLCD controllers, each linked to an NXP
TDA19988 HDMI transmitter that provides output encoding. Add them
to the device tree.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 46 +++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index dd5158e..8ee094a 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -92,8 +92,8 @@
 			scpi_clk: scpi_clocks at 3 {
 				compatible = "arm,scpi-variable-clocks";
 				#clock-cells = <1>;
-				clock-indices = <3>, <4>;
-				clock-output-names = "pxlclk0", "pxlclk1";
+				clock-indices = <3>;
+				clock-output-names = "pxlclk";
 			};
 		};
 
@@ -123,6 +123,34 @@
 		clock-names = "apb_pclk";
 	};
 
+	hdlcd at 7ff50000 {
+		compatible = "arm,hdlcd";
+		reg = <0 0x7ff50000 0 0x1000>;
+		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&scpi_clk 3>;
+		clock-names = "pxlclk";
+
+		port {
+			hdlcd1_output: endpoint at 0 {
+				remote-endpoint = <&tda998x_1_input>;
+			};
+		};
+	};
+
+	hdlcd at 7ff60000 {
+		compatible = "arm,hdlcd";
+		reg = <0 0x7ff60000 0 0x1000>;
+		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&scpi_clk 3>;
+		clock-names = "pxlclk";
+
+		port {
+			hdlcd0_output: endpoint at 0 {
+				remote-endpoint = <&tda998x_0_input>;
+			};
+		};
+	};
+
 	soc_uart0: uart at 7ff80000 {
 		compatible = "arm,pl011", "arm,primecell";
 		reg = <0x0 0x7ff80000 0x0 0x1000>;
@@ -141,14 +169,24 @@
 		i2c-sda-hold-time-ns = <500>;
 		clocks = <&soc_smc50mhz>;
 
-		dvi0: dvi-transmitter at 70 {
+		hdmi-transmitter at 70 {
 			compatible = "nxp,tda998x";
 			reg = <0x70>;
+			port {
+				tda998x_0_input: endpoint at 0 {
+					remote-endpoint = <&hdlcd0_output>;
+				};
+			};
 		};
 
-		dvi1: dvi-transmitter at 71 {
+		hdmi-transmitter at 71 {
 			compatible = "nxp,tda998x";
 			reg = <0x71>;
+			port {
+				tda998x_1_input: endpoint at 0 {
+					remote-endpoint = <&hdlcd1_output>;
+				};
+			};
 		};
 	};
 
-- 
2.6.2
