From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri,  1 Jun 2018 11:28:19 +0200
Subject: [PATCH 1/4] clk: renesas: cpg-mssr: Stop using printk format %pCr
In-Reply-To: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
References: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1527845302-12159-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Printk format "%pCr" will be removed soon, as clk_get_rate() must not be
called in atomic context.

Replace it by open-coding the operation.  This is safe here, as the code
runs in task context.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 49e510691eeeab07..f4b013e9352d9efc 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -258,8 +258,9 @@ struct clk *cpg_mssr_clk_src_twocell_get(struct of_phandle_args *clkspec,
 		dev_err(dev, "Cannot get %s clock %u: %ld", type, clkidx,
 		       PTR_ERR(clk));
 	else
-		dev_dbg(dev, "clock (%u, %u) is %pC at %pCr Hz\n",
-			clkspec->args[0], clkspec->args[1], clk, clk);
+		dev_dbg(dev, "clock (%u, %u) is %pC at %lu Hz\n",
+			clkspec->args[0], clkspec->args[1], clk,
+			clk_get_rate(clk));
 	return clk;
 }
 
@@ -326,7 +327,7 @@ static void __init cpg_mssr_register_core_clk(const struct cpg_core_clk *core,
 	if (IS_ERR_OR_NULL(clk))
 		goto fail;
 
-	dev_dbg(dev, "Core clock %pC at %pCr Hz\n", clk, clk);
+	dev_dbg(dev, "Core clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
 	priv->clks[id] = clk;
 	return;
 
@@ -392,7 +393,7 @@ static void __init cpg_mssr_register_mod_clk(const struct mssr_mod_clk *mod,
 	if (IS_ERR(clk))
 		goto fail;
 
-	dev_dbg(dev, "Module clock %pC at %pCr Hz\n", clk, clk);
+	dev_dbg(dev, "Module clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
 	priv->clks[id] = clk;
 	priv->smstpcr_saved[clock->index / 32].mask |= BIT(clock->index % 32);
 	return;
-- 
2.7.4
