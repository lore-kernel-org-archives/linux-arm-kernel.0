From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:09:48 +0200
Subject: [PATCH 53/58] arm64: dts: renesas: r8a77990: Add VIN and CSI-2 device
 nodes
In-Reply-To: <cover.1536828567.git.horms+renesas@verge.net.au>
References: <cover.1536828567.git.horms+renesas@verge.net.au>
Message-ID: <ec70407ae7d790d6b34bfe582901c1149e842248.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

Add device nodes for VIN4, VIN5 and CSI40 to R-Car E3 R8A77990 device tree.

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
[simon: sorted nodes by bus address, then IP block]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77990.dtsi | 79 +++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index e3009c5f5210..c010358ba076 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -481,6 +481,54 @@
 			status = "disabled";
 		};
 
+		vin4: video at e6ef4000 {
+			compatible = "renesas,vin-r8a77990";
+			reg = <0 0xe6ef4000 0 0x1000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 807>;
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 807>;
+			renesas,id = <4>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					reg = <1>;
+
+					vin4csi40: endpoint {
+						remote-endpoint= <&csi40vin4>;
+					};
+				};
+			};
+		};
+
+		vin5: video at e6ef5000 {
+			compatible = "renesas,vin-r8a77990";
+			reg = <0 0xe6ef5000 0 0x1000>;
+			interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 806>;
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 806>;
+			renesas,id = <5>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					reg = <1>;
+
+					vin5csi40: endpoint {
+						remote-endpoint= <&csi40vin5>;
+					};
+				};
+			};
+		};
+
 		xhci0: usb at ee000000 {
 			compatible = "renesas,xhci-r8a77990",
 				     "renesas,rcar-gen3-xhci";
@@ -546,6 +594,37 @@
 			resets = <&cpg 408>;
 		};
 
+		csi40: csi2 at feaa0000 {
+			compatible = "renesas,r8a77990-csi2", "renesas,rcar-gen3-csi2";
+			reg = <0 0xfeaa0000 0 0x10000>;
+			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 716>;
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 716>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					csi40vin4: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&vin4csi40>;
+					};
+					csi40vin5: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&vin5csi40>;
+					};
+				};
+			};
+		};
+
 		prr: chipid at fff00044 {
 			compatible = "renesas,prr";
 			reg = <0 0xfff00044 0 4>;
-- 
2.11.0
