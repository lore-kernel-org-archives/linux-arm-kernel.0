From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 8 Mar 2010 15:55:22 +0000
Subject: [PATCH v2] Fix GPIOs bank H and J not being preserved during
	suspend
In-Reply-To: <1268047288-11166-1-git-send-email-chripell@fsfe.org>
References: <cabda6421003080317t37124990v72ac56906719c091@mail.gmail.com>
	<1268047288-11166-1-git-send-email-chripell@fsfe.org>
Message-ID: <20100308155522.GE24864@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 08, 2010 at 12:21:28PM +0100, Christian Pellegrin wrote:
> This patch adds bank H and J GPIOs (present on S3C244X CPUs) to the list
> of registers that must be saved/resumed during suspend.
> 
> Signed-off-by: Christian Pellegrin <chripell@fsfe.org>
> ---
>  arch/arm/mach-s3c2410/include/mach/gpio-core.h |    2 +-
>  arch/arm/plat-s3c/pm-gpio.c                    |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2410/include/mach/gpio-core.h b/arch/arm/mach-s3c2410/include/mach/gpio-core.h
> index f8b879a..7c33ecf 100644
> --- a/arch/arm/mach-s3c2410/include/mach/gpio-core.h
> +++ b/arch/arm/mach-s3c2410/include/mach/gpio-core.h
> @@ -24,7 +24,7 @@ static inline struct s3c_gpio_chip *s3c_gpiolib_getchip(unsigned int pin)
>  {
>  	struct s3c_gpio_chip *chip;
>  
> -	if (pin > S3C2410_GPG(10))
> +	if (pin > S3C_GPIO_END)
>  		return NULL;
>  
>  	chip = &s3c24xx_gpios[pin/32];
> diff --git a/arch/arm/plat-s3c/pm-gpio.c b/arch/arm/plat-s3c/pm-gpio.c
> index cfd326a..b3cc8db 100644
> --- a/arch/arm/plat-s3c/pm-gpio.c
> +++ b/arch/arm/plat-s3c/pm-gpio.c
> @@ -343,7 +343,7 @@ void s3c_pm_save_gpios(void)
>  			  ourchip->pm_save[2],
>  			  ourchip->pm_save[3]);
>  
> -		gpio_nr += ourchip->chip.ngpio;
> +		gpio_nr += ourchip->chip.ngpio - 1;
>  		gpio_nr += CONFIG_S3C_GPIO_SPACE;
>  	}
>  }
> @@ -374,7 +374,7 @@ void s3c_pm_restore_gpios(void)
>  
>  		s3c_pm_resume_gpio(ourchip);
>  
> -		gpio_nr += ourchip->chip.ngpio;
> +		gpio_nr += ourchip->chip.ngpio - 1;
>  		gpio_nr += CONFIG_S3C_GPIO_SPACE;
>  	}
>  }

Still not getting why you're changing this from x, to x - 1.

> 1.5.6.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
