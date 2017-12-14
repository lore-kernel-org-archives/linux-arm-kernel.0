From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 Dec 2017 12:23:50 +0800
Subject: [PATCH v2 3/3] [DO NOT MERGE] ARM: dts: sun8i: a83t: bpi-m3: Enable
 PCM5122 codec with I2S1
In-Reply-To: <20171214042350.29469-1-wens@csie.org>
References: <20171214042350.29469-1-wens@csie.org>
Message-ID: <20171214042350.29469-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables a PiFi DAC+ V2.0, which is a PCM5122-based audio
output DAC add-on board for the Raspberry Pi B+ and later, connected
to the GPIO header of the Bananapi M3 via jumper cables. The power,
ground, and I2C pins are in the same position, but the I2S ones are
not.

The I2C controller used is I2C2, while the I2S controller is I2S1.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 33 ++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index 6550bf0e594b..a9a208ebda12 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -70,6 +70,23 @@
 		gpio = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
 	};
 
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "PiFi DAC+ v2.0";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,mclk-fs = <512>;
+		simple-audio-card,frame-master = <&link_cpu>;
+		simple-audio-card,bitclock-master = <&link_cpu>;
+
+		link_cpu: simple-audio-card,cpu {
+			sound-dai = <&i2s1>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&pcm5122>;
+		};
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&ac100_rtc 1>;
@@ -100,6 +117,22 @@
 	status = "okay";
 };
 
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_ph_pins>;
+	status = "okay";
+
+	pcm5122: pcm5122 at 4d {
+		#sound-dai-cells = <0>;
+		compatible = "ti,pcm5122";
+		reg = <0x4d>;
+	};
+};
+
+&i2s1 {
+	status = "okay";
+};
+
 &mdio {
 	rgmii_phy: ethernet-phy at 1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.15.0
