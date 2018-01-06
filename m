From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Sat,  6 Jan 2018 09:00:09 +0100
Subject: [PATCH] mdio-sun4i: Fix a memory leak
Message-ID: <20180106080009.5325-1-christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the probing of the regulator is deferred, the memory allocated by
'mdiobus_alloc_size()' will be leaking.
It should be freed before the next call to 'sun4i_mdio_probe()' which will
reallocate it.

Fixes: 4bdcb1dd9feb ("net: Add MDIO bus driver for the Allwinner EMAC")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/phy/mdio-sun4i.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio-sun4i.c b/drivers/net/phy/mdio-sun4i.c
index 135296508a7e..6425ce04d3f9 100644
--- a/drivers/net/phy/mdio-sun4i.c
+++ b/drivers/net/phy/mdio-sun4i.c
@@ -118,8 +118,10 @@ static int sun4i_mdio_probe(struct platform_device *pdev)
 
 	data->regulator = devm_regulator_get(&pdev->dev, "phy");
 	if (IS_ERR(data->regulator)) {
-		if (PTR_ERR(data->regulator) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(data->regulator) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto err_out_free_mdiobus;
+		}
 
 		dev_info(&pdev->dev, "no regulator found\n");
 		data->regulator = NULL;
-- 
2.14.1
