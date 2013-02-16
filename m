From: anilk4.v@gmail.com (Anil Kumar)
Date: Sat, 16 Feb 2013 13:03:56 +0530
Subject: [PATCH V2] ARM: dts: omap3-devkit8000: Enable audio support
Message-ID: <1361000036-18121-1-git-send-email-anilk4.v@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the needed sections to enable audio support on
Devkit8000 when booted with DT blob.

Signed-off-by: Anil Kumar <anilk4.v@gmail.com>
---
This patch is based on top of kernel 3.8-rc5 and
the following patches.

Peter Ujfalusi:-
ASoC: twl4030: Correct the support for Voice port
ASoC: twl4030: Convert MICBIAS to SUPPLY widget
ASoC: omap-twl4030: Add support for routing, voice port and jack detect

Anil Kumar:-
ARM: dts: add minimal DT support for DevKit8000
https://patchwork.kernel.org/patch/2122461/

-Tested for playback and capture on Devkit8000.

 Test process:-

 #amixer set 'PredriveR Mixer AudioR2' on
 #amixer set 'PredriveL Mixer AudioL2' on
 #amixer set PreDriv 100 unmute
 #amixer set 'DAC2 Digital Fine' 100
 #amixer cset numid=27 1
 #arecord | aplay

For V2:
 - Remove pin mux as done at device boot time by default.

:100644 100644 6338993... c70116f... M	arch/arm/boot/dts/omap3-devkit8000.dts
 arch/arm/boot/dts/omap3-devkit8000.dts |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
index 6338993..c70116f 100644
--- a/arch/arm/boot/dts/omap3-devkit8000.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000.dts
@@ -42,6 +42,19 @@
                 };
 
 	};
+
+	sound {
+		compatible = "ti,omap-twl4030";
+		ti,model = "devkit8000";
+
+		ti,mcbsp = <&mcbsp2>;
+		ti,codec = <&twl_audio>;
+		ti,audio-routing =
+			"Ext Spk", "PREDRIVEL",
+			"Ext Spk", "PREDRIVER",
+			"MAINMIC", "Main Mic",
+			"Main Mic", "Mic Bias 1";
+	};
 };
 
 &i2c1 {
@@ -51,6 +64,12 @@
 		reg = <0x48>;
 		interrupts = <7>;	/* SYS_NIRQ cascaded to intc */
 		interrupt-parent = <&intc>;
+
+		twl_audio: audio {
+			compatible = "ti,twl4030-audio";
+			codec {
+			};
+		};
 	};
 };
 
@@ -86,10 +105,6 @@
 	status = "disabled";
 };
 
-&mcbsp2 {
-	status = "disabled";
-};
-
 &mcbsp3 {
 	status = "disabled";
 };
-- 
1.7.0.4
