From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 24 May 2017 21:06:44 +0200
Subject: [PATCH 03/11] crypto: sun4i-ss: use lower/upper_32_bits helpers
In-Reply-To: <20170524190652.13278-1-antoine.tenart@free-electrons.com>
References: <20170524190652.13278-1-antoine.tenart@free-electrons.com>
Message-ID: <20170524190652.13278-4-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace custom bit shifts and masks with lower/upper_32_bits helpers.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/crypto/sunxi-ss/sun4i-ss-hash.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-hash.c b/drivers/crypto/sunxi-ss/sun4i-ss-hash.c
index 39f0abe5ee25..e53c3127b743 100644
--- a/drivers/crypto/sunxi-ss/sun4i-ss-hash.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-hash.c
@@ -188,7 +188,6 @@ static int sun4i_hash(struct ahash_request *areq)
 	struct sg_mapping_iter mi;
 	int in_r, err = 0, zeros;
 	size_t copied = 0;
-	__be64 bits;
 
 	dev_dbg(ss->dev, "%s %s bc=%llu len=%u mode=%x wl=%u h0=%0x",
 		__func__, crypto_tfm_alg_name(areq->base.tfm),
@@ -423,12 +422,13 @@ static int sun4i_hash(struct ahash_request *areq)
 
 	/* write the length of data */
 	if (op->mode == SS_OP_SHA1) {
-		bits = cpu_to_be64(op->byte_count << 3);
-		bf[j++] = bits & 0xffffffff;
-		bf[j++] = (bits >> 32) & 0xffffffff;
+		__be64 bits = cpu_to_be64(op->byte_count << 3);
+		bf[j++] = lower_32_bits(bits);
+		bf[j++] = upper_32_bits(bits);
 	} else {
-		bf[j++] = (op->byte_count << 3) & 0xffffffff;
-		bf[j++] = (op->byte_count >> 29) & 0xffffffff;
+		__le64 bits = op->byte_count << 3;
+		bf[j++] = lower_32_bits(bits);
+		bf[j++] = upper_32_bits(bits);
 	}
 	writesl(ss->base + SS_RXFIFO, bf, j);
 
-- 
2.9.4
