From: ayaka@soulik.info (Randy Li)
Date: Tue, 16 Aug 2016 04:42:07 +0800
Subject: [PATCH] ARM: dts: rockchip: add analog audio support for firefly
 reload
In-Reply-To: <1471293727-26258-1-git-send-email-ayaka@soulik.info>
References: <1471293727-26258-1-git-send-email-ayaka@soulik.info>
Message-ID: <1471293727-26258-2-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ES8323 found on firefly reload board is used to output
analog audio to headphone and capture the sound from micphone
on board and the one may attach to headphone. It would be also
used to capture the sound from HDMI IN.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 arch/arm/boot/dts/rk3288-firefly-reload.dts | 36 +++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-firefly-reload.dts b/arch/arm/boot/dts/rk3288-firefly-reload.dts
index 0f5a7c1..ae46231 100644
--- a/arch/arm/boot/dts/rk3288-firefly-reload.dts
+++ b/arch/arm/boot/dts/rk3288-firefly-reload.dts
@@ -200,8 +200,34 @@
 
 	sound {
 		compatible = "simple-audio-card";
-		simple-audio-card,name = "SPDIF";
-		simple-audio-card,dai-link at 1 {  /* S/PDIF - S/PDIF */
+		simple-audio-card,name = "rockchip-audio";
+		/*simple-audio-card,hp-det-gpio = <&gpio7 15 GPIO_ACTIVE_HIGH>;*/
+		simple-audio-card,widgets =
+			"Microphone", "Mic Jack",
+			"Headphone", "Headphone Jack";
+                simple-audio-card,routing =
+                        "Headphone Jack", "LOUT2",
+                        "Headphone Jack", "ROUT2",
+                        "LINPUT2", "Mic Jack",
+                        "LINPUT1", "Mic Jack",
+                        "RINPUT1", "Mic Jack";
+
+                simple-audio-card,dai-link at 0 {
+                        format = "i2s";
+			bitclock-master = <&link0_codec>;
+			frame-master = <&link0_codec>;
+
+                        cpu {
+				sound-dai = <&i2s>; 
+			};
+
+                        link0_codec: codec {
+				sound-dai = <&codec>;
+				system-clock-frequency = <11289600>;
+			};
+                };
+
+		simple-audio-card,dai-link at 1 {
 			cpu { sound-dai = <&spdif>; };
 			codec { sound-dai = <&spdif_out>; };
 		};
@@ -236,14 +262,15 @@
 		AVDD-supply = <&vcca_33>;
 		PVDD-supply = <&vcca_33>;
 		HPVDD-supply = <&vcca_33>;
-		clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
-		clock-names = "i2s_hclk", "i2s_clk";
+		clocks = <&cru SCLK_I2S0_OUT>;
 		reg = <0x10>;
+		#sound-dai-cells = <0>;
 	};
 };
 
 &i2s {
 	status = "okay";
+	#sound-dai-cells = <0>;
 };
 
 &sdmmc {
@@ -256,7 +283,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc_clk>, <&sdmmc_cmd>, <&sdmmc_cd>, <&sdmmc_bus4>;
 	vmmc-supply = <&vcc_sd>;
-	vqmmc-supply = <&vcc_sd>;
 	status = "okay";
 };
 
-- 
2.7.4
