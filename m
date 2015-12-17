From: wxt@rock-chips.com (Caesar Wang)
Date: Thu, 17 Dec 2015 22:21:51 +0800
Subject: [PATCH v1 5/6] ARM: dts: add the sound codec for kylin board
In-Reply-To: <1450362112-8075-1-git-send-email-wxt@rock-chips.com>
References: <1450362112-8075-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1450362112-8075-6-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support the rt5616 codec for kylin board, but we need
enable the i2s firstly.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm/boot/dts/rk3036-kylin.dts | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index 69b1e1e..296139b 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -46,6 +46,28 @@
 	model = "Rockchip RK3036 KylinBoard";
 	compatible = "rockchip,rk3036-kylin", "rockchip,rk3036";
 
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "rockchip,rt5616-codec";
+		simple-audio-card,mclk-fs = <64>;
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Headphone", "Headphone Jack";
+		simple-audio-card,routing =
+			"MIC1", "Microphone Jack",
+			"MIC2", "Microphone Jack",
+			"Microphone Jack", "micbias1",
+			"Headphone Jack", "HPOL",
+			"Headphone Jack", "HPOR";
+		simple-audio-card,cpu {
+			sound-dai = <&i2s>;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&rt5616>;
+		};
+	};
+
 	vcc_sys: vsys-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
@@ -261,6 +283,17 @@
 
 &i2c2 {
 	status = "okay";
+
+	rt5616: rt5616 at 1b {
+		#sound-dai-cells = <0>;
+		compatible = "rt5616";
+		reg = <0x1b>;
+	};
+};
+
+&i2s {
+	#sound-dai-cells = <0>;
+	status = "okay";
 };
 
 &lcdc {
-- 
1.9.1
