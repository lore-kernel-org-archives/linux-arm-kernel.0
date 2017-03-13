From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 13 Mar 2017 18:12:33 +0100
Subject: [PATCH v2 4/4] clk: renesas: rcar-gen3-cpg: Add support for RCLK on
 R-Car H3 ES2.0
In-Reply-To: <1489425153-22623-1-git-send-email-geert+renesas@glider.be>
References: <1489425153-22623-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1489425153-22623-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Starting with R-Car H3 ES2.0, the parent of RCLK is selected using MD28.

Add support for that, but retain the old behavior for R-Car H3 ES1.x and
M3-W ES1.0 using a quirk.

Inspired by a patch by Takeshi Kihara in the BSP.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Takeshi Kihara <takeshi.kihara.df@renesas.com>
---
v2:
  - New.
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 38 ++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index e5247e3dc897f9f4..3dee900522b703bd 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -252,11 +252,20 @@ static u32 cpg_mode __initdata;
 static u32 cpg_quirks __initdata;
 
 #define PLL_ERRATA	BIT(0)		/* Missing PLL0/2/4 post-divider */
+#define RCKCR_CKSEL	BIT(1)		/* Manual RCLK parent selection */
 
 static const struct soc_device_attribute cpg_quirks_match[] __initconst = {
 	{
 		.soc_id = "r8a7795", .revision = "ES1.0",
-		.data = (void *)PLL_ERRATA,
+		.data = (void *)(PLL_ERRATA | RCKCR_CKSEL),
+	},
+	{
+		.soc_id = "r8a7795", .revision = "ES1.*",
+		.data = (void *)RCKCR_CKSEL,
+	},
+	{
+		.soc_id = "r8a7796", .revision = "ES1.0",
+		.data = (void *)RCKCR_CKSEL,
 	},
 	{ /* sentinel */ }
 };
@@ -330,18 +339,25 @@ struct clk * __init rcar_gen3_cpg_clk_register(struct device *dev,
 		return cpg_sd_clk_register(core, base, __clk_get_name(parent));
 
 	case CLK_TYPE_GEN3_R:
-		/*
-		 * RINT is default.
-		 * Only if EXTALR is populated, we switch to it.
-		 */
-		value = readl(base + CPG_RCKCR) & 0x3f;
-
-		if (clk_get_rate(clks[cpg_clk_extalr])) {
-			parent = clks[cpg_clk_extalr];
-			value |= BIT(15);
+		if (cpg_quirks & RCKCR_CKSEL) {
+			/*
+			 * RINT is default.
+			 * Only if EXTALR is populated, we switch to it.
+			 */
+			value = readl(base + CPG_RCKCR) & 0x3f;
+
+			if (clk_get_rate(clks[cpg_clk_extalr])) {
+				parent = clks[cpg_clk_extalr];
+				value |= BIT(15);
+			}
+
+			writel(value, base + CPG_RCKCR);
+			break;
 		}
 
-		writel(value, base + CPG_RCKCR);
+		/* Select parent clock of RCLK by MD28 */
+		if (cpg_mode & BIT(28))
+			parent = clks[cpg_clk_extalr];
 		break;
 
 	default:
-- 
2.7.4
