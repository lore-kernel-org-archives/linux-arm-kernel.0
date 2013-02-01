From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 01 Feb 2013 18:21:56 +0530
Subject: [PATCH V2 4/4] DMA: PL330: Modify pl330 filter based on new generic
 dma dt bindings.
In-Reply-To: <1359723116-18173-1-git-send-email-padma.v@samsung.com>
References: <1359723116-18173-1-git-send-email-padma.v@samsung.com>
Message-ID: <1359723116-18173-5-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modify the filter function to filter the required channel
based on new filter params.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 drivers/dma/pl330.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index ddf4dd0..14d84a4 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2392,15 +2392,12 @@ bool pl330_filter(struct dma_chan *chan, void *param)
 
 #ifdef CONFIG_OF
 	if (chan->device->dev->of_node) {
-		const __be32 *prop_value;
-		phandle phandle;
-		struct device_node *node;
-
-		prop_value = ((struct property *)param)->value;
-		phandle = be32_to_cpup(prop_value++);
-		node = of_find_node_by_phandle(phandle);
-		return ((chan->private == node) &&
-				(chan->chan_id == be32_to_cpup(prop_value)));
+		struct dma_pl330_filter_args *fargs = param;
+
+		if (chan->device != &fargs->pdmac->ddma)
+			return false;
+
+		return (chan->chan_id == fargs->chan_id);
 	}
 #endif
 
-- 
1.7.4.4
