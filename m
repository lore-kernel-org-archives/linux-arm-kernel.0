From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Aug 2013 14:51:01 +0100
Subject: [PATCH v6] dmaengine: Add MOXA ART DMA engine driver
In-Reply-To: <1375450125-29767-1-git-send-email-jonas.jensen@gmail.com>
References: <1375445018-20713-1-git-send-email-jonas.jensen@gmail.com>
 <1375450125-29767-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20130802135101.GQ23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 03:28:45PM +0200, Jonas Jensen wrote:
> +struct moxart_dma_chan {
> +	struct dma_chan			chan;
> +	int				ch_num;
> +	bool				allocated;
> +	int				error_flag;
> +	struct moxart_dma_reg		*reg;
> +	void				(*callback)(void *param);
> +	void				*callback_param;
> +	struct completion		dma_complete;

Is this completion used anywhere?

> +	struct dma_slave_config		cfg;
> +	struct dma_async_tx_descriptor	tx_desc;
> +	unsigned int			line;
> +};
...
> +static dma_cookie_t moxart_tx_submit(struct dma_async_tx_descriptor *tx)
> +{
> +	struct moxart_dma_chan *mchan = to_moxart_dma_chan(tx->chan);
> +	struct moxart_dma_container *mc = to_dma_container(mchan->chan.device);
> +	dma_cookie_t cookie;
> +	u32 ctrl;
> +	unsigned long flags;
> +
> +	mchan->callback = tx->callback;
> +	mchan->callback_param = tx->callback_param;

As 'mchan' contains the tx descriptor, I don't know why you feel that you
need to copy these.

> +static irqreturn_t moxart_dma_interrupt(int irq, void *devid)
> +{
> +	struct moxart_dma_container *mc = to_dma_container(devid);
> +	struct moxart_dma_chan *mchan = &mc->slave_chans[0];
> +	unsigned int i;
> +	u32 ctrl;
> +
> +	pr_debug("%s\n", __func__);
> +
> +	for (i = 0; i < APB_DMA_MAX_CHANNEL; i++, mchan++) {
> +		if (mchan->allocated) {
> +			ctrl = readl(&mchan->reg->ctrl);
> +			if (ctrl & APB_DMA_FIN_INT_STS) {
> +				ctrl &= ~APB_DMA_FIN_INT_STS;
> +				dma_cookie_complete(&mchan->tx_desc);
> +			}
> +			if (ctrl & APB_DMA_ERR_INT_STS) {
> +				ctrl &= ~APB_DMA_ERR_INT_STS;
> +				mchan->error_flag = 1;
> +			}
> +			if (mchan->callback) {
> +				pr_debug("%s: call callback for mchan=%p\n",
> +					 __func__, mchan);
> +				mchan->callback(mchan->callback_param);

Calling the callback from interrupt context is not on.

2/ Specify a completion callback.  The callback routine runs in tasklet
   context if the offload engine driver supports interrupts, or it is
   called in application context if the operation is carried out
   synchronously in software.

That can be found in Documentation/crypto/async-tx-api.txt and applies
to all DMA engine implementations (which is the underlying implementation
of the async-tx API.)
