From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:45:57 +0000
Subject: [PATCH 47/48] ARM: PL08x: allow dma_set_runtime_config() to return
	errors
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZtA5-0003Sx-Om@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are cases in dma_set_runtime_config() where we fail to perform
the requested action - and we just issue a KERN_ERR message in that
case.  We have the facility to return an error to the caller, so that
is what we should do.

When we encounter an error due to invalid parameters, we should not
modify driver state.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 1c9f712..c7f7b82 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1117,13 +1117,14 @@ static const struct burst_table burst_sizes[] = {
 	},
 };
 
-static void dma_set_runtime_config(struct dma_chan *chan,
-			       struct dma_slave_config *config)
+static int dma_set_runtime_config(struct dma_chan *chan,
+				  struct dma_slave_config *config)
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
 	struct pl08x_driver_data *pl08x = plchan->host;
 	struct pl08x_channel_data *cd = plchan->cd;
 	enum dma_slave_buswidth addr_width;
+	dma_addr_t addr;
 	u32 maxburst;
 	u32 cctl = 0;
 	int i;
@@ -1131,17 +1132,17 @@ static void dma_set_runtime_config(struct dma_chan *chan,
 	/* Transfer direction */
 	plchan->runtime_direction = config->direction;
 	if (config->direction == DMA_TO_DEVICE) {
-		plchan->runtime_addr = config->dst_addr;
+		addr = config->dst_addr;
 		addr_width = config->dst_addr_width;
 		maxburst = config->dst_maxburst;
 	} else if (config->direction == DMA_FROM_DEVICE) {
-		plchan->runtime_addr = config->src_addr;
+		addr = config->src_addr;
 		addr_width = config->src_addr_width;
 		maxburst = config->src_maxburst;
 	} else {
 		dev_err(&pl08x->adev->dev,
 			"bad runtime_config: alien transfer direction\n");
-		return;
+		return -EINVAL;
 	}
 
 	switch (addr_width) {
@@ -1160,7 +1161,7 @@ static void dma_set_runtime_config(struct dma_chan *chan,
 	default:
 		dev_err(&pl08x->adev->dev,
 			"bad runtime_config: alien address width\n");
-		return;
+		return -EINVAL;
 	}
 
 	/*
@@ -1179,6 +1180,8 @@ static void dma_set_runtime_config(struct dma_chan *chan,
 		cctl |= burst_sizes[i].reg;
 	}
 
+	plchan->runtime_addr = addr;
+
 	/* Modify the default channel data to fit PrimeCell request */
 	cd->cctl = cctl;
 
@@ -1190,6 +1193,8 @@ static void dma_set_runtime_config(struct dma_chan *chan,
 		addr_width,
 		maxburst,
 		cctl);
+
+	return 0;
 }
 
 /*
@@ -1452,10 +1457,8 @@ static int pl08x_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 
 	/* Controls applicable to inactive channels */
 	if (cmd == DMA_SLAVE_CONFIG) {
-		dma_set_runtime_config(chan,
-				       (struct dma_slave_config *)
-				       arg);
-		return 0;
+		return dma_set_runtime_config(chan,
+					      (struct dma_slave_config *)arg);
 	}
 
 	/*
-- 
1.6.2.5
