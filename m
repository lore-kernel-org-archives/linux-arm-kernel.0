From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Jan 2014 16:39:20 +0000
Subject: [PATCH 1/6] arm64: Add macros to manage processor debug state
In-Reply-To: <1390490948-25386-1-git-send-email-vijay.kilari@gmail.com>
References: <1390490948-25386-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <20140124163920.GI31040@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Jan 23, 2014 at 03:29:07PM +0000, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
> 
> Add macros to enable and disable to manage PSTATE.D
> for debugging. The macros local_dbg_save and local_dbg_restore
> are moved to irqflags.h file
> 
> KGDB boot tests fail because of PSTATE.D is masked.
> unmask it for debugging support
> 
> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
> ---
>  arch/arm64/include/asm/debug-monitors.h |   17 -----------
>  arch/arm64/include/asm/irqflags.h       |   48 +++++++++++++++++++++++++++++++
>  arch/arm64/kernel/debug-monitors.c      |    1 +
>  3 files changed, 49 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
> index 6231479..ee9f28e 100644
> --- a/arch/arm64/include/asm/debug-monitors.h
> +++ b/arch/arm64/include/asm/debug-monitors.h
> @@ -43,23 +43,6 @@ enum debug_el {
>  #ifndef __ASSEMBLY__
>  struct task_struct;
>  
> -#define local_dbg_save(flags)							\
> -	do {									\
> -		typecheck(unsigned long, flags);				\
> -		asm volatile(							\
> -		"mrs	%0, daif			// local_dbg_save\n"	\
> -		"msr	daifset, #8"						\
> -		: "=r" (flags) : : "memory");					\
> -	} while (0)
> -
> -#define local_dbg_restore(flags)						\
> -	do {									\
> -		typecheck(unsigned long, flags);				\
> -		asm volatile(							\
> -		"msr	daif, %0			// local_dbg_restore\n"	\
> -		: : "r" (flags) : "memory");					\
> -	} while (0)
> -
>  #define DBG_ARCH_ID_RESERVED	0	/* In case of ptrace ABI updates. */
>  
>  #define DBG_HOOK_HANDLED	0
> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index b2fcfbc..f9b013e 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -90,5 +90,53 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
>  	return flags & PSR_I_BIT;
>  }
>  
> +/*
> + * save and restore debug state
> + */
> +static inline unsigned long arch_local_dbg_save(void)
> +{
> +	unsigned long flags;
> +	asm volatile(
> +		"mrs	%0, daif	// arch_local_dbg_save"
> +		"msr	daifset, #8"
> +		: "=r" (flags) : : "memory");
> +	return flags;
> +}
> +
> +static inline void arch_local_dbg_restore(unsigned long flags)
> +{
> +	asm volatile(
> +		"msr	daif, %0	// arch_local_dbg_restore"
> +		:
> +		: "r" (flags)
> +		: "memory");
> +}
> +
> +#define raw_local_dbg_save(flags)			\
> +	do {						\
> +		typecheck(unsigned long, flags);	\
> +		flags = arch_local_dbg_save();		\
> +	} while (0)
> +
> +#define raw_local_dbg_restore(flags)			\
> +	do {						\
> +		typecheck(unsigned long, flags);	\
> +		arch_local_dbg_restore(flags);		\
> +	} while (0)
> +
> +#define local_dbg_save(flags)				\
> +	do {						\
> +		raw_local_dbg_save(flags);		\
> +	} while (0)
> +
> +#define local_dbg_restore(flags)			\
> +	do {						\
> +		typecheck(unsigned long, flags);	\
> +		raw_local_dbg_restore(flags);		\
> +	} while (0)

Hehe, I think you took me a bit too literally when I said to follow what we
do for irqs. This code is arm64-specific, so you don't need to construct it
in the same way. All you need to do is *move* the existing code from
debug-monitors.h to irqflags.h. That's it!

> +#define local_dbg_enable()	asm("msr	daifclr, #8" : : : "memory")
> +#define local_dbg_disable()	asm("msr	daifset, #8" : : : "memory")

I'm also fine with adding these two.

Will
