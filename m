From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 11 Sep 2012 17:21:45 +0200
Subject: [PATCH 2/2] dmaengine: at_hdmac: check that each sg data length is
 non-null
In-Reply-To: <77b1e7252fbc9a31e1ed8806e017f8bd8a4605e0.1347375975.git.nicolas.ferre@atmel.com>
References: <77b1e7252fbc9a31e1ed8806e017f8bd8a4605e0.1347375975.git.nicolas.ferre@atmel.com>
Message-ID: <4dd23d54172aedff69d4bb9be950cea18be9b848.1347375975.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid the construction of a malformed DMA request sent to
the DMA controller.
Log message is for debug only because this condition is unlikely to
append and may only trigger at driver development time.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Stable <stable@vger.kernel.org> [2.6.31+]
---
 drivers/dma/at_hdmac.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 6c09e18..7ab6e26 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -689,6 +689,11 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 
 			mem = sg_dma_address(sg);
 			len = sg_dma_len(sg);
+			if (unlikely(!len)) {
+				dev_dbg(chan2dev(chan),
+					"prep_slave_sg: sg(%d) data length is zero\n", i);
+				goto err;
+			}
 			mem_width = 2;
 			if (unlikely(mem & 3 || len & 3))
 				mem_width = 0;
@@ -724,6 +729,11 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 
 			mem = sg_dma_address(sg);
 			len = sg_dma_len(sg);
+			if (unlikely(!len)) {
+				dev_dbg(chan2dev(chan),
+					"prep_slave_sg: sg(%d) data length is zero\n", i);
+				goto err;
+			}
 			mem_width = 2;
 			if (unlikely(mem & 3 || len & 3))
 				mem_width = 0;
@@ -757,6 +767,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 
 err_desc_get:
 	dev_err(chan2dev(chan), "not enough descriptors available\n");
+err:
 	atc_desc_put(atchan, first);
 	return NULL;
 }
-- 
1.7.10
