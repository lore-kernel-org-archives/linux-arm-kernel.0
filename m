From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Jul 2015 10:42:58 +0200
Subject: [PATCH v2 2/2] dmaengine: hdmac: Add memset capabilities
Message-ID: <1437381778-19108-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like for the XDMAC, the SoCs that embed the HDMAC don't have any kind
of GPU, and need to accelerate a few framebuffer-related operations through
their DMA controller.

However, unlike the XDMAC, the HDMAC doesn't have the memset capability
built-in. That can be easily emulated though, by doing a transfer with a
fixed adress on the variable that holds the value we want to set.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
Changes from v1:
  - Replaced the dma_alloc_coherent calls by a dma_pool

 drivers/dma/at_hdmac.c      | 124 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/dma/at_hdmac_regs.h |   6 +++
 2 files changed, 127 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 59892126d175..44f4891b71ad 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -390,6 +390,7 @@ static void
 atc_chain_complete(struct at_dma_chan *atchan, struct at_desc *desc)
 {
 	struct dma_async_tx_descriptor	*txd = &desc->txd;
+	struct at_dma			*atdma = to_at_dma(atchan->chan_common.device);
 
 	dev_vdbg(chan2dev(&atchan->chan_common),
 		"descriptor %u complete\n", txd->cookie);
@@ -398,6 +399,13 @@ atc_chain_complete(struct at_dma_chan *atchan, struct at_desc *desc)
 	if (!atc_chan_is_cyclic(atchan))
 		dma_cookie_complete(txd);
 
+	/* If the transfer was a memset, free our temporary buffer */
+	if (desc->memset) {
+		dma_pool_free(atdma->memset_pool, desc->memset_vaddr,
+			      desc->memset_paddr);
+		desc->memset = false;
+	}
+
 	/* move children to free_list */
 	list_splice_init(&desc->tx_list, &atchan->free_list);
 	/* move myself to free_list */
@@ -820,6 +828,96 @@ err_desc_get:
 	return NULL;
 }
 
+/**
+ * atc_prep_dma_memset - prepare a memcpy operation
+ * @chan: the channel to prepare operation on
+ * @dest: operation virtual destination address
+ * @value: value to set memory buffer to
+ * @len: operation length
+ * @flags: tx descriptor status flags
+ */
+static struct dma_async_tx_descriptor *
+atc_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
+		    size_t len, unsigned long flags)
+{
+	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
+	struct at_dma		*atdma = to_at_dma(chan->device);
+	struct at_desc		*desc = NULL;
+	size_t			xfer_count;
+	u32			ctrla;
+	u32			ctrlb;
+
+	dev_vdbg(chan2dev(chan), "%s: d0x%x v0x%x l0x%zx f0x%lx\n", __func__,
+		dest, value, len, flags);
+
+	if (unlikely(!len)) {
+		dev_dbg(chan2dev(chan), "%s: length is zero!\n", __func__);
+		return NULL;
+	}
+
+	if (!is_dma_fill_aligned(chan->device, dest, 0, len)) {
+		dev_dbg(chan2dev(chan), "%s: buffer is not aligned\n",
+			__func__);
+		return NULL;
+	}
+
+	xfer_count = len >> 2;
+	if (xfer_count > ATC_BTSIZE_MAX) {
+		dev_err(chan2dev(chan), "%s: buffer is too big\n",
+			__func__);
+		return NULL;
+	}
+
+	ctrlb =   ATC_DEFAULT_CTRLB | ATC_IEN
+		| ATC_SRC_ADDR_MODE_FIXED
+		| ATC_DST_ADDR_MODE_INCR
+		| ATC_FC_MEM2MEM;
+
+	ctrla = ATC_SRC_WIDTH(2) |
+		ATC_DST_WIDTH(2);
+
+	desc = atc_desc_get(atchan);
+	if (!desc) {
+		dev_err(chan2dev(chan), "%s: can't get a descriptor\n",
+			__func__);
+		return NULL;
+	}
+
+	desc->memset_vaddr = dma_pool_alloc(atdma->memset_pool, GFP_ATOMIC,
+					    &desc->memset_paddr);
+	if (!desc->memset_vaddr) {
+		dev_err(chan2dev(chan), "%s: couldn't allocate buffer\n",
+			__func__);
+		goto err_put_desc;
+	}
+
+	*desc->memset_vaddr = value;
+	desc->memset = true;
+
+	desc->lli.saddr = desc->memset_paddr;
+	desc->lli.daddr = dest;
+	desc->lli.ctrla = ctrla | xfer_count;
+	desc->lli.ctrlb = ctrlb;
+
+	desc->txd.cookie = -EBUSY;
+	desc->len = len;
+	desc->total_len = len;
+
+	/* set transfer width for the calculation of the residue */
+	desc->tx_width = 2;
+
+	/* set end-of-link on the descriptor */
+	set_desc_eol(desc);
+
+	desc->txd.flags = flags;
+
+	return &desc->txd;
+
+err_put_desc:
+	atc_desc_put(atchan, desc);
+	return NULL;
+}
+
 
 /**
  * atc_prep_slave_sg - prepare descriptors for a DMA_SLAVE transaction
@@ -1713,6 +1811,8 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_SG, at91sam9rl_config.cap_mask);
 	dma_cap_set(DMA_INTERLEAVE, at91sam9g45_config.cap_mask);
 	dma_cap_set(DMA_MEMCPY, at91sam9g45_config.cap_mask);
+	dma_cap_set(DMA_MEMSET, at91sam9g45_config.cap_mask);
+	dma_cap_set(DMA_PRIVATE, at91sam9g45_config.cap_mask);
 	dma_cap_set(DMA_SLAVE, at91sam9g45_config.cap_mask);
 	dma_cap_set(DMA_SG, at91sam9g45_config.cap_mask);
 
@@ -1776,7 +1876,16 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	if (!atdma->dma_desc_pool) {
 		dev_err(&pdev->dev, "No memory for descriptors dma pool\n");
 		err = -ENOMEM;
-		goto err_pool_create;
+		goto err_desc_pool_create;
+	}
+
+	/* create a pool of consistent memory blocks for memset blocks */
+	atdma->memset_pool = dma_pool_create("at_hdmac_memset_pool",
+					     &pdev->dev, sizeof(int), 4, 0);
+	if (!atdma->memset_pool) {
+		dev_err(&pdev->dev, "No memory for memset dma pool\n");
+		err = -ENOMEM;
+		goto err_memset_pool_create;
 	}
 
 	/* clear any pending interrupt */
@@ -1822,6 +1931,11 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	if (dma_has_cap(DMA_MEMCPY, atdma->dma_common.cap_mask))
 		atdma->dma_common.device_prep_dma_memcpy = atc_prep_dma_memcpy;
 
+	if (dma_has_cap(DMA_MEMSET, atdma->dma_common.cap_mask)) {
+		atdma->dma_common.device_prep_dma_memset = atc_prep_dma_memset;
+		atdma->dma_common.fill_align = DMAENGINE_ALIGN_4_BYTES;
+	}
+
 	if (dma_has_cap(DMA_SLAVE, atdma->dma_common.cap_mask)) {
 		atdma->dma_common.device_prep_slave_sg = atc_prep_slave_sg;
 		/* controller can do slave DMA: can trigger cyclic transfers */
@@ -1842,8 +1956,9 @@ static int __init at_dma_probe(struct platform_device *pdev)
 
 	dma_writel(atdma, EN, AT_DMA_ENABLE);
 
-	dev_info(&pdev->dev, "Atmel AHB DMA Controller ( %s%s%s), %d channels\n",
+	dev_info(&pdev->dev, "Atmel AHB DMA Controller ( %s%s%s%s), %d channels\n",
 	  dma_has_cap(DMA_MEMCPY, atdma->dma_common.cap_mask) ? "cpy " : "",
+	  dma_has_cap(DMA_MEMSET, atdma->dma_common.cap_mask) ? "set " : "",
 	  dma_has_cap(DMA_SLAVE, atdma->dma_common.cap_mask)  ? "slave " : "",
 	  dma_has_cap(DMA_SG, atdma->dma_common.cap_mask)  ? "sg-cpy " : "",
 	  plat_dat->nr_channels);
@@ -1868,8 +1983,10 @@ static int __init at_dma_probe(struct platform_device *pdev)
 
 err_of_dma_controller_register:
 	dma_async_device_unregister(&atdma->dma_common);
+	dma_pool_destroy(atdma->memset_pool);
+err_memset_pool_create:
 	dma_pool_destroy(atdma->dma_desc_pool);
-err_pool_create:
+err_desc_pool_create:
 	free_irq(platform_get_irq(pdev, 0), atdma);
 err_irq:
 	clk_disable_unprepare(atdma->clk);
@@ -1894,6 +2011,7 @@ static int at_dma_remove(struct platform_device *pdev)
 	at_dma_off(atdma);
 	dma_async_device_unregister(&atdma->dma_common);
 
+	dma_pool_destroy(atdma->memset_pool);
 	dma_pool_destroy(atdma->dma_desc_pool);
 	free_irq(platform_get_irq(pdev, 0), atdma);
 
diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
index bc8d5ebedd19..a2283886dd87 100644
--- a/drivers/dma/at_hdmac_regs.h
+++ b/drivers/dma/at_hdmac_regs.h
@@ -201,6 +201,11 @@ struct at_desc {
 	size_t				boundary;
 	size_t				dst_hole;
 	size_t				src_hole;
+
+	/* Memset temporary buffer */
+	bool				memset;
+	dma_addr_t			memset_paddr;
+	int				*memset_vaddr;
 };
 
 static inline struct at_desc *
@@ -331,6 +336,7 @@ struct at_dma {
 	u8			all_chan_mask;
 
 	struct dma_pool		*dma_desc_pool;
+	struct dma_pool		*memset_pool;
 	/* AT THE END channels table */
 	struct at_dma_chan	chan[0];
 };
-- 
2.4.5
