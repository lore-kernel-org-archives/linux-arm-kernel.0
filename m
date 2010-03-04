From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 4 Mar 2010 23:21:15 +0000
Subject: [PATCH] Fix GPIOs bank H and J not being preserved during suspend
In-Reply-To: <1267599637-9283-1-git-send-email-chripell@fsfe.org>
References: <cabda6421003022258j51258c56w99b0e75d2d2b088c@mail.gmail.com>
	<1267599637-9283-1-git-send-email-chripell@fsfe.org>
Message-ID: <20100304232115.GB31126@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 03, 2010 at 08:00:37AM +0100, Christian Pellegrin wrote:
> This patch adds bank H and J GPIOs (present on S3C244X CPUs) to the list
> of registers that must be saved/resumed during suspend.
> 
> Signed-off-by: Christian Pellegrin <chripell@fsfe.org>
> ---
>  arch/arm/mach-s3c2410/include/mach/gpio-core.h |    5 +++++
>  arch/arm/plat-s3c/pm-gpio.c                    |    4 ++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2410/include/mach/gpio-core.h b/arch/arm/mach-s3c2410/include/mach/gpio-core.h
> index f8b879a..de9697c 100644
> --- a/arch/arm/mach-s3c2410/include/mach/gpio-core.h
> +++ b/arch/arm/mach-s3c2410/include/mach/gpio-core.h
> @@ -24,8 +24,13 @@ static inline struct s3c_gpio_chip *s3c_gpiolib_getchip(unsigned int pin)
>  {
>  	struct s3c_gpio_chip *chip;
>  
> +#ifdef CONFIG_CPU_S3C244X
> +	if (pin > S3C2410_GPJ(15))
> +		return NULL;
> +#else

Hmm, could we use the arch define for number of GPIOs here instead
of an ifdef?

  	if (pin > S3C2410_GPG(10))
>  		return NULL;
> +#endif
>  
>  	chip = &s3c24xx_gpios[pin/32];
>  	return (S3C2410_GPIO_OFFSET(pin) < chip->chip.ngpio) ? chip : NULL;
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
> -- 
> 1.5.6.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
