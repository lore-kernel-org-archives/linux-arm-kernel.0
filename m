From: kbeldan@baylibre.com (Karl Beldan)
Date: Wed, 17 Aug 2016 12:54:54 +0000
Subject: [PATCH v2] ARM: dts: da850-lcdk: Audio support via simple-card
Message-ID: <20160817125454.20717-1-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LCDK embeds a TLV320AIC3106 connected to the SoC McASP for analog
audio. The power supply of the codec comes from the main PMIC
(TPS650250) DCDCs which are always on per HW design and not
controllable by SW, so SW wise the codec driver will rely on the 'dummy'
regulator.
Quality is good with arecord -pipe- aplay on Line In/Line Out.

Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
---
v2:
 - Drop MIC paths parts as suggested by Sekhar.

 arch/arm/boot/dts/da850-lcdk.dts | 68 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index dbcca0b..7563260 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -23,10 +23,46 @@
 		device_type = "memory";
 		reg = <0xc0000000 0x08000000>;
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "DA850/OMAP-L138 LCDK";
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
 
 &pmx_core {
 	status = "okay";
+
+	mcasp0_pins: pinmux_mcasp0_pins {
+		pinctrl-single,bits = <
+			/* AHCLKX AFSX ACLKX */
+			0x00 0x00101010 0x00f0f0f0
+			/* ARX13 ARX14 */
+			0x04 0x00000110 0x00000ff0
+		>;
+	};
 };
 
 &serial2 {
@@ -68,3 +104,35 @@
 	cd-gpios = <&gpio 64 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	tlv320aic3106: tlv320aic3106 at 18 {
+		#sound-dai-cells = <0>;
+		compatible = "ti,tlv320aic3106";
+		reg = <0x18>;
+		status = "okay";
+	};
+};
+
+&mcasp0 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcasp0_pins>;
+	status = "okay";
+
+	op-mode = <0>;   /* DAVINCI_MCASP_IIS_MODE */
+	tdm-slots = <2>;
+	serial-dir = <   /* 0: INACTIVE, 1: TX, 2: RX */
+		0 0 0 0
+		0 0 0 0
+		0 0 0 0
+		0 1 2 0
+	>;
+	tx-num-evt = <32>;
+	rx-num-evt = <32>;
+};
-- 
2.9.2
