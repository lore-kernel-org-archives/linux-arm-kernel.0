From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 12 Jul 2017 12:39:32 +0200
Subject: [PATCH v2] ARM: shmobile: rcar-gen2: Add support for CPG/MSSR bindings
Message-ID: <1499855972-22126-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
---
v2:
  - Drop RZ/G1E,
  - Add support for R-Car H2, M2-W, and M2-N.
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index a54125cb509ca775..18b556835e474feb 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -30,17 +30,29 @@
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
2.7.4
