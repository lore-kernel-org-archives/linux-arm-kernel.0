From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 14 Nov 2012 10:22:48 +0100
Subject: [PATCH v2] i2c: at91: add dma support
In-Reply-To: <1352470068-7678-1-git-send-email-ludovic.desroches@atmel.com>
References: <1352470068-7678-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20121114092248.GB5954@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2012 at 03:07:48PM +0100, ludovic.desroches at atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Add dma support for Atmel TWI which is available on sam9x5 and later.
> 
> When using dma for reception, you have to read only n-2 bytes. The last
> two bytes are read manually. Don't doing this should cause to send the
> STOP command too late and then to get extra data in the receive
> register.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Some minor comments. But please let sparse run over your build. It has
some hints for you.

> ---
> 
> Changes:
> - v2 (based on Russell feedback):
>     - replace DMA_TO_DEVICE/DMA_FROM_DEVICE by DMA_MEM_TO_DEV/DMA_DEV_TO_MEM
>     - don't check for tx_submit errors
>     - atmel dma header location has changed
> 
>  drivers/i2c/busses/i2c-at91.c | 316 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 305 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index aa59a25..f6fba9c 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -19,6 +19,8 @@
>  
>  #include <linux/clk.h>
>  #include <linux/completion.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> @@ -30,6 +32,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  

Unneeded empty line.

> +#include <linux/platform_data/dma-atmel.h>
> +
>  #define TWI_CLK_HZ		100000			/* max 400 Kbits/s */
>  #define AT91_I2C_TIMEOUT	msecs_to_jiffies(100)	/* transfer timeout */
>  
> @@ -65,9 +69,21 @@
>  #define	AT91_TWI_THR		0x0034	/* Transmit Holding Register */
>  
>  struct at91_twi_pdata {
> -	unsigned	clk_max_div;
> -	unsigned	clk_offset;
> -	bool		has_unre_flag;
> +	unsigned		clk_max_div;
> +	unsigned		clk_offset;
> +	bool			has_unre_flag;
> +	bool			has_dma_support;
> +	struct at_dma_slave	dma_slave;
> +};

This is a good example why indenting struct members to tabs is causing
trouble later. My recommendation is to use a single space even if this
means no alignment.

...

> @@ -224,12 +389,36 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
>  		if (dev->buf_len <= 1 && !(dev->msg->flags & I2C_M_RECV_LEN))
>  			start_flags |= AT91_TWI_STOP;
>  		at91_twi_write(dev, AT91_TWI_CR, start_flags);
> -		at91_twi_write(dev, AT91_TWI_IER,
> +		/*
> +		 * When using dma, the last byte has to be read manually in
> +		 * order to not send the stop command too late and then
> +		 * to receive extra data. In practice, there are some issues
> +		 * if you use the dma to read n-1 bytes because of latency.
> +		 * Reading n-2 bytes with dma and the two last ones manually
> +		 * seems to be the best solution.
> +		 */
> +		if (dev->use_dma && (dev->buf_len > 2)) {

Setting up DMA can cause quite some overhead, so it might be more
efficient to to start using DMA only for transfers bigger than x byte
instead of 2.

...

BTW on a glimpse, are you really using the cookies you set up?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121114/a3215989/attachment.sig>
