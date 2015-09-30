From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 30 Sep 2015 10:14:25 +0900
Subject: [PATCH RESEND] mach:-s3c64xx:Cause kernel oops with WARN_ON if
 calls for setting up gpio fail in s3c64xx_i2s_cfg_gpio
In-Reply-To: <1442537674-26953-1-git-send-email-xerofoify@gmail.com>
References: <1442537674-26953-1-git-send-email-xerofoify@gmail.com>
Message-ID: <560B3771.2090300@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.09.2015 09:54, Nicholas Krause wrote:
> This fixes the function s3c64xx_i2c_cfg_gpio

The problem is not described and you did not provide a fix so the
description is highly inaccurate and misleading.

> to cause a kernel oopes

Warn causes oops?

> if the call to either s3c_gpio_cfgpin_range or s3c_gpio_cfgpin fail
> as we cannot continue to run

"cannot continue to run" means BUG_ON?

> on a board using this gpio setup if
> the configuration for the board fails when the gpio configuration
> of the board is being reconfigured in the function in
> s3c64xx_i2s_cfg_gpio.

Please rephrase. You essentially said "Configuration fails when
configuration is being reconfigured". Too many configurations...

Fix the subject as well.

Best regards,
Krzysztof

> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  arch/arm/mach-s3c64xx/dev-audio.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
> index ff780a8..5e7538b 100644
> --- a/arch/arm/mach-s3c64xx/dev-audio.c
> +++ b/arch/arm/mach-s3c64xx/dev-audio.c
> @@ -36,10 +36,10 @@ static int s3c64xx_i2s_cfg_gpio(struct platform_device *pdev)
>  		base = S3C64XX_GPE(0);
>  		break;
>  	case 2:
> -		s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C_GPIO_SFN(5));
> -		s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C_GPIO_SFN(5));
> -		s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C_GPIO_SFN(5));
> -		s3c_gpio_cfgpin_range(S3C64XX_GPH(6), 4, S3C_GPIO_SFN(5));
> +		WARN_ON(s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C_GPIO_SFN(5)));
> +		WARN_ON(s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C_GPIO_SFN(5)));
> +		WARN_ON(s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C_GPIO_SFN(5)));
> +		WARN_ON(s3c_gpio_cfgpin_range(S3C64XX_GPH(6), 4, S3C_GPIO_SFN(5));)
>  		return 0;
>  	default:
>  		printk(KERN_DEBUG "Invalid I2S Controller number: %d\n",
> @@ -47,7 +47,7 @@ static int s3c64xx_i2s_cfg_gpio(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	s3c_gpio_cfgpin_range(base, 5, S3C_GPIO_SFN(3));
> +	WARN_ON(s3c_gpio_cfgpin_range(base, 5, S3C_GPIO_SFN(3)));
>  
>  	return 0;
>  }
> 
