From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 13 Feb 2016 13:45:59 +0000
Subject: [PATCH] iio: adc/imx25-gcq: move incorrect do_div
In-Reply-To: <1455275748-999115-1-git-send-email-arnd@arndb.de>
References: <1455275748-999115-1-git-send-email-arnd@arndb.de>
Message-ID: <56BF3397.1040006@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/16 11:15, Arnd Bergmann wrote:
> The newly added driver uses do_div() to device a 32-bit number, which now
> provokes a warning:
> 
> drivers/iio/adc/fsl-imx25-gcq.c: In function 'mx25_gcq_setup_cfgs':
> include/asm-generic/div64.h:207:28: warning: comparison of distinct pointer types lacks a cast
>   (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
> 
> This replaces the do_div() call with a straight division operator.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 6df2e98c3ea5 ("iio: adc: Add imx25-gcq ADC driver")
Acked-by: Jonathan Cameron <jic23@kernel.org>

oops.
> ---
>  drivers/iio/adc/fsl-imx25-gcq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> index 2fd192735d5b..72b32c1ab257 100644
> --- a/drivers/iio/adc/fsl-imx25-gcq.c
> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> @@ -233,7 +233,7 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
>  			priv->channel_vref_mv[reg] =
>  				regulator_get_voltage(priv->vref[refp]);
>  			/* Conversion from uV to mV */
> -			do_div(priv->channel_vref_mv[reg], 1000);
> +			priv->channel_vref_mv[reg] /= 1000;
>  			break;
>  		case MX25_ADC_REFP_INT:
>  			priv->channel_vref_mv[reg] = 2500;
> 
