From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 06 Feb 2013 11:48:45 +0530
Subject: [PATCH V3 1/5] DMA: PL330: Add new pl330 filter for DT case.
In-Reply-To: <1360131529-2847-1-git-send-email-padma.v@samsung.com>
References: <1360131529-2847-1-git-send-email-padma.v@samsung.com>
Message-ID: <1360131529-2847-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a new pl330_dt_filter for DT case to filter the
required channel based on the new filter params and modifies the
old filter only for non-DT case as suggested by Arnd Bergmann.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 drivers/dma/pl330.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 80680ee..87110f2 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -606,6 +606,11 @@ struct dma_pl330_desc {
 	struct dma_pl330_chan *pchan;
 };
 
+struct dma_pl330_filter_args {
+	struct dma_pl330_dmac *pdmac;
+	unsigned int chan_id;
+};
+
 static inline void _callback(struct pl330_req *r, enum pl330_op_err err)
 {
 	if (r && r->xfer_cb)
@@ -2352,6 +2357,16 @@ static void dma_pl330_rqcb(void *token, enum pl330_op_err err)
 	tasklet_schedule(&pch->task);
 }
 
+static bool pl330_dt_filter(struct dma_chan *chan, void *param)
+{
+	struct dma_pl330_filter_args *fargs = param;
+
+	if (chan->device != &fargs->pdmac->ddma)
+		return false;
+
+	return (chan->chan_id == fargs->chan_id);
+}
+
 bool pl330_filter(struct dma_chan *chan, void *param)
 {
 	u8 *peri_id;
@@ -2359,20 +2374,6 @@ bool pl330_filter(struct dma_chan *chan, void *param)
 	if (chan->device->dev->driver != &pl330_driver.drv)
 		return false;
 
-#ifdef CONFIG_OF
-	if (chan->device->dev->of_node) {
-		const __be32 *prop_value;
-		phandle phandle;
-		struct device_node *node;
-
-		prop_value = ((struct property *)param)->value;
-		phandle = be32_to_cpup(prop_value++);
-		node = of_find_node_by_phandle(phandle);
-		return ((chan->private == node) &&
-				(chan->chan_id == be32_to_cpup(prop_value)));
-	}
-#endif
-
 	peri_id = chan->private;
 	return *peri_id == (unsigned)param;
 }
-- 
1.7.4.4
