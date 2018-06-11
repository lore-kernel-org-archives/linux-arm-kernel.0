From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Mon, 11 Jun 2018 19:52:27 +0200
Subject: [PATCH] net: stmmac: dwmac-meson8b: Fix an error handling path in
 'meson8b_dwmac_probe()'
Message-ID: <20180611175227.27509-1-christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If 'of_device_get_match_data()' fails, we need to release some resources as
done in the other error handling path of this function.

Fixes: efacb568c962 ("net: stmmac: dwmac-meson: extend phy mode setting")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index 4ff231df7322..c5979569fd60 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -334,9 +334,10 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 
 	dwmac->data = (const struct meson8b_dwmac_data *)
 		of_device_get_match_data(&pdev->dev);
-	if (!dwmac->data)
-		return -EINVAL;
-
+	if (!dwmac->data) {
+		ret = -EINVAL;
+		goto err_remove_config_dt;
+	}
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	dwmac->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(dwmac->regs)) {
-- 
2.17.0
