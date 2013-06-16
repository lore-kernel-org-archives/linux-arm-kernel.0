From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 16 Jun 2013 22:54:09 +0200
Subject: [RFC PATCH 02/11] dma: amba-pl08x: Refactor pl08x_getbytes_chan() to
 lower indentation
In-Reply-To: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1371416058-22047-3-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Further patch will introduce support for PL080S, which requires some
things to be done conditionally, thus increasing indentation level of
some functions even more.

This patch reduces indentation level of pl08x_getbytes_chan() function
by inverting several conditions and returning from function wherever
possible.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/dma/amba-pl08x.c | 51 ++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index d443a68..1e57ded 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -473,47 +473,52 @@ static inline u32 get_bytes_in_cctl(u32 cctl)
 /* The channel should be paused when calling this */
 static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 {
+	struct pl08x_lli *llis_va;
 	struct pl08x_phy_chan *ch;
+	dma_addr_t llis_bus;
 	struct pl08x_txd *txd;
 	size_t bytes = 0;
+	int index;
+	u32 clli;
 
 	ch = plchan->phychan;
 	txd = plchan->at;
 
+	if (!ch || !txd)
+		return bytes;
+
 	/*
 	 * Follow the LLIs to get the number of remaining
 	 * bytes in the currently active transaction.
 	 */
-	if (ch && txd) {
-		u32 clli = readl(ch->base + PL080_CH_LLI) & ~PL080_LLI_LM_AHB2;
+	clli = readl(ch->base + PL080_CH_LLI) & ~PL080_LLI_LM_AHB2;
+
+	/* First get the remaining bytes in the active transfer */
+	bytes = get_bytes_in_cctl(readl(ch->base + PL080_CH_CONTROL));
 
-		/* First get the remaining bytes in the active transfer */
-		bytes = get_bytes_in_cctl(readl(ch->base + PL080_CH_CONTROL));
+	if (!clli)
+		return bytes;
 
-		if (clli) {
-			struct pl08x_lli *llis_va = txd->llis_va;
-			dma_addr_t llis_bus = txd->llis_bus;
-			int index;
+	llis_va = txd->llis_va;
+	llis_bus = txd->llis_bus;
 
-			BUG_ON(clli < llis_bus || clli >= llis_bus +
+	BUG_ON(clli < llis_bus || clli >= llis_bus +
 				sizeof(struct pl08x_lli) * MAX_NUM_TSFR_LLIS);
 
-			/*
-			 * Locate the next LLI - as this is an array,
-			 * it's simple maths to find.
-			 */
-			index = (clli - llis_bus) / sizeof(struct pl08x_lli);
+	/*
+	 * Locate the next LLI - as this is an array,
+	 * it's simple maths to find.
+	 */
+	index = (clli - llis_bus) / sizeof(struct pl08x_lli);
 
-			for (; index < MAX_NUM_TSFR_LLIS; index++) {
-				bytes += get_bytes_in_cctl(llis_va[index].cctl);
+	for (; index < MAX_NUM_TSFR_LLIS; index++) {
+		bytes += get_bytes_in_cctl(llis_va[index].cctl);
 
-				/*
-				 * A LLI pointer of 0 terminates the LLI list
-				 */
-				if (!llis_va[index].lli)
-					break;
-			}
-		}
+		/*
+		 * A LLI pointer of 0 terminates the LLI list
+		 */
+		if (!llis_va[index].lli)
+			break;
 	}
 
 	return bytes;
-- 
1.8.2.1
