From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 12 Aug 2012 00:11:33 -0400 (EDT)
Subject: [PATCH v2 11/22] ARM: LPAE: use 64-bit accessors for TTBR
 registers
In-Reply-To: <1344648306-15619-12-git-send-email-cyril@ti.com>
References: <1344648306-15619-1-git-send-email-cyril@ti.com>
 <1344648306-15619-12-git-send-email-cyril@ti.com>
Message-ID: <alpine.LFD.2.02.1208120008380.5231@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Aug 2012, Cyril Chemparathy wrote:

> This patch adds TTBR accessor macros, and modifies cpu_get_pgd() and
> the LPAE version of cpu_set_reserved_ttbr0() to use these instead.
> 
> In the process, we also fix these functions to correctly handle cases
> where the physical address lies beyond the 4G limit of 32-bit addressing.
> 
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> ---
>  arch/arm/include/asm/proc-fns.h |   24 +++++++++++++++++++-----
>  arch/arm/mm/context.c           |    9 ++-------
>  2 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
> index 75b5f14..24224df 100644
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
> +			: : "cc");				\
> +		ttbr;						\
> +	})

I don't think you have to clobber the condition code (cc) here.  It has 
been a long while since the ability to pass a condition code inside an 
inline assembly statement was removed from gcc.

Other that that...

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
