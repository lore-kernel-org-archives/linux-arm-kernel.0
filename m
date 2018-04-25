From: maxime.chevallier@bootlin.com (Maxime Chevallier)
Date: Wed, 25 Apr 2018 20:21:17 +0200
Subject: [PATCH net v2 2/2] net: mvpp2: Fix clock resource by adding missing
 mg_core_clk
In-Reply-To: <20180425182117.28826-1-maxime.chevallier@bootlin.com>
References: <20180425182117.28826-1-maxime.chevallier@bootlin.com>
Message-ID: <20180425182117.28826-3-maxime.chevallier@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell's PPv2.2 IP needs an additional clock named "MG Core clock".
This is required on Armada 7K and 8K.

This commit adds the required clock in mvpp2, making sure it's only
used on PPv2.2.

Fixes: c7e92def1ef4 ("clk: mvebu: cp110: Fix clock tree representation")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2: Don't immediately fail if mg_core_clk isn't present in DT, following
    G.Clement's remarks.

 drivers/net/ethernet/marvell/mvpp2.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 0c2f04813d42..6f410235987c 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -942,6 +942,7 @@ struct mvpp2 {
 	struct clk *pp_clk;
 	struct clk *gop_clk;
 	struct clk *mg_clk;
+	struct clk *mg_core_clk;
 	struct clk *axi_clk;
 
 	/* List of pointers to port structures */
@@ -8768,18 +8769,27 @@ static int mvpp2_probe(struct platform_device *pdev)
 			err = clk_prepare_enable(priv->mg_clk);
 			if (err < 0)
 				goto err_gop_clk;
+
+			priv->mg_core_clk = devm_clk_get(&pdev->dev, "mg_core_clk");
+			if (IS_ERR(priv->mg_core_clk)) {
+				priv->mg_core_clk = NULL;
+			} else {
+				err = clk_prepare_enable(priv->mg_core_clk);
+				if (err < 0)
+					goto err_mg_clk;
+			}
 		}
 
 		priv->axi_clk = devm_clk_get(&pdev->dev, "axi_clk");
 		if (IS_ERR(priv->axi_clk)) {
 			err = PTR_ERR(priv->axi_clk);
 			if (err == -EPROBE_DEFER)
-				goto err_mg_clk;
+				goto err_mg_core_clk;
 			priv->axi_clk = NULL;
 		} else {
 			err = clk_prepare_enable(priv->axi_clk);
 			if (err < 0)
-				goto err_mg_clk;
+				goto err_mg_core_clk;
 		}
 
 		/* Get system's tclk rate */
@@ -8851,6 +8861,10 @@ static int mvpp2_probe(struct platform_device *pdev)
 	}
 err_axi_clk:
 	clk_disable_unprepare(priv->axi_clk);
+
+err_mg_core_clk:
+	if (priv->hw_version == MVPP22)
+		clk_disable_unprepare(priv->mg_core_clk);
 err_mg_clk:
 	if (priv->hw_version == MVPP22)
 		clk_disable_unprepare(priv->mg_clk);
@@ -8898,6 +8912,7 @@ static int mvpp2_remove(struct platform_device *pdev)
 		return 0;
 
 	clk_disable_unprepare(priv->axi_clk);
+	clk_disable_unprepare(priv->mg_core_clk);
 	clk_disable_unprepare(priv->mg_clk);
 	clk_disable_unprepare(priv->pp_clk);
 	clk_disable_unprepare(priv->gop_clk);
-- 
2.11.0
