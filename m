From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 21 Apr 2016 12:04:35 +0100
Subject: [PATCH 18/18] ARM: DT: STi: stihxxx-b2120: Add DT nodes for STi audio
 card
In-Reply-To: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1461236675-10176-19-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the uniperif players 2 & 3 for b2120 boards
and also adds the "simple-audio-card" device node to interconnect
the SoC sound device and the codec.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stihxxx-b2120.dtsi | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index 133375b..f50d293 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -135,5 +135,45 @@
 				dvb-card	= <STV0367_TDA18212_NIMA_1>;
 			};
 		};
+
+		sti_uni_player2: sti-uni-player at 2 {
+			status = "okay";
+		};
+
+		sti_uni_player3: sti-uni-player at 3 {
+			status = "okay";
+		};
+
+		sound {
+			compatible = "simple-audio-card";
+			simple-audio-card,name = "sti audio card";
+			status = "okay";
+
+			simple-audio-card,dai-link at 0 {
+				/* DAC */
+				format = "i2s";
+				dai-tdm-slot-width = <32>;
+				mclk-fs = <256>;
+				cpu {
+					sound-dai = <&sti_uni_player2>;
+				};
+
+				codec {
+					sound-dai = <&sti_sasg_codec 1>;
+				};
+			};
+			simple-audio-card,dai-link at 1 {
+				/* SPDIF */
+				format = "left_j";
+				mclk-fs = <128>;
+				cpu {
+					sound-dai = <&sti_uni_player3>;
+				};
+
+				codec {
+					sound-dai = <&sti_sasg_codec 0>;
+				};
+			};
+		};
 	};
 };
-- 
1.9.1
