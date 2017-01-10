From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 10 Jan 2017 08:12:38 +0100
Subject: [PATCH v3 3/4] dmaengine: pl330: Store pointer to slave device
In-Reply-To: <1484032359-8311-1-git-send-email-m.szyprowski@samsung.com>
References: <1484032359-8311-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170110071343eucas1p1b3f8c5122f2d2259e95353a98fdd9484@eucas1p1.samsung.com>
Message-ID: <1484032359-8311-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Store the pointer to slave device, which requested our channel. It will be
later used to implement runtime PM of PL330 DMA controller. Although
DMA channels might be requested many times, each DMA peripheral channel is
physically dedicated only for specific hardware, so there should be only
one slave device for each channel.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/pl330.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index d7670e7220e4..4489d4d13012 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -450,6 +450,7 @@ struct dma_pl330_chan {
 
 	/* for runtime pm tracking */
 	bool active;
+	struct device *slave;
 };
 
 struct pl330_dmac {
@@ -2101,6 +2102,14 @@ static struct dma_chan *of_dma_pl330_xlate(struct of_phandle_args *dma_spec,
 	if (chan_id >= pl330->num_peripherals)
 		return NULL;
 
+	if (!pl330->peripherals[chan_id].slave) {
+		pl330->peripherals[chan_id].slave = slave;
+	} else if (pl330->peripherals[chan_id].slave != slave) {
+		dev_err(pl330->ddma.dev,
+			"Can't use same channel with multiple slave devices!\n");
+		return NULL;
+	}
+
 	return dma_get_slave_channel(&pl330->peripherals[chan_id].chan);
 }
 
-- 
1.9.1
