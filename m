From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Oct 2013 18:14:46 +0100
Subject: [RFC v2 PATCH 2/4] ARM64: add support for kernel mode NEON in
 atomic context
In-Reply-To: <1381344634-14917-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1381344634-14917-1-git-send-email-ard.biesheuvel@linaro.org>
 <1381344634-14917-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20131011171446.GA18859@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 09, 2013 at 07:50:32PM +0100, Ard Biesheuvel wrote:
> --- a/arch/arm64/include/asm/neon.h
> +++ b/arch/arm64/include/asm/neon.h
> @@ -8,7 +8,38 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/hardirq.h>
> +#include <linux/types.h>
> +#include <asm/fpsimd.h>
> +
>  #define cpu_has_neon()		(1)
>  
> +#define DEFINE_NEON_STACK_REGS(a, num)					\
> +	struct {							\
> +		struct fpsimd_partial_state regs;			\
> +		__uint128_t vregs[(num) > 32 ? 32 : ((num) + 1) & ~1U];	\
> +	} a = { .regs.num_regs = sizeof(a.vregs) / sizeof(__uint128_t) }
> +
> +#define DEFINE_NEON_STACK_REGS_ALL(name)	DEFINE_NEON_STACK_REGS(name, 32)
> +
>  void kernel_neon_begin(void);
>  void kernel_neon_end(void);
> +
> +static inline void __kernel_neon_begin_atomic(struct fpsimd_partial_state *regs)
> +{
> +	if (!in_interrupt())
> +		kernel_neon_begin();
> +	else
> +		fpsimd_save_partial_state(regs);
> +}
> +
> +static inline void __kernel_neon_end_atomic(struct fpsimd_partial_state *regs)
> +{
> +	if (!in_interrupt())
> +		kernel_neon_end();
> +	else
> +		fpsimd_load_partial_state(regs);
> +}

The _atomic suffix is a bit misleading (you basically mean no user
context). I wonder whether it's better to have some _fast/_slow variants
instead. Looking at the other two patches, you only need 2 or 4
registers to do the crypto stuff but if you are not in_interrupt(), you
basically save and restore the full NEON bank. I would say for such
cases just make kernel_neon_begin_fast() call which is safe in all
contexts and much faster.

-- 
Catalin
