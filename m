From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 1 Apr 2015 08:56:30 +0530
Subject: [PATCH 1/2] dma: Add Freescale qDMA engine driver support
In-Reply-To: <1426570119-8634-1-git-send-email-yao.yuan@freescale.com>
References: <1426570119-8634-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <20150401032630.GR7192@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 01:28:38PM +0800, Yuan Yao wrote:
> +static int fsl_qdma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	/*
> +	 * In QDMA mode, We don't need to do anything.
> +	 */
> +	return 0;
> +}
Pls remove this

> +static struct fsl_qdma_comp *fsl_qdma_request_enqueue_desc(
> +					struct fsl_qdma_chan *fsl_chan)
> +{
> +	struct fsl_qdma_comp *comp_temp;
> +	struct fsl_qdma_queue *queue = fsl_chan->queue;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&queue->queue_lock, flags);
> +	if (list_empty(&queue->comp_free)) {
> +		spin_unlock_irqrestore(&queue->queue_lock, flags);
> +		comp_temp = kzalloc(sizeof(*comp_temp), GFP_KERNEL);
this is called by prep_ APIs so should be atomic so GFP_KERNEL is wrong, you
should use GFP_NOWAIT like you did for below..

> +static int fsl_qdma_halt(struct fsl_qdma_engine *fsl_qdma)
> +{
> +	void __iomem *addr = fsl_qdma->membase;
> +	int i, count = 5;
> +	u32 reg;
> +
> +	/* Disable the command queue and wait for idle state. */
no locks held while you do this ?

> +static struct dma_async_tx_descriptor *fsl_qdma_prep_dma_sg(
> +		struct dma_chan *chan,
> +		struct scatterlist *dst_sg, unsigned int dst_nents,
> +		struct scatterlist *src_sg, unsigned int src_nents,
> +		unsigned long flags)
> +{
> +	return NULL;
> +}
why is this empty?

> +	dma_cap_set(DMA_PRIVATE, fsl_qdma->dma_dev.cap_mask);
> +	dma_cap_set(DMA_SLAVE, fsl_qdma->dma_dev.cap_mask);
> +	dma_cap_set(DMA_MEMCPY, fsl_qdma->dma_dev.cap_mask);
> +
> +	fsl_qdma->dma_dev.dev = &pdev->dev;
> +	fsl_qdma->dma_dev.device_alloc_chan_resources
> +		= fsl_qdma_alloc_chan_resources;
> +	fsl_qdma->dma_dev.device_free_chan_resources
> +		= fsl_qdma_free_chan_resources;
> +	fsl_qdma->dma_dev.device_tx_status = fsl_qdma_tx_status;
> +	fsl_qdma->dma_dev.device_prep_dma_memcpy = fsl_qdma_prep_memcpy;
> +	fsl_qdma->dma_dev.device_prep_dma_sg = fsl_qdma_prep_dma_sg;
> +	fsl_qdma->dma_dev.device_issue_pending = fsl_qdma_issue_pending;
pls set direction etc fields as well

> +
> +	/* Free descriptor areas */
> +	for (i = 0; i < fsl_qdma->n_queues; i++) {
> +		queue_temp = fsl_qdma->queue + i;
> +		list_for_each_entry_safe(comp_temp, _comp_temp,
> +					&queue_temp->comp_used,	list) {
> +			dma_pool_free(queue_temp->comp_pool,
> +					comp_temp->virt_addr,
> +					comp_temp->bus_addr);
> +			list_del(&comp_temp->list);
> +			kfree(comp_temp);
> +		}
> +		list_for_each_entry_safe(comp_temp, _comp_temp,
> +					&queue_temp->comp_free, list) {
> +			dma_pool_free(queue_temp->comp_pool,
> +					comp_temp->virt_addr,
> +					comp_temp->bus_addr);
> +			list_del(&comp_temp->list);
> +			kfree(comp_temp);
> +		}
> +		dma_free_coherent(&pdev->dev, sizeof(struct fsl_qdma_ccdf) *
> +					queue_temp->n_cq, queue_temp->cq,
> +					queue_temp->bus_addr);
> +		dma_pool_destroy(queue_temp->comp_pool);
> +	}
> +
> +	dma_free_coherent(&pdev->dev, sizeof(struct fsl_qdma_ccdf) *
> +				status->n_cq, status->cq, status->bus_addr);
and at this point you still have irq registered and enabled, so can be
invoked!

-- 
~Vinod
