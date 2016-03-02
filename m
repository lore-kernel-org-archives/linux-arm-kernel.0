From: ramesh.shanmugasundaram@bp.renesas.com (Ramesh Shanmugasundaram)
Date: Wed,  2 Mar 2016 08:15:50 +0000
Subject: [PATCH v2] arm64: dts: r8a7795: Add CAN FD support
In-Reply-To: <1456826640-23237-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
References: <1456826640-23237-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Message-ID: <1456906550-4849-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds CAN FD controller node for r8a7795.

Note: CAN FD controller register base address specified in R-Car Gen3
Hardware User Manual v0.5E is incorrect. The correct address is:

CAN FD - 0xe66c0000

Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
Thanks Sergei, Simon for the comments.

	Changes since v1:
	As suggested by Sergei, Simon
	* Changed node name from canfd@ to can@

---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index a88f8d8..9185688 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -553,6 +553,30 @@
 			status = "disabled";
 		};
 
+		canfd: can at e66c0000 {
+			compatible = "renesas,r8a7795-canfd",
+				     "renesas,rcar-gen3-canfd";
+			reg = <0 0xe66c0000 0 0x8000>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				   <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 914>,
+			       <&cpg CPG_CORE R8A7795_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "fck", "canfd", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&cpg>;
+			status = "disabled";
+
+			channel0 {
+				status = "disabled";
+			};
+
+			channel1 {
+				status = "disabled";
+			};
+		};
+
 		hscif0: serial at e6540000 {
 			compatible = "renesas,hscif-r8a7795",
 				     "renesas,rcar-gen3-hscif",
-- 
1.9.1
