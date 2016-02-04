From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:29:28 +0100
Subject: [PATCH 34/70] ARM: dts: gose: enable sound DMA support via DVC in
 device tree
In-Reply-To: <cover.1454595846.git.horms+renesas@verge.net.au>
References: <cover.1454595846.git.horms+renesas@verge.net.au>
Message-ID: <ae79f66db7e75dfe696df7f392f4db4980117306.1454595846.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable DMA transfer using DVC in r8a7793/gose device tree.

     DMA               DMApp
[MEM] -> [SRC] -> [DVC] -> [SSIU] -> [SSI]

     DMA               DMApp
[MEM] <- [DVC] <- [SRC] <- [SSIU] <- [SSI]

Based on similar work for the r8a7791/koelsch by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 17c87fe0944f..2fa052036dbc 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -18,7 +18,24 @@
  * This command is required when Playback/Capture
  *
  *	amixer set "LINEOUT Mixer DACL" on
+ *	amixer set "DVC Out" 100%
+ *	amixer set "DVC In" 100%
+ *
+ * You can use Mute
+ *
+ *	amixer set "DVC Out Mute" on
+ *	amixer set "DVC In Mute" on
+ *
+ * You can use Volume Ramp
+ *
+ *	amixer set "DVC Out Ramp Up Rate"   "0.125 dB/64 steps"
+ *	amixer set "DVC Out Ramp Down Rate" "0.125 dB/512 steps"
+ *	amixer set "DVC Out Ramp" on
+ *	aplay xxx.wav &
+ *	amixer set "DVC Out"  80%  // Volume Down
+ *	amixer set "DVC Out" 100%  // Volume Up
  */
+
 /dts-v1/;
 #include "r8a7793.dtsi"
 #include <dt-bindings/gpio/gpio.h>
@@ -401,8 +418,8 @@
 
 	rcar_sound,dai {
 		dai0 {
-			playback = <&ssi0 &src2>;
-			capture  = <&ssi1 &src3>;
+			playback = <&ssi0 &src2 &dvc0>;
+			capture  = <&ssi1 &src3 &dvc1>;
 		};
 	};
 };
-- 
2.7.0.rc3.207.g0ac5344
