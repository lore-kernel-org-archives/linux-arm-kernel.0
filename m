From: ryder.lee@mediatek.com (Ryder Lee)
Date: Thu, 1 Jun 2017 10:30:21 +0800
Subject: [PATCH v1 1/2] crypto: mediatek - remove redundant clock setting
In-Reply-To: <1496284222-12560-1-git-send-email-ryder.lee@mediatek.com>
References: <1496284222-12560-1-git-send-email-ryder.lee@mediatek.com>
Message-ID: <1496284222-12560-2-git-send-email-ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes redundant clock setting for 'clk_ethif', which is
the parent of 'clk_cryp'. Hence, we just need to handle its child.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/crypto/mediatek/mtk-platform.c | 10 +---------
 drivers/crypto/mediatek/mtk-platform.h |  2 --
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/crypto/mediatek/mtk-platform.c b/drivers/crypto/mediatek/mtk-platform.c
index b6ecc28..9b4437c 100644
--- a/drivers/crypto/mediatek/mtk-platform.c
+++ b/drivers/crypto/mediatek/mtk-platform.c
@@ -504,19 +504,14 @@ static int mtk_crypto_probe(struct platform_device *pdev)
 		}
 	}
 
-	cryp->clk_ethif = devm_clk_get(&pdev->dev, "ethif");
 	cryp->clk_cryp = devm_clk_get(&pdev->dev, "cryp");
-	if (IS_ERR(cryp->clk_ethif) || IS_ERR(cryp->clk_cryp))
+	if (IS_ERR(cryp->clk_cryp))
 		return -EPROBE_DEFER;
 
 	cryp->dev = &pdev->dev;
 	pm_runtime_enable(cryp->dev);
 	pm_runtime_get_sync(cryp->dev);
 
-	err = clk_prepare_enable(cryp->clk_ethif);
-	if (err)
-		goto err_clk_ethif;
-
 	err = clk_prepare_enable(cryp->clk_cryp);
 	if (err)
 		goto err_clk_cryp;
@@ -559,8 +554,6 @@ static int mtk_crypto_probe(struct platform_device *pdev)
 err_resource:
 	clk_disable_unprepare(cryp->clk_cryp);
 err_clk_cryp:
-	clk_disable_unprepare(cryp->clk_ethif);
-err_clk_ethif:
 	pm_runtime_put_sync(cryp->dev);
 	pm_runtime_disable(cryp->dev);
 
@@ -576,7 +569,6 @@ static int mtk_crypto_remove(struct platform_device *pdev)
 	mtk_desc_dma_free(cryp);
 
 	clk_disable_unprepare(cryp->clk_cryp);
-	clk_disable_unprepare(cryp->clk_ethif);
 
 	pm_runtime_put_sync(cryp->dev);
 	pm_runtime_disable(cryp->dev);
diff --git a/drivers/crypto/mediatek/mtk-platform.h b/drivers/crypto/mediatek/mtk-platform.h
index 303c152..f0831f1 100644
--- a/drivers/crypto/mediatek/mtk-platform.h
+++ b/drivers/crypto/mediatek/mtk-platform.h
@@ -200,7 +200,6 @@ struct mtk_sha_rec {
  * struct mtk_cryp - Cryptographic device
  * @base:	pointer to mapped register I/O base
  * @dev:	pointer to device
- * @clk_ethif:	pointer to ethif clock
  * @clk_cryp:	pointer to crypto clock
  * @irq:	global system and rings IRQ
  * @ring:	pointer to descriptor rings
@@ -215,7 +214,6 @@ struct mtk_sha_rec {
 struct mtk_cryp {
 	void __iomem *base;
 	struct device *dev;
-	struct clk *clk_ethif;
 	struct clk *clk_cryp;
 	int irq[MTK_IRQ_NUM];
 
-- 
1.9.1
