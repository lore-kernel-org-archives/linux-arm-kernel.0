From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:30:44 +0000
Subject: [PATCH 02/48] ARM: PL08x: fix array overflow in
	dma_set_runtime_config()
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZsvM-0001Nw-EJ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If maxburst was passed in as zero, we would overflow the burst_sizes[]
array.  Fix this by checking for this condition, and defaulting to
single transfer 'bursts'.

Improve the readability of the loop using a for() loop rather than
a while() loop with the iterator initialized far from the loop.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 3da49ed..0809810 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1207,7 +1207,7 @@ static void dma_set_runtime_config(struct dma_chan *chan,
 	u32 cctl = 0;
 	/* Mask out all except src and dst channel */
 	u32 ccfg = cd->ccfg & 0x000003DEU;
-	int i = 0;
+	int i;
 
 	/* Transfer direction */
 	plchan->runtime_direction = config->direction;
@@ -1250,18 +1250,17 @@ static void dma_set_runtime_config(struct dma_chan *chan,
 
 	/*
 	 * Now decide on a maxburst:
-	 * If this channel will only request single transfers, set
-	 * this down to ONE element.
+	 * If this channel will only request single transfers, set this
+	 * down to ONE element.  Also select one element if no maxburst
+	 * is specified.
 	 */
-	if (plchan->cd->single) {
+	if (plchan->cd->single || maxburst == 0) {
 		cctl |= (PL080_BSIZE_1 << PL080_CONTROL_SB_SIZE_SHIFT) |
 			(PL080_BSIZE_1 << PL080_CONTROL_DB_SIZE_SHIFT);
 	} else {
-		while (i < ARRAY_SIZE(burst_sizes)) {
+		for (i = 0; i < ARRAY_SIZE(burst_sizes); i++)
 			if (burst_sizes[i].burstwords <= maxburst)
 				break;
-			i++;
-		}
 		cctl |= burst_sizes[i].reg;
 	}
 
-- 
1.6.2.5
