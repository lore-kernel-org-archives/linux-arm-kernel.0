From: romain.perier@free-electrons.com (Romain Perier)
Date: Tue,  9 Aug 2016 11:03:18 +0200
Subject: [PATCH 5/7] crypto: marvell - Update transformation context for each
 dequeued req
In-Reply-To: <1470733400-23621-1-git-send-email-romain.perier@free-electrons.com>
References: <1470733400-23621-1-git-send-email-romain.perier@free-electrons.com>
Message-ID: <1470733400-23621-6-git-send-email-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far, sub part of mv_cesa_int was responsible of dequeuing complete
requests, then call the 'cleanup' operation on these reqs and call the
crypto api callback 'complete'. The problem is that the transformation
context 'ctx' is retrieved only once before the while loop. Which means
that the wrong 'cleanup' operation might be called on the wrong type of
cesa requests, it can lead to memory corruptions with this message:

marvell-cesa f1090000.crypto: dma_pool_free cesa_padding, 5a5a5a5a/5a5a5a5a (bad dma)

This commit fixes the issue, by updating the transformation context for
each dequeued cesa request.

Fixes: commit 85030c5168f1 ("crypto: marvell - Add support for chai...")
Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
---
 drivers/crypto/marvell/cesa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/marvell/cesa.c b/drivers/crypto/marvell/cesa.c
index d64af86..37dadb2 100644
--- a/drivers/crypto/marvell/cesa.c
+++ b/drivers/crypto/marvell/cesa.c
@@ -166,6 +166,7 @@ static irqreturn_t mv_cesa_int(int irq, void *priv)
 			if (!req)
 				break;
 
+			ctx = crypto_tfm_ctx(req->tfm);
 			mv_cesa_complete_req(ctx, req, 0);
 		}
 	}
-- 
2.8.1
