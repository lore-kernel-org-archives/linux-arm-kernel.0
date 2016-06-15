From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 15 Jun 2016 21:28:45 +0800
Subject: [PATCH 2/3] ARM: dts: rockchip: add simple sound card for RK3036 SoCs
In-Reply-To: <1465997312-17777-1-git-send-email-ykk@rock-chips.com>
References: <1465997312-17777-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1465997325-17830-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using I2S as the audio input source, and force the mclk_fs to 256.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 arch/arm/boot/dts/rk3036.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 843d2be..ecff071 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -335,6 +335,9 @@
 		rockchip,grf = <&grf>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&hdmi_ctl>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 
 		hdmi_in: port {
@@ -347,6 +350,25 @@
 		};
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "rockchip,hdmi";
+		simple-audio-card,widgets = "Headphone", "Out Jack",
+					    "Line", "In Jack";
+		status = "disabled";
+
+		simple-audio-card,dai-link {
+			format = "i2s";
+			mclk-fs = <256>;
+			cpu {
+				sound-dai = <&i2s>;
+			};
+			codec {
+				sound-dai = <&hdmi>;
+			};
+		};
+	};
+
 	timer: timer at 20044000 {
 		compatible = "rockchip,rk3036-timer", "rockchip,rk3288-timer";
 		reg = <0x20044000 0x20>;
-- 
1.9.1
