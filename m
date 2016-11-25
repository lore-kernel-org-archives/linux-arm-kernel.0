From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 25 Nov 2016 20:34:39 +0800
Subject: [PATCH v2 5/8] ARM: dts: sun8i-a23: q8-tablet: Enable internal audio
 codec
In-Reply-To: <20161125123442.28410-1-wens@csie.org>
References: <20161125123442.28410-1-wens@csie.org>
Message-ID: <20161125123442.28410-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A23 Q8 tablets have an internal mono speaker w/ external amp
which has a shutdown control tied to a GPIO pin. Both the speaker
amp and the headphone jack are tied to the HP output pins. While
the speaker is mono, the headset jack is stereo. Unfortunately
the driver does not support automatic switching of this.

In addition, the headset is DC coupled, or "direct drive" enabled.
The headset's microphone is tied to MIC2 with HBIAS providing power.
A separate internal microphone is tied to MIC1 with MBIAS providing
power.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23-q8-tablet.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-q8-tablet.dts b/arch/arm/boot/dts/sun8i-a23-q8-tablet.dts
index 956320a6cc78..3ab5c0c09d93 100644
--- a/arch/arm/boot/dts/sun8i-a23-q8-tablet.dts
+++ b/arch/arm/boot/dts/sun8i-a23-q8-tablet.dts
@@ -48,3 +48,26 @@
 	model = "Q8 A23 Tablet";
 	compatible = "allwinner,q8-a23", "allwinner,sun8i-a23";
 };
+
+&codec {
+	pinctrl-0 = <&codec_pa_pin>;
+	allwinner,pa-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
+	allwinner,audio-routing =
+		"Headphone", "HP",
+		"Headphone", "HPCOM",
+		"Speaker", "HP",
+		"MIC1", "Mic",
+		"MIC2", "Headset Mic",
+		"Mic",  "MBIAS",
+		"Headset Mic", "HBIAS";
+	status = "okay";
+};
+
+&pio {
+	codec_pa_pin: codec_pa_pin at 0 {
+		allwinner,pins = "PH9";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
-- 
2.10.2
