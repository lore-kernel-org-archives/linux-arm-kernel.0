From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 23 May 2010 13:19:07 +0400
Subject: [PATCH] s3c24xx fix: freeze during suspend/resume on s3c24xx
	if some	GPIO banks not present
In-Reply-To: <4BF8B232.9020903@vscht.cz>
References: <4BF8B232.9020903@vscht.cz>
Message-ID: <4BF8F30B.9040704@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Pinkava J. wrote:

> When saving GPIOs during suspend/resume we need skip missing GPIO banks, not
> trying get corresponding chip again and again in infinite loop.

    I didn't see any infinite loops there -- *continue* itself leads to 
incrementing 'gpio_nr', no?

> Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
> ---
>  arch/arm/plat-samsung/pm-gpio.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/pm-gpio.c b/arch/arm/plat-samsung/pm-gpio.c
> index d50ab9d..7df03f8 100644
> --- a/arch/arm/plat-samsung/pm-gpio.c
> +++ b/arch/arm/plat-samsung/pm-gpio.c
> @@ -331,8 +331,10 @@ void s3c_pm_save_gpios(void)
> 
>  	for (gpio_nr = 0; gpio_nr < S3C_GPIO_END;) {
>  		ourchip = s3c_gpiolib_getchip(gpio_nr);
> -		if (!ourchip)
> +		if (!ourchip) {
> +			gpio_nr++;
>  			continue;
> +		}
> 
>  		s3c_pm_save_gpio(ourchip);
> 
> @@ -369,8 +371,10 @@ void s3c_pm_restore_gpios(void)
> 
>  	for (gpio_nr = 0; gpio_nr < S3C_GPIO_END;) {
>  		ourchip = s3c_gpiolib_getchip(gpio_nr);
> -		if (!ourchip)
> +		if (!ourchip) {
> +			gpio_nr++;
>  			continue;
> +		}
> 
>  		s3c_pm_resume_gpio(ourchip);

WBR, Sergei
