From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 28 Jun 2018 11:50:54 +0200
Subject: [PATCH 3/3] ARM64: dts: meson-axg: add s400 speaker amplifier
In-Reply-To: <20180628095054.13433-1-jbrunet@baylibre.com>
References: <20180628095054.13433-1-jbrunet@baylibre.com>
Message-ID: <20180628095054.13433-4-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the first of the two tas5707 power amplifier present on the
speaker daughter board.

According to the schematics of the S400 v3, only I2SB_DIN3 and
I2SC_DOUT2 will be available to the speaker board.

9R83, 9R84 and 9R18 are not connected so no audio signal will be
provided to the second amplifier. There is no point in enabling it
even if it is visible on the i2c bus.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 0b655570b7c2..1927282e8530 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -147,6 +147,19 @@
 	status = "okay";
 	pinctrl-0 = <&i2c1_z_pins>;
 	pinctrl-names = "default";
+
+	speaker_amp1: audio-codec at 1b {
+		compatible = "ti,tas5707";
+		reg = <0x1b>;
+		reset-gpios = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		AVDD-supply = <&vcc_3v3>;
+		DVDD-supply = <&vcc_3v3>;
+		PVDD_A-supply = <&main_12v>;
+		PVDD_B-supply = <&main_12v>;
+		PVDD_C-supply = <&main_12v>;
+		PVDD_D-supply = <&main_12v>;
+	};
 };
 
 &i2c_AO {
-- 
2.14.4
