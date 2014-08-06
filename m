From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  6 Aug 2014 03:18:32 +0200
Subject: [RFC 8/8] ARM: Kirkwood: Describe DPCM audio support in DT
In-Reply-To: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
References: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
Message-ID: <1407287912-19447-9-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the DAI backend and the I2S front end of the audio
hardware for both HP T5325 and Marvell OpenRD Client.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-openrd-client.dts | 39 +++++++++++++++++++++++-----
 arch/arm/boot/dts/kirkwood-t5325.dts         | 33 +++++++++++++++++------
 2 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-openrd-client.dts b/arch/arm/boot/dts/kirkwood-openrd-client.dts
index 887b9c1fee43..2cb216512ff2 100644
--- a/arch/arm/boot/dts/kirkwood-openrd-client.dts
+++ b/arch/arm/boot/dts/kirkwood-openrd-client.dts
@@ -29,19 +29,44 @@
 				reg = <0x4a>;
 			};
 		};
+
+		audio: audio-controller at a0000 {
+			status = "okay";
+		};
+
 	};
 
 	sound {
 		compatible = "simple-audio-card";
-		simple-audio-card,format = "i2s";
-		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,name = "openrd-client-audio";
+		simple-audio-card,routing =
+			"i2s-tx", "dma-tx",
+			"dma-rx", "i2s-rx";
 
-		simple-audio-card,cpu {
-			sound-dai = <&audio0>;
+		simple-audio-card,dai-link at 0 { /* Front end */
+			dynamic;
+			dpcm_playback;
+			dpcm_capture;
+			cpu {
+				sound-dai = <&audio 0>;
+			};
+			codec {
+				snd-soc-dummy;
+			};
 		};
-
-		simple-audio-card,codec {
-			sound-dai = <&cs42l51>;
+		simple-audio-card,dia-link at 1 { /* I2S Backend */
+			format = "i2s";
+			dpcm_playback;
+			dpcm_capture;
+			no_pcm;
+			mclk-fs = <256>;
+			platform_name = "snd-soc-dummy";
+			cpu {
+				sound-dai = <&audio 1>;
+			};
+			codec {
+				sound-dai = <&cs42l51>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-t5325.dts b/arch/arm/boot/dts/kirkwood-t5325.dts
index cc6cd0bdcfac..f9466a2858c9 100644
--- a/arch/arm/boot/dts/kirkwood-t5325.dts
+++ b/arch/arm/boot/dts/kirkwood-t5325.dts
@@ -189,7 +189,7 @@
 
 	sound {
 		compatible = "simple-audio-card";
-		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "t5325";
 		simple-audio-card,routing =
 			"Headphone Jack", "HPL",
 			"Headphone Jack", "HPR",
@@ -204,15 +204,32 @@
 			"Speaker", "Speaker",
 			"Microphone", "Mic Jack";
 
-		simple-audio-card,mclk-fs = <256>;
-
-		simple-audio-card,cpu {
-			sound-dai = <&audio>;
+		simple-audio-card,dai-link at 0 { /* Front end */
+			dynamic;
+			dpcm_playback;
+			dpcm_capture;
+			cpu {
+				sound-dai = <&audio 0>;
+			};
+			codec {
+				snd-soc-dummy;
+			};
 		};
-
-		simple-audio-card,codec {
-			sound-dai = <&alc5621>;
+		simple-audio-card,dia-link at 1 { /* I2S Backend */
+			format = "i2s";
+			dpcm_playback;
+			dpcm_capture;
+			no_pcm;
+			mclk-fs = <256>;
+			platform_name = "snd-soc-dummy";
+			cpu {
+				sound-dai = <&audio 1>;
+			};
+			codec {
+				sound-dai = <&alc5621>;
+			};
 		};
+
 	};
 };
 
-- 
2.0.1
