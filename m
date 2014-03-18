From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 18 Mar 2014 16:27:37 +0800
Subject: [PATCH] ARM: cache-tauros2: remove ARMv6 code
In-Reply-To: <1589565.fmu2VlFkhj@wuerfel>
References: <1589565.fmu2VlFkhj@wuerfel>
Message-ID: <CAN1soZz6-+s4bKbCJFXQResa07Ub9s1qfRrf2nDLC8eFVQEDsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 2:51 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> When building a kernel with support for both ARMv6 and ARMv7 but
> no MMU, the call from tauros2_internal_init to adjust_cr causes
> a link error. While that could probably be resolved, we don't
> actually support cache-tauros2 on ARMv6 any more. All PJ4 CPU
> implementations support both ARMv6 and ARMv7 and we already assume
> that we are using them only in ARMv7 mode.
>
> Removing the ARMv6 code path reduces the code size and avoids
> the linker error.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>
>
> diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
> index 1be0f4e..7964ef2 100644
> --- a/arch/arm/mm/cache-tauros2.c
> +++ b/arch/arm/mm/cache-tauros2.c
> @@ -229,33 +229,6 @@ static void __init tauros2_internal_init(unsigned int features)
>         }
>  #endif
>
> -#ifdef CONFIG_CPU_32v6
> -       /*
> -        * Check whether this CPU lacks support for the v7 hierarchical
> -        * cache ops.  (PJ4 is in its v6 personality mode if the MMFR3
> -        * register indicates no support for the v7 hierarchical cache
> -        * ops.)
> -        */
> -       if (cpuid_scheme() && (read_mmfr3() & 0xf) == 0) {
> -               /*
> -                * When Tauros2 is used in an ARMv6 system, the L2
> -                * enable bit is in the ARMv6 ARM-mandated position
> -                * (bit [26] of the System Control Register).
> -                */
> -               if (!(get_cr() & 0x04000000)) {
> -                       printk(KERN_INFO "Tauros2: Enabling L2 cache.\n");
> -                       adjust_cr(0x04000000, 0x04000000);
> -               }
> -
> -               mode = "ARMv6";
> -               outer_cache.inv_range = tauros2_inv_range;
> -               outer_cache.clean_range = tauros2_clean_range;
> -               outer_cache.flush_range = tauros2_flush_range;
> -               outer_cache.disable = tauros2_disable;
> -               outer_cache.resume = tauros2_resume;
> -       }
> -#endif
> -
>  #ifdef CONFIG_CPU_32v7
>         /*
>          * Check whether this CPU has support for the v7 hierarchical
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
