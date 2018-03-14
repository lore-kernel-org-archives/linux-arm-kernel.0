From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Wed, 14 Mar 2018 22:09:34 +0100
Subject: [PATCH] net: ethernet: arc: Fix a potential memory leak if an
 optional regulator is deferred
Message-ID: <7fd57a4e7f7a41dccf55430cbc43de3b0a7f7826.1521061530.git.christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the optional regulator is deferrred, we must release some resources.
They will be re-allocated when the probe function will be called again.

Fixes: 6eacf31139bf ("ethernet: arc: Add support for Rockchip SoC layer device tree bindings")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/arc/emac_rockchip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/arc/emac_rockchip.c b/drivers/net/ethernet/arc/emac_rockchip.c
index 16f9bee992fe..8ee9dfd0e363 100644
--- a/drivers/net/ethernet/arc/emac_rockchip.c
+++ b/drivers/net/ethernet/arc/emac_rockchip.c
@@ -169,8 +169,10 @@ static int emac_rockchip_probe(struct platform_device *pdev)
 	/* Optional regulator for PHY */
 	priv->regulator = devm_regulator_get_optional(dev, "phy");
 	if (IS_ERR(priv->regulator)) {
-		if (PTR_ERR(priv->regulator) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(priv->regulator) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto out_clk_disable;
+		}
 		dev_err(dev, "no regulator found\n");
 		priv->regulator = NULL;
 	}
-- 
2.14.1
