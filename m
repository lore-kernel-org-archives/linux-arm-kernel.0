From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:03:40 +0200
Subject: [PATCH 8/9] arm64: dts: renesas: r8a77990: Enable USB3.0 host for
 Ebisu board
In-Reply-To: <cover.1532087303.git.horms+renesas@verge.net.au>
References: <cover.1532087303.git.horms+renesas@verge.net.au>
Message-ID: <fe1bc94a275db82720c6055aa06f6ff87cbb8450.1532087303.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds and USB3.0 host device node and enable it for
R-Car E3 Ebisu board.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts | 12 ++++++++++++
 arch/arm64/boot/dts/renesas/r8a77990.dtsi      | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
index 5e28c1b94b77..2bc3a4884b00 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
@@ -71,6 +71,11 @@
 		groups = "usb0_b";
 		function = "usb0";
 	};
+
+	usb30_pins: usb30 {
+		groups = "usb30";
+		function = "usb30";
+	};
 };
 
 &rwdt {
@@ -88,3 +93,10 @@
 
 	status = "okay";
 };
+
+&xhci0 {
+	pinctrl-0 = <&usb30_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index 28eccd1d3980..ae89260baad9 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -349,6 +349,17 @@
 			status = "disabled";
 		};
 
+		xhci0: usb at ee000000 {
+			compatible = "renesas,xhci-r8a77990",
+				     "renesas,rcar-gen3-xhci";
+			reg = <0 0xee000000 0 0xc00>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 328>;
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 328>;
+			status = "disabled";
+		};
+
 		ohci0: usb at ee080000 {
 			compatible = "generic-ohci";
 			reg = <0 0xee080000 0 0x100>;
-- 
2.11.0
