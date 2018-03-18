From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Sun, 18 Mar 2018 23:59:36 +0100
Subject: [PATCH v2] net: ethernet: arc: Fix a potential memory leak if an
 optional regulator is deferred
Message-ID: <7fd57a4e79da41dccf55430cbc43de340a7f1826.1521061530.git.christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the optional regulator is deferred, we must release some resources.
They will be re-allocated when the probe function will be called again.

Fixes: 6eacf31139bf ("ethernet: arc: Add support for Rockchip SoC layer device tree bindings")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: v1 did not compile because of an erroneous variable name. s/ret/err/
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
+			err = -EPROBE_DEFER;
+			goto out_clk_disable;
+		}
 		dev_err(dev, "no regulator found\n");
 		priv->regulator = NULL;
 	}
-- 
2.14.1
