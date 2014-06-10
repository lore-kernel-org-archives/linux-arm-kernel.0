From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 10 Jun 2014 16:46:06 +0200
Subject: [PATCH v3 6/6] ARM: EXYNOS: Refactoring to remove soc_is_exynos
 macros from exynos
In-Reply-To: <1399706419-13976-7-git-send-email-pankaj.dubey@samsung.com>
References: <1399706287-13919-1-git-send-email-y@samsung.com>
 <1399706419-13976-1-git-send-email-pankaj.dubey@samsung.com>
 <1399706419-13976-7-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <53971A2E.2010104@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 10.05.2014 09:20, Pankaj Dubey wrote:
> This patch enables chipid driver for ARCH_EXYNOS and refactors
> machine code as well as exynos cpufreq driver code for using
> chipid driver for identification of SoC ID and SoC rev.
> 
> This patch also updates DT binding information in exynos4 and
> exynos5 dtsi file. As to differentiate product id bit-mask we need
> separate compatible string for exynos4 and exynos5. Hoping this will
> be helpful in future as bit-mask and bit-shift bit may differ.
> Added binding information as well.

[snip]

> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index d0482c2..9d6ec84 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -20,13 +20,13 @@
>  #include <linux/smp.h>
>  #include <linux/io.h>
>  #include <linux/of_address.h>
> +#include <linux/exynos-soc.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/smp_plat.h>
>  #include <asm/smp_scu.h>
>  #include <asm/firmware.h>
>  
> -#include <plat/cpu.h>
>  #include <mach/map.h>
>  
>  #include "common.h"
> @@ -59,7 +59,8 @@ static void __init exynos_smp_prepare_sram(void)
>  
>  static inline void __iomem *cpu_boot_reg_base(void)
>  {
> -	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
> +	if (is_soc_id_compatible(EXYNOS4210) &&
> +			is_soc_rev_compatible(EXYNOS4210_REV_1_1))

Well, how is this any better than what is already there? When adding a
new SoC, you will likely have to add another series of "||"s or "&&"s
with specific SoC IDs, when using this kind of API. This is not the point.

For now, all those things can be replaced simply with
of_machine_is_compatible() (except checks for samsung_rev()), but in the
end they need to be properly abstracted. The goal is to be able to add
support for new SoC, which requires identical steps to perform certain
things as already supported SoCs, without explicitly stating this in
driver code.

E.g. Exynos5250 is already supported, while Exynos5251 shows up. Let's
say it has exactly the same secondary CPU boot-up method as Exynos5250,
but to enter suspend mode, the same steps as on Exynos5260 have to be
performed. With any kind of per-SoC check API, you will have to add
soc_is_exynos5251() or is_soc_id_compatible(EXYNOS5251) in CPU bring-up
code and low-level suspend code, even though all the functional code is
already there.

Best regards,
Tomasz
