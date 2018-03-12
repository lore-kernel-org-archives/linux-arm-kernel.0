From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 12 Mar 2018 12:23:56 +0800
Subject: [PATCH 4/4] ARM: dts: sun8i: a33: Enable A33 internal audio codec on
 A33-OLinuXino
In-Reply-To: <20180312042356.18625-1-wens@csie.org>
References: <20180312042356.18625-1-wens@csie.org>
Message-ID: <20180312042356.18625-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A33-OLinuXino routes the SoC's headphone output to a headphone jack,
and the microphone input to a microphone jack. Power to the microphone
is provided by MBIAS.

This patch enables the various parts of the codec, and adds widgets and
routes for simple-card.

HBIAS is connected to the microphone jack as well, but in a manner that
is confusing and likely does not provide power. This part is left out
of this patch.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
index 7f8a481af570..a1a1eb64caeb 100644
--- a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
+++ b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
@@ -69,6 +69,14 @@
 	};
 };
 
+&codec {
+	status = "okay";
+};
+
+&dai {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -182,6 +190,21 @@
 	vcc-lcd-supply = <&reg_dc1sw>;
 };
 
+&sound {
+	/* Board level jack widgets */
+	simple-audio-card,widgets = "Microphone", "Microphone Jack",
+				    "Headphone", "Headphone Jack";
+	/* Board level routing. First 2 routes copied from SoC level */
+	simple-audio-card,routing =
+		"Left DAC", "AIF1 Slot 0 Left",
+		"Right DAC", "AIF1 Slot 0 Right",
+		"HP", "HPCOM",
+		"Headphone Jack", "HP",
+		"MIC1", "Microphone Jack",
+		"Microphone Jack", "MBIAS";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_b>;
-- 
2.16.2
