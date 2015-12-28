From: geliangtang@163.com (Geliang Tang)
Date: Mon, 28 Dec 2015 21:53:07 +0800
Subject: [PATCH] crypto: hifn_795x, picoxcell - use ablkcipher_request_cast
Message-ID: <9b6f300df7ffd4c5d65253fdbbb2d1a1cba04835.1451310459.git.geliangtang@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use ablkcipher_request_cast() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/crypto/hifn_795x.c        | 4 ++--
 drivers/crypto/picoxcell_crypto.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/hifn_795x.c b/drivers/crypto/hifn_795x.c
index 201e57d..eee2c7e 100644
--- a/drivers/crypto/hifn_795x.c
+++ b/drivers/crypto/hifn_795x.c
@@ -1943,7 +1943,7 @@ static void hifn_flush(struct hifn_device *dev)
 
 	spin_lock_irqsave(&dev->lock, flags);
 	while ((async_req = crypto_dequeue_request(&dev->queue))) {
-		req = container_of(async_req, struct ablkcipher_request, base);
+		req = ablkcipher_request_cast(async_req);
 		spin_unlock_irqrestore(&dev->lock, flags);
 
 		hifn_process_ready(req, -ENODEV);
@@ -2062,7 +2062,7 @@ static int hifn_process_queue(struct hifn_device *dev)
 		if (backlog)
 			backlog->complete(backlog, -EINPROGRESS);
 
-		req = container_of(async_req, struct ablkcipher_request, base);
+		req = ablkcipher_request_cast(async_req);
 
 		err = hifn_handle_req(req);
 		if (err)
diff --git a/drivers/crypto/picoxcell_crypto.c b/drivers/crypto/picoxcell_crypto.c
index 15b5e39..3b1c7ec 100644
--- a/drivers/crypto/picoxcell_crypto.c
+++ b/drivers/crypto/picoxcell_crypto.c
@@ -856,8 +856,7 @@ static int spacc_ablk_need_fallback(struct spacc_req *req)
 
 static void spacc_ablk_complete(struct spacc_req *req)
 {
-	struct ablkcipher_request *ablk_req =
-		container_of(req->req, struct ablkcipher_request, base);
+	struct ablkcipher_request *ablk_req = ablkcipher_request_cast(req->req);
 
 	if (ablk_req->src != ablk_req->dst) {
 		spacc_free_ddt(req, req->src_ddt, req->src_addr, ablk_req->src,
-- 
2.5.0
