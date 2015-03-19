From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 19 Mar 2015 17:46:47 +0100
Subject: [PATCH 10/13] usb: gadget: atmel_usba: use endian agnostic IO
 on ARM
In-Reply-To: <1426693992-31163-11-git-send-email-ben.dooks@codethink.co.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
 <1426693992-31163-11-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <550AFD77.1080901@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 18/03/2015 16:53, Ben Dooks a ?crit :
> Change from using the __raw IO accesors to the endian agnostic versions
> of readl/writel_relaxed when not on AVR32. This fixes issues with running
> big endian on ARMv7.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> --
> CC: Nicolas Ferre <nicolas.ferre@atmel.com>

Felipe, for the record:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, bye.

> CC: Felipe Balbi <balbi@ti.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: linux-usb at vger.kernel.org
> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c |  4 ++--
>  drivers/usb/gadget/udc/atmel_usba_udc.h | 22 ++++++++++++++++------
>  2 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index d79cb35..be2f503 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -152,7 +152,7 @@ static int regs_dbg_open(struct inode *inode, struct file *file)
>  
>  	spin_lock_irq(&udc->lock);
>  	for (i = 0; i < inode->i_size / 4; i++)
> -		data[i] = __raw_readl(udc->regs + i * 4);
> +		data[i] = usba_io_readl(udc->regs + i * 4);
>  	spin_unlock_irq(&udc->lock);
>  
>  	file->private_data = data;
> @@ -1249,7 +1249,7 @@ static int handle_ep0_setup(struct usba_udc *udc, struct usba_ep *ep,
>  		if (crq->wLength != cpu_to_le16(sizeof(status)))
>  			goto stall;
>  		ep->state = DATA_STAGE_IN;
> -		__raw_writew(status, ep->fifo);
> +		usba_io_writew(status, ep->fifo);
>  		usba_ep_writel(ep, SET_STA, USBA_TX_PK_RDY);
>  		break;
>  	}
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
> index 497cd18..92bd486 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.h
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
> @@ -191,18 +191,28 @@
>  	 | USBA_BF(name, value))
>  
>  /* Register access macros */
> +#ifdef CONFIG_AVR32
> +#define usba_io_readl	__raw_readl
> +#define usba_io_writel	__raw_writel
> +#define usba_io_writew	__raw_writew
> +#else
> +#define usba_io_readl	readl_relaxed
> +#define usba_io_writel	writel_relaxed
> +#define usba_io_writew	writew_relaxed
> +#endif
> +
>  #define usba_readl(udc, reg)					\
> -	__raw_readl((udc)->regs + USBA_##reg)
> +	usba_io_readl((udc)->regs + USBA_##reg)
>  #define usba_writel(udc, reg, value)				\
> -	__raw_writel((value), (udc)->regs + USBA_##reg)
> +	usba_io_writel((value), (udc)->regs + USBA_##reg)
>  #define usba_ep_readl(ep, reg)					\
> -	__raw_readl((ep)->ep_regs + USBA_EPT_##reg)
> +	usba_io_readl((ep)->ep_regs + USBA_EPT_##reg)
>  #define usba_ep_writel(ep, reg, value)				\
> -	__raw_writel((value), (ep)->ep_regs + USBA_EPT_##reg)
> +	usba_io_writel((value), (ep)->ep_regs + USBA_EPT_##reg)
>  #define usba_dma_readl(ep, reg)					\
> -	__raw_readl((ep)->dma_regs + USBA_DMA_##reg)
> +	usba_io_readl((ep)->dma_regs + USBA_DMA_##reg)
>  #define usba_dma_writel(ep, reg, value)				\
> -	__raw_writel((value), (ep)->dma_regs + USBA_DMA_##reg)
> +	usba_io_writel((value), (ep)->dma_regs + USBA_DMA_##reg)
>  
>  /* Calculate base address for a given endpoint or DMA controller */
>  #define USBA_EPT_BASE(x)	(0x100 + (x) * 0x20)
> 


-- 
Nicolas Ferre
