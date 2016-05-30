From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 May 2016 10:37:00 +0200
Subject: [PATCH 2/5] spi: sun4i: fix FIFO limit
In-Reply-To: <e315008b5e9dc3f1490507508fd2f6e94767dfbb.1464130597.git.hramrach@gmail.com>
References: <cover.1464130597.git.hramrach@gmail.com>
 <e315008b5e9dc3f1490507508fd2f6e94767dfbb.1464130597.git.hramrach@gmail.com>
Message-ID: <20160530083700.GF4247@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 26, 2016 at 07:25:24PM -0000, Michal Suchanek wrote:
> When testing SPI without DMA I noticed that filling the FIFO on the
> spi controller causes timeout.
> 
> Always leave room for one byte in the FIFO.
> 
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>

Sending it to stable would be great (with a fixes tag too).

> 
> ---
> v2:
> use EMSGSIZE instead of EINVAL
> ---
>  drivers/spi/spi-sun4i.c | 8 ++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index fe63bbd..04f1b77 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -180,7 +180,9 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
>  
>  	/* We don't support transfer larger than the FIFO */
>  	if (tfr->len > SUN4I_FIFO_DEPTH)
> -		return -EINVAL;
> +		return -EMSGSIZE;

One new line here.

> +	if (tfr->tx_buf && tfr->len >= SUN4I_FIFO_DEPTH)
> +		return -EMSGSIZE;
>  
>  	reinit_completion(&sspi->done);
>  	sspi->tx_buf = tfr->tx_buf;
> @@ -271,7 +273,9 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
>  	sun4i_spi_write(sspi, SUN4I_XMIT_CNT_REG, SUN4I_XMIT_CNT(tx_len));
>  
>  	/* Fill the TX FIFO */
> -	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
> +	/* Filling the FIFO fully causes timeout for some reason
> +	 * at least on spi2 on A10s */

This is not the proper comment style and generate a warning with
checkpatch, please fix that (and merge the comment with the previous
comment).

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160530/70e12939/attachment.sig>
