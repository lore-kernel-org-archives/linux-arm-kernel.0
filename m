From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Feb 2011 18:17:49 +0000
Subject: [PATCH 1/5] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <1296871696-21008-2-git-send-email-shawn.guo@freescale.com>
References: <1296871696-21008-1-git-send-email-shawn.guo@freescale.com>
	<1296871696-21008-2-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110204181749.GB8732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 05, 2011 at 10:08:12AM +0800, Shawn Guo wrote:
> +struct mxs_dma_ccw_bits {
> +	unsigned int	command:2;
> +#define MXS_DMA_NO_XFER	0x00
> +#define MXS_DMA_WRITE	0x01
> +#define MXS_DMA_READ	0x02
> +#define MXS_DMA_SENSE	0x03			/* not implemented */
> +	unsigned int	chain:1;
> +	unsigned int	irq:1;
> +	unsigned int	nand_lock:1;		/* not implemented */
> +	unsigned int	nand_wait4ready:1;	/* not implemented */
> +	unsigned int	dec_sem:1;
> +	unsigned int	wait4end:1;
> +	unsigned int	halt_on_terminate:1;
> +	unsigned int	terminate_flush:1;
> +	unsigned int	reserved:2;
> +	unsigned int	pio_num:4;
> +	unsigned int	xfer_bytes:16;
> +#define MAX_XFER_BYTES	0xffff
> +};

Bitfields are subject to endianness issues.  Are you sure this is a good
idea?

> +static dma_cookie_t mxs_dma_tx_submit(struct dma_async_tx_descriptor *tx)
> +{
> +	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(tx->chan);
> +	dma_cookie_t cookie;
> +
> +	spin_lock_irq(&mxs_chan->lock);
> +
> +	cookie = mxs_dma_assign_cookie(mxs_chan);
> +
> +	mxs_dma_enable_chan(mxs_chan);
> +
> +	spin_unlock_irq(&mxs_chan->lock);

Do you know that you'll always be called from an IRQs-enabled context?
If not, you should use the irqsave/irqrestore versions.

> +
> +	return cookie;
> +}
> +
> +static irqreturn_t mxs_dma_int_handler(int irq, void *dev_id)
> +{
> +	struct mxs_dma_engine *mxs_dma = dev_id;
> +	u32 stat1, stat2;
> +
> +	/* completion status */
> +	stat1 = __raw_readl(mxs_dma->base + HW_APBHX_CTRL1);
> +	stat1 &= 0xffff;
> +	__mxs_clrl(stat1, mxs_dma->base + HW_APBHX_CTRL1);
> +
> +	/* error status */
> +	stat2 = __raw_readl(mxs_dma->base + HW_APBHX_CTRL2);
> +	__mxs_clrl(stat2, mxs_dma->base + HW_APBHX_CTRL2);

Would it be useful to report error status when it happens?

> +
> +	/*
> +	 * When both completion and error of termination bits set at the
> +	 * same time, we do not take it as an error.  IOW, it only becomes
> +	 * an error we need to handler here in case of ether it's an bus
> +	 * error or a termination error with no completion.
> +	 */
> +	stat2 = ((stat2 >> 16) & stat2) |	   /* bus error */
> +		(~(stat2 >> 16) & stat2 & ~stat1); /* termination with no completion */
> +
> +	/* combine error and completion status for checking */
> +	stat1 = (stat2 << 16) | stat1;
> +	while (stat1) {
> +		int channel = fls(stat1) - 1;
> +		struct mxs_dma_chan *mxs_chan =
> +				&mxs_dma->mxs_chans[channel % 16];
> +
> +		if (channel >= 16) {
> +			dev_dbg(mxs_dma->dev, "%s: error in channel %d\n",
> +						__func__, channel - 16);
> +			mxs_dma_reset_chan(mxs_chan);
> +			mxs_chan->status = DMA_ERROR;
> +		} else {
> +			if (mxs_chan->flags & MXS_DMA_SG_LOOP)
> +				mxs_chan->status = DMA_IN_PROGRESS;
> +			else
> +				mxs_chan->status = DMA_SUCCESS;
> +		}
> +
> +		stat1 &= ~(1 << channel);
> +
> +		if (mxs_chan->desc.callback)
> +			mxs_chan->desc.callback(mxs_chan->desc.callback_param);

Callbacks are supposed to happen from tasklet context, not irq context.

> +
> +		if (mxs_chan->status == DMA_SUCCESS)
> +			mxs_chan->last_completed = mxs_chan->desc.cookie;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
> +	struct mxs_dma_data *data = chan->private;
> +	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
> +	static unsigned long flags;
> +	int ret;
> +
> +	if (!data)
> +		return -EINVAL;
> +
> +	mxs_chan->chan_irq = data->chan_irq;
> +
> +	mxs_chan->ccw = dma_alloc_coherent(NULL, PAGE_SIZE,
> +				&mxs_chan->ccw_phys, GFP_KERNEL);

Don't you have a struct device for this?  Without a struct device,
dma_alloc_coherent() can only assume that it must give you something
suitable for the smallest DMA mask in your system.  That seems
to be mxs_dma->dev.

> +	if (!mxs_chan->ccw) {
> +		ret = -ENOMEM;
> +		goto err_alloc;
> +	}
> +
> +	memset(mxs_chan->ccw, 0, PAGE_SIZE);
> +
> +	ret = request_irq(mxs_chan->chan_irq, mxs_dma_int_handler,
> +				flags, "mxs-dma", mxs_dma);
> +	if (ret)
> +		goto err_irq;
> +
> +	flags = IRQF_SHARED;

Initialization of flags after use?

> +
> +	clk_enable(mxs_dma->clk);

Error checking?

> +
> +	mxs_dma_reset_chan(mxs_chan);
> +
> +	dma_async_tx_descriptor_init(&mxs_chan->desc, chan);
> +	mxs_chan->desc.tx_submit = mxs_dma_tx_submit;
> +
> +	/* the descriptor is ready */
> +	async_tx_ack(&mxs_chan->desc);
> +
> +	return 0;
> +
> +err_irq:
> +	dma_free_coherent(NULL, PAGE_SIZE, mxs_chan->ccw, mxs_chan->ccw_phys);
> +err_alloc:
> +	return ret;
> +}
> +
> +static void mxs_dma_free_chan_resources(struct dma_chan *chan)
> +{
> +	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
> +	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
> +
> +	mxs_dma_disable_chan(mxs_chan);
> +
> +	free_irq(mxs_chan->chan_irq, mxs_dma);
> +
> +	dma_free_coherent(NULL, PAGE_SIZE, mxs_chan->ccw, mxs_chan->ccw_phys);

Same comment about struct device.
