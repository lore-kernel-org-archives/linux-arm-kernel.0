From: Jiri.Pinkava@vscht.cz (Pinkava J.)
Date: Sun, 23 May 2010 15:18:44 +0200
Subject: [PATCH] s3c24xx fix: freeze during suspend/resume on s3c24xx
	if some	GPIO banks not present
In-Reply-To: <4BF8B232.9020903@vscht.cz>
References: <4BF8B232.9020903@vscht.cz>
Message-ID: <4BF92B34.6090100@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 23.5.2010 06:42, Pinkava J. napsal(a):
> When saving GPIOs during suspend/resume we need skip missing GPIO banks, not
> trying get corresponding chip again and again in infinite loop.
> 
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
Note that there is in for-linus/samsung4 working version usign

 	for (gpio_nr = 0; gpio_nr < S3C_GPIO_END; gpio_nr++) {

but into linus kernel was introduced a bug by last commit.

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
> 
