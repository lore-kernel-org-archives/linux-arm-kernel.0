From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:57:59 +0100
Subject: [PATCH 20/31] ARM: dts: r8a7791: Tidyup Audio-DMAC channel for DVC
In-Reply-To: <cover.1489999062.git.horms+renesas@verge.net.au>
References: <cover.1489999062.git.horms+renesas@verge.net.au>
Message-ID: <d49db72b567d6273f41f045b0c146837d3e50f8d.1489999063.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current	Audio-DMAC is assigned "rx" as Audio-DMAC0, "tx" as Audio-DMAC1.
Thus, DVC "tx" should be assigned as Audio-DMAC1, instead of Audio-DMAC0.

Because of this, current platform board (using SRC/DVC/SSI)
Playback/Capture both will use same Audio-DMAC0
(but it depends on audio data path).

First note is that this "rx" and "tx" are from each IP point,
it doesn't mean Playback/Capture.
Second note is that Audio DMAC assigned on DT is only for
Audio-DMAC, Audio-DMAC-peri-peri has no entry.

=> Audio-DMAC
-> Audio-DMAC-peri-peri
-- HW connection

Playback case

	[Mem] => [SRC]--[DVC] -> [SSI]--[Codec]
	      rx ~~~~~~~~~~~~
Capture

	[Mem] <= [DVC]--[SRC] <- [SSI]--[Codec]
	      tx ~~~~~~~~~~~~

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 525377df16ee..b319ef4d57b0 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1779,11 +1779,11 @@
 
 		rcar_sound,dvc {
 			dvc0: dvc-0 {
-				dmas = <&audma0 0xbc>;
+				dmas = <&audma1 0xbc>;
 				dma-names = "tx";
 			};
 			dvc1: dvc-1 {
-				dmas = <&audma0 0xbe>;
+				dmas = <&audma1 0xbe>;
 				dma-names = "tx";
 			};
 		};
-- 
2.7.0.rc3.207.g0ac5344
