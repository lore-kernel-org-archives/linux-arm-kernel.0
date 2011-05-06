From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri,  6 May 2011 19:56:53 +0200
Subject: [PATCH v2 3/3] dmaengine: at_hdmac: use descriptor chaining help
	function
In-Reply-To: <f4341d4672a23a958398b75cb4305e0e680f2e32.1304532833.git.nicolas.ferre@atmel.com>
References: <f4341d4672a23a958398b75cb4305e0e680f2e32.1304532833.git.nicolas.ferre@atmel.com>
Message-ID: <f2d2fb135151456f81dd3ac1938771589a0e5503.1304704588.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A little function helps to chain descriptors:
it is already used in cyclic dma operations, now use it in memcpy and slave_sg
preparation functions.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/dma/at_hdmac.c |   33 +++------------------------------
 1 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 5968245..2c6bc3a 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -626,16 +626,7 @@ atc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 
 		desc->txd.cookie = 0;
 
-		if (!first) {
-			first = desc;
-		} else {
-			/* inform the HW lli about chaining */
-			prev->lli.dscr = desc->txd.phys;
-			/* insert the link descriptor to the LD ring */
-			list_add_tail(&desc->desc_node,
-					&first->tx_list);
-		}
-		prev = desc;
+		atc_desc_chain(&first, &prev, desc);
 	}
 
 	/* First descriptor of the chain embedds additional information */
@@ -726,16 +717,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 					| len >> mem_width;
 			desc->lli.ctrlb = ctrlb;
 
-			if (!first) {
-				first = desc;
-			} else {
-				/* inform the HW lli about chaining */
-				prev->lli.dscr = desc->txd.phys;
-				/* insert the link descriptor to the LD ring */
-				list_add_tail(&desc->desc_node,
-						&first->tx_list);
-			}
-			prev = desc;
+			atc_desc_chain(&first, &prev, desc);
 			total_len += len;
 		}
 		break;
@@ -769,16 +751,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 					| len >> reg_width;
 			desc->lli.ctrlb = ctrlb;
 
-			if (!first) {
-				first = desc;
-			} else {
-				/* inform the HW lli about chaining */
-				prev->lli.dscr = desc->txd.phys;
-				/* insert the link descriptor to the LD ring */
-				list_add_tail(&desc->desc_node,
-						&first->tx_list);
-			}
-			prev = desc;
+			atc_desc_chain(&first, &prev, desc);
 			total_len += len;
 		}
 		break;
-- 
1.7.3
