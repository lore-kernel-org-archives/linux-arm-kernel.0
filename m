From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Mon, 16 Aug 2010 13:56:34 +0200
Subject: [PATCH 1/3] dmaengine: add possibility for cyclic transfers
In-Reply-To: <1281956870-12463-2-git-send-email-s.hauer@pengutronix.de>
References: <1281956870-12463-1-git-send-email-s.hauer@pengutronix.de>
	<1281956870-12463-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <19561.10098.732048.877464@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sascha Hauer writes:
> Cyclic transfers are useful for audio where a single buffer divided
> in periods has to be transfered endlessly until stopped. After being
> prepared the transfer is started using the dma_async_descriptor->tx_submit
> function. dma_async_descriptor->callback is called after each period.
> The transfer is stopped using the DMA_TERMINATE_ALL callback.
> While being used for cyclic transfers the channel cannot be used
> for other transfer types.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
> ---
>  drivers/dma/dmaengine.c   |    2 ++
>  include/linux/dmaengine.h |    6 +++++-
>  2 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 9d31d5e..e5e79ce 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -692,6 +692,8 @@ int dma_async_device_register(struct dma_device *device)
>  		!device->device_prep_dma_interrupt);
>  	BUG_ON(dma_has_cap(DMA_SLAVE, device->cap_mask) &&
>  		!device->device_prep_slave_sg);
> +	BUG_ON(dma_has_cap(DMA_CYCLIC, device->cap_mask) &&
> +		!device->device_prep_dma_cyclic);
>  	BUG_ON(dma_has_cap(DMA_SLAVE, device->cap_mask) &&
>  		!device->device_control);
>  
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index c61d4ca..0df7864 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -67,10 +67,11 @@ enum dma_transaction_type {
>  	DMA_PRIVATE,
>  	DMA_ASYNC_TX,
>  	DMA_SLAVE,
> +	DMA_CYCLIC,
>  };
>  
>  /* last transaction type for creation of the capabilities mask */
> -#define DMA_TX_TYPE_END (DMA_SLAVE + 1)
> +#define DMA_TX_TYPE_END (DMA_CYCLIC + 1)
>  
>  
>  /**
> @@ -478,6 +479,9 @@ struct dma_device {
>  		struct dma_chan *chan, struct scatterlist *sgl,
>  		unsigned int sg_len, enum dma_data_direction direction,
>  		unsigned long flags);
> +	struct dma_async_tx_descriptor *(*device_prep_dma_cyclic)(
> +		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
> +		size_t period_len, enum dma_data_direction direction);
>  	int (*device_control)(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
>  		unsigned long arg);
>  
> -- 
> 1.7.1
> 
Why not implement this feature using cyclic SG lists (created with
sg_chain())? This would give you endless DMA transfers without any
special DMA API extensions.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
