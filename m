From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 22 Jul 2014 11:13:28 +0200
Subject: [PATCH 1/2] drivers/i2c/busses: use correct type for dma_map/unmap
In-Reply-To: <1405935725-10457-2-git-send-email-wsa@the-dreams.de>
References: <1405935725-10457-1-git-send-email-wsa@the-dreams.de>
 <1405935725-10457-2-git-send-email-wsa@the-dreams.de>
Message-ID: <20140722091328.GD2349@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 11:42:03AM +0200, Wolfram Sang wrote:
> dma_{un}map_* uses 'enum dma_data_direction' not 'enum dma_transfer_direction'.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks Wolfram.

> ---
>  drivers/i2c/busses/i2c-at91.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index e95f9ba96790..83c989382be9 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -210,7 +210,7 @@ static void at91_twi_write_data_dma_callback(void *data)
>  	struct at91_twi_dev *dev = (struct at91_twi_dev *)data;
>  
>  	dma_unmap_single(dev->dev, sg_dma_address(&dev->dma.sg),
> -			 dev->buf_len, DMA_MEM_TO_DEV);
> +			 dev->buf_len, DMA_TO_DEVICE);
>  
>  	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
>  }
> @@ -289,7 +289,7 @@ static void at91_twi_read_data_dma_callback(void *data)
>  	struct at91_twi_dev *dev = (struct at91_twi_dev *)data;
>  
>  	dma_unmap_single(dev->dev, sg_dma_address(&dev->dma.sg),
> -			 dev->buf_len, DMA_DEV_TO_MEM);
> +			 dev->buf_len, DMA_FROM_DEVICE);
>  
>  	/* The last two bytes have to be read without using dma */
>  	dev->buf += dev->buf_len - 2;
> -- 
> 2.0.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
