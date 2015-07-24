From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Jul 2015 17:41:22 +0900
Subject: [PATCH 1/9] ARM: shmobile: emev2: add IIC cores to dtsi
In-Reply-To: <cover.1437724902.git.horms+renesas@verge.net.au>
References: <cover.1437724902.git.horms+renesas@verge.net.au>
Message-ID: <cd42d042a2e712a7f9880f860075815539ce4baf.1437724902.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2.dtsi | 48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index bb45694d91bc..edad0c4eea35 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -21,6 +21,8 @@
 		gpio2 = &gpio2;
 		gpio3 = &gpio3;
 		gpio4 = &gpio4;
+		i2c0 = &iic0;
+		i2c1 = &iic1;
 	};
 
 	cpus {
@@ -66,6 +68,30 @@
 			clock-frequency = <32768>;
 			#clock-cells = <0>;
 		};
+		iic0_sclkdiv: iic0_sclkdiv {
+			compatible = "renesas,emev2-smu-clkdiv";
+			reg = <0x624 0>;
+			clocks = <&pll3_fo>;
+			#clock-cells = <0>;
+		};
+		iic0_sclk: iic0_sclk {
+			compatible = "renesas,emev2-smu-gclk";
+			reg = <0x48c 1>;
+			clocks = <&iic0_sclkdiv>;
+			#clock-cells = <0>;
+		};
+		iic1_sclkdiv: iic1_sclkdiv {
+			compatible = "renesas,emev2-smu-clkdiv";
+			reg = <0x624 16>;
+			clocks = <&pll3_fo>;
+			#clock-cells = <0>;
+		};
+		iic1_sclk: iic1_sclk {
+			compatible = "renesas,emev2-smu-gclk";
+			reg = <0x490 1>;
+			clocks = <&iic1_sclkdiv>;
+			#clock-cells = <0>;
+		};
 		pll3_fo: pll3_fo {
 			compatible = "fixed-factor-clock";
 			clocks = <&c32ki>;
@@ -234,4 +260,26 @@
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
+
+	iic0: i2c at e0070000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,iic-emev2";
+		reg = <0xe0070000 0x28>;
+		interrupts = <0 32 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&iic0_sclk>;
+		clock-names = "sclk";
+		status = "disabled";
+	};
+
+	iic1: i2c at e10a0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,iic-emev2";
+		reg = <0xe10a0000 0x28>;
+		interrupts = <0 33 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&iic1_sclk>;
+		clock-names = "sclk";
+		status = "disabled";
+	};
 };
-- 
2.1.4
