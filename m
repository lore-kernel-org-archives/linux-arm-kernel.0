From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Jul 2014 10:49:26 +0100
Subject: [PATCH 2/2] arm: add early_ioremap support
In-Reply-To: <1404898792-4201-3-git-send-email-leif.lindholm@linaro.org>
References: <1404898792-4201-1-git-send-email-leif.lindholm@linaro.org>
 <1404898792-4201-3-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20140709094926.GP21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 10:39:52AM +0100, Leif Lindholm wrote:
> +config EARLY_IOREMAP
> +	depends on MMU
> +	bool "Provide early_ioremap() support for kernel initialization."
> +	select GENERIC_EARLY_IOREMAP

Nit: please order as bool, then depends, then select.

> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 8a16ee5..aa2621a 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -36,6 +36,7 @@
>  #include <asm/cpu.h>
>  #include <asm/cputype.h>
>  #include <asm/elf.h>
> +#include <asm/io.h>

Please always use linux/io.h in preference to asm/io.h.

> +static inline pmd_t * __init early_ioremap_pmd(unsigned long addr)
> +{
> +	unsigned int index = pgd_index(addr);
> +	pgd_t *pgd = cpu_get_pgd() + index;

What is the reasoning for using cpu_get_pgd() ?  Is there some specific
reason you want to read from the hardware register rather than using
the pgd_offset_k() macro here?

> +void __init
> +early_ioremap_shutdown(void)

Nit: should be a single line.

The rest of the patch looks fine, thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
