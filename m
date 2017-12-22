From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 11:30:14 +0100
Subject: [PATCH 36/37] ARM: dts: iwg22d-sodimm: Sound DMA support via DVC on
 DTS
In-Reply-To: <cover.1513938145.git.horms+renesas@verge.net.au>
References: <cover.1513938145.git.horms+renesas@verge.net.au>
Message-ID: <6f41d5e0872e4b55a5352ff79ab2452bff306753.1513938145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

DMA transfer uses DVC

     DMA               DMApp
[MEM] -> [SRC] -> [DVC] -> [SSIU] -> [SSI]

     DMA               DMApp
[MEM] <- [DVC] <- [SRC] <- [SSIU] <- [SSI]

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
index 2cac57c7c44d..a4058f4cfbcd 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
@@ -8,6 +8,29 @@
  * kind, whether express or implied.
  */
 
+/*
+ * SSI-SGTL5000
+ *
+ * This command is required when Playback/Capture
+ *
+ *      amixer set "DVC Out" 100%
+ *      amixer set "DVC In" 100%
+ *
+ * You can use Mute
+ *
+ *      amixer set "DVC Out Mute" on
+ *      amixer set "DVC In Mute" on
+ *
+ * You can use Volume Ramp
+ *
+ *      amixer set "DVC Out Ramp Up Rate"   "0.125 dB/64 steps"
+ *      amixer set "DVC Out Ramp Down Rate" "0.125 dB/512 steps"
+ *      amixer set "DVC Out Ramp" on
+ *      aplay xxx.wav &
+ *      amixer set "DVC Out"  80%  // Volume Down
+ *      amixer set "DVC Out" 100%  // Volume Up
+ */
+
 /dts-v1/;
 #include "r8a7745-iwg22m.dtsi"
 
@@ -183,8 +206,8 @@
 
 	rcar_sound,dai {
 		dai0 {
-			playback = <&ssi3 &src3>;
-			capture = <&ssi4 &src4>;
+			playback = <&ssi3 &src3 &dvc0>;
+			capture = <&ssi4 &src4 &dvc1>;
 		};
 	};
 };
-- 
2.11.0
