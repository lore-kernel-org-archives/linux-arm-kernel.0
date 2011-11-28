From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 28 Nov 2011 14:19:18 +0100
Subject: [PATCH V2] mfd: Fixed unconditional reset of the ADC reading
 enable bits
In-Reply-To: <1322484759-17809-1-git-send-email-robin@protonic.nl>
References: <1322484759-17809-1-git-send-email-robin@protonic.nl>
Message-ID: <20111128131918.GK17668@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2011 at 01:52:39PM +0100, Robin van der Gracht wrote:
> When the ADC is being prepared for a single or multiple channel reading,
> the adc0 register is reconfigured without taking the lithium cell, charge
> current and battery current reading enable bits into account. Which results
> in clearing the bits.
> 
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> ---
> 
> V2: Maskes now merged to a single mask
> 
>  drivers/mfd/mc13xxx-core.c  |    4 ++--
>  include/linux/mfd/mc13xxx.h |   10 +++++++++-
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index e9619ac..5315999 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -615,13 +615,13 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
>  		break;
>  
>  	case MC13XXX_ADC_MODE_SINGLE_CHAN:
> -		adc0 |= old_adc0 & MC13XXX_ADC0_TSMOD_MASK;
> +		adc0 |= old_adc0 & MC13XXX_ADC0_CONFIG_MASK;
>  		adc1 |= (channel & 0x7) << MC13XXX_ADC1_CHAN0_SHIFT;
>  		adc1 |= MC13XXX_ADC1_RAND;
>  		break;
>  
>  	case MC13XXX_ADC_MODE_MULT_CHAN:
> -		adc0 |= old_adc0 & MC13XXX_ADC0_TSMOD_MASK;
> +		adc0 |= old_adc0 & MC13XXX_ADC0_CONFIG_MASK;
>  		adc1 |= 4 << MC13XXX_ADC1_CHAN1_SHIFT;
>  		break;
>  
> diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
> index 3816c2f..c5011d4 100644
> --- a/include/linux/mfd/mc13xxx.h
> +++ b/include/linux/mfd/mc13xxx.h
> @@ -172,7 +172,10 @@ struct mc13xxx_platform_data {
>  #define MC13XXX_ADC_MODE_SINGLE_CHAN	2
>  #define MC13XXX_ADC_MODE_MULT_CHAN	3
>  
> -#define MC13XXX_ADC0		43
> +#define MC13XXX_ADC0			43
If you keep the line as is (i.e. only two tabs) you can have my Ack.
(The indention is then identical with the one used in
drivers/mfd/mc13xxx-core.c, register offsets appear further to the left
than the masks of the registers.)

Best regards
Uwe

> +#define MC13XXX_ADC0_LICELLCON		(1 << 0)
> +#define MC13XXX_ADC0_CHRGICON		(1 << 1)
> +#define MC13XXX_ADC0_BATICON		(1 << 2)
>  #define MC13XXX_ADC0_ADREFEN		(1 << 10)
>  #define MC13XXX_ADC0_TSMOD0		(1 << 12)
>  #define MC13XXX_ADC0_TSMOD1		(1 << 13)
> @@ -184,4 +187,9 @@ struct mc13xxx_platform_data {
>  					MC13XXX_ADC0_TSMOD1 | \
>  					MC13XXX_ADC0_TSMOD2)
>  
> +#define MC13XXX_ADC0_CONFIG_MASK	(MC13XXX_ADC0_TSMOD_MASK | \
> +					MC13XXX_ADC0_LICELLCON | \
> +					MC13XXX_ADC0_CHRGICON | \
> +					MC13XXX_ADC0_BATICON)
> +
>  #endif /* ifndef __LINUX_MFD_MC13XXX_H */
> -- 
> 1.7.4.1
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
