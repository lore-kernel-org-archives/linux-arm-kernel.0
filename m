From: lionel.debieve@st.com (Lionel Debieve)
Date: Mon, 6 Nov 2017 09:05:47 +0100
Subject: [PATCH 1/1] crypto: stm32/hash - Fix return issue in update
Message-ID: <1509955547-23983-1-git-send-email-lionel.debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When update data reached the threshold for data processing,
we must inform that processing is on going.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 drivers/crypto/stm32/stm32-hash.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index c462be7..4ca4a26 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -895,7 +895,6 @@ static int stm32_hash_enqueue(struct ahash_request *req, unsigned int op)
 static int stm32_hash_update(struct ahash_request *req)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
-	int ret;
 
 	if (!req->nbytes || !(rctx->flags & HASH_FLAGS_CPU))
 		return 0;
@@ -909,12 +908,7 @@ static int stm32_hash_update(struct ahash_request *req)
 		return 0;
 	}
 
-	ret = stm32_hash_enqueue(req, HASH_OP_UPDATE);
-
-	if (rctx->flags & HASH_FLAGS_FINUP)
-		return ret;
-
-	return 0;
+	return stm32_hash_enqueue(req, HASH_OP_UPDATE);
 }
 
 static int stm32_hash_final(struct ahash_request *req)
-- 
2.7.4
