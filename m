From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Aug 2015 11:12:03 +0900
Subject: [PATCH 04/12] clk: shmobile: rcar-gen2: Add CPG/MSTP Clock Domain
 support
In-Reply-To: <cover.1438911559.git.horms+renesas@verge.net.au>
References: <cover.1438911559.git.horms+renesas@verge.net.au>
Message-ID: <713290fcd73b31d0517c5c6ec505b612e93d1662.1438911559.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add Clock Domain support to the R-Car Gen2 Clock Pulse Generator (CPG)
driver using the generic PM Domain.  This allows to power-manage the
module clocks of SoC devices that are part of the CPG/MSTP Clock Domain
using Runtime PM, or for system suspend/resume.

SoC devices that are part of the CPG/MSTP Clock Domain and can be
power-managed through an MSTP clock should be tagged in DT with a proper
"power-domains" property.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../clock/renesas,rcar-gen2-cpg-clocks.txt         | 26 ++++++++++++++++++++--
 drivers/clk/shmobile/clk-rcar-gen2.c               |  2 ++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
index 56f111bd3e45..2a9a8edc8f35 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
@@ -2,6 +2,8 @@
 
 The CPG generates core clocks for the R-Car Gen2 SoCs. It includes three PLLs
 and several fixed ratio dividers.
+The CPG also provides a Clock Domain for SoC devices, in combination with the
+CPG Module Stop (MSTP) Clocks.
 
 Required Properties:
 
@@ -20,10 +22,18 @@ Required Properties:
   - clock-output-names: The names of the clocks. Supported clocks are "main",
     "pll0", "pll1", "pll3", "lb", "qspi", "sdh", "sd0", "sd1", "z", "rcan", and
     "adsp"
+  - #power-domain-cells: Must be 0
 
+SoC devices that are part of the CPG/MSTP Clock Domain and can be power-managed
+through an MSTP clock should refer to the CPG device node in their
+"power-domains" property, as documented by the generic PM domain bindings in
+Documentation/devicetree/bindings/power/power_domain.txt.
 
-Example
--------
+
+Examples
+--------
+
+  - CPG device node:
 
 	cpg_clocks: cpg_clocks at e6150000 {
 		compatible = "renesas,r8a7790-cpg-clocks",
@@ -34,4 +44,16 @@ Example
 		clock-output-names = "main", "pll0, "pll1", "pll3",
 				     "lb", "qspi", "sdh", "sd0", "sd1", "z",
 				     "rcan", "adsp";
+		#power-domain-cells = <0>;
+	};
+
+
+  - CPG/MSTP Clock Domain member device node:
+
+	thermal at e61f0000 {
+		compatible = "renesas,thermal-r8a7790", "renesas,rcar-thermal";
+		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
+		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp5_clks R8A7790_CLK_THERMAL>;
+		power-domains = <&cpg_clocks>;
 	};
diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
index acfb6d7dbd6b..f2c457f494eb 100644
--- a/drivers/clk/shmobile/clk-rcar-gen2.c
+++ b/drivers/clk/shmobile/clk-rcar-gen2.c
@@ -415,6 +415,8 @@ static void __init rcar_gen2_cpg_clocks_init(struct device_node *np)
 	}
 
 	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
+
+	cpg_mstp_add_clk_domain(np);
 }
 CLK_OF_DECLARE(rcar_gen2_cpg_clks, "renesas,rcar-gen2-cpg-clocks",
 	       rcar_gen2_cpg_clocks_init);
-- 
2.1.4
