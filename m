From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:29:10 +0100
Subject: [PATCH 16/70] ARM: dts: r8a7793: gose: Add HDMI video out support
In-Reply-To: <cover.1454595846.git.horms+renesas@verge.net.au>
References: <cover.1454595846.git.horms+renesas@verge.net.au>
Message-ID: <8871eb07c0e77196f1f6cd2ccd659516e3e5d9aa.1454595846.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

This patch adds r8a7793 GOSE HDMI video out support.

The r8a7793 GOSE board is similar to r8a7791 Koelsch. For those
boards an on-board HDMI encoder chip provides HDMI video out
and also a LVDS port is available for external LCD panels.

Tested on r8a7793 Gose with HDMI hooked up to a Toshiba TV.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
[simon: rebased; reused existing i2c2 node]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 85 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 987ed03b1e02..0b4cc8d99390 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -129,6 +129,54 @@
 			label = "LED8";
 		};
 	};
+
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&adv7511_out>;
+			};
+		};
+	};
+
+	x2_clk: x2-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <74250000>;
+	};
+
+	x13_clk: x13-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <148500000>;
+	};
+};
+
+&du {
+	pinctrl-0 = <&du_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	clocks = <&mstp7_clks R8A7793_CLK_DU0>,
+		 <&mstp7_clks R8A7793_CLK_DU1>,
+		 <&mstp7_clks R8A7793_CLK_LVDS0>,
+		 <&x13_clk>, <&x2_clk>;
+	clock-names = "du.0", "du.1", "lvds.0",
+		      "dclkin.0", "dclkin.1";
+
+	ports {
+		port at 0 {
+			endpoint {
+				remote-endpoint = <&adv7511_in>;
+			};
+		};
+		port at 1 {
+			lvds_connector: endpoint {
+			};
+		};
+	};
 };
 
 &extal_clk {
@@ -141,6 +189,11 @@
 		renesas,function = "i2c2";
 	};
 
+	du_pins: du {
+		renesas,groups = "du_rgb888", "du_sync", "du_disp", "du_clk_out_0";
+		renesas,function = "du";
+	};
+
 	scif0_pins: serial0 {
 		renesas,groups = "scif0_data_d";
 		renesas,function = "scif0";
@@ -247,6 +300,38 @@
 	status = "okay";
 	clock-frequency = <100000>;
 
+	hdmi at 39 {
+		compatible = "adi,adv7511w";
+		reg = <0x39>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
+
+		adi,input-depth = <8>;
+		adi,input-colorspace = "rgb";
+		adi,input-clock = "1x";
+		adi,input-style = <1>;
+		adi,input-justification = "evenly";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				adv7511_in: endpoint {
+					remote-endpoint = <&du_out_rgb>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+				adv7511_out: endpoint {
+					remote-endpoint = <&hdmi_con>;
+				};
+			};
+		};
+	};
+
 	eeprom at 50 {
 		compatible = "renesas,r1ex24002", "atmel,24c02";
 		reg = <0x50>;
-- 
2.7.0.rc3.207.g0ac5344
