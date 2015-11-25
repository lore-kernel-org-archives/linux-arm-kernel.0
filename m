From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 25 Nov 2015 06:36:25 +0000
Subject: [PATCH 02/12] arm64: renesas: r8a7795: Sound SSI PIO support
In-Reply-To: <8737vu8ucv.wl%kuninori.morimoto.gx@renesas.com>
References: <8737vu8ucv.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <87ziy27fqk.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds SSI for PIO sound support

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 95 ++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 18d2221..6fff49c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -52,6 +52,29 @@
 		clock-frequency = <0>;
 	};
 
+	/*
+	 * The external audio clocks are configured as 0 Hz fixed frequency
+	 * clocks by default.
+	 * Boards that provide audio clocks should override them.
+	 */
+	audio_clk_a: audio_clk_a {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	audio_clk_b: audio_clk_b {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	audio_clk_c: audio_clk_c {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
@@ -474,5 +497,77 @@
 			power-domains = <&cpg>;
 			status = "disabled";
 		};
+
+		rcar_sound: sound at ec500000 {
+			/*
+			 * #sound-dai-cells is required
+			 *
+			 * Single DAI : #sound-dai-cells = <0>;	<&rcar_sound>;
+			 * Multi  DAI : #sound-dai-cells = <1>;	<&rcar_sound N>;
+			 */
+			/*
+			 * #clock-cells is required for audio_clkout0/1/2/3
+			 *
+			 * clkout	: #clock-cells = <0>;	<&rcar_sound>;
+			 * clkout0/1/2/3: #clock-cells = <1>;	<&rcar_sound N>;
+			 */
+			compatible =  "renesas,rcar_sound-r8a7795", "renesas,rcar_sound-gen3";
+			reg =	<0 0xec500000 0 0x1000>, /* SCU */
+				<0 0xec5a0000 0 0x100>,  /* ADG */
+				<0 0xec540000 0 0x1000>, /* SSIU */
+				<0 0xec541000 0 0x280>,  /* SSI */
+				<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
+			reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
+
+			clocks = <&cpg CPG_MOD 1005>,
+				 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
+				 <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
+				 <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
+				 <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
+				 <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
+				 <&audio_clk_a>, <&audio_clk_b>,
+				 <&audio_clk_c>,
+				 <&cpg CPG_CORE R8A7795_CLK_S0D4>;
+			clock-names = "ssi-all",
+				      "ssi.9", "ssi.8", "ssi.7", "ssi.6",
+				      "ssi.5", "ssi.4", "ssi.3", "ssi.2",
+				      "ssi.1", "ssi.0",
+				      "clk_a", "clk_b", "clk_c", "clk_i";
+			power-domains = <&cpg>;
+			status = "disabled";
+
+			rcar_sound,ssi {
+				ssi0: ssi at 0 {
+					interrupts = <0 370 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi1: ssi at 1 {
+					 interrupts = <0 371 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi2: ssi at 2 {
+					interrupts = <0 372 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi3: ssi at 3 {
+					interrupts = <0 373 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi4: ssi at 4 {
+					interrupts = <0 374 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi5: ssi at 5 {
+					interrupts = <0 375 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi6: ssi at 6 {
+					interrupts = <0 376 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi7: ssi at 7 {
+					interrupts = <0 377 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi8: ssi at 8 {
+					interrupts = <0 378 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi9: ssi at 9 {
+					interrupts = <0 379 IRQ_TYPE_LEVEL_HIGH>;
+				};
+			};
+		};
 	};
 };
-- 
1.9.1
