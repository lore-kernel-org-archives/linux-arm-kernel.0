From: branislav@radocaj.org (Branislav Radocaj)
Date: Wed,  6 Dec 2017 18:24:33 +0100
Subject: [PATCH] net: ethernet: arc: fix error handling in emac_rockchip_probe
Message-ID: <20171206172433.3457-1-branislav@radocaj.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    If clk_set_rate() fails, we should disable clk
    before return.

    Found by Linux Driver Verification project (linuxtesting.org).

    Signed-off-by: Branislav Radocaj <branislav@radocaj.org>
---
 drivers/net/ethernet/arc/emac_rockchip.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/arc/emac_rockchip.c b/drivers/net/ethernet/arc/emac_rockchip.c
index e278e3d96ee0..c6163874e4e7 100644
--- a/drivers/net/ethernet/arc/emac_rockchip.c
+++ b/drivers/net/ethernet/arc/emac_rockchip.c
@@ -220,9 +220,11 @@ static int emac_rockchip_probe(struct platform_device *pdev)
 
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
@@ -232,7 +234,8 @@ static int emac_rockchip_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-
+out_clk_disable_macclk:
+	clk_disable_unprepare(priv->macclk);
 out_regulator_disable:
 	if (priv->regulator)
 		regulator_disable(priv->regulator);
-- 
2.11.0
