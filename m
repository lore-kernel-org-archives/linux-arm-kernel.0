From: colin.king@canonical.com (Colin King)
Date: Tue,  3 Jan 2017 13:21:22 +0000
Subject: [PATCH] crypto: mediatek: don't return garbage err on successful
 return
Message-ID: <20170103132122.26900-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

In the case where keylen <= bs mtk_sha_setkey returns an uninitialized
return value in err.  Fix this by returning 0 instead of err.

Issue detected by static analysis with cppcheck.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/mediatek/mtk-sha.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/mediatek/mtk-sha.c b/drivers/crypto/mediatek/mtk-sha.c
index 8951363..8e1b440 100644
--- a/drivers/crypto/mediatek/mtk-sha.c
+++ b/drivers/crypto/mediatek/mtk-sha.c
@@ -878,7 +878,7 @@ static int mtk_sha_setkey(struct crypto_ahash *tfm,
 		bctx->opad[i] ^= 0x5c;
 	}
 
-	return err;
+	return 0;
 }
 
 static int mtk_sha_export(struct ahash_request *req, void *out)
-- 
2.10.2
