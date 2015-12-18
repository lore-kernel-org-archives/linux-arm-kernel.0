From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:29:37 +0900
Subject: [PATCH 07/25] ARM: shmobile: r8a7778: tidyup #sound-dai-cells settings
In-Reply-To: <cover.1450402264.git.horms+renesas@verge.net.au>
References: <cover.1450402264.git.horms+renesas@verge.net.au>
Message-ID: <2020dddd67c1884ea7cb9891b36aac7ff5e73038.1450402264.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Renesas sound driver needs #sound-dai-cells settings, but, this usage
is a little bit confusable. It came from ALSA SoC historical reasons.
The sound DAI naming method is different between Single/Multi DAI in
the ALSA framework, and it is used for sound card matching.
And this #sound-dai-cells has relationship to it.
Current SoC dtsi has #sound-dai-cells = <1> as default settings
(= it is assuming that board/platform has multi DAI), and
board/platform side needs to overwrite it if board/platform was single
DAI. This style is more confusable for users.
This patch removes SoC side default settings, and force to set it by
board/platform side.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 4f8e07811746..b140627dd88b 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -236,7 +236,12 @@
 	};
 
 	rcar_sound: sound at ffd90000 {
-		#sound-dai-cells = <1>;
+		/*
+		 * #sound-dai-cells is required
+		 *
+		 * Single DAI : #sound-dai-cells = <0>;         <&rcar_sound>;
+		 * Multi  DAI : #sound-dai-cells = <1>;         <&rcar_sound N>;
+		 */
 		compatible = "renesas,rcar_sound-r8a7778", "renesas,rcar_sound-gen1";
 		reg =	<0xffd90000 0x1000>,	/* SRU */
 			<0xffd91000 0x240>,	/* SSI */
-- 
2.1.4
