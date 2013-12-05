From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Dec 2013 04:43:21 +0100
Subject: [RFC part3 PATCH 1/2] clocksource / arch_timer: Use ACPI GTDT
 table to initialize arch timer
In-Reply-To: <1386088891-2917-2-git-send-email-hanjun.guo@linaro.org>
References: <1386088891-2917-1-git-send-email-hanjun.guo@linaro.org>
 <1386088891-2917-2-git-send-email-hanjun.guo@linaro.org>
Message-ID: <201312050443.21858.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 December 2013, Hanjun Guo wrote:

> +#ifdef CONFIG_ACPI
> +void __init arch_timer_acpi_init(void)
> +{
...
> +}
> +#else
> +void __init arch_timer_acpi_init(void) { return; };
> +#endif
>  

The #else clause is broken in combination with 

> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
> index 6d26b40..2654edf 100644
> --- a/include/clocksource/arm_arch_timer.h
> +++ b/include/clocksource/arm_arch_timer.h
> @@ -66,6 +66,11 @@ static inline struct timecounter *arch_timer_get_timecounter(void)
>  	return NULL;
>  }
>  
> +static inline void arch_timer_acpi_init(void)
> +{
> +	return;
> +}
> +
>  #endif
>  

this inline function. Have you build-tested this with CONFIG_ACPI disabled?

	Arnd
