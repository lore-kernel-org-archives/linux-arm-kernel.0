From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Dec 2010 10:08:04 +0000
Subject: [PATCH 06/11] ARM: PL08x: clean up LLI lookup
In-Reply-To: <20101224100550.GB20587@n2100.arm.linux.org.uk>
References: <20101224100550.GB20587@n2100.arm.linux.org.uk>
Message-ID: <E1PW4ZA-0006Da-PF@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the LLI list is an array, we can use maths to locate which LLI
index we're currently at, and then sum up the remaining LLI entries
until we reach the end of the list.

This makes the code much easier to read, and much less susceptible
to falling off the end of the array.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   37 ++++++++++++++++++++-----------------
 1 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index f365878..04c3350 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -332,53 +332,56 @@ static inline u32 get_bytes_in_cctl(u32 cctl)
 static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 {
 	struct pl08x_phy_chan *ch;
-	struct pl08x_txd *txdi = NULL;
 	struct pl08x_txd *txd;
 	unsigned long flags;
 	u32 bytes = 0;
 
 	spin_lock_irqsave(&plchan->lock, flags);
-
 	ch = plchan->phychan;
 	txd = plchan->at;
 
 	/*
-	 * Next follow the LLIs to get the number of pending bytes in the
-	 * currently active transaction.
+	 * Follow the LLIs to get the number of remaining
+	 * bytes in the currently active transaction.
 	 */
 	if (ch && txd) {
-		struct lli *llis_va = txd->llis_va;
-		struct lli *llis_bus = (struct lli *) txd->llis_bus;
 		u32 clli = readl(ch->base + PL080_CH_LLI) & ~PL080_LLI_LM_AHB2;
 
-		/* First get the bytes in the current active LLI */
+		/* First get the remaining bytes in the active transfer */
 		bytes = get_bytes_in_cctl(readl(ch->base + PL080_CH_CONTROL));
 
 		if (clli) {
-			int i = 0;
+			struct lli *llis_va = txd->llis_va;
+			dma_addr_t llis_bus = txd->llis_bus;
+			int index;
 
-			/* Forward to the LLI pointed to by clli */
-			while ((clli != (u32) &(llis_bus[i])) &&
-			       (i < MAX_NUM_TSFR_LLIS))
-				i++;
+			BUG_ON(clli < llis_bus || clli >= llis_bus +
+				sizeof(struct lli) * MAX_NUM_TSFR_LLIS);
+
+			/*
+			 * Locate the next LLI - as this is an array,
+			 * it's simple maths to find.
+			 */
+			index = (clli - llis_bus) / sizeof(struct lli);
+
+			for (; index < MAX_NUM_TSFR_LLIS; index++) {
+				bytes += get_bytes_in_cctl(llis_va[index].cctl);
 
-			while (clli) {
-				bytes += get_bytes_in_cctl(llis_va[i].cctl);
 				/*
 				 * A LLI pointer of 0 terminates the LLI list
 				 */
-				clli = llis_va[i].lli;
-				i++;
+				if (!llis_va[index].lli)
+					break;
 			}
 		}
 	}
 
 	/* Sum up all queued transactions */
 	if (!list_empty(&plchan->desc_list)) {
+		struct pl08x_txd *txdi;
 		list_for_each_entry(txdi, &plchan->desc_list, node) {
 			bytes += txdi->len;
 		}
-
 	}
 
 	spin_unlock_irqrestore(&plchan->lock, flags);
-- 
1.6.2.5
