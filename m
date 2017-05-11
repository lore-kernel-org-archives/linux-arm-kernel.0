From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 11 May 2017 13:58:52 +0200
Subject: [PATCH v3 1/3] arm64: dts: r8a7795: Add support for R-Car H3 ES2.0
In-Reply-To: <1494503934-23367-1-git-send-email-geert+renesas@glider.be>
References: <1494503934-23367-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1494503934-23367-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update r8a7795.dtsi so it corresponds to R-Car H3 ES2.0 or later:
  - The following devices no longer exist on ES2.0, and are thus removed:
    fcpf2, fcpvd3, fcpvi2, fdp1-2, usb3-if1, vspd3, vspi2.
  - The DU <-> VSPD topology is different on ES2.0, hence remove the
    "compatible" and "vsps" properties from the DU node until the driver
    can handle this.

Move support for the ES1.x revision of the R-Car H3 SoC into a
separate file.  To avoid duplication, r8a7795-es1.dtsi includes
r8a7795.dtsi, add adds/removes/overrides device nodes and properties
where needed.

Switch r8a7795-salvator-x.dts and r8a7795-h3ulcb.dts from r8a7795.dtsi
to r8a7795-es1.dtsi to preserve compatibility.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
While currently r8a7795-es1.dtsi only adds device nodes, removal of
devices nodes and properties can be implemented using the /delete-node/
and /delete-property/ keywords, as shown below:

	&soc {
		/delete-node/ <name>@<addr>;
	};

	&<label> {
		/delete-property/ <prop>;
	};

v3:
  - Rebase on top of common Salvator-X board support extraction,
  - Remove the "compatible" property from the DU node in r8a7795.dtsi,
    in addition to the "vsps" property,

v2:
  - Use a separate file for ES1.x instead of for ES2.0, so r8a7795.dtsi
    always corresponds to the latest SoC revision,
  - Add a dash between SoC part number and revision, for compatibility
    with the BSP,
  - Enhance the hardware description from basic support to everything
    already supported on ES1.x (except for DU due VSP),
  - Let r8a7795-es1.dtsi include r8a7795.dtsi.
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi       | 84 ++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     |  4 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  4 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 71 +-----------------
 4 files changed, 89 insertions(+), 74 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
new file mode 100644
index 0000000000000000..a0ba7bd21ea3aa18
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
index a1fbf0ab8ad8e425..95fe207cb6a3fd2f 100644
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
index 52fce67df3413f1f..be5b2e966ea1700e 100644
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
index 7d87dff70ac84c40..e2c447cc12fe7f3a 100644
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
@@ -1748,18 +1692,7 @@
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
 		du: display at feb00000 {
-			compatible = "renesas,du-r8a7795";
 			reg = <0 0xfeb00000 0 0x80000>,
 			      <0 0xfeb90000 0 0x14>;
 			reg-names = "du", "lvds.0";
@@ -1775,8 +1708,6 @@
 			clock-names = "du.0", "du.1", "du.2", "du.3", "lvds.0";
 			status = "disabled";
 
-			vsps = <&vspd0 &vspd1 &vspd2 &vspd3>;
-
 			ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.7.4
