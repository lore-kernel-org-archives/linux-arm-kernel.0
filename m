From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:05:38 +0200
Subject: [PATCH 3/5] ARM: shmobile: rcar-gen2: Add support for CPG/MSSR
 bindings
In-Reply-To: <cover.1501512320.git.horms+renesas@verge.net.au>
References: <cover.1501512320.git.horms+renesas@verge.net.au>
Message-ID: <cdcdfaad8a25f53a5bb01c04e1eff33e453dab30.1501512320.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

When using the new CPG/MSSR bindings, there is no longer a
"renesas,rcar-gen2-cpg-clocks" node, and the code to obtain the external
clock crystal frequency falls back to a default of 20 MHz.
While this is correct for all upstream R-Car Gen2 and RZ/G1 boards, this
is not necessarily the case for out-of-tree third party boards.

Add support for finding the external clock crystal oscillator on RZ/G1M,
and on R-Car H2, M2-W, and M2-N using the new CPG/MSSR bindings, through
the corresponding "renesas,r8a77xx-cpg-mssr" nodes.

Note that this is not needed on R-Car V2H and E2, and on RZ/G1E, as on
those SoCs the arch_timer and generic counter clock is derived from the
ZS clock instead.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index a6e74f481dea..3bd505da3172 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -29,17 +29,29 @@
 #include "common.h"
 #include "rcar-gen2.h"
 
+static const struct of_device_id cpg_matches[] __initconst = {
+	{ .compatible = "renesas,rcar-gen2-cpg-clocks", },
+	{ .compatible = "renesas,r8a7743-cpg-mssr", .data = "extal" },
+	{ .compatible = "renesas,r8a7790-cpg-mssr", .data = "extal" },
+	{ .compatible = "renesas,r8a7791-cpg-mssr", .data = "extal" },
+	{ .compatible = "renesas,r8a7793-cpg-mssr", .data = "extal" },
+	{ /* sentinel */ }
+};
+
 static unsigned int __init get_extal_freq(void)
 {
+	const struct of_device_id *match;
 	struct device_node *cpg, *extal;
 	u32 freq = 20000000;
+	int idx = 0;
 
-	cpg = of_find_compatible_node(NULL, NULL,
-				      "renesas,rcar-gen2-cpg-clocks");
+	cpg = of_find_matching_node_and_match(NULL, cpg_matches, &match);
 	if (!cpg)
 		return freq;
 
-	extal = of_parse_phandle(cpg, "clocks", 0);
+	if (match->data)
+		idx = of_property_match_string(cpg, "clock-names", match->data);
+	extal = of_parse_phandle(cpg, "clocks", idx);
 	of_node_put(cpg);
 	if (!extal)
 		return freq;
-- 
2.1.4
