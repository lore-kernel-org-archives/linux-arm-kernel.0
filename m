From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 2 Aug 2013 19:25:32 +0300
Subject: [PATCHv5 13/31] ARM: dts: clk: Add apll related clocks
In-Reply-To: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Message-ID: <1375460751-23676-14-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Keerthy <j-keerthy@ti.com>

The patch adds a mux node to choose the parent of apll_pcie_ck node.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index e4853f8..b377526 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -326,13 +326,24 @@ dpll_pcie_ref_m2ldo_ck: dpll_pcie_ref_m2ldo_ck at 4a008210 {
 	ti,autoidle-low;
 };
 
+/* APLL_PCIE */
+
+/* mux clock to select the reference clock */
+apll_pcie_in_clk_mux: apll_pcie_in_clk_mux at 4ae06118 {
+	compatible = "mux-clock";
+	clocks = <&dpll_pcie_ref_ck>, <&pciesref_acs_clk_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a00821c 0x4>;
+	bit-mask = <0x80>;
+};
+
 apll_pcie_ck: apll_pcie_ck at 4a008200 {
 	#clock-cells = <0>;
-	compatible = "ti,omap4-dpll-clock";
-	clocks = <&dpll_pcie_ref_ck>;
-	reg = <0x4a008200 0x4>, <0x4a008204 0x4>, <0x4a008208 0x4>, <0x4a00820c 0x4>;
-	ti,clk-ref = <&dpll_pcie_ref_ck>;
+	clocks = <&apll_pcie_in_clk_mux>;
+	reg = <0x4a00821c 0x4>, <0x4a008220 0x4>;
 	ti,clk-bypass = <&dpll_pcie_ref_ck>;
+	ti,clk-ref = <&apll_pcie_in_clk_mux>;
+	compatible = "ti,dra7-apll-clock";
 };
 
 apll_pcie_clkvcoldo: apll_pcie_clkvcoldo {
-- 
1.7.9.5
