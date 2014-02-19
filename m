From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Wed, 19 Feb 2014 15:42:31 +0800
Subject: [PATCH v2 4/4] ARM: dts: vf610-twr: Add simple-card support.
In-Reply-To: <1392795751-13351-1-git-send-email-Li.Xiubo@freescale.com>
References: <1392795751-13351-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1392795751-13351-5-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds and enables simple-card support in DT node.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/vf610-twr.dts | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 0f4bff5..a553aa2 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -48,6 +48,35 @@
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
@@ -88,6 +117,7 @@
 	status = "okay";
 
 	codec: sgtl5000 at 0a {
+	       #sound-dai-cells = <0>;
 	       compatible = "fsl,sgtl5000";
 	       reg = <0x0a>;
 	       VDDA-supply = <&reg_3p3v>;
@@ -165,6 +195,7 @@
 };
 
 &sai2 {
+	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai2>;
 	status = "okay";
-- 
1.8.4
