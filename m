From: shailendra.v@samsung.com (Shailendra Verma)
Date: Fri, 27 Jan 2017 16:49:40 +0530
Subject: [PATCH] Net: ethernet: mediatek - Fix possible NULL derefrence.
References: <CGME20170127111947epcas2p14f5ea86f0069142be02339754fda4a55@epcas2p1.samsung.com>
Message-ID: <1485515980-3814-1-git-send-email-shailendra.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_match_device could return NULL, and so can cause a NULL
pointer dereference later.

Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 4a62ffd..4495b7b 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2369,6 +2369,10 @@ static int mtk_probe(struct platform_device *pdev)
 	int i;
 
 	match = of_match_device(of_mtk_match, &pdev->dev);
+	if (!match) {
+		dev_err(&pdev->dev, "Error: No device match found\n");
+		return -ENODEV;
+	}
 	soc = (struct mtk_soc_data *)match->data;
 
 	eth = devm_kzalloc(&pdev->dev, sizeof(*eth), GFP_KERNEL);
-- 
1.7.9.5
