From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 12 Dec 2017 18:25:10 +0000
Subject: [PATCH 4/5] ARM: dts: r8a7743: Add sound support
In-Reply-To: <1513103111-45830-1-git-send-email-biju.das@bp.renesas.com>
References: <1513103111-45830-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1513103111-45830-5-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic r8a7743(RZ/G1M) part of  the sound device node.

This patch is based on the r8a7791 sound work by Kuninori Morimoto.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 185 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index b60527a..59860c8 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -1290,6 +1290,191 @@
 			resets = <&cpg 319>;
 			status = "disabled";
 		};
+
+		rcar_sound: sound at ec500000 {
+			/*
+			 * #sound-dai-cells is required
+			 *
+			 * Single DAI : #sound-dai-cells = <0>;         <&rcar_sound>;
+			 * Multi  DAI : #sound-dai-cells = <1>;         <&rcar_sound N>;
+			 */
+			compatible = "renesas,rcar_sound-r8a7743",
+				     "renesas,rcar_sound-gen2";
+			reg = <0 0xec500000 0 0x1000>, /* SCU */
+			      <0 0xec5a0000 0 0x100>,  /* ADG */
+			      <0 0xec540000 0 0x1000>, /* SSIU */
+			      <0 0xec541000 0 0x280>,  /* SSI */
+			      <0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
+			reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
+
+			clocks = <&cpg CPG_MOD 1005>,
+				 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
+				 <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
+				 <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
+				 <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
+				 <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
+				 <&cpg CPG_MOD 1022>, <&cpg CPG_MOD 1023>,
+				 <&cpg CPG_MOD 1024>, <&cpg CPG_MOD 1025>,
+				 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
+				 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
+				 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
+				 <&cpg CPG_MOD 1021>, <&cpg CPG_MOD 1020>,
+				 <&cpg CPG_MOD 1021>, <&cpg CPG_MOD 1020>,
+				 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
+				 <&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>,
+				 <&cpg CPG_CORE R8A7743_CLK_M2>;
+			clock-names = "ssi-all",
+				      "ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
+				      "ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
+				      "src.9", "src.8", "src.7", "src.6", "src.5",
+				      "src.4", "src.3", "src.2", "src.1", "src.0",
+				      "ctu.0", "ctu.1",
+				      "mix.0", "mix.1",
+				      "dvc.0", "dvc.1",
+				      "clk_a", "clk_b", "clk_c", "clk_i";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 1005>,
+				 <&cpg 1006>, <&cpg 1007>, <&cpg 1008>, <&cpg 1009>,
+				 <&cpg 1010>, <&cpg 1011>, <&cpg 1012>, <&cpg 1013>,
+				 <&cpg 1014>, <&cpg 1015>;
+			reset-names = "ssi-all",
+				      "ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
+				      "ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0";
+			status = "disabled";
+
+			rcar_sound,dvc {
+				dvc0: dvc-0 {
+					dmas = <&audma1 0xbc>;
+					dma-names = "tx";
+				};
+				dvc1: dvc-1 {
+					dmas = <&audma1 0xbe>;
+					dma-names = "tx";
+				};
+			};
+
+			rcar_sound,mix {
+				mix0: mix-0 { };
+				mix1: mix-1 { };
+			};
+
+			rcar_sound,ctu {
+				ctu00: ctu-0 { };
+				ctu01: ctu-1 { };
+				ctu02: ctu-2 { };
+				ctu03: ctu-3 { };
+				ctu10: ctu-4 { };
+				ctu11: ctu-5 { };
+				ctu12: ctu-6 { };
+				ctu13: ctu-7 { };
+			};
+
+			rcar_sound,src {
+				src0: src-0 {
+					interrupts = <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x85>, <&audma1 0x9a>;
+					dma-names = "rx", "tx";
+				};
+				src1: src-1 {
+					interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x87>, <&audma1 0x9c>;
+					dma-names = "rx", "tx";
+				};
+				src2: src-2 {
+					interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x89>, <&audma1 0x9e>;
+					dma-names = "rx", "tx";
+				};
+				src3: src-3 {
+					interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x8b>, <&audma1 0xa0>;
+					dma-names = "rx", "tx";
+				};
+				src4: src-4 {
+					interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x8d>, <&audma1 0xb0>;
+					dma-names = "rx", "tx";
+				};
+				src5: src-5 {
+					interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x8f>, <&audma1 0xb2>;
+					dma-names = "rx", "tx";
+				};
+				src6: src-6 {
+					interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x91>, <&audma1 0xb4>;
+					dma-names = "rx", "tx";
+				};
+				src7: src-7 {
+					interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x93>, <&audma1 0xb6>;
+					dma-names = "rx", "tx";
+				};
+				src8: src-8 {
+					interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x95>, <&audma1 0xb8>;
+					dma-names = "rx", "tx";
+				};
+				src9: src-9 {
+					interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x97>, <&audma1 0xba>;
+					dma-names = "rx", "tx";
+				};
+			};
+
+			rcar_sound,ssi {
+				ssi0: ssi-0 {
+					interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi1: ssi-1 {
+					interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x03>, <&audma1 0x04>, <&audma0 0x49>, <&audma1 0x4a>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi2: ssi-2 {
+					interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x05>, <&audma1 0x06>, <&audma0 0x63>, <&audma1 0x64>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi3: ssi-3 {
+					interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x07>, <&audma1 0x08>, <&audma0 0x6f>, <&audma1 0x70>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi4: ssi-4 {
+					interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x09>, <&audma1 0x0a>, <&audma0 0x71>, <&audma1 0x72>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi5: ssi-5 {
+					interrupts = <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0b>, <&audma1 0x0c>, <&audma0 0x73>, <&audma1 0x74>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi6: ssi-6 {
+					interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0d>, <&audma1 0x0e>, <&audma0 0x75>, <&audma1 0x76>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
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
+				};
+			};
+		};
 	};
 
 	/* External root clock */
-- 
1.9.1
