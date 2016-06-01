From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 1 Jun 2016 11:56:08 +0300
Subject: [PATCH 07/28] crypto: ahash: increase the maximum allowed statesize
In-Reply-To: <1464771389-10640-1-git-send-email-t-kristo@ti.com>
References: <1464771389-10640-1-git-send-email-t-kristo@ti.com>
Message-ID: <1464771389-10640-8-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The statesize is used to determine the maximum size for saved ahash
context. In some cases, this can be much larger than what is currently
allocated for it, for example omap-sham driver uses a buffer size of
PAGE_SIZE. Increase the statesize to accommodate this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 crypto/ahash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/ahash.c b/crypto/ahash.c
index 3887a98..375bbd7 100644
--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -536,7 +536,7 @@ static int ahash_prepare_alg(struct ahash_alg *alg)
 	struct crypto_alg *base = &alg->halg.base;
 
 	if (alg->halg.digestsize > PAGE_SIZE / 8 ||
-	    alg->halg.statesize > PAGE_SIZE / 8 ||
+	    alg->halg.statesize > PAGE_SIZE * 2 ||
 	    alg->halg.statesize == 0)
 		return -EINVAL;
 
-- 
1.9.1
