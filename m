From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Oct 2013 18:26:04 +0100
Subject: [RFC v3 PATCH 1/7] ARM: add support for kernel mode NEON in
 atomic context
In-Reply-To: <1381666503-23726-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
 <1381666503-23726-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20131015172604.GA4765@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 13, 2013 at 01:14:57PM +0100, Ard Biesheuvel wrote:
> diff --git a/arch/arm/include/asm/neon.h b/arch/arm/include/asm/neon.h
> index 8f730fe..800d85c 100644
> --- a/arch/arm/include/asm/neon.h
> +++ b/arch/arm/include/asm/neon.h
> @@ -8,10 +8,30 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/types.h>
> +#include <linux/hardirq.h>
> +#include <asm/fpstate.h>
>  #include <asm/hwcap.h>
>  
>  #define cpu_has_neon()		(!!(elf_hwcap & HWCAP_NEON))
>  
> +/*
> + * Avoid wasting stack space by making the size of the allocated area depend on
> + * whether we are currently running in process context. (If this is the case, we
> + * will use the normal preserve/restore mechanism, leaving the allocated stack
> + * space unused.)
> + */
> +#define __QREG_SIZE(num)	\
> +	((!in_interrupt()) ? 0 : (num) > 16 ? 256 : 16 * (((num) + 1) & ~1U))
> +
> +#define DEFINE_NEON_REGSTACK_PARTIAL(v, num)		\
> +	struct {					\
> +		struct vfp_partial_state regs;		\
> +		u8 qregs[__QREG_SIZE(num)];		\
> +	} v

Oh, interesting gcc feature. What does it generate?

-- 
Catalin
