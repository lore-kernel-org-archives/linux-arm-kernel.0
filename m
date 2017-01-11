From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Jan 2017 14:55:20 +0100
Subject: [PATCH 2/2] crypto: mediatek - fix format string for 64-bit builds
In-Reply-To: <20170111135104.3961730-1-arnd@arndb.de>
References: <20170111135104.3961730-1-arnd@arndb.de>
Message-ID: <20170111135601.4047225-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After I enabled COMPILE_TEST for non-ARM targets, I ran into these
warnings:

crypto/mediatek/mtk-aes.c: In function 'mtk_aes_info_map':
crypto/mediatek/mtk-aes.c:224:28: error: format '%d' expects argument of type 'int', but argument 3 has type 'long unsigned int' [-Werror=format=]
   dev_err(cryp->dev, "dma %d bytes error\n", sizeof(*info));
crypto/mediatek/mtk-sha.c:344:28: error: format '%d' expects argument of type 'int', but argument 3 has type 'long unsigned int' [-Werror=format=]
crypto/mediatek/mtk-sha.c:550:21: error: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'size_t {aka long unsigned int}' [-Werror=format=]

The correct format for size_t is %zu, so use that in all three
cases.

Fixes: 785e5c616c84 ("crypto: mediatek - Add crypto driver support for some MediaTek chips")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/mediatek/mtk-aes.c | 2 +-
 drivers/crypto/mediatek/mtk-sha.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/mediatek/mtk-aes.c b/drivers/crypto/mediatek/mtk-aes.c
index 3271471060d9..1370cabeeb5b 100644
--- a/drivers/crypto/mediatek/mtk-aes.c
+++ b/drivers/crypto/mediatek/mtk-aes.c
@@ -221,7 +221,7 @@ static int mtk_aes_info_map(struct mtk_cryp *cryp,
 	aes->ct_dma = dma_map_single(cryp->dev, info, sizeof(*info),
 					DMA_TO_DEVICE);
 	if (unlikely(dma_mapping_error(cryp->dev, aes->ct_dma))) {
-		dev_err(cryp->dev, "dma %d bytes error\n", sizeof(*info));
+		dev_err(cryp->dev, "dma %zu bytes error\n", sizeof(*info));
 		return -EINVAL;
 	}
 	aes->tfm_dma = aes->ct_dma + sizeof(*ct);
diff --git a/drivers/crypto/mediatek/mtk-sha.c b/drivers/crypto/mediatek/mtk-sha.c
index 89513632c8ed..98b3d74ae23d 100644
--- a/drivers/crypto/mediatek/mtk-sha.c
+++ b/drivers/crypto/mediatek/mtk-sha.c
@@ -341,7 +341,7 @@ static int mtk_sha_info_map(struct mtk_cryp *cryp,
 	sha->ct_dma = dma_map_single(cryp->dev, info, sizeof(*info),
 				      DMA_BIDIRECTIONAL);
 	if (unlikely(dma_mapping_error(cryp->dev, sha->ct_dma))) {
-		dev_err(cryp->dev, "dma %d bytes error\n", sizeof(*info));
+		dev_err(cryp->dev, "dma %zu bytes error\n", sizeof(*info));
 		return -EINVAL;
 	}
 	sha->tfm_dma = sha->ct_dma + sizeof(*ct);
@@ -547,7 +547,7 @@ static int mtk_sha_update_slow(struct mtk_cryp *cryp,
 
 	final = (ctx->flags & SHA_FLAGS_FINUP) && !ctx->total;
 
-	dev_dbg(cryp->dev, "slow: bufcnt: %u\n", ctx->bufcnt);
+	dev_dbg(cryp->dev, "slow: bufcnt: %zu\n", ctx->bufcnt);
 
 	if (final) {
 		sha->flags |= SHA_FLAGS_FINAL;
-- 
2.9.0
