From: andre.przywara@arm.com (Andre Przywara)
Date: Fri,  8 Jan 2016 11:24:08 +0000
Subject: [RESEND PATCH 1/2] crypto: sunxi-ss-cipher: promote variables to
 match types in min3() calls
In-Reply-To: <1452252249-12040-1-git-send-email-andre.przywara@arm.com>
References: <1452252249-12040-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1452252249-12040-2-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(resending to add linux-crypto, patch unchanged)

The min3() macro expects all arguments to be of the same type (or
size at least).
Change the type of some local variables in sun4i-ss-cipher.c to
size_t to match the type used in some generic structures we
compare against.
That shouldn't change anything for 32-bit (as size_t is unsigned int
there anyway), but allows compilation for 64-bit architectures.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/crypto/sunxi-ss/sun4i-ss-cipher.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c b/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
index a19ee12..707f30f 100644
--- a/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
@@ -25,13 +25,13 @@ static int sun4i_ss_opti_poll(struct ablkcipher_request *areq)
 	struct sun4i_cipher_req_ctx *ctx = ablkcipher_request_ctx(areq);
 	u32 mode = ctx->mode;
 	/* when activating SS, the default FIFO space is SS_RX_DEFAULT(32) */
-	u32 rx_cnt = SS_RX_DEFAULT;
-	u32 tx_cnt = 0;
+	size_t rx_cnt = SS_RX_DEFAULT;
+	size_t tx_cnt = 0;
 	u32 spaces;
 	u32 v;
 	int i, err = 0;
-	unsigned int ileft = areq->nbytes;
-	unsigned int oleft = areq->nbytes;
+	size_t ileft = areq->nbytes;
+	size_t oleft = areq->nbytes;
 	unsigned int todo;
 	struct sg_mapping_iter mi, mo;
 	unsigned int oi, oo; /* offset for in and out */
@@ -134,13 +134,13 @@ static int sun4i_ss_cipher_poll(struct ablkcipher_request *areq)
 	struct sun4i_cipher_req_ctx *ctx = ablkcipher_request_ctx(areq);
 	u32 mode = ctx->mode;
 	/* when activating SS, the default FIFO space is SS_RX_DEFAULT(32) */
-	u32 rx_cnt = SS_RX_DEFAULT;
-	u32 tx_cnt = 0;
+	size_t rx_cnt = SS_RX_DEFAULT;
+	size_t tx_cnt = 0;
 	u32 v;
 	u32 spaces;
 	int i, err = 0;
-	unsigned int ileft = areq->nbytes;
-	unsigned int oleft = areq->nbytes;
+	size_t ileft = areq->nbytes;
+	size_t oleft = areq->nbytes;
 	unsigned int todo;
 	struct sg_mapping_iter mi, mo;
 	unsigned int oi, oo;	/* offset for in and out */
@@ -148,7 +148,7 @@ static int sun4i_ss_cipher_poll(struct ablkcipher_request *areq)
 	char bufo[4 * SS_TX_MAX]; /* buffer for linearize SG dst */
 	unsigned int ob = 0;	/* offset in buf */
 	unsigned int obo = 0;	/* offset in bufo*/
-	unsigned int obl = 0;	/* length of data in bufo */
+	size_t obl = 0;	/* length of data in bufo */
 
 	if (areq->nbytes == 0)
 		return 0;
@@ -251,7 +251,7 @@ static int sun4i_ss_cipher_poll(struct ablkcipher_request *areq)
 		spaces = readl(ss->base + SS_FCSR);
 		rx_cnt = SS_RXFIFO_SPACES(spaces);
 		tx_cnt = SS_TXFIFO_SPACES(spaces);
-		dev_dbg(ss->dev, "%x %u/%u %u/%u cnt=%u %u/%u %u/%u cnt=%u %u %u\n",
+		dev_dbg(ss->dev, "%x %u/%zu %zu/%u cnt=%zu %u/%zu %zu/%u cnt=%zu %u %u\n",
 			mode,
 			oi, mi.length, ileft, areq->nbytes, rx_cnt,
 			oo, mo.length, oleft, areq->nbytes, tx_cnt,
-- 
2.6.4
