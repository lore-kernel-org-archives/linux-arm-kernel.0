From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 15 Aug 2013 21:27:11 +0200
Subject: [PATCH v2 3/4] iio: at91: ADC start-up time calculation changed
 since at91sam9x5
In-Reply-To: <1376219071-29946-4-git-send-email-josh.wu@atmel.com>
References: <1376219071-29946-1-git-send-email-josh.wu@atmel.com>
 <1376219071-29946-4-git-send-email-josh.wu@atmel.com>
Message-ID: <20130815192711.GE12162@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

On Sun, Aug 11, 2013 at 07:04:30PM +0800, Josh Wu wrote:
> Since in at91sam9x5, sama5d3x chip. the start up time calucation is
> changed.  This patch can choose different start up time calculation
> formula for different chips.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
> v1 --> v2:
>   add a new variable for different start_time calculation.
> 
>  drivers/iio/adc/at91_adc.c |   42 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index b41eb60..9b0ffff 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -40,6 +40,7 @@
>  	(writel_relaxed(val, st->reg_base + reg))
>  
>  struct at91_adc_caps {
> +	bool	start_time_use_lookup_tab;
>  	u32	mr_prescal_mask;
>  	u32	mr_startup_mask;
>  };
> @@ -700,13 +701,39 @@ static int at91_adc_probe(struct platform_device *pdev)
>  		goto error_disable_adc_clk;
>  	}
>  
> -	/*
> -	 * Number of ticks needed to cover the startup time of the ADC as
> -	 * defined in the electrical characteristics of the board, divided by 8.
> -	 * The formula thus is : Startup Time = (ticks + 1) * 8 / ADC Clock
> -	 */
> -	ticks = round_up((st->startup_time * adc_clk_khz /
> -			  1000) - 1, 8) / 8;
> +	if (!st->caps->start_time_use_lookup_tab) {
> +		/*
> +		 * Number of ticks needed to cover the startup time of the ADC
> +		 * as defined in the electrical characteristics of the board,
> +		 * divided by 8. The formula thus is :
> +		 *   Startup Time = (ticks + 1) * 8 / ADC Clock
> +		 */
> +		ticks = round_up((st->startup_time * adc_clk_khz /
> +				  1000) - 1, 8) / 8;
> +	} else {
> +		/*
> +		 * For sama5d3x and at91sam9x5, the formula changes to:
> +		 * Startup Time = <lookup_table_value> / ADC Clock
> +		 */
> +		const int startup_lookup[] = {
> +			0  , 8  , 16 , 24 ,
> +			64 , 80 , 96 , 112,
> +			512, 576, 640, 704,
> +			768, 832, 896, 960
> +			};
> +
> +		int i, size = ARRAY_SIZE(startup_lookup);
> +		ticks = st->startup_time * adc_clk_khz / 1000;
> +		for (i = 0; i < size; i++)
> +			if (ticks < startup_lookup[i])
> +				break;
> +
> +		ticks = i;
> +		if (ticks == size)
> +			/* Reach the end of lookup table */
> +			ticks = size - 1;
> +	}
> +

Maybe just declaring two different functions here to calculate the
number of ticks, and just holding the function pointer in your structure
would make things more readable and future-proof?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130815/6deb8364/attachment-0001.sig>
