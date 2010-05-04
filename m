From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 4 May 2010 08:01:11 +0100
Subject: [PATCH v2.6.34-rc2] s3c: Fix GPIOs bank H and J not being
	preserved during suspend on S3C24XX
In-Reply-To: <1269937386-7597-1-git-send-email-chripell@fsfe.org>
References: <1269937386-7597-1-git-send-email-chripell@fsfe.org>
Message-ID: <20100504070111.GC26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 30, 2010 at 10:23:06AM +0200, Christian Pellegrin wrote:
> With this patch the platform-specific define for the last defined GPIO
> on S3C machines is used instead of a hard-coded value (which is right
> only for the s3c2410). The gpio_nr being incremented by 1 too much (look
> for the gpio_nr++ in the for instruction) is fixed too although it
> doesn't make any trouble on current S3C implementations.
> 
> Signed-off-by: Christian Pellegrin <chripell@fsfe.org>
> ---
>  arch/arm/mach-s3c2410/include/mach/gpio-track.h |    2 +-
>  arch/arm/plat-samsung/pm-gpio.c                 |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2410/include/mach/gpio-track.h b/arch/arm/mach-s3c2410/include/mach/gpio-track.h
> index acb2591..6371eaa 100644
> --- a/arch/arm/mach-s3c2410/include/mach/gpio-track.h
> +++ b/arch/arm/mach-s3c2410/include/mach/gpio-track.h
> @@ -23,7 +23,7 @@ static inline struct s3c_gpio_chip *s3c_gpiolib_getchip(unsigned int pin)
>  {
>  	struct s3c_gpio_chip *chip;
>  
> -	if (pin > S3C2410_GPG(10))
> +	if (pin > S3C_GPIO_END)
>  		return NULL;
>  
>  	chip = &s3c24xx_gpios[pin/32];

This may get removed in the up-comming s3c2410_gpio fallout, so I'll
keep this in mind if it is needed. Series should be posted in the next
few days.

> diff --git a/arch/arm/plat-samsung/pm-gpio.c b/arch/arm/plat-samsung/pm-gpio.c
> index 69a4c7f..1aac746 100644
> --- a/arch/arm/plat-samsung/pm-gpio.c
> +++ b/arch/arm/plat-samsung/pm-gpio.c
> @@ -343,7 +343,7 @@ void s3c_pm_save_gpios(void)
>  			  ourchip->pm_save[2],
>  			  ourchip->pm_save[3]);
>  
> -		gpio_nr += ourchip->chip.ngpio;
> +		gpio_nr += ourchip->chip.ngpio - 1;
>  		gpio_nr += CONFIG_S3C_GPIO_SPACE;
>  	}
>  }

Hmm, think a better fix for this would be to remove the gpio_nr++ in
the for() loop.

could you send the gpio fix with the above change as a seperate patch
please?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
