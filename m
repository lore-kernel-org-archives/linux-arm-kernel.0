From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 7 Feb 2011 15:13:50 +0100
Subject: [PATCH 1/5] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <1296871696-21008-2-git-send-email-shawn.guo@freescale.com>
References: <1296871696-21008-1-git-send-email-shawn.guo@freescale.com>
	<1296871696-21008-2-git-send-email-shawn.guo@freescale.com>
Message-ID: <19791.65054.702709.553133@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
[...]
> diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> new file mode 100644
> index 0000000..8d1e811
> --- /dev/null
> +++ b/drivers/dma/mxs-dma.c
> @@ -0,0 +1,702 @@
[...]
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
> +
Apart from the fact, that this is initilized after use, the use of
IRQF_SHARED is wrong here. Shared interrupt handlers are for
multiple handlers sharing a single interrupt source, not for multiple
interrupt sources sharing the same handler!
A shared handler must return IRQ_NONE, if it detects that the
interrupt was from a source it does not handle.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
