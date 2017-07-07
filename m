From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Fri, 7 Jul 2017 02:11:35 -0500
Subject: [PATCH] net: ethernet: mediatek: add NULL check on of_match_device()
 return value
Message-ID: <20170707071135.GA29205@embeddedgus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check return value from call to of_match_device()
in order to prevent a NULL pointer dereference.

In case of NULL print error message and return -ENODEV

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index adaaafc..6a77dea 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2408,6 +2408,11 @@ static int mtk_probe(struct platform_device *pdev)
 	int i;
 
 	match = of_match_device(of_mtk_match, &pdev->dev);
+	if (!match) {
+		dev_err(&pdev->dev, "failed to match device\n");
+		return -ENODEV;
+	}
+
 	soc = (struct mtk_soc_data *)match->data;
 
 	eth = devm_kzalloc(&pdev->dev, sizeof(*eth), GFP_KERNEL);
-- 
2.5.0
