From: branislav@radocaj.org (Branislav Radocaj)
Date: Sat,  9 Dec 2017 12:51:33 +0100
Subject: [PATCH v2] net: ethernet: arc: fix error handling in
 emac_rockchip_probe
Message-ID: <20171209115133.19205-1-branislav@radocaj.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If clk_set_rate() fails, we should disable clk before return.
Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Branislav Radocaj <branislav@radocaj.org>
---

Changes since v2:
* Improved inconsistent failure handling of clock rate setting
* For completeness of usecase, added arc_emac_probe error handling
---
 drivers/net/ethernet/arc/emac_rockchip.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/arc/emac_rockchip.c b/drivers/net/ethernet/arc/emac_rockchip.c
index e278e3d96ee0..16f9bee992fe 100644
--- a/drivers/net/ethernet/arc/emac_rockchip.c
+++ b/drivers/net/ethernet/arc/emac_rockchip.c
@@ -199,9 +199,11 @@ static int emac_rockchip_probe(struct platform_device *pdev)
 
 	/* RMII interface needs always a rate of 50MHz */
 	err = clk_set_rate(priv->refclk, 50000000);
-	if (err)
+	if (err) {
 		dev_err(dev,
 			"failed to change reference clock rate (%d)\n", err);
+		goto out_regulator_disable;
+	}
 
 	if (priv->soc_data->need_div_macclk) {
 		priv->macclk = devm_clk_get(dev, "macclk");
@@ -220,19 +222,24 @@ static int emac_rockchip_probe(struct platform_device *pdev)
 
 		/* RMII TX/RX needs always a rate of 25MHz */
 		err = clk_set_rate(priv->macclk, 25000000);
-		if (err)
+		if (err) {
 			dev_err(dev,
 				"failed to change mac clock rate (%d)\n", err);
+			goto out_clk_disable_macclk;
+		}
 	}
 
 	err = arc_emac_probe(ndev, interface);
 	if (err) {
 		dev_err(dev, "failed to probe arc emac (%d)\n", err);
-		goto out_regulator_disable;
+		goto out_clk_disable_macclk;
 	}
 
 	return 0;
 
+out_clk_disable_macclk:
+	if (priv->soc_data->need_div_macclk)
+		clk_disable_unprepare(priv->macclk);
 out_regulator_disable:
 	if (priv->regulator)
 		regulator_disable(priv->regulator);
-- 
2.11.0
