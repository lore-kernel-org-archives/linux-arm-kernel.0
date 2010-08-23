From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 23 Aug 2010 09:17:07 +0200
Subject: [PATCH 2/3] dmaengine: add wrapper functions for dmaengine
In-Reply-To: <1281956870-12463-3-git-send-email-s.hauer@pengutronix.de>
References: <1281956870-12463-1-git-send-email-s.hauer@pengutronix.de>
	<1281956870-12463-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20100823071707.GT27749@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 16, 2010 at 01:07:49PM +0200, Sascha Hauer wrote:
> Currently dmaengine users have to explicitely dereference function
> pointers in struct dma_device. For the convenience of drivers and
> to be more flexible when changing the dmaengine later add static
> inline wrapper functions for the dma commands.
> 
> This patch is not complete yet. If there's consensus on this patch
> I'll provide an updated patch with the missing functions.

Dan,

Any comment on this one?

Sascha

> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  include/linux/dmaengine.h |   41 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 41 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 0df7864..635c60b 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -491,6 +491,47 @@ struct dma_device {
>  	void (*device_issue_pending)(struct dma_chan *chan);
>  };
>  
> +static inline int dmaengine_device_control(struct dma_chan *chan,
> +					   enum dma_ctrl_cmd cmd,
> +					   unsigned long arg)
> +{
> +	return chan->device->device_control(chan, cmd, arg);
> +}
> +
> +static inline int dmaengine_slave_config(struct dma_chan *chan,
> +					  struct dma_slave_config *config)
> +{
> +	return dmaengine_device_control(chan, DMA_SLAVE_CONFIG,
> +			(unsigned long)config);
> +}
> +
> +static inline int dmaengine_terminate_all(struct dma_chan *chan)
> +{
> +	return dmaengine_device_control(chan, DMA_TERMINATE_ALL, 0);
> +}
> +
> +static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
> +		struct dma_chan *chan, struct scatterlist *sgl,
> +		unsigned int sg_len, enum dma_data_direction direction,
> +		unsigned long flags)
> +{
> +	return chan->device->device_prep_slave_sg(chan, sgl, sg_len, direction,
> +			flags);
> +}
> +
> +static inline struct dma_async_tx_descriptor *dmaengine_prep_cyclic(
> +		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
> +		size_t period_len, enum dma_data_direction direction)
> +{
> +	return chan->device->device_prep_dma_cyclic(chan, buf_addr, buf_len,
> +			period_len, direction);
> +}
> +
> +static inline int dmaengine_tx_submit(struct dma_async_tx_descriptor *desc)
> +{
> +	return desc->tx_submit(desc);
> +}
> +
>  static inline bool dmaengine_check_align(u8 align, size_t off1, size_t off2, size_t len)
>  {
>  	size_t mask;
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
