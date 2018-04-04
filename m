From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 4 Apr 2018 09:10:39 +0200
Subject: [PATCH v2 2/6] spi: sun4i: restrict transfer length in PIO-mode
In-Reply-To: <20180403152905.1524-3-ssuloev@orpaltech.com>
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
 <20180403152905.1524-3-ssuloev@orpaltech.com>
Message-ID: <20180404071039.2kiizzkzzogsk3o4@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2018 at 06:29:01PM +0300, Sergey Suloev wrote:
> There is no need to handle the 3/4 FIFO empty interrupt
> as the maximum supported transfer length in PIO mode
> is 64 bytes.
> As long as a problem was reported previously with filling FIFO
> on A10s we want to stick with 63 bytes depth.
> 
> Changes in v2:
> 1) Restored processing of 3/4 FIFO full interrupt.
> 
> Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
> ---
>  drivers/spi/spi-sun4i.c | 37 ++++++++++---------------------------
>  1 file changed, 10 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index 4141003..08fd007 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -22,7 +22,12 @@
>  
>  #include <linux/spi/spi.h>
>  
> -#define SUN4I_FIFO_DEPTH		64
> +/*
> + * FIFO length is 64 bytes
> + * But filling the FIFO fully might cause a timeout
> + * on some devices, for example on spi2 on A10s
> + */
> +#define SUN4I_FIFO_DEPTH		63

The FIFO depth is 64 bytes, so the code should remain the same at
least from that regard.

>  #define SUN4I_RXDATA_REG		0x00
>  
> @@ -202,7 +207,7 @@ static void sun4i_spi_set_cs(struct spi_device *spi, bool enable)
>  
>  static size_t sun4i_spi_max_transfer_size(struct spi_device *spi)
>  {
> -	return SUN4I_FIFO_DEPTH - 1;
> +	return SUN4I_FIFO_DEPTH;
>  }
>  
>  static int sun4i_spi_transfer_one(struct spi_master *master,
> @@ -216,11 +221,8 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
>  	int ret = 0;
>  	u32 reg;
>  
> -	/* We don't support transfer larger than the FIFO */
> -	if (tfr->len > SUN4I_MAX_XFER_SIZE)
> -		return -EMSGSIZE;
> -
> -	if (tfr->tx_buf && tfr->len >= SUN4I_MAX_XFER_SIZE)
> +	/* We don't support transfers larger than FIFO depth */
> +	if (tfr->len > SUN4I_FIFO_DEPTH)
>  		return -EMSGSIZE;

This essentially reverts 196737912da5, why?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180404/7de4c81b/attachment.sig>
