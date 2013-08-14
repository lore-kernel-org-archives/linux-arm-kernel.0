From: joelf@ti.com (Joel Fernandes)
Date: Wed, 14 Aug 2013 18:12:42 -0500
Subject: [PATCH 03/10] crypto: omap-aes: Populate number of SG elements
In-Reply-To: <1376521969-16807-1-git-send-email-joelf@ti.com>
References: <1376521969-16807-1-git-send-email-joelf@ti.com>
Message-ID: <1376521969-16807-4-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Crypto layer only passes nbytes but number of SG elements is needed
for mapping/unmapping SGs at one time using dma_map* API and also
needed to pass in for dmaengine prep function.

We call function added to scatterwalk for this purpose in omap_aes_handle_queue
to populate the values which are used later.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 drivers/crypto/omap-aes.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index 3838e0a..b7189a8 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -171,6 +171,8 @@ struct omap_aes_dev {
 	void			*buf_out;
 	int			dma_out;
 	struct dma_chan		*dma_lch_out;
+	int			in_sg_len;
+	int			out_sg_len;
 	dma_addr_t		dma_addr_out;
 
 	const struct omap_aes_pdata	*pdata;
@@ -741,6 +743,10 @@ static int omap_aes_handle_queue(struct omap_aes_dev *dd,
 	dd->out_offset = 0;
 	dd->out_sg = req->dst;
 
+	dd->in_sg_len = scatterwalk_bytes_sglen(dd->in_sg, dd->total);
+	dd->out_sg_len = scatterwalk_bytes_sglen(dd->out_sg, dd->total);
+	BUG_ON(dd->in_sg_len < 0 || dd->out_sg_len < 0);
+
 	rctx = ablkcipher_request_ctx(req);
 	ctx = crypto_ablkcipher_ctx(crypto_ablkcipher_reqtfm(req));
 	rctx->mode &= FLAGS_MODE_MASK;
-- 
1.7.9.5
