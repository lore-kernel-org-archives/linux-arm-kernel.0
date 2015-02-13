From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 13 Feb 2015 09:37:05 +0100
Subject: [PATCH 06/11] ARM: at91: fix pm declarations
In-Reply-To: <1423770163-583064-7-git-send-email-arnd@arndb.de>
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
 <1423770163-583064-7-git-send-email-arnd@arndb.de>
Message-ID: <54DDB7B1.2020800@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/02/2015 20:42, Arnd Bergmann a ?crit :
> In a recent rearrangement of the at91 pm initialization code, a broken
> set of declarations was added for the !CONFIG_PM-case, leading to
> this link error:
> 
> arch/arm/mach-at91/board-dt-sama5.o: In function `at91_rm9200_pm_init':
> arch/arm/mach-at91/generic.h:40: multiple definition of `at91_rm9200_pm_init'
> arch/arm/mach-at91/setup.o:arch/arm/mach-at91/generic.h:40: first defined here
> arch/arm/mach-at91/board-dt-sama5.o: In function `at91_sam9260_pm_init':
> arch/arm/mach-at91/generic.h:41: multiple definition of `at91_sam9260_pm_init'
> arch/arm/mach-at91/setup.o:arch/arm/mach-at91/generic.h:41: first defined here
> arch/arm/mach-at91/board-dt-sama5.o: In function `at91_sam9g45_pm_init':
> arch/arm/mach-at91/generic.h:42: multiple definition of `at91_sam9g45_pm_init'
> arch/arm/mach-at91/setup.o:arch/arm/mach-at91/generic.h:42: first defined here
> 
> This adds the missing 'static inline' to the declarations to avoid
> creating a copy of the functions in each file that includes the
> header.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 4db0ba22da9 ("ARM: at91: pm: prepare for multiplatform")
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Yes:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks Arnd. Bye,

> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/mach-at91/generic.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
> index a6e726a6e0b5..583369ffc284 100644
> --- a/arch/arm/mach-at91/generic.h
> +++ b/arch/arm/mach-at91/generic.h
> @@ -35,10 +35,10 @@ extern void __init at91sam9260_pm_init(void);
>  extern void __init at91sam9g45_pm_init(void);
>  extern void __init at91sam9x5_pm_init(void);
>  #else
> -void __init at91rm9200_pm_init(void) { }
> -void __init at91sam9260_pm_init(void) { }
> -void __init at91sam9g45_pm_init(void) { }
> -void __init at91sam9x5_pm_init(void) { }
> +static inline void __init at91rm9200_pm_init(void) { }
> +static inline void __init at91sam9260_pm_init(void) { }
> +static inline void __init at91sam9g45_pm_init(void) { }
> +static inline void __init at91sam9x5_pm_init(void) { }
>  #endif
>  
>  #endif /* _AT91_GENERIC_H */
> 


-- 
Nicolas Ferre
