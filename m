From: lionel.debieve@st.com (lionel.debieve at st.com)
Date: Mon, 6 Nov 2017 23:41:52 +0100
Subject: [PATCH v2 1/1] crypto: stm32/hash - Fix return issue on update
Message-ID: <1510008112-1573-1-git-send-email-lionel.debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lionel Debieve <lionel.debieve@st.com>

When data append reached the threshold for processing,
we must inform that processing is on going to wait before
managing the next request.

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
