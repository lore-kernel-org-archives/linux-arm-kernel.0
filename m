From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 06 Feb 2013 11:48:46 +0530
Subject: [PATCH V3 2/5] DMA: PL330: Add xlate function
In-Reply-To: <1360131529-2847-1-git-send-email-padma.v@samsung.com>
References: <1360131529-2847-1-git-send-email-padma.v@samsung.com>
Message-ID: <1360131529-2847-3-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add xlate to translate the device-tree binding information into
the appropriate format. The filter function requires the dma
controller device and dma channel number as filter_params.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/pl330.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 87110f2..e68c83b 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -25,6 +25,7 @@
 #include <linux/amba/pl330.h>
 #include <linux/scatterlist.h>
 #include <linux/of.h>
+#include <linux/of_dma.h>
 
 #include "dmaengine.h"
 #define PL330_MAX_CHAN		8
@@ -2379,6 +2380,30 @@ bool pl330_filter(struct dma_chan *chan, void *param)
 }
 EXPORT_SYMBOL(pl330_filter);
 
+static struct dma_chan *of_dma_pl330_xlate(struct of_phandle_args *dma_spec,
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
+	return dma_request_channel(cap, pl330_dt_filter, &fargs);
+}
+
 static int pl330_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
-- 
1.7.4.4
