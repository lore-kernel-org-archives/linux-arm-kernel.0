From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 25 Feb 2015 22:58:01 +0100
Subject: [PATCH 3/4] ARM: mvebu: add audio support to Armada 385 DB
In-Reply-To: <1424901482-3809-1-git-send-email-mw@semihalf.com>
References: <y>
 <1424901482-3809-1-git-send-email-mw@semihalf.com>
Message-ID: <1424901482-3809-4-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the necessary Device Tree information to enable
audio support on the Armada 385 DB platform. In details it:

 * Instantiates the CS42L51 audio codec on the I2C0 bus

 * Adds simple-card DT binding for audio on Armada 385 DB

 * Adds description for both analog I2S and S/PDIF I/O

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm/boot/dts/armada-388-db.dts | 69 +++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/armada-388-db.dts b/arch/arm/boot/dts/armada-388-db.dts
index 16512ef..bf5d9a7 100644
--- a/arch/arm/boot/dts/armada-388-db.dts
+++ b/arch/arm/boot/dts/armada-388-db.dts
@@ -82,6 +82,11 @@
 			i2c at 11000 {
 				status = "okay";
 				clock-frequency = <100000>;
+				audio_codec: audio-codec at 4a {
+					#sound-dai-cells = <0>;
+					compatible = "cirrus,cs42l51";
+					reg = <0x4a>;
+				};
 			};
 
 			i2c at 11100 {
@@ -158,6 +163,12 @@
 				no-1-8-v;
 			};
 
+			audio-controller at e8000 {
+				pinctrl-0 = <&i2s_pins>;
+				pinctrl-names = "default";
+				status = "okay";
+			};
+
 			usb3 at f0000 {
 				status = "okay";
 			};
@@ -183,4 +194,62 @@
 			};
 		};
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "Armada 385 DB Audio";
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,widgets =
+			"Headphone", "Out Jack",
+			"Line", "In Jack";
+		simple-audio-card,routing =
+			"Out Jack", "HPL",
+			"Out Jack", "HPR",
+			"AIN1L", "In Jack",
+			"AIN1R", "In Jack";
+		status = "okay";
+
+		simple-audio-card,dai-link at 0 {
+			format = "i2s";
+			cpu {
+				sound-dai = <&audio_controller 0>;
+			};
+
+			codec {
+				sound-dai = <&audio_codec>;
+			};
+		};
+
+		simple-audio-card,dai-link at 1 {
+			format = "i2s";
+			cpu {
+				sound-dai = <&audio_controller 1>;
+			};
+
+			codec {
+				sound-dai = <&spdif_out>;
+			};
+		};
+
+		simple-audio-card,dai-link at 2 {
+			format = "i2s";
+			cpu {
+				sound-dai = <&audio_controller 1>;
+			};
+
+			codec {
+				sound-dai = <&spdif_in>;
+			};
+		};
+	};
+
+	spdif_out: spdif-out {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+	};
+
+	spdif_in: spdif-in {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dir";
+	};
 };
-- 
1.8.3.1
