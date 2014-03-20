From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Mar 2014 13:19:19 +0900
Subject: [PATCH 57/62] ARM: exynos: fix l2x0 saved regs handling
In-Reply-To: <1395257399-359545-58-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-58-git-send-email-arnd@arndb.de>
Message-ID: <024901cf43f3$906b51a0$b141f4e0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> The exynos4_l2x0_cache_init function tries to flush the data cache
> for the location of the saved l2x0 registers and pass the physical
> address to the s5p-sleep implementation.
> 
> However, the s5p-sleep code is optional, and if it is disabled,
> we get a linker error here when the l2x0_regs_phys variable does
> not exist.
> 
> To solve this, use a compile-time conditional to drop this code
> if we don't want it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks,
Kukjin

> Cc: Ben Dooks <ben-linux@fluff.org>
> ---
>  arch/arm/mach-exynos/common.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index 025fd82..b2f9bb0 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -404,8 +404,10 @@ static int __init exynos4_l2x0_cache_init(void)
>  	if (ret)
>  		return ret;
> 
> -	l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);
> -	clean_dcache_area(&l2x0_regs_phys, sizeof(unsigned long));
> +	if (IS_ENABLED(CONFIG_S5P_SLEEP)) {
> +		l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);
> +		clean_dcache_area(&l2x0_regs_phys, sizeof(unsigned long));
> +	}
>  	return 0;
>  }
>  early_initcall(exynos4_l2x0_cache_init);
> --
> 1.8.3.2
