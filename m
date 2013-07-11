From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 11 Jul 2013 12:23:13 +0200
Subject: [PATCH] gpio: samsung: more generic pinctrl exclude ifdef
In-Reply-To: <201307090212.31422.heiko@sntech.de>
References: <201307090212.31422.heiko@sntech.de>
Message-ID: <2059841.SxvZmAMDu5@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Tuesday 09 of July 2013 02:12:31 Heiko St?bner wrote:
> The exclude check should run any time when either the PINCTRL_SAMSUNG
> or PINCTRL_EXYNOS5440 are selected.
> 
> As the real check for the presence of a pinctrl driver is done via a
> dt lookup it's not necessary to specifiy every pinctrl option in the
> ifdef individually.
> 
> This fixes a breakage on s3c2416, when both the legacy and
> dt boards are selected.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Extracted from Tomasz pinctrl series, as it fixes a bug in the current
> 3.11 development.
> 
>  drivers/gpio/gpio-samsung.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
> index a1392f4..ceb7971 100644
> --- a/drivers/gpio/gpio-samsung.c
> +++ b/drivers/gpio/gpio-samsung.c
> @@ -2949,7 +2949,7 @@ static __init int samsung_gpiolib_init(void)
>  	int i, nr_chips;
>  	int group = 0;
> 
> -#if defined(CONFIG_PINCTRL_EXYNOS) || defined(CONFIG_PINCTRL_EXYNOS5440)
> +#if defined(CONFIG_PINCTRL_SAMSUNG) || defined(CONFIG_PINCTRL_EXYNOS5440)
>  	/*
>  	* This gpio driver includes support for device tree support and there
>  	* are platforms using it. In order to maintain compatibility with those

I think we can simplify this even more now, since when booting with DT pinctrl 
driver is always used. What about just removing the whole check, including the 
ifdef and looking for compatible nodes and replacing them with:

	if (of_have_populated_dt())
		return -ENODEV;

Best regards,
Tomasz
