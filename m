From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  7 Jul 2015 16:10:07 +0200
Subject: [PATCH/RFC 01/11] clk: shmobile: rcar-gen2: Obtain MD pin values
 using syscon/regmap
In-Reply-To: <1436278217-20522-1-git-send-email-geert+renesas@glider.be>
References: <1436278217-20522-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1436278217-20522-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Obtain the values of the MD pins by reading the Mode Monitoring Register
(MODEMR) using syscon and regmap. The syscon device and register offset
to use are obtained from the "renesas,modemr" property in DT.

Fall back to calling rcar_gen2_read_mode_pins() in the R-Car Gen2
platform code for backward-compatibility with old DTs.

TODO Document "renesas,modemr" property in DT binding doc.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/shmobile/clk-rcar-gen2.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
index 745496f7ee9c7402..b121a49f7575a97b 100644
--- a/drivers/clk/shmobile/clk-rcar-gen2.c
+++ b/drivers/clk/shmobile/clk-rcar-gen2.c
@@ -15,8 +15,10 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/math64.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -368,9 +370,22 @@ static void __init rcar_gen2_cpg_clocks_init(struct device_node *np)
 {
 	const struct cpg_pll_config *config;
 	struct rcar_gen2_cpg *cpg;
+	struct regmap *regmap;
 	struct clk **clks;
 	unsigned int i;
 	int num_clks;
+	u32 reg;
+
+	regmap = syscon_regmap_lookup_by_phandle(np, "renesas,modemr");
+	if (IS_ERR(regmap) ||
+	    of_property_read_u32_index(np, "renesas,modemr", 1, &reg) ||
+	    regmap_read(regmap, reg, &cpg_mode)) {
+		/* Backward-compatibility with old DT */
+		extern u32 rcar_gen2_read_mode_pins(void);
+
+		pr_warn("%s: failed to parse renesas,modemr\n", np->full_name);
+		cpg_mode = rcar_gen2_read_mode_pins();
+	}
 
 	num_clks = of_property_count_strings(np, "clock-output-names");
 	if (num_clks < 0) {
-- 
1.9.1
