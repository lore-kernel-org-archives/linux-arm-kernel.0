From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 19 May 2015 02:18:53 +0900
Subject: [PATCH] ARM: uniphier: only select TWD for SMP
In-Reply-To: <2227073.rylFc5jIqu@wuerfel>
References: <2227073.rylFc5jIqu@wuerfel>
Message-ID: <CAK7LNATdibWyVuMMyw2h5MMVJFdEu4TWrDoGpGC9cPj068FXiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2015-05-19 0:55 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> This makes uniphier behave like all the other platforms that
> support TWD, and only select this driver when SMP is enabled.
> Without this, we get a compile error on UP builds:
>
> arch/arm/kernel/smp_twd.c: In function 'twd_local_timer_of_register':
> arch/arm/kernel/smp_twd.c:391:20: error: 'setup_max_cpus' undeclared (first use in this function)
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I'd like to apply this directly to the next/soc branch
>
> diff --git a/arch/arm/mach-uniphier/Kconfig b/arch/arm/mach-uniphier/Kconfig
> index a017b1dd9c78..b640458fd757 100644
> --- a/arch/arm/mach-uniphier/Kconfig
> +++ b/arch/arm/mach-uniphier/Kconfig
> @@ -5,7 +5,7 @@ config ARCH_UNIPHIER
>         select ARM_GLOBAL_TIMER
>         select ARM_GIC
>         select HAVE_ARM_SCU
> -       select HAVE_ARM_TWD
> +       select HAVE_ARM_TWD if SMP
>         help
>           Support for UniPhier SoC family developed by Socionext Inc.
>           (formerly, System LSI Business Division of Panasonic Corporation)



I am not familiar with smp_twd.c, but I think
the local timer and watchdog still exist in the ARM mpcore
even if it is a uni-processor implementation.

That is why I simply selected HAVE_ARM_TWD.
Am I doing something wrong?



Is it reasonable to have something depends on HAVE_ARM_TWD?


config SMP_ARM_TWD
      depends on SMP && HAVE_ARM_TWD



obj-$(SMP_ARM_TWD)       +=   smp_twd.o



I am not sure...


-- 
Best Regards
Masahiro Yamada
