From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Thu, 18 Aug 2016 22:42:10 +0000
Subject: [PATCH -next] crypto: fix missing unlock on error in sun4i_hash()
Message-ID: <1471560130-5265-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing unlock before return from function sun4i_hash()
in the error handling case.

Fixes: 477d9b2e591b ("crypto: sun4i-ss - unify update/final function")
Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/crypto/sunxi-ss/sun4i-ss-hash.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-hash.c b/drivers/crypto/sunxi-ss/sun4i-ss-hash.c
index 2ee3b59..de66f47 100644
--- a/drivers/crypto/sunxi-ss/sun4i-ss-hash.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-hash.c
@@ -245,6 +245,7 @@ int sun4i_hash(struct ahash_request *areq)
 		if (end > areq->nbytes || areq->nbytes - end > 63) {
 			dev_err(ss->dev, "ERROR: Bound error %u %u\n",
 				end, areq->nbytes);
+			spin_unlock(&ss->slock);
 			return -EINVAL;
 		}
 	} else {
