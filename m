From: joe@perches.com (Joe Perches)
Date: Fri, 15 Nov 2013 09:03:36 -0800
Subject: [PATCHv5] dmaengine: Add support for BCM2835
In-Reply-To: <52864BBC.7000506@koalo.de>
References: <52864BBC.7000506@koalo.de>
Message-ID: <1384535016.18739.23.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-11-15 at 17:28 +0100, Florian Meier wrote:
> Add support for DMA controller of BCM2835 as used in the Raspberry Pi.
> Currently it only supports cyclic DMA.

trivial style notes:

> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
[]
> +/* DMA CS Control and Status bits */
> +#define BCM2835_DMA_ACTIVE	(1 << 0)
> +#define BCM2835_DMA_INT	(1 << 2)
> +#define BCM2835_DMA_ISPAUSED	(1 << 4)  /* Pause requested or not active */
> +#define BCM2835_DMA_ISHELD	(1 << 5)  /* Is held by DREQ flow control */
> +#define BCM2835_DMA_ERR	(1 << 8)
> +#define BCM2835_DMA_ABORT	(1 << 30) /* stop current CB, go to next, WO */
> +#define BCM2835_DMA_RESET	(1 << 31) /* WO, self clearing */

These could use the BIT macro

> +#define BCM2835_DMA_DATA_TYPE_S8 1
> +#define BCM2835_DMA_DATA_TYPE_S16 2
> +#define BCM2835_DMA_DATA_TYPE_S32 4
> +#define BCM2835_DMA_DATA_TYPE_S128 16

Are these sizeof(s8), sizeof(s16), sizeof(s32)?
Is there a S64's?  Are there any s128's?

> +static int bcm2835_dma_abort(void __iomem *dma_chan_base)
> +{
> +	unsigned long int cs;
> +	int rc = 0;

Perhaps better without using an automatic for rc
and using direct returns.

> +
> +	cs = readl(dma_chan_base + BCM2835_DMA_CS);
> +
> +	if (BCM2835_DMA_ACTIVE & cs) {

	if (!(cs & BCM2835_DMA_ACTIVE))
		return 0;

and avoid the indent level and use consistent
(cs & bit) style through the routine instead
of mixing (bit & cs) and (cs & bit)

> +		long int timeout = 10000;

Move timeout to start of routine.

> +		/* write 0 to the active bit - pause the DMA */
> +		writel(0, dma_chan_base + BCM2835_DMA_CS);
> +
> +		/* wait for any current AXI transfer to complete */
> +		while ((cs & BCM2835_DMA_ISPAUSED) && --timeout >= 0)
> +			cs = readl(dma_chan_base + BCM2835_DMA_CS);
> +
> +		if (cs & BCM2835_DMA_ISPAUSED) {
> +			/* we'll un-pause when we set of our next DMA */
> +			rc = -ETIMEDOUT;

	return -ETIMEDOUT;

and avoid another indentation level.

> +
> +		} else if (BCM2835_DMA_ACTIVE & cs) {
> +			/* terminate the control block chain */
> +			writel(0, dma_chan_base + BCM2835_DMA_NEXTCB);
> +
> +			/* abort the whole DMA */
> +			writel(BCM2835_DMA_ABORT | BCM2835_DMA_ACTIVE,
> +			       dma_chan_base + BCM2835_DMA_CS);
> +		}
> +	}
> +
> +	return rc;
> +}

So perhaps this becomes:

static int bcm2835_dma_abort(void __iomem *dma_chan_base)
{
	unsigned long int cs;
	long timeout;

	cs = readl(dma_chan_base + BCM2835_DMA_CS);
+       if (!(cs & BCM2835_DMA_ACTIVE))
		return 0;
	
	/* write 0 to the active bit - pause the DMA */
	writel(0, dma_chan_base + BCM2835_DMA_CS);

	/* wait for any current AXI transfer to complete */
	timeout = 10000;
	while ((cs & BCM2835_DMA_ISPAUSED) && --timeout >= 0)
		cs = readl(dma_chan_base + BCM2835_DMA_CS);

	/* we'll un-pause when we set of our next DMA */
	if (cs & BCM2835_DMA_ISPAUSED)
		return -ETIMEDOUT;

	if (!(cs & BCM2835_DMA_ACTIVE))
		return 0;

	/* terminate the control block chain */
	writel(0, dma_chan_base + BCM2835_DMA_NEXTCB);
	/* abort the whole DMA */
	writel(BCM2835_DMA_ABORT | BCM2835_DMA_ACTIVE,
	       dma_chan_base + BCM2835_DMA_CS);

	return 0;
}

[]

> +static size_t bcm2835_dma_desc_size_pos(struct bcm2835_desc *d, dma_addr_t addr)
> +{
> +	unsigned i;
> +	size_t size;

Please set size to 0 here and not in the for loop
> +
> +	for (size = i = 0; i < d->frames; i++) {

[]

> +static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
> +	struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
> +	size_t period_len, enum dma_transfer_direction direction,
> +	unsigned long flags, void *context)
> +{

> +	/* Allocate memory for control blocks */
> +	d->control_block_size = d->frames * sizeof(struct bcm2835_dma_cb);
> +	d->control_block_base = dma_alloc_coherent(chan->device->dev,
> +			d->control_block_size, &d->control_block_base_phys,
> +			GFP_NOWAIT);
> +
> +	if (!d->control_block_base) {
> +		kfree(d);
> +		dev_err(chan->device->dev,
> +				"%s: Memory allocation error\n", __func__);

Please use dma_zalloc_coherent and the OOM message
isn't necessary as dma_alloc_coherent has a generic
OOM message.

> +		return NULL;
> +	}
> +
> +	memset(d->control_block_base, 0, d->control_block_size);

unnecessary with dma_zalloc_coherent
