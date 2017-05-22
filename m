From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 15:59:07 +0200
Subject: [PATCH 34/35] arm64: dts: r8a7795: Add support for R-Car H3 ES2.0
In-Reply-To: <cover.1495457812.git.horms+renesas@verge.net.au>
References: <cover.1495457812.git.horms+renesas@verge.net.au>
Message-ID: <291e0c4994d0813f74056163367a100fef7ad2eb.1495457812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Update r8a7795.dtsi so it corresponds to R-Car H3 ES2.0 or later:
  - The following devices no longer exist on ES2.0, and are thus removed:
    fcpf2, fcpvd3, fcpvi2, fdp1-2, usb3-if1, vspd3, vspi2.
  - The DU <-> VSPD topology is different on ES2.0, hence remove the
    "compatible" and "vsps" properties from the DU node until the driver
    can handle this.

Move support for the ES1.x revision of the R-Car H3 SoC into a
separate file.  To avoid duplication, r8a7795-es1.dtsi includes
r8a7795.dtsi, and adds device nodes and properties where needed.
Note that while currently r8a7795-es1.dtsi only adds device nodes,
removal of devices nodes and properties can be implemented using the
/delete-node/ and /delete-property/ keywords, as shown below:

	&soc {
		/delete-node/ <name>@<addr>;
	};

	&<label> {
		/delete-property/ <prop>;
	};

Switch r8a7795-salvator-x.dts and r8a7795-h3ulcb.dts from r8a7795.dtsi
to r8a7795-es1.dtsi to preserve compatibility.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi       | 84 ++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     |  4 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  4 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 71 +-----------------
 4 files changed, 89 insertions(+), 74 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
new file mode 100644
index 000000000000..a0ba7bd21ea3
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -0,0 +1,84 @@
+/*
+ * Device Tree Source for the r8a7795 ES1.x SoC
+ *
+ * Copyright (C) 2015 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include "r8a7795.dtsi"
+
+&soc {
+	xhci1: usb at ee0400000 {
+		compatible = "renesas,xhci-r8a7795", "renesas,rcar-gen3-xhci";
+		reg = <0 0xee040000 0 0xc00>;
+		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg CPG_MOD 327>;
+		power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+		resets = <&cpg 327>;
+		status = "disabled";
+	};
+
+	fcpf2: fcp at fe952000 {
+		compatible = "renesas,fcpf";
+		reg = <0 0xfe952000 0 0x200>;
+		clocks = <&cpg CPG_MOD 613>;
+		power-domains = <&sysc R8A7795_PD_A3VP>;
+		resets = <&cpg 613>;
+	};
+
+	vspi2: vsp at fe9c0000 {
+		compatible = "renesas,vsp2";
+		reg = <0 0xfe9c0000 0 0x8000>;
+		interrupts = <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg CPG_MOD 629>;
+		power-domains = <&sysc R8A7795_PD_A3VP>;
+		resets = <&cpg 629>;
+
+		renesas,fcp = <&fcpvi2>;
+	};
+
+	fcpvi2: fcp at fe9cf000 {
+		compatible = "renesas,fcpv";
+		reg = <0 0xfe9cf000 0 0x200>;
+		clocks = <&cpg CPG_MOD 609>;
+		power-domains = <&sysc R8A7795_PD_A3VP>;
+		resets = <&cpg 609>;
+	};
+
+	vspd3: vsp at fea38000 {
+		compatible = "renesas,vsp2";
+		reg = <0 0xfea38000 0 0x4000>;
+		interrupts = <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg CPG_MOD 620>;
+		power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+		resets = <&cpg 620>;
+
+		renesas,fcp = <&fcpvd3>;
+	};
+
+	fcpvd3: fcp at fea3f000 {
+		compatible = "renesas,fcpv";
+		reg = <0 0xfea3f000 0 0x200>;
+		clocks = <&cpg CPG_MOD 600>;
+		power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+		resets = <&cpg 600>;
+	};
+
+	fdp1 at fe948000 {
+		compatible = "renesas,fdp1";
+		reg = <0 0xfe948000 0 0x2400>;
+		interrupts = <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg CPG_MOD 117>;
+		power-domains = <&sysc R8A7795_PD_A3VP>;
+		resets = <&cpg 117>;
+		renesas,fcp = <&fcpf2>;
+	};
+};
+
+&du {
+	compatible = "renesas,du-r8a7795";
+	vsps = <&vspd0 &vspd1 &vspd2 &vspd3>;
+};
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
index a1fbf0ab8ad8..95fe207cb6a3 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
@@ -12,11 +12,11 @@
 #define CPG_AUDIO_CLK_I		R8A7795_CLK_S0D4
 
 /dts-v1/;
-#include "r8a7795.dtsi"
+#include "r8a7795-es1.dtsi"
 #include "ulcb.dtsi"
 
 / {
-	model = "Renesas H3ULCB board based on r8a7795";
+	model = "Renesas H3ULCB board based on r8a7795 ES1.x";
 	compatible = "renesas,h3ulcb", "renesas,r8a7795";
 
 	memory at 48000000 {
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index fcd9ca73f2c7..b84c156ed696 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -11,11 +11,11 @@
 #define CPG_AUDIO_CLK_I		R8A7795_CLK_S0D4
 
 /dts-v1/;
-#include "r8a7795.dtsi"
+#include "r8a7795-es1.dtsi"
 #include "salvator-x.dtsi"
 
 / {
-	model = "Renesas Salvator-X board based on r8a7795";
+	model = "Renesas Salvator-X board based on r8a7795 ES1.x";
 	compatible = "renesas,salvator-x", "renesas,r8a7795";
 
 	memory at 48000000 {
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index ee0129634cdf..24c607e30009 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -182,7 +182,7 @@
 		clock-frequency = <0>;
 	};
 
-	soc {
+	soc: soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
 
@@ -1274,16 +1274,6 @@
 			status = "disabled";
 		};
 
-		xhci1: usb at ee0400000 {
-			compatible = "renesas,xhci-r8a7795", "renesas,rcar-gen3-xhci";
-			reg = <0 0xee040000 0 0xc00>;
-			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 327>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 327>;
-			status = "disabled";
-		};
-
 		usb_dmac0: dma-controller at e65a0000 {
 			compatible = "renesas,r8a7795-usb-dmac",
 				     "renesas,usb-dmac";
@@ -1568,14 +1558,6 @@
 			resets = <&cpg 614>;
 		};
 
-		fcpf2: fcp at fe952000 {
-			compatible = "renesas,fcpf";
-			reg = <0 0xfe952000 0 0x200>;
-			clocks = <&cpg CPG_MOD 613>;
-			power-domains = <&sysc R8A7795_PD_A3VP>;
-			resets = <&cpg 613>;
-		};
-
 		vspbd: vsp at fe960000 {
 			compatible = "renesas,vsp2";
 			reg = <0 0xfe960000 0 0x8000>;
@@ -1633,25 +1615,6 @@
 			resets = <&cpg 610>;
 		};
 
-		vspi2: vsp at fe9c0000 {
-			compatible = "renesas,vsp2";
-			reg = <0 0xfe9c0000 0 0x8000>;
-			interrupts = <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 629>;
-			power-domains = <&sysc R8A7795_PD_A3VP>;
-			resets = <&cpg 629>;
-
-			renesas,fcp = <&fcpvi2>;
-		};
-
-		fcpvi2: fcp at fe9cf000 {
-			compatible = "renesas,fcpv";
-			reg = <0 0xfe9cf000 0 0x200>;
-			clocks = <&cpg CPG_MOD 609>;
-			power-domains = <&sysc R8A7795_PD_A3VP>;
-			resets = <&cpg 609>;
-		};
-
 		vspd0: vsp at fea20000 {
 			compatible = "renesas,vsp2";
 			reg = <0 0xfea20000 0 0x4000>;
@@ -1709,25 +1672,6 @@
 			resets = <&cpg 601>;
 		};
 
-		vspd3: vsp at fea38000 {
-			compatible = "renesas,vsp2";
-			reg = <0 0xfea38000 0 0x4000>;
-			interrupts = <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 620>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 620>;
-
-			renesas,fcp = <&fcpvd3>;
-		};
-
-		fcpvd3: fcp at fea3f000 {
-			compatible = "renesas,fcpv";
-			reg = <0 0xfea3f000 0 0x200>;
-			clocks = <&cpg CPG_MOD 600>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 600>;
-		};
-
 		fdp1 at fe940000 {
 			compatible = "renesas,fdp1";
 			reg = <0 0xfe940000 0 0x2400>;
@@ -1748,16 +1692,6 @@
 			renesas,fcp = <&fcpf1>;
 		};
 
-		fdp1 at fe948000 {
-			compatible = "renesas,fdp1";
-			reg = <0 0xfe948000 0 0x2400>;
-			interrupts = <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 117>;
-			power-domains = <&sysc R8A7795_PD_A3VP>;
-			resets = <&cpg 117>;
-			renesas,fcp = <&fcpf2>;
-		};
-
 		hdmi0: hdmi0 at fead0000 {
 			compatible = "renesas,r8a7795-hdmi", "renesas,rcar-gen3-hdmi";
 			reg = <0 0xfead0000 0 0x10000>;
@@ -1809,7 +1743,6 @@
 		};
 
 		du: display at feb00000 {
-			compatible = "renesas,du-r8a7795";
 			reg = <0 0xfeb00000 0 0x80000>,
 			      <0 0xfeb90000 0 0x14>;
 			reg-names = "du", "lvds.0";
@@ -1825,8 +1758,6 @@
 			clock-names = "du.0", "du.1", "du.2", "du.3", "lvds.0";
 			status = "disabled";
 
-			vsps = <&vspd0 &vspd1 &vspd2 &vspd3>;
-
 			ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.1.4
