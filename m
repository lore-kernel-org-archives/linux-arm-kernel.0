From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:38:12 +0000
Subject: [PATCH 24/48] ARM: PL08x: rename lli.next to lli.lli
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt2a-0001QD-Gl@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LLI pointer in the documentation is placed into the LLI register,
so name it LLI rather than 'next'.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index a389df5..a897315 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -111,7 +111,7 @@ struct vendor_data {
 struct pl08x_lli {
 	u32 src;
 	u32 dst;
-	u32 next;
+	u32 lli;
 	u32 cctl;
 };
 
@@ -375,7 +375,7 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 				/*
 				 * A LLI pointer of 0 terminates the LLI list
 				 */
-				clli = llis_va[i].next;
+				clli = llis_va[i].lli;
 				i++;
 			}
 		}
@@ -577,7 +577,7 @@ static int pl08x_fill_lli_for_desc(struct pl08x_driver_data *pl08x,
 	 * memory. So we don't manipulate this bit currently.
 	 */
 
-	llis_va[num_llis].next = llis_bus + (num_llis + 1) * sizeof(struct pl08x_lli);
+	llis_va[num_llis].lli = llis_bus + (num_llis + 1) * sizeof(struct pl08x_lli);
 
 	if (cctl & PL080_CONTROL_SRC_INCR)
 		txd->srcbus.addr += len;
@@ -925,7 +925,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	/*
 	 * The final LLI terminates the LLI.
 	 */
-	llis_va[num_llis - 1].next = 0;
+	llis_va[num_llis - 1].lli = 0;
 	/*
 	 * The final LLI element shall also fire an interrupt
 	 */
@@ -934,7 +934,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	/* Now store the channel register values */
 	txd->csrc = llis_va[0].src;
 	txd->cdst = llis_va[0].dst;
-	txd->clli = llis_va[0].next;
+	txd->clli = llis_va[0].lli;
 	txd->cctl = llis_va[0].cctl;
 	/* ccfg will be set at physical channel allocation time */
 
@@ -950,7 +950,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
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
