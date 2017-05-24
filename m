From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 24 May 2017 21:06:49 +0200
Subject: [PATCH 08/11] crypto: sun4i-ss: use GENMASK to generate masks
In-Reply-To: <20170524190652.13278-1-antoine.tenart@free-electrons.com>
References: <20170524190652.13278-1-antoine.tenart@free-electrons.com>
Message-ID: <20170524190652.13278-9-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the GENMASK helper instead of custom calculations to generate masks,
It also helps the readability.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/crypto/sunxi-ss/sun4i-ss-hash.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-hash.c b/drivers/crypto/sunxi-ss/sun4i-ss-hash.c
index 0c2efc88bc0a..685de5b6ab17 100644
--- a/drivers/crypto/sunxi-ss/sun4i-ss-hash.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-hash.c
@@ -384,11 +384,14 @@ static int sun4i_hash(struct ahash_request *areq)
 			writesl(ss->base + SS_RXFIFO, op->buf, nwait);
 			op->byte_count += 4 * nwait;
 		}
+
 		nbw = op->len - 4 * nwait;
-		wb = *(u32 *)(op->buf + nwait * 4);
-		wb &= (0xFFFFFFFF >> (4 - nbw) * 8);
+		if (nbw) {
+			wb = *(u32 *)(op->buf + nwait * 4);
+			wb &= GENMASK((nbw * 8) - 1, 0);
 
-		op->byte_count += nbw;
+			op->byte_count += nbw;
+		}
 	}
 
 	/* write the remaining bytes of the nbw buffer */
-- 
2.9.4
