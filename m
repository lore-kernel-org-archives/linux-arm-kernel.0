From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 05 Jul 2011 14:13:32 +0100
Subject: [PATCH 9/9] DMA: PL08x: cleanup selection of burst size
In-Reply-To: <20110705131030.GE8286@n2100.arm.linux.org.uk>
References: <20110705131030.GE8286@n2100.arm.linux.org.uk>
Message-ID: <E1Qe5RU-0005Ni-3q@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   58 ++++++++++++++++++++++-----------------------
 1 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 4e139d7..e734fe6 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1048,50 +1048,42 @@ pl08x_dma_tx_status(struct dma_chan *chan,
 
 /* PrimeCell DMA extension */
 struct burst_table {
-	int burstwords;
+	u32 burstwords;
 	u32 reg;
 };
 
 static const struct burst_table burst_sizes[] = {
 	{
 		.burstwords = 256,
-		.reg = (PL080_BSIZE_256 << PL080_CONTROL_SB_SIZE_SHIFT) |
-			(PL080_BSIZE_256 << PL080_CONTROL_DB_SIZE_SHIFT),
+		.reg = PL080_BSIZE_256,
 	},
 	{
 		.burstwords = 128,
-		.reg = (PL080_BSIZE_128 << PL080_CONTROL_SB_SIZE_SHIFT) |
-			(PL080_BSIZE_128 << PL080_CONTROL_DB_SIZE_SHIFT),
+		.reg = PL080_BSIZE_128,
 	},
 	{
 		.burstwords = 64,
-		.reg = (PL080_BSIZE_64 << PL080_CONTROL_SB_SIZE_SHIFT) |
-			(PL080_BSIZE_64 << PL080_CONTROL_DB_SIZE_SHIFT),
+		.reg = PL080_BSIZE_64,
 	},
 	{
 		.burstwords = 32,
-		.reg = (PL080_BSIZE_32 << PL080_CONTROL_SB_SIZE_SHIFT) |
-			(PL080_BSIZE_32 << PL080_CONTROL_DB_SIZE_SHIFT),
+		.reg = PL080_BSIZE_32,
 	},
 	{
 		.burstwords = 16,
-		.reg = (PL080_BSIZE_16 << PL080_CONTROL_SB_SIZE_SHIFT) |
-			(PL080_BSIZE_16 << PL080_CONTROL_DB_SIZE_SHIFT),
+		.reg = PL080_BSIZE_16,
 	},
 	{
 		.burstwords = 8,
-		.reg = (PL080_BSIZE_8 << PL080_CONTROL_SB_SIZE_SHIFT) |
-			(PL080_BSIZE_8 << PL080_CONTROL_DB_SIZE_SHIFT),
+		.reg = PL080_BSIZE_8,
 	},
 	{
 		.burstwords = 4,
-		.reg = (PL080_BSIZE_4 << PL080_CONTROL_SB_SIZE_SHIFT) |
-			(PL080_BSIZE_4 << PL080_CONTROL_DB_SIZE_SHIFT),
+		.reg = PL080_BSIZE_4,
 	},
 	{
-		.burstwords = 1,
-		.reg = (PL080_BSIZE_1 << PL080_CONTROL_SB_SIZE_SHIFT) |
-			(PL080_BSIZE_1 << PL080_CONTROL_DB_SIZE_SHIFT),
+		.burstwords = 0,
+		.reg = PL080_BSIZE_1,
 	},
 };
 
@@ -1135,15 +1127,25 @@ static u32 pl08x_width(enum dma_slave_buswidth width)
 	return ~0;
 }
 
+static u32 pl08x_burst(u32 maxburst)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(burst_sizes); i++)
+		if (burst_sizes[i].burstwords <= maxburst)
+			break;
+
+	return burst_sizes[i].reg;
+}
+
 static int dma_set_runtime_config(struct dma_chan *chan,
 				  struct dma_slave_config *config)
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
 	struct pl08x_driver_data *pl08x = plchan->host;
 	enum dma_slave_buswidth addr_width;
-	u32 width, maxburst;
+	u32 width, burst, maxburst;
 	u32 cctl = 0;
-	int i;
 
 	if (!plchan->slave)
 		return -EINVAL;
@@ -1173,20 +1175,16 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 	cctl |= width << PL080_CONTROL_DWIDTH_SHIFT;
 
 	/*
-	 * Now decide on a maxburst:
 	 * If this channel will only request single transfers, set this
 	 * down to ONE element.  Also select one element if no maxburst
 	 * is specified.
 	 */
-	if (plchan->cd->single || maxburst == 0) {
-		cctl |= (PL080_BSIZE_1 << PL080_CONTROL_SB_SIZE_SHIFT) |
-			(PL080_BSIZE_1 << PL080_CONTROL_DB_SIZE_SHIFT);
-	} else {
-		for (i = 0; i < ARRAY_SIZE(burst_sizes); i++)
-			if (burst_sizes[i].burstwords <= maxburst)
-				break;
-		cctl |= burst_sizes[i].reg;
-	}
+	if (plchan->cd->single)
+		maxburst = 1;
+
+	burst = pl08x_burst(maxburst);
+	cctl |= burst << PL080_CONTROL_SB_SIZE_SHIFT;
+	cctl |= burst << PL080_CONTROL_DB_SIZE_SHIFT;
 
 	if (plchan->runtime_direction == DMA_FROM_DEVICE) {
 		plchan->src_addr = config->src_addr;
-- 
1.7.4.4
