From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:20:19 +0200
Subject: [PATCH 08/14] arm64: dts: renesas: revise properties for R-Car Gen3
 SoCs' usb 2.0
In-Reply-To: <cover.1538125184.git.horms+renesas@verge.net.au>
References: <cover.1538125184.git.horms+renesas@verge.net.au>
Message-ID: <737e05bf034e9ce4cba97bdc818ded181ef23e4b.1538125184.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

R-Car Gen3 SoCs need to enable/deassert clocks/resets of both usb 2.0
host (included phy) and peripheral. Otherwise, other side device
cannot work correctly. So, this patch revises properties of clocks
and resets. After that, each device driver can enable/deassert
clocks/resets by its self.

Notes:
 - To work the renesas_usbhs driver correctly when host side drivers
   are disabled and the renesas_usbhs driver doesn't have multiple
   clock management, this patch doesn't change the order of the clocks
   property in each hsusb node.
 - This patch doesn't have any side-effects even if the renesas_usbhs
   driver doesn't have reset_control and multiple clock management.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 32 +++++++++++++++----------------
 arch/arm64/boot/dts/renesas/r8a7796.dtsi  | 16 ++++++++--------
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 16 ++++++++--------
 arch/arm64/boot/dts/renesas/r8a77990.dtsi | 12 ++++++------
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 12 ++++++------
 5 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 83077fdd7e4a..b5f2273caca4 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -697,7 +697,7 @@
 				     "renesas,rcar-gen3-usbhs";
 			reg = <0 0xe6590000 0 0x100>;
 			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 704>;
+			clocks = <&cpg CPG_MOD 704>, <&cpg CPG_MOD 703>;
 			dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
 			       <&usb_dmac1 0>, <&usb_dmac1 1>;
 			dma-names = "ch0", "ch1", "ch2", "ch3";
@@ -705,7 +705,7 @@
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 704>;
+			resets = <&cpg 704>, <&cpg 703>;
 			status = "disabled";
 		};
 
@@ -714,7 +714,7 @@
 				     "renesas,rcar-gen3-usbhs";
 			reg = <0 0xe659c000 0 0x100>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 705>;
+			clocks = <&cpg CPG_MOD 705>, <&cpg CPG_MOD 700>;
 			dmas = <&usb_dmac2 0>, <&usb_dmac2 1>,
 			       <&usb_dmac3 0>, <&usb_dmac3 1>;
 			dma-names = "ch0", "ch1", "ch2", "ch3";
@@ -722,7 +722,7 @@
 			phys = <&usb2_phy3>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 705>;
+			resets = <&cpg 705>, <&cpg 700>;
 			status = "disabled";
 		};
 
@@ -2097,11 +2097,11 @@
 			compatible = "generic-ohci";
 			reg = <0 0xee080000 0 0x100>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 703>, <&cpg 704>;
 			status = "disabled";
 		};
 
@@ -2133,11 +2133,11 @@
 			compatible = "generic-ohci";
 			reg = <0 0xee0e0000 0 0x100>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 700>;
+			clocks = <&cpg CPG_MOD 700>, <&cpg CPG_MOD 705>;
 			phys = <&usb2_phy3>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 700>;
+			resets = <&cpg 700>, <&cpg 705>;
 			status = "disabled";
 		};
 
@@ -2145,12 +2145,12 @@
 			compatible = "generic-ehci";
 			reg = <0 0xee080100 0 0x100>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			companion = <&ohci0>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 703>, <&cpg 704>;
 			status = "disabled";
 		};
 
@@ -2184,12 +2184,12 @@
 			compatible = "generic-ehci";
 			reg = <0 0xee0e0100 0 0x100>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 700>;
+			clocks = <&cpg CPG_MOD 700>, <&cpg CPG_MOD 705>;
 			phys = <&usb2_phy3>;
 			phy-names = "usb";
 			companion = <&ohci3>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 700>;
+			resets = <&cpg 700>, <&cpg 705>;
 			status = "disabled";
 		};
 
@@ -2198,9 +2198,9 @@
 				     "renesas,rcar-gen3-usb2-phy";
 			reg = <0 0xee080200 0 0x700>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 703>, <&cpg 704>;
 			#phy-cells = <0>;
 			status = "disabled";
 		};
@@ -2232,9 +2232,9 @@
 				     "renesas,rcar-gen3-usb2-phy";
 			reg = <0 0xee0e0200 0 0x700>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 700>;
+			clocks = <&cpg CPG_MOD 700>, <&cpg CPG_MOD 705>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 700>;
+			resets = <&cpg 700>, <&cpg 705>;
 			#phy-cells = <0>;
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 947bfc2fe335..1ec6aaa520c1 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -676,7 +676,7 @@
 				     "renesas,rcar-gen3-usbhs";
 			reg = <0 0xe6590000 0 0x100>;
 			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 704>;
+			clocks = <&cpg CPG_MOD 704>, <&cpg CPG_MOD 703>;
 			dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
 			       <&usb_dmac1 0>, <&usb_dmac1 1>;
 			dma-names = "ch0", "ch1", "ch2", "ch3";
@@ -684,7 +684,7 @@
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 704>;
+			resets = <&cpg 704>, <&cpg 703>;
 			status = "disabled";
 		};
 
@@ -1969,11 +1969,11 @@
 			compatible = "generic-ohci";
 			reg = <0 0xee080000 0 0x100>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 703>, <&cpg 704>;
 			status = "disabled";
 		};
 
@@ -1993,12 +1993,12 @@
 			compatible = "generic-ehci";
 			reg = <0 0xee080100 0 0x100>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			companion = <&ohci0>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 703>, <&cpg 704>;
 			status = "disabled";
 		};
 
@@ -2020,9 +2020,9 @@
 				     "renesas,rcar-gen3-usb2-phy";
 			reg = <0 0xee080200 0 0x700>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 703>, <&cpg 704>;
 			#phy-cells = <0>;
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 31d23196e720..fd00010a5ed7 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -592,7 +592,7 @@
 				     "renesas,rcar-gen3-usbhs";
 			reg = <0 0xe6590000 0 0x100>;
 			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 704>;
+			clocks = <&cpg CPG_MOD 704>, <&cpg CPG_MOD 703>;
 			dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
 			       <&usb_dmac1 0>, <&usb_dmac1 1>;
 			dma-names = "ch0", "ch1", "ch2", "ch3";
@@ -600,7 +600,7 @@
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
-			resets = <&cpg 704>;
+			resets = <&cpg 704>, <&cpg 703>;
 			status = "disabled";
 		};
 
@@ -1467,11 +1467,11 @@
 			compatible = "generic-ohci";
 			reg = <0 0xee080000 0 0x100>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 703>, <&cpg 704>;
 			status = "disabled";
 		};
 
@@ -1491,12 +1491,12 @@
 			compatible = "generic-ehci";
 			reg = <0 0xee080100 0 0x100>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			companion = <&ohci0>;
 			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 703>, <&cpg 704>;
 			status = "disabled";
 		};
 
@@ -1518,9 +1518,9 @@
 				     "renesas,rcar-gen3-usb2-phy";
 			reg = <0 0xee080200 0 0x700>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
 			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 703>, <&cpg 704>;
 			#phy-cells = <0>;
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index 2cb5c19b8a7c..0c726ea5d315 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -793,11 +793,11 @@
 			compatible = "generic-ohci";
 			reg = <0 0xee080000 0 0x100>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 703>, <&cpg 704>;
 			status = "disabled";
 		};
 
@@ -805,12 +805,12 @@
 			compatible = "generic-ehci";
 			reg = <0 0xee080100 0 0x100>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			companion = <&ohci0>;
 			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 703>, <&cpg 704>;
 			status = "disabled";
 		};
 
@@ -819,9 +819,9 @@
 				     "renesas,rcar-gen3-usb2-phy";
 			reg = <0 0xee080200 0 0x700>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
 			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 703>, <&cpg 704>;
 			#phy-cells = <0>;
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index 625ba2b302c7..89a04a4496fd 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -829,11 +829,11 @@
 			compatible = "generic-ohci";
 			reg = <0 0xee080000 0 0x100>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 703>, <&cpg 704>;
 			status = "disabled";
 		};
 
@@ -841,12 +841,12 @@
 			compatible = "generic-ehci";
 			reg = <0 0xee080100 0 0x100>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			companion = <&ohci0>;
 			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 703>, <&cpg 704>;
 			status = "disabled";
 		};
 
@@ -855,9 +855,9 @@
 				     "renesas,rcar-gen3-usb2-phy";
 			reg = <0 0xee080200 0 0x700>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
 			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 703>, <&cpg 704>;
 			#phy-cells = <0>;
 			status = "disabled";
 		};
-- 
2.11.0
