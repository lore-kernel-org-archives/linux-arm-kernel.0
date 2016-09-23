From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 23 Sep 2016 14:17:30 +0100
Subject: [PATCH v6 3/4] arm64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <1474533318-7796-3-git-send-email-oss@buserror.net>
References: <1474533318-7796-1-git-send-email-oss@buserror.net>
 <1474533318-7796-3-git-send-email-oss@buserror.net>
Message-ID: <57E52B6A.5070909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/09/16 09:35, Scott Wood wrote:
> Erratum A-008585 says that the ARM generic timer counter "has the
> potential to contain an erroneous value for a small number of core
> clock cycles every time the timer value changes".  Accesses to TVAL
> (both read and write) are also affected due to the implicit counter
> read.  Accesses to CVAL are not affected.
> 
> The workaround is to reread TVAL and count registers until successive
> reads return the same value.  Writes to TVAL are replaced with an
> equivalent write to CVAL.
> 
> The workaround is to reread TVAL and count registers until successive reads
> return the same value, and when writing TVAL to retry until counter
> reads before and after the write return the same value.
> 
> The workaround is enabled if the fsl,erratum-a008585 property is found in
> the timer node in the device tree.  This can be overridden with the
> clocksource.arm_arch_timer.fsl-a008585 boot parameter, which allows KVM
> users to enable the workaround until a mechanism is implemented to
> automatically communicate this information.
> 
> This erratum can be found on LS1043A and LS2080A.
> 
> Signed-off-by: Scott Wood <oss@buserror.net>
> ---
> v6:
> - Addressed feedback from Mark Rutland
> 
> v5:
> - Export arch_timer_read_ool_enabled so that get_cycles() can be called
>   from modules.
> 
> v4:
> - Undef ARCH_TIMER_REG_READ after use
> 
> v3:
> - Used cval rather than a loop for the write side of the erratum
> - Added a Kconfig control
> - Moved the device tree binding into its own patch
> - Added erratum to silicon-errata.txt
> - Changed function names to contain the erratum name
> - Factored out the setting of erratum versions of set_next_event
>   to improve readability
> - Added a comment clarifying that the timeout is arbitrary
> 
> v2:
> Significant rework based on feedback, including using static_key,
> disabling VDSO counter access rather than adding the workaround to the
> VDSO, and uninlining the loops.
> 
> Dropped the separate property for indicating that writes to TVAL are
> affected, as I believe that's just a side effect of the implicit
> counter read being corrupted, and thus a chip that is affected by one
> will always be affected by the other.
> 
> Dropped the arm32 portion as it seems there was confusion about whether
> LS1021A is affected.  Currently I am being told that it is not
> affected.
> 
> I considered writing to CVAL rather than looping on TVAL writes, but
> that would still have required separate set_next_event() code for the
> erratum, and adding CVAL to the enum would have required a bunch of
> extra handlers in switch statements (even where unused, due to compiler
> warnings about unhandled enum values) including in an arm32 header.  It
> seemed better to avoid the arm32 interaction and new untested
> accessors.
> 
> Signed-off-by: Scott Wood <oss@buserror.net>
> ---
>  Documentation/arm64/silicon-errata.txt |   2 +
>  Documentation/kernel-parameters.txt    |   9 +++
>  arch/arm64/include/asm/arch_timer.h    |  47 ++++++++++++++-
>  drivers/clocksource/Kconfig            |  10 ++++
>  drivers/clocksource/arm_arch_timer.c   | 104 +++++++++++++++++++++++++++++++++
>  5 files changed, 169 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> index 4da60b4..041e3a9 100644
> --- a/Documentation/arm64/silicon-errata.txt
> +++ b/Documentation/arm64/silicon-errata.txt
> @@ -60,3 +60,5 @@ stable kernels.
>  | Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154    |
>  | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456    |
>  | Cavium         | ThunderX SMMUv2 | #27704          | N/A		       |
> +|                |                 |                 |                         |
> +| Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585     |
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 46c030a..fb4de4d 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -698,6 +698,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  			loops can be debugged more effectively on production
>  			systems.
>  
> +	clocksource.arm_arch_timer.fsl-a008585=
> +			[ARM64]
> +			Format: <bool>
> +			Enable/disable the workaround of Freescale/NXP
> +			erratum A-008585.  This can be useful for KVM
> +			guests, if the guest device tree doesn't show the
> +			erratum.  If unspecified, the workaround is
> +			enabled based on the device tree.
> +
>  	clearcpuid=BITNUM [X86]
>  			Disable CPUID feature X for the kernel. See
>  			arch/x86/include/asm/cpufeatures.h for the valid bit
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index 7ff386c..cddd5b7 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -24,10 +24,51 @@
>  
>  #include <linux/bug.h>
>  #include <linux/init.h>
> +#include <linux/jump_label.h>
>  #include <linux/types.h>
>  
>  #include <clocksource/arm_arch_timer.h>
>  
> +#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585)
> +extern struct static_key_false arch_timer_read_ool_enabled;
> +#define needs_fsl_a008585_workaround() \
> +	static_branch_unlikely(&arch_timer_read_ool_enabled)
> +#else
> +#define needs_fsl_a008585_workaround()  false
> +#endif
> +
> +u32 __fsl_a008585_read_cntp_tval_el0(void);
> +u32 __fsl_a008585_read_cntv_tval_el0(void);
> +u64 __fsl_a008585_read_cntvct_el0(void);
> +
> +/*
> + * The number of retries is an arbitrary value well beyond the highest number
> + * of iterations the loop has been observed to take.
> + */
> +#define __fsl_a008585_read_reg(reg) ({			\
> +	u64 _old, _new;					\
> +	int _retries = 200;				\
> +							\
> +	do {						\
> +		_old = read_sysreg(reg);		\
> +		_new = read_sysreg(reg);		\
> +		_retries--;				\
> +	} while (unlikely(_old != _new) && _retries);	\
> +							\
> +	WARN_ON_ONCE(!_retries);			\
> +	_new;						\
> +})
> +
> +#define arch_timer_unstable_reg_read(reg) 		\

I think this name is the only thing I don't like about this patch,
because it is only unstable if the workaround is on. This is a minor
thing and it can be addressed when/after merging it. No need to respin
it on this account.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

The usual question is "Who takes it?". I'm quite keen on it, as my
LS2085 is otherwise completely unusable.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
