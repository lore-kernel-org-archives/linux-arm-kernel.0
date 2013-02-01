From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 01 Feb 2013 18:21:53 +0530
Subject: [PATCH V2 1/4] DMA: PL330: Add xlate function
In-Reply-To: <1359723116-18173-1-git-send-email-padma.v@samsung.com>
References: <1359723116-18173-1-git-send-email-padma.v@samsung.com>
Message-ID: <1359723116-18173-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add xlate to translate the device-tree binding information into
the appropriate format. The filter function requires the dma
controller device and dma channel number as filter_params.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 drivers/dma/pl330.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 80680ee..6196cc0 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -25,6 +25,7 @@
 #include <linux/amba/pl330.h>
 #include <linux/scatterlist.h>
 #include <linux/of.h>
+#include <linux/of_dma.h>
 
 #include "dmaengine.h"
 #define PL330_MAX_CHAN		8
@@ -606,6 +607,11 @@ struct dma_pl330_desc {
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
@@ -2352,6 +2358,31 @@ static void dma_pl330_rqcb(void *token, enum pl330_op_err err)
 	tasklet_schedule(&pch->task);
 }
 
+struct dma_chan *of_dma_pl330_xlate(struct of_phandle_args *dma_spec,
+						struct of_dma *ofdma)
+{
+	int count = dma_spec->args_count;
+	struct dma_pl330_dmac *pdmac = ofdma->of_dma_data;
+	struct dma_pl330_filter_args fargs;
+	dma_cap_mask_t cap;
+
+	if (!pdmac)
+		return NULL;
+
+	if (count != 1)
+		return NULL;
+
+	fargs.pdmac = pdmac;
+	fargs.chan_id = dma_spec->args[0];
+
+	dma_cap_zero(cap);
+	dma_cap_set(DMA_SLAVE, cap);
+	dma_cap_set(DMA_CYCLIC, cap);
+
+	return dma_request_channel(cap, pl330_filter, &fargs);
+}
+EXPORT_SYMBOL_GPL(of_dma_pl330_xlate);
+
 bool pl330_filter(struct dma_chan *chan, void *param)
 {
 	u8 *peri_id;
-- 
1.7.4.4
