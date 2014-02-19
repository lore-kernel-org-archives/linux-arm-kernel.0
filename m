From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Wed, 19 Feb 2014 13:38:43 +0800
Subject: [PATCH 4/4] ARM: dts: Add simple-card support for Vybird-TWR board
In-Reply-To: <1392788323-6092-1-git-send-email-Li.Xiubo@freescale.com>
References: <1392788323-6092-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1392788323-6092-5-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds and enables simple-card support in DT node.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 29790c9..ff27dce 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -45,6 +45,35 @@
 			regulator-always-on;
 		};
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Headphone", "Headphone Jack",
+			"Speaker", "Speaker Ext",
+			"Line", "Line In Jack";
+		simple-audio-card,routing =
+			"MIC_IN", "Microphone Jack",
+			"Microphone Jack", "Mic Bias",
+			"LINE_IN", "Line In Jack",
+			"Headphone Jack", "HP_OUT",
+			"Speaker Ext", "LINE_OUT";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+			master-clkdir-out;
+			frame-master;
+			bitclock-master;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&codec>;
+			frame-master;
+			bitclock-master;
+		};
+	};
 };
 
 &dspi0 {
@@ -85,6 +114,7 @@
 	status = "okay";
 
 	codec: sgtl5000 at 0a {
+	       #sound-dai-cells = <0>;
 	       compatible = "fsl,sgtl5000";
 	       reg = <0x0a>;
 	       VDDA-supply = <&reg_3p3v>;
@@ -162,6 +192,7 @@
 };
 
 &sai2 {
+	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai2>;
 	status = "okay";
-- 
1.8.4
