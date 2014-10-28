From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 28 Oct 2014 17:08:43 +0100
Subject: [PATCH 5/6] ARM: mvebu: use simple-card DT binding for audio on
 Armada 370 DB
In-Reply-To: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1414512524-24466-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit modifies the Armada 370 and Armada 370 DB Device Tree
descriptions to use the simple-card DT binding to describe the audio
complex of the Armada 370 DB instead of a custom audio machine driver.

To do so, it:

 - Adds the sound-dai-cells properties to the CS42L51 node, the audio
   controller node and the SPDIF in/out nodes.

 - Completely changes the description of the sound complex to use the
   "simple-audio-card" DT binding instead of the
   "marvell,a370db-audio" DT binding.

 - Fixes the indentation to properly use tabs instead of spaces.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts | 56 +++++++++++++++++++++++++++++++++----
 arch/arm/boot/dts/armada-370.dtsi   |  1 +
 2 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index d505135..0b7bf5e 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -75,6 +75,7 @@
 				clock-frequency = <100000>;
 				status = "okay";
 				audio_codec: audio-codec at 4a {
+					#sound-dai-cells = <0>;
 					compatible = "cirrus,cs42l51";
 					reg = <0x4a>;
 				};
@@ -143,17 +144,60 @@
 	};
 
 	sound {
-	      compatible = "marvell,a370db-audio";
-	      marvell,audio-controller = <&audio_controller>;
-	      marvell,audio-codec = <&audio_codec &spdif_out &spdif_in>;
-	      status = "okay";
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "Armada 370 DB Audio";
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,widgets =
+			"Headphone", "Out Jack",
+			"Line", "In Jack";
+		simple-audio-card,routing =
+			"Out Jack", "HPL",
+			"Out Jack", "HPR",
+			"AIN1L", "In Jack",
+			"AIN1L", "In Jack";
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
 	};
 
 	spdif_out: spdif-out {
-	      compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
 	};
 
 	spdif_in: spdif-in {
-	      compatible = "linux,spdif-dir";
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dir";
 	};
 };
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 6b3c23b..8d0c451 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -249,6 +249,7 @@
 			};
 
 			audio_controller: audio-controller at 30000 {
+				#sound-dai-cells = <1>;
 				compatible = "marvell,armada370-audio";
 				reg = <0x30000 0x4000>;
 				interrupts = <93>;
-- 
2.0.0
