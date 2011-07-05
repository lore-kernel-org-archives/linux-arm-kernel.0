From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 05 Jul 2011 14:12:51 +0100
Subject: [PATCH 7/9] DMA: PL08x: cleanup selection of buswidth
In-Reply-To: <20110705131030.GE8286@n2100.arm.linux.org.uk>
References: <20110705131030.GE8286@n2100.arm.linux.org.uk>
Message-ID: <E1Qe5Qp-0005Na-Rt@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index cb17d92..985bc29 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1105,13 +1105,26 @@ static u32 pl08x_cctl(u32 cctl)
 	return cctl | PL080_CONTROL_PROT_SYS;
 }
 
+static u32 pl08x_width(enum dma_slave_buswidth width)
+{
+	switch (width) {
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+		return PL08X_WIDTH_8BIT;
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		return PL08X_WIDTH_16BIT;
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		return PL08X_WIDTH_32BIT;
+	}
+	return ~0;
+}
+
 static int dma_set_runtime_config(struct dma_chan *chan,
 				  struct dma_slave_config *config)
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
 	struct pl08x_driver_data *pl08x = plchan->host;
 	enum dma_slave_buswidth addr_width;
-	u32 maxburst;
+	u32 width, maxburst;
 	u32 cctl = 0;
 	int i;
 
@@ -1132,25 +1145,16 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 		return -EINVAL;
 	}
 
-	switch (addr_width) {
-	case DMA_SLAVE_BUSWIDTH_1_BYTE:
-		cctl |= (PL080_WIDTH_8BIT << PL080_CONTROL_SWIDTH_SHIFT) |
-			(PL080_WIDTH_8BIT << PL080_CONTROL_DWIDTH_SHIFT);
-		break;
-	case DMA_SLAVE_BUSWIDTH_2_BYTES:
-		cctl |= (PL080_WIDTH_16BIT << PL080_CONTROL_SWIDTH_SHIFT) |
-			(PL080_WIDTH_16BIT << PL080_CONTROL_DWIDTH_SHIFT);
-		break;
-	case DMA_SLAVE_BUSWIDTH_4_BYTES:
-		cctl |= (PL080_WIDTH_32BIT << PL080_CONTROL_SWIDTH_SHIFT) |
-			(PL080_WIDTH_32BIT << PL080_CONTROL_DWIDTH_SHIFT);
-		break;
-	default:
+	width = pl08x_width(addr_width);
+	if (width == ~0) {
 		dev_err(&pl08x->adev->dev,
 			"bad runtime_config: alien address width\n");
 		return -EINVAL;
 	}
 
+	cctl |= width << PL080_CONTROL_SWIDTH_SHIFT;
+	cctl |= width << PL080_CONTROL_DWIDTH_SHIFT;
+
 	/*
 	 * Now decide on a maxburst:
 	 * If this channel will only request single transfers, set this
-- 
1.7.4.4
