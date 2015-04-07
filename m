From: leilei.zhao@atmel.com (Leilei Zhao)
Date: Tue, 7 Apr 2015 17:45:05 +0800
Subject: [PATCH 04/10] crypto: atmel-sha: fix sg list management
In-Reply-To: <1428399911-23325-1-git-send-email-leilei.zhao@atmel.com>
References: <1428399911-23325-1-git-send-email-leilei.zhao@atmel.com>
Message-ID: <1428399911-23325-5-git-send-email-leilei.zhao@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having a zero length sg doesn't mean it is the end of the sg list. This
case happens when calculating HMAC of IPSec packet.

Signed-off-by: Leilei Zhao <leilei.zhao@atmel.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/crypto/atmel-sha.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index b471bbe..9fb8af1 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -163,8 +163,20 @@ static size_t atmel_sha_append_sg(struct atmel_sha_reqctx *ctx)
 		count = min(ctx->sg->length - ctx->offset, ctx->total);
 		count = min(count, ctx->buflen - ctx->bufcnt);
 
-		if (count <= 0)
-			break;
+		if (count <= 0) {
+			/*
+			* Check if count <= 0 because the buffer is full or
+			* because the sg length is 0. In the latest case,
+			* check if there is another sg in the list, a 0 length
+			* sg doesn't necessarily mean the end of the sg list.
+			*/
+			if ((ctx->sg->length == 0) && !sg_is_last(ctx->sg)) {
+				ctx->sg = sg_next(ctx->sg);
+				continue;
+			} else {
+				break;
+			}
+		}
 
 		scatterwalk_map_and_copy(ctx->buffer + ctx->bufcnt, ctx->sg,
 			ctx->offset, count, 0);
-- 
1.7.9.5
