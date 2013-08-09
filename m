From: chanho61.park@samsung.com (Chanho Park)
Date: Fri, 09 Aug 2013 20:11:34 +0900
Subject: [PATCH-RESEND 2/2] dma: pl330: add pl330_prep_dma_sg to transfer from
 sglist to sglist
In-Reply-To: <1376046694-2638-1-git-send-email-chanho61.park@samsung.com>
References: <1376046694-2638-1-git-send-email-chanho61.park@samsung.com>
Message-ID: <1376046694-2638-3-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds prep_dma_sg function to transfer memory to memory which mapped
in scatter/gather list. The patch move get_burst_len to upwards to call in the
__pl330_prep_dma_mecpy. Some duplicated code was splitted off from
prep_dma_memcpy.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
Acked-by : Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/dma/pl330.c |  179 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 138 insertions(+), 41 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index ebc2af9..b6d9087 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2636,9 +2636,33 @@ static inline void fill_px(struct pl330_xfer *px,
 	px->src_addr = src;
 }
 
+/* Call after fixing burst size */
+static inline int get_burst_len(struct dma_pl330_desc *desc, size_t len)
+{
+	struct dma_pl330_chan *pch = desc->pchan;
+	struct pl330_info *pi = &pch->dmac->pif;
+	int burst_len;
+
+	burst_len = pi->pcfg.data_bus_width / 8;
+	burst_len *= pi->pcfg.data_buf_dep;
+	burst_len >>= desc->rqcfg.brst_size;
+
+	/* src/dst_burst_len can't be more than 16 */
+	if (burst_len > 16)
+		burst_len = 16;
+
+	while (burst_len > 1) {
+		if (!(len % (burst_len << desc->rqcfg.brst_size)))
+			break;
+		burst_len--;
+	}
+
+	return burst_len;
+}
+
 static struct dma_pl330_desc *
 __pl330_prep_dma_memcpy(struct dma_pl330_chan *pch, dma_addr_t dst,
-		dma_addr_t src, size_t len)
+		dma_addr_t src, size_t len, int burst)
 {
 	struct dma_pl330_desc *desc = pl330_get_desc(pch);
 
@@ -2660,31 +2684,23 @@ __pl330_prep_dma_memcpy(struct dma_pl330_chan *pch, dma_addr_t dst,
 	 */
 	fill_px(&desc->px, dst, src, len);
 
-	return desc;
-}
-
-/* Call after fixing burst size */
-static inline int get_burst_len(struct dma_pl330_desc *desc, size_t len)
-{
-	struct dma_pl330_chan *pch = desc->pchan;
-	struct pl330_info *pi = &pch->dmac->pif;
-	int burst_len;
-
-	burst_len = pi->pcfg.data_bus_width / 8;
-	burst_len *= pi->pcfg.data_buf_dep;
-	burst_len >>= desc->rqcfg.brst_size;
-
-	/* src/dst_burst_len can't be more than 16 */
-	if (burst_len > 16)
-		burst_len = 16;
+	desc->rqcfg.src_inc = 1;
+	desc->rqcfg.dst_inc = 1;
+	desc->req.rqtype = MEMTOMEM;
 
-	while (burst_len > 1) {
-		if (!(len % (burst_len << desc->rqcfg.brst_size)))
+	while (burst > 1) {
+		if (!(len % burst))
 			break;
-		burst_len--;
+		burst /= 2;
 	}
 
-	return burst_len;
+	desc->rqcfg.brst_size = 0;
+	while (burst != (1 << desc->rqcfg.brst_size))
+		desc->rqcfg.brst_size++;
+
+	desc->rqcfg.brst_len = get_burst_len(desc, len);
+
+	return desc;
 }
 
 static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
@@ -2786,28 +2802,12 @@ pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 
 	pi = &pch->dmac->pif;
 
-	desc = __pl330_prep_dma_memcpy(pch, dst, src, len);
-	if (!desc)
-		return NULL;
-
-	desc->rqcfg.src_inc = 1;
-	desc->rqcfg.dst_inc = 1;
-	desc->req.rqtype = MEMTOMEM;
-
 	/* Select max possible burst size */
 	burst = pi->pcfg.data_bus_width / 8;
 
-	while (burst > 1) {
-		if (!(len % burst))
-			break;
-		burst /= 2;
-	}
-
-	desc->rqcfg.brst_size = 0;
-	while (burst != (1 << desc->rqcfg.brst_size))
-		desc->rqcfg.brst_size++;
-
-	desc->rqcfg.brst_len = get_burst_len(desc, len);
+	desc = __pl330_prep_dma_memcpy(pch, dst, src, len, burst);
+	if (!desc)
+		return NULL;
 
 	desc->txd.flags = flags;
 
@@ -2837,6 +2837,102 @@ static void __pl330_giveback_desc(struct dma_pl330_dmac *pdmac,
 }
 
 static struct dma_async_tx_descriptor *
+pl330_prep_dma_sg(struct dma_chan *chan,
+	struct scatterlist *dst_sg, unsigned int dst_nents,
+	struct scatterlist *src_sg, unsigned int src_nents,
+	unsigned long flags)
+{
+	struct dma_pl330_desc *first, *desc = NULL;
+	struct dma_pl330_chan *pch = to_pchan(chan);
+	struct pl330_info *pi;
+	dma_addr_t src, dst;
+	size_t len, dst_len = 0, src_len = 0;
+	int burst;
+
+	if (unlikely(!pch))
+		return NULL;
+
+	pi = &pch->dmac->pif;
+
+	/* basic sanity checks */
+	if (dst_nents == 0 || src_nents == 0)
+		return NULL;
+
+	if (dst_sg == NULL || src_sg == NULL)
+		return NULL;
+
+	first = NULL;
+
+	/* Select max possible burst size */
+	burst = pi->pcfg.data_bus_width / 8;
+
+	/* get prepared for the loop */
+	dst_len = sg_dma_len(dst_sg);
+	src_len = sg_dma_len(src_sg);
+
+	while (true) {
+		len = min_t(size_t, src_len, dst_len);
+
+		if (len == 0)
+			goto fetch;
+
+		dst = sg_dma_address(dst_sg) + sg_dma_len(dst_sg) - dst_len;
+		src = sg_dma_address(src_sg) + sg_dma_len(src_sg) - src_len;
+
+		desc = __pl330_prep_dma_memcpy(pch, dst, src, len, burst);
+		if (!desc) {
+			struct dma_pl330_dmac *pdmac = pch->dmac;
+
+			dev_err(pdmac->pif.dev,
+				"%s:%d Unable to fetch desc\n",
+				__func__, __LINE__);
+
+			__pl330_giveback_desc(pdmac, first);
+
+			return NULL;
+		}
+		if (!first)
+			first = desc;
+		else
+			list_add_tail(&desc->node, &first->node);
+
+		desc->txd.flags = flags;
+
+		dst_len -= len;
+		src_len -= len;
+
+fetch:
+		/* fetch the next dst scatterlist entry */
+		if (dst_len == 0) {
+			/* no more entries: we're done */
+			if (dst_nents == 0)
+				break;
+			/* fetch the next entry: if there are no more: done */
+			dst_sg = sg_next(dst_sg);
+			if (dst_sg == NULL)
+				break;
+			dst_nents--;
+			dst_len = sg_dma_len(dst_sg);
+		}
+
+		/* fetch the next src scatterlist entry */
+		if (src_len == 0) {
+			/* no more entries: we're done */
+			if (src_nents == 0)
+				break;
+			/* fetch the next entry: if there are no more: done */
+			src_sg = sg_next(src_sg);
+			if (src_sg == NULL)
+				break;
+			src_nents--;
+			src_len = sg_dma_len(src_sg);
+		}
+	}
+
+	return &first->txd;
+}
+
+static struct dma_async_tx_descriptor *
 pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
 		unsigned long flg, void *context)
@@ -3029,6 +3125,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	pd->device_alloc_chan_resources = pl330_alloc_chan_resources;
 	pd->device_free_chan_resources = pl330_free_chan_resources;
 	pd->device_prep_dma_memcpy = pl330_prep_dma_memcpy;
+	pd->device_prep_dma_sg = pl330_prep_dma_sg;
 	pd->device_prep_dma_cyclic = pl330_prep_dma_cyclic;
 	pd->device_tx_status = pl330_tx_status;
 	pd->device_prep_slave_sg = pl330_prep_slave_sg;
-- 
1.7.9.5
