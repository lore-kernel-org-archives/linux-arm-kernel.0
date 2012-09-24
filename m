From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Sep 2012 15:10:24 +0100
Subject: [PATCH v3 RESEND 11/17] ARM: LPAE: use 64-bit accessors for
 TTBR registers
In-Reply-To: <1348242975-19184-12-git-send-email-cyril@ti.com>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-12-git-send-email-cyril@ti.com>
Message-ID: <20120924141023.GG23298@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 04:56:09PM +0100, Cyril Chemparathy wrote:
> This patch adds TTBR accessor macros, and modifies cpu_get_pgd() and
> the LPAE version of cpu_set_reserved_ttbr0() to use these instead.
> 
> In the process, we also fix these functions to correctly handle cases
> where the physical address lies beyond the 4G limit of 32-bit addressing.
> 
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm/include/asm/proc-fns.h |   24 +++++++++++++++++++-----
>  arch/arm/mm/context.c           |    9 ++-------
>  2 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
> index 75b5f14..2d270b8 100644
> --- a/arch/arm/include/asm/proc-fns.h
> +++ b/arch/arm/include/asm/proc-fns.h
> @@ -116,13 +116,27 @@ extern void cpu_resume(void);
>  #define cpu_switch_mm(pgd,mm) cpu_do_switch_mm(virt_to_phys(pgd),mm)
>  
>  #ifdef CONFIG_ARM_LPAE
> +
> +#define cpu_get_ttbr(nr)					\
> +	({							\
> +		u64 ttbr;					\
> +		__asm__("mrrc	p15, " #nr ", %Q0, %R0, c2"	\
> +			: "=r" (ttbr)				\
> +			: : );					\

Minor nit, we don't need the extra  : : (it makes the macro shorter by
one line).

> +		ttbr;						\
> +	})
> +
> +#define cpu_set_ttbr(nr, val)					\
> +	do {							\
> +		u64 ttbr = val;					\
> +		__asm__("mcrr	p15, " #nr ", %Q0, %R0, c2"	\
> +			: : "r" (ttbr)				\
> +			: "cc");				\

Do we need the "cc" here? I know it was there before but the instruction
does not affect the condition flags.

It looks fine otherwise.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
