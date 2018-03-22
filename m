From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Thu, 22 Mar 2018 02:09:39 +0000
Subject: [PATCH -next] staging: mt7621-eth: fix return value check in
 mtk_probe()
Message-ID: <1521684579-76660-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of error, the function devm_ioremap_resource() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Fixes: e3cbf478f846 ("staging: mt7621-eth: add the drivers core files")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/staging/mt7621-eth/mtk_eth_soc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-eth/mtk_eth_soc.c b/drivers/staging/mt7621-eth/mtk_eth_soc.c
index 98b4462..dea4270 100644
--- a/drivers/staging/mt7621-eth/mtk_eth_soc.c
+++ b/drivers/staging/mt7621-eth/mtk_eth_soc.c
@@ -2077,8 +2077,8 @@ static int mtk_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	eth->base = devm_ioremap_resource(&pdev->dev, res);
-	if (!eth->base)
-		return -EADDRNOTAVAIL;
+	if (IS_ERR(eth->base))
+		return PTR_ERR(eth->base);
 
 	spin_lock_init(&eth->page_lock);
