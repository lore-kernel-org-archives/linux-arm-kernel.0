From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 01 Apr 2012 12:15:01 +0300
Subject: [PATCH] ARM: pxa: mfp: Force gpio direction for
 MFP_LPM_KEEP_OUTPUT
In-Reply-To: <1333196437.11228.YahooMailClassic@web29011.mail.ird.yahoo.com>
References: <1333196437.11228.YahooMailClassic@web29011.mail.ird.yahoo.com>
Message-ID: <4F781C95.5000004@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 03/31/12 15:20, Paul Parsons wrote:
> Some MFP configurations specify MFP_LPM_KEEP_OUTPUT to preserve the gpio output
> value (HIGH or LOW) during sleep mode. For example:
> 
>     GPIO72_GPIO | MFP_LPM_KEEP_OUTPUT,
> 
> Unfortunately MFP_LPM_KEEP_OUTPUT makes no special provision for setting the
> sleep mode gpio direction, unlike MFP_LPM_DRIVE_HIGH and MFP_LPM_DRIVE_LOW.
> Consequently MFP configurations of the form:
> 
>     GPIO<n>_GPIO | MFP_LPM_KEEP_OUTPUT,
> 
> will set the sleep mode gpio direction to INPUT.
> 
> This patch forces the sleep mode gpio direction to OUTPUT in cases where
> MFP_LPM_KEEP_OUTPUT was specified. This brings MFP_LPM_KEEP_OUTPUT into line
> with MFP_LPM_DRIVE_HIGH and MFP_LPM_DRIVE_LOW.
> 
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> ---
> 
> diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach-pxa/mfp-pxa2xx.c
> index b0a8428..3b443199 100644
> --- a/arch/arm/mach-pxa/mfp-pxa2xx.c
> +++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
> @@ -96,6 +96,9 @@ static int __mfp_config_gpio(unsigned gpio, unsigned long c)
>  		break;
>  	}
>  
> +	if (c & MFP_LPM_KEEP_OUTPUT)
> +		is_out = 1;
> +

MFP_LPM_KEEP_OUTPUT does not meant to be used to setup the mfp config,
but for pins that have been configured for output by gpio_direction_out().
(Hint: *_KEEP_*).

Also, I don't think this is a good idea, because the patch allows a pin
be configured as output, but does not forces a value (high/low)
and this is not safe.

Why can't you use:
GPIO<n>_GPIO | MFP_LPM_DRIVE_<level>
?

>  	if (is_out ^ gpio_desc[gpio].dir_inverted)
>  		gpdr_lpm[bank] |= mask;
>  	else

-- 
Regards,
Igor.
