From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:39:59 +0100
Subject: [RFC 14/34] dmaengine: PL08x: extract function to to generate cctl
 values
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZIuF-0006zd-D0@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extract the functionality from dma_slave_config to generate the cctl
values for a given bus width and burst size.  This allows us to use
this elsewhere in the driver, namely the prepare functions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   53 +++++++++++++++++++++++++++------------------
 1 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 93ad50d..54aa290 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1203,14 +1203,40 @@ static u32 pl08x_burst(u32 maxburst)
 	return burst_sizes[i].reg;
 }
 
+static u32 pl08x_get_cctl(struct pl08x_dma_chan *plchan,
+	enum dma_slave_buswidth addr_width, u32 maxburst)
+{
+	u32 width, burst, cctl = 0;
+
+	width = pl08x_width(addr_width);
+	if (width == ~0)
+		return ~0;
+
+	cctl |= width << PL080_CONTROL_SWIDTH_SHIFT;
+	cctl |= width << PL080_CONTROL_DWIDTH_SHIFT;
+
+	/*
+	 * If this channel will only request single transfers, set this
+	 * down to ONE element.  Also select one element if no maxburst
+	 * is specified.
+	 */
+	if (plchan->cd->single)
+		maxburst = 1;
+
+	burst = pl08x_burst(maxburst);
+	cctl |= burst << PL080_CONTROL_SB_SIZE_SHIFT;
+	cctl |= burst << PL080_CONTROL_DB_SIZE_SHIFT;
+
+	return pl08x_cctl(cctl);
+}
+
 static int dma_set_runtime_config(struct dma_chan *chan,
 				  struct dma_slave_config *config)
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
 	struct pl08x_driver_data *pl08x = plchan->host;
 	enum dma_slave_buswidth addr_width;
-	u32 width, burst, maxburst;
-	u32 cctl = 0;
+	u32 maxburst, cctl = 0;
 
 	if (!plchan->slave)
 		return -EINVAL;
@@ -1229,8 +1255,8 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 		return -EINVAL;
 	}
 
-	width = pl08x_width(addr_width);
-	if (width == ~0) {
+	cctl = pl08x_get_cctl(plchan, addr_width, maxburst);
+	if (cctl == ~0) {
 		dev_err(&pl08x->adev->dev,
 			"bad runtime_config: alien address width\n");
 		return -EINVAL;
@@ -1238,25 +1264,10 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 
 	plchan->cfg = *config;
 
-	cctl |= width << PL080_CONTROL_SWIDTH_SHIFT;
-	cctl |= width << PL080_CONTROL_DWIDTH_SHIFT;
-
-	/*
-	 * If this channel will only request single transfers, set this
-	 * down to ONE element.  Also select one element if no maxburst
-	 * is specified.
-	 */
-	if (plchan->cd->single)
-		maxburst = 1;
-
-	burst = pl08x_burst(maxburst);
-	cctl |= burst << PL080_CONTROL_SB_SIZE_SHIFT;
-	cctl |= burst << PL080_CONTROL_DB_SIZE_SHIFT;
-
 	if (plchan->runtime_direction == DMA_DEV_TO_MEM) {
-		plchan->src_cctl = pl08x_cctl(cctl);
+		plchan->src_cctl = cctl;
 	} else {
-		plchan->dst_cctl = pl08x_cctl(cctl);
+		plchan->dst_cctl = cctl;
 	}
 
 	dev_dbg(&pl08x->adev->dev,
-- 
1.7.4.4
