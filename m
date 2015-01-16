From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jan 2015 11:34:56 +0900
Subject: [PATCH 4/4] ARM: shmobile: r8a7791: tidyup #sound-dai-cells settings
In-Reply-To: <cover.1421371490.git.horms+renesas@verge.net.au>
References: <cover.1421371490.git.horms+renesas@verge.net.au>
Message-ID: <d2b541c98f5402ebb49ee1c636ef5bc31462b4ca.1421371490.git.horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7791-koelsch.dts | 1 +
 arch/arm/boot/dts/r8a7791.dtsi        | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 990af16..9c651c0 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -582,6 +582,7 @@
 	pinctrl-0 = <&sound_pins &sound_clk_pins>;
 	pinctrl-names = "default";
 
+	/* Single DAI */
 	#sound-dai-cells = <0>;
 
 	status = "okay";
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 7fdd1a6..002dbc5 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1381,7 +1381,12 @@
 	};
 
 	rcar_sound: rcar_sound at ec500000 {
-		#sound-dai-cells = <1>;
+		/*
+		 * #sound-dai-cells is required
+		 *
+		 * Single DAI : #sound-dai-cells = <0>;         <&rcar_sound>;
+		 * Multi  DAI : #sound-dai-cells = <1>;         <&rcar_sound N>;
+		 */
 		compatible =  "renesas,rcar_sound-r8a7791", "renesas,rcar_sound-gen2";
 		reg =	<0 0xec500000 0 0x1000>, /* SCU */
 			<0 0xec5a0000 0 0x100>,  /* ADG */
-- 
2.1.4
