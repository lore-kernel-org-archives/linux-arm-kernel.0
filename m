From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Dec 2010 10:07:44 +0000
Subject: [PATCH 05/11] ARM: PL08x: rename lli.next to lli.lli
In-Reply-To: <20101224100550.GB20587@n2100.arm.linux.org.uk>
References: <20101224100550.GB20587@n2100.arm.linux.org.uk>
Message-ID: <E1PW4Yq-0006DW-Bw@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LLI pointer in the documentation is placed into the LLI register,
so name it LLI rather than 'next'.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index c6a8283..f365878 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -103,7 +103,7 @@ struct vendor_data {
 struct lli {
 	u32 src;
 	u32 dst;
-	u32 next;
+	u32 lli;
 	u32 cctl;
 };
 
@@ -367,7 +367,7 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 				/*
 				 * A LLI pointer of 0 terminates the LLI list
 				 */
-				clli = llis_va[i].next;
+				clli = llis_va[i].lli;
 				i++;
 			}
 		}
@@ -569,7 +569,7 @@ int pl08x_fill_lli_for_desc(struct pl08x_driver_data *pl08x,
 	 * memory. So we don't manipulate this bit currently.
 	 */
 
-	llis_va[num_llis].next =
+	llis_va[num_llis].lli =
 		(dma_addr_t)((u32) &(llis_bus[num_llis + 1]));
 
 	if (cctl & PL080_CONTROL_SRC_INCR)
@@ -936,14 +936,14 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 		 * Loop the circular buffer so that the next element
 		 * points back to the beginning of the LLI.
 		 */
-		llis_va[num_llis - 1].next =
+		llis_va[num_llis - 1].lli =
 			(dma_addr_t)((unsigned int)&(llis_bus[0]));
 	} else {
 		/*
 		 * On non-circular buffers, the final LLI terminates
 		 * the LLI.
 		 */
-		llis_va[num_llis - 1].next = 0;
+		llis_va[num_llis - 1].lli = 0;
 		/*
 		 * The final LLI element shall also fire an interrupt
 		 */
@@ -954,7 +954,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	txd->csrc = llis_va[0].src;
 	txd->cdst = llis_va[0].dst;
 	if (num_llis > 1)
-		txd->clli = llis_va[0].next;
+		txd->clli = llis_va[0].lli;
 	else
 		txd->clli = 0;
 
@@ -973,7 +973,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 				 llis_va[i].src,
 				 llis_va[i].dst,
 				 llis_va[i].cctl,
-				 llis_va[i].next
+				 llis_va[i].lli
 				);
 		}
 	}
-- 
1.6.2.5
