From: ykaneko0929@gmail.com (Yoshihiro Kaneko)
Date: Wed, 18 Jul 2018 04:47:59 +0900
Subject: [PATCH/RFT 3/7] arm64: dts: renesas: r8a77965: Add Sound device node
 and SSI support
In-Reply-To: <1531856883-19645-1-git-send-email-ykaneko0929@gmail.com>
References: <1531856883-19645-1-git-send-email-ykaneko0929@gmail.com>
Message-ID: <1531856883-19645-4-git-send-email-ykaneko0929@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

Based on several similar patches of the R8A7796 device tree
by Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 109 +++++++++++++++++++++++-------
 1 file changed, 85 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index c0dbabd..c5d6ab4 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -12,7 +12,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/r8a77965-sysc.h>
 
-#define CPG_AUDIO_CLK_I		10
+#define CPG_AUDIO_CLK_I		R8A77965_CLK_S0D4
 
 / {
 	compatible = "renesas,r8a77965";
@@ -1324,42 +1324,103 @@
 		};
 
 		rcar_sound: sound at ec500000 {
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
+			compatible =  "renesas,rcar_sound-r8a7796", "renesas,rcar_sound-gen3";
 			reg =	<0 0xec500000 0 0x1000>, /* SCU */
 				<0 0xec5a0000 0 0x100>,  /* ADG */
 				<0 0xec540000 0 0x1000>, /* SSIU */
 				<0 0xec541000 0 0x280>,  /* SSI */
 				<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
-			/* placeholder */
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
+				 <&cpg CPG_CORE R8A77965_CLK_S0D4>;
+			clock-names = "ssi-all",
+				      "ssi.9", "ssi.8", "ssi.7", "ssi.6",
+				      "ssi.5", "ssi.4", "ssi.3", "ssi.2",
+				      "ssi.1", "ssi.0",
+				      "clk_a", "clk_b", "clk_c", "clk_i";
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 1005>,
+				 <&cpg 1006>, <&cpg 1007>,
+				 <&cpg 1008>, <&cpg 1009>,
+				 <&cpg 1010>, <&cpg 1011>,
+				 <&cpg 1012>, <&cpg 1013>,
+				 <&cpg 1014>, <&cpg 1015>;
+			reset-names = "ssi-all",
+				      "ssi.9", "ssi.8", "ssi.7", "ssi.6",
+				      "ssi.5", "ssi.4", "ssi.3", "ssi.2",
+				      "ssi.1", "ssi.0";
+			status = "disabled";
 
-			rcar_sound,dvc {
-				dvc0: dvc-0 {
+			rcar_sound,ssi {
+				ssi0: ssi-0 {
+					interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
+					dma-names = "rx", "tx", "rxu", "txu";
 				};
-				dvc1: dvc-1 {
+				ssi1: ssi-1 {
+					interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x03>, <&audma1 0x04>, <&audma0 0x49>, <&audma1 0x4a>;
+					dma-names = "rx", "tx", "rxu", "txu";
 				};
-			};
-
-			rcar_sound,src {
-				src0: src-0 {
+				ssi2: ssi-2 {
+					interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x05>, <&audma1 0x06>, <&audma0 0x63>, <&audma1 0x64>;
+					dma-names = "rx", "tx", "rxu", "txu";
 				};
-				src1: src-1 {
+				ssi3: ssi-3 {
+					interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x07>, <&audma1 0x08>, <&audma0 0x6f>, <&audma1 0x70>;
+					dma-names = "rx", "tx", "rxu", "txu";
 				};
-			};
-
-			rcar_sound,ssi {
-				ssi0: ssi-0 {
+				ssi4: ssi-4 {
+					interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x09>, <&audma1 0x0a>, <&audma0 0x71>, <&audma1 0x72>;
+					dma-names = "rx", "tx", "rxu", "txu";
 				};
-				ssi1: ssi-1 {
+				ssi5: ssi-5 {
+					interrupts = <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0b>, <&audma1 0x0c>, <&audma0 0x73>, <&audma1 0x74>;
+					dma-names = "rx", "tx", "rxu", "txu";
 				};
-			};
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				port at 0 {
-					reg = <0>;
+				ssi6: ssi-6 {
+					interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0d>, <&audma1 0x0e>, <&audma0 0x75>, <&audma1 0x76>;
+					dma-names = "rx", "tx", "rxu", "txu";
 				};
-				port at 1 {
-					reg = <1>;
+				ssi7: ssi-7 {
+					interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0f>, <&audma1 0x10>, <&audma0 0x79>, <&audma1 0x7a>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi8: ssi-8 {
+					interrupts = <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x11>, <&audma1 0x12>, <&audma0 0x7b>, <&audma1 0x7c>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi9: ssi-9 {
+					interrupts = <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x13>, <&audma1 0x14>, <&audma0 0x7d>, <&audma1 0x7e>;
+					dma-names = "rx", "tx", "rxu", "txu";
 				};
 			};
 		};
-- 
1.9.1
