From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 9 Jan 2018 09:56:19 +0000
Subject: [PATCH v2 2/6] arm: Invalidate BTB on prefetch abort outside of
 user mapping on Cortex A8, A9, A12 and A17
In-Reply-To: <20180108185533.9698-3-marc.zyngier@arm.com>
References: <20180108185533.9698-1-marc.zyngier@arm.com>
 <20180108185533.9698-3-marc.zyngier@arm.com>
Message-ID: <95be85f8-7960-d8de-6295-f3ae183446eb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/18 18:55, Marc Zyngier wrote:
> In order to prevent aliasing attacks on the branch predictor,
> invalidate the BTB on CPUs that are known to be affected when taking
> a prefetch abort on a address that is outside of a user task limit.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/cp15.h |  2 ++
>  arch/arm/mm/fault.c         | 19 +++++++++++++
>  arch/arm/mm/fsr-2level.c    |  4 +--
>  arch/arm/mm/fsr-3level.c    | 67 ++++++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 89 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
> index 4c9fa72b59f5..9e900ae855aa 100644
> --- a/arch/arm/include/asm/cp15.h
> +++ b/arch/arm/include/asm/cp15.h
> @@ -65,6 +65,8 @@
>  #define __write_sysreg(v, r, w, c, t)	asm volatile(w " " c : : "r" ((t)(v)))
>  #define write_sysreg(v, ...)		__write_sysreg(v, __VA_ARGS__)
>  
> +#define BPIALL				__ACCESS_CP15(c7, 0, c5, 6)
> +
>  extern unsigned long cr_alignment;	/* defined in entry-armv.S */
>  
>  static inline unsigned long get_cr(void)
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 42f585379e19..ff272ffcf741 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -21,6 +21,7 @@
>  #include <linux/highmem.h>
>  #include <linux/perf_event.h>
>  
> +#include <asm/cp15.h>
>  #include <asm/exception.h>
>  #include <asm/pgtable.h>
>  #include <asm/system_misc.h>
> @@ -181,6 +182,7 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
>  	si.si_errno = 0;
>  	si.si_code = code;
>  	si.si_addr = (void __user *)addr;
> +
>  	force_sig_info(sig, &si, tsk);
>  }
>  
> @@ -404,6 +406,23 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  }
>  #endif					/* CONFIG_MMU */
>  
> +static int
> +do_pabt_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
> +{
> +	if (addr > TASK_SIZE) {
> +		switch(read_cpuid_part()) {
> +		case ARM_CPU_PART_CORTEX_A8:
> +		case ARM_CPU_PART_CORTEX_A9:
> +		case ARM_CPU_PART_CORTEX_A12:
> +		case ARM_CPU_PART_CORTEX_A17:
> +			write_sysreg(0, BPIALL);
> +			break;
> +		}
> +	}
> +
> +	return do_page_fault(addr, fsr, regs);
> +}

For the record, this breaks !MMU. I've fixed it locally by moving this
function inside the CONFIG_MMU part, and provided a dummy stub for !MMU.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
