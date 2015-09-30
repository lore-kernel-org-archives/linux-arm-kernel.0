From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 01 Oct 2015 08:48:23 +0900
Subject: [PATCH RESENDv2] mach:-s3c64xx:Output trace information with
 WARN_ON if calls for setting up gpio board configuration fail in
 s3c64xx_i2s_cfg_gpio
In-Reply-To: <1443578870-14534-1-git-send-email-xerofoify@gmail.com>
References: <1443578870-14534-1-git-send-email-xerofoify@gmail.com>
Message-ID: <560C74C7.7030409@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.09.2015 11:07, Nicholas Krause wrote:
> This fixes the function s3c64xx_i2c_cfg_gpio to log output to the 
> kernel log buff with WARN_ON if any of the calls to either 
> s3c_gpio_cfgpin_range or s3c_gpio_cfgpin fail as we cannot exit 
> from s3c64xx_i2s_cfg_gpio if any of these calls fail due to 
> other intended function work being required to complete.

This is better now.

> Therefore
> due to this output our failed calls by means of WARN_ON to the
> kernel log buffer for failed configuration of gpio devices using
> this driver file.

I don't get this sentence. What do you want to say?


> v2:Fix Patch Wording as it was clearly confusing and incorrect

Changelog goes after --- separator.

Last question - have you compiled it? I mean truly compiled like
generated object file and linked objects into vmlinux?

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
