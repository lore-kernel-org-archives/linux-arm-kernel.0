From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 1 Aug 2014 09:13:30 +0300
Subject: [PATCH v2 6/6] ARM: DTS: da850-evm: Enable audio via simple-card
In-Reply-To: <1406873610-5037-1-git-send-email-peter.ujfalusi@ti.com>
References: <1406873610-5037-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1406873610-5037-7-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The audio on the board is using McASP <-> tlv320aic3106 codec and we have
LineIn and LineOut jacks.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/da850-evm.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 41715b495861..4f935ad9f27b 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -52,6 +52,7 @@
 				reg = <0x48>;
 			};
 			tlv320aic3106: tlv320aic3106 at 18 {
+				#sound-dai-cells = <0>;
 				compatible = "ti,tlv320aic3106";
 				reg = <0x18>;
 				status = "okay";
@@ -142,6 +143,33 @@
 		regulator-max-microvolt = <5000000>;
 		regulator-boot-on;
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "DA850/OMAP-L138 EVM";
+		simple-audio-card,widgets =
+			"Line", "Line In",
+			"Line", "Line Out";
+		simple-audio-card,routing =
+			"LINE1L", "Line In",
+			"LINE1R", "Line In",
+			"Line Out", "LLOUT",
+			"Line Out", "RLOUT";
+		simple-audio-card,format = "dsp_b";
+		simple-audio-card,bitclock-master = <&link0_codec>;
+		simple-audio-card,frame-master = <&link0_codec>;
+		simple-audio-card,bitclock-inversion;
+
+		simple-audio-card,cpu {
+			sound-dai = <&mcasp0>;
+			system-clock-frequency = <24576000>;
+		};
+
+		link0_codec: simple-audio-card,codec {
+			sound-dai = <&tlv320aic3106>;
+			system-clock-frequency = <24576000>;
+		};
+	};
 };
 
 /include/ "tps6507x.dtsi"
@@ -197,6 +225,7 @@
 };
 
 &mcasp0 {
+	#sound-dai-cells = <0>;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcasp0_pins>;
-- 
2.0.2
