From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:20:24 +0200
Subject: [PATCH 13/14] arm64: dts: renesas: r8a77995: draak: Enable HDMI
 display output
In-Reply-To: <cover.1538125184.git.horms+renesas@verge.net.au>
References: <cover.1538125184.git.horms+renesas@verge.net.au>
Message-ID: <bcf3003438ea464594f668a61cf2344a7f82f91c.1538125184.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <uli+renesas@fpond.eu>

Adds LVDS decoder, HDMI encoder and connector for the Draak board.

The LVDS0 and LVDS1 encoders can use the DU_DOTCLKIN0, DU_DOTCLKIN1 and
EXTAL externals clocks. Two of them are provided to the SoC on the Draak
board, hook them up in DT.

Signed-off-by: Ulrich Hecht <uli+renesas@fpond.eu>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 98 +++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index e39b73005381..2405eaad0296 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for the Draak board
  *
- * Copyright (C) 2016 Renesas Electronics Corp.
+ * Copyright (C) 2016-2018 Renesas Electronics Corp.
  * Copyright (C) 2017 Glider bvba
  */
 
@@ -45,6 +45,41 @@
 		};
 	};
 
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_out: endpoint {
+				remote-endpoint = <&adv7511_out>;
+			};
+		};
+	};
+
+	lvds-decoder {
+		compatible = "thine,thc63lvd1024";
+		vcc-supply = <&reg_3p3v>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				thc63lvd1024_in: endpoint {
+					remote-endpoint = <&lvds0_out>;
+				};
+			};
+
+			port at 2 {
+				reg = <2>;
+				thc63lvd1024_out: endpoint {
+					remote-endpoint = <&adv7511_in>;
+				};
+			};
+		};
+	};
+
 	memory at 48000000 {
 		device_type = "memory";
 		/* first 128MB is reserved for secure area. */
@@ -190,6 +225,43 @@
 
 	};
 
+	hdmi-encoder at 39 {
+		compatible = "adi,adv7511w";
+		reg = <0x39>, <0x3f>, <0x38>, <0x3c>;
+		reg-names = "main", "edid", "packet", "cec";
+		interrupt-parent = <&gpio1>;
+		interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
+
+		/* Depends on LVDS */
+		max-clock = <135000000>;
+		min-vrefresh = <50>;
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
+					remote-endpoint = <&thc63lvd1024_out>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+				adv7511_out: endpoint {
+					remote-endpoint = <&hdmi_con_out>;
+				};
+			};
+		};
+	};
+
 	hdmi-decoder at 4c {
 		compatible = "adi,adv7612";
 		reg = <0x4c>;
@@ -240,6 +312,30 @@
 	status = "okay";
 };
 
+&lvds0 {
+	status = "okay";
+
+	clocks = <&cpg CPG_MOD 727>,
+		 <&x12_clk>,
+		 <&extal_clk>;
+	clock-names = "fck", "dclkin.0", "extal";
+
+	ports {
+		port at 1 {
+			lvds0_out: endpoint {
+				remote-endpoint = <&thc63lvd1024_in>;
+			};
+		};
+	};
+};
+
+&lvds1 {
+	clocks = <&cpg CPG_MOD 727>,
+		 <&x12_clk>,
+		 <&extal_clk>;
+	clock-names = "fck", "dclkin.0", "extal";
+};
+
 &ohci0 {
 	status = "okay";
 };
-- 
2.11.0
