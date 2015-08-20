From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Aug 2015 16:45:52 +0200
Subject: [PATCH 2/9] spi: sun4i: fix FIFO limit
In-Reply-To: <a40fbf7ca8bd36f08f5e9d3fb6f6de2454066af7.1440080122.git.hramrach@gmail.com>
References: <cover.1440080122.git.hramrach@gmail.com>
 <a40fbf7ca8bd36f08f5e9d3fb6f6de2454066af7.1440080122.git.hramrach@gmail.com>
Message-ID: <20150820144552.GU30520@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 02:19:46PM -0000, Michal Suchanek wrote:
> When testing SPI without DMA I noticed that filling the FIFO on the
> spi controller causes timeout.
> 
> Always leave room for one byte in the FIFO.
> 
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> ---
>  drivers/spi/spi-sun4i.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index 48532ec..707f61b 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -178,6 +178,8 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
>  	/* We don't support transfer larger than the FIFO */
>  	if (tfr->len > SUN4I_FIFO_DEPTH)
>  		return -EINVAL;
> +	if (tfr->tx_buf && tfr->len => SUN4I_FIFO_DEPTH)
> +		return -EINVAL;

Shouldn't you fix the condition just above instead?

>  
>  	reinit_completion(&sspi->done);
>  	sspi->tx_buf = tfr->tx_buf;
> @@ -271,7 +273,9 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
>  	sun4i_spi_write(sspi, SUN4I_XMIT_CNT_REG, SUN4I_XMIT_CNT(tx_len));
>  
>  	/* Fill the TX FIFO */
> -	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
> +	/* Filling the fifo fully causes timeout for some reason
> +	 * at least on spi2 on a10s */

Please use the proper comment style. And it only happens on that
particular SPI controller and SoC combination?

> +	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH - 1);
>  
>  	/* Enable the interrupts */
>  	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC);
> -- 
> 2.1.4
> 

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/b3e270e9/attachment.sig>
