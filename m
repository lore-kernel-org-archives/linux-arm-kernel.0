From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 9 Jan 2012 10:41:30 +0900
Subject: [PATCH] ARM: EXYNOS: Fix build error which was from common.c and
 old cpu.c
In-Reply-To: <01a001ccce6d$d9f3ea60$8ddbbf20$%kim@samsung.com>
References: <01a001ccce6d$d9f3ea60$8ddbbf20$%kim@samsung.com>
Message-ID: <CAH9JG2Xxc=_rSp-vDfNp+V8hoYfQSQaJQy0nVXADsMXH-rUknw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/9/12, Kukjin Kim <kgene.kim@samsung.com> wrote:
> This fixes build error and wrong merge conflicts.
> arch/arm/mach-exynos/common.c: In function 'exynos4_gic_irq_fix_base':
> arch/arm/mach-exynos/common.c:393: error: dereferencing pointer to
> incomplete type
> arch/arm/mach-exynos/common.c:396: error: dereferencing pointer to
> incomplete type
>
> Following A and B have been created from different base and the build
> error was casued in the process of merging and should be fixed in this
> merge window.

Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

Do the same job. boot tested.
>
> A. commit db0d4db ("ARM: gic: allow GIC to support non-banked setups"),
>   commit 4e44d2c ("ARM: exynos4: convert to CONFIG_MULTI_IRQ_HANDLER")
>   and commit 69676c3 ("ARM: exynos4: Fix build error due to
>   'gic_bank_offset' undeclared")
>
> B. commit cc511b8 ("ARM: 7257/1: EXYNOS: introduce arch/arm/mach-exynos/
>   common.[ch]") introduced common.[ch]")
>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Axel Lin <axel.lin@gmail.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> Hi Russell,
>
> This should be fixed, I'm sending this to patch system.
> If you're ok with this, please pick it up for this merge window.
>
> Thanks.
>
>  arch/arm/mach-exynos/common.c |   20 +++-----------------
>  1 files changed, 3 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index b6ac6ee..647c843 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -19,6 +19,7 @@
>  #include <linux/serial_core.h>
>
>  #include <asm/proc-fns.h>
> +#include <asm/exception.h>
Not needed.
>  #include <asm/hardware/cache-l2x0.h>
>  #include <asm/hardware/gic.h>
>  #include <asm/mach/map.h>
> @@ -43,8 +44,6 @@
>
>  #include "common.h"
>
> -unsigned int gic_bank_offset __read_mostly;
> -
>  static const char name_exynos4210[] = "EXYNOS4210";
>  static const char name_exynos4212[] = "EXYNOS4212";
>  static const char name_exynos4412[] = "EXYNOS4412";
> @@ -386,27 +385,14 @@ static void __init combiner_init(unsigned int
> combiner_nr, void __iomem *base,
>  	}
>  }
>
> -static void exynos4_gic_irq_fix_base(struct irq_data *d)
> -{
> -	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
> -
> -	gic_data->cpu_base = S5P_VA_GIC_CPU +
> -			    (gic_bank_offset * smp_processor_id());
> -
> -	gic_data->dist_base = S5P_VA_GIC_DIST +
> -			    (gic_bank_offset * smp_processor_id());
> -}
> -
>  void __init exynos4_init_irq(void)
>  {
>  	int irq;
> +	unsigned int gic_bank_offset;
>
>  	gic_bank_offset = soc_is_exynos4412() ? 0x4000 : 0x8000;
>
> -	gic_init(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
> -	gic_arch_extn.irq_eoi = exynos4_gic_irq_fix_base;
> -	gic_arch_extn.irq_unmask = exynos4_gic_irq_fix_base;
> -	gic_arch_extn.irq_mask = exynos4_gic_irq_fix_base;
> +	gic_init_bases(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU,
> gic_bank_offset);
>
>  	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
