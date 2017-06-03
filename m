From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 3 Jun 2017 09:30:19 +0100
Subject: [PATCH] iio:adc:lpc32xx Handle return value of clk_prepare_enable
In-Reply-To: <e54764708d74134ef1f5b3566b2d4d3ab4187b45.1496045161.git.arvind.yadav.cs@gmail.com>
References: <e54764708d74134ef1f5b3566b2d4d3ab4187b45.1496045161.git.arvind.yadav.cs@gmail.com>
Message-ID: <20170603093019.3cfa04b5@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 May 2017 16:35:27 +0530
Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:

> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/lpc32xx_adc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
> index 0de709b..6a5b9a9 100644
> --- a/drivers/iio/adc/lpc32xx_adc.c
> +++ b/drivers/iio/adc/lpc32xx_adc.c
> @@ -76,10 +76,14 @@ static int lpc32xx_read_raw(struct iio_dev *indio_dev,
>  			    long mask)
>  {
>  	struct lpc32xx_adc_state *st = iio_priv(indio_dev);
> -
> +	int ret;
>  	if (mask == IIO_CHAN_INFO_RAW) {
>  		mutex_lock(&indio_dev->mlock);
> -		clk_prepare_enable(st->clk);
> +		ret = clk_prepare_enable(st->clk);
> +		if (ret) {
> +			mutex_unlock(&indio_dev->mlock);
> +			return ret;
> +		}
>  		/* Measurement setup */
>  		__raw_writel(LPC32XXAD_INTERNAL | (chan->address) |
>  			     LPC32XXAD_REFp | LPC32XXAD_REFm,
