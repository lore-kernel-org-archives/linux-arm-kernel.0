From: will.deacon@arm.com (Will Deacon)
Date: Wed, 22 Jan 2014 17:31:17 +0000
Subject: [PATCH 1/6] arm64: Add macros to manage processor debug state
In-Reply-To: <1390401773-12100-2-git-send-email-vijay.kilari@gmail.com>
References: <1390401773-12100-1-git-send-email-vijay.kilari@gmail.com>
 <1390401773-12100-2-git-send-email-vijay.kilari@gmail.com>
Message-ID: <20140122173117.GJ14108@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jan 22, 2014 at 02:42:48PM +0000, vijay.kilari at gmail.com wrote:
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
>  arch/arm64/include/asm/debug-monitors.h |   18 ++----------------
>  arch/arm64/include/asm/irqflags.h       |   22 ++++++++++++++++++++++
>  arch/arm64/kernel/debug-monitors.c      |    3 ++-
>  3 files changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
> index 6231479..bc48880 100644
> --- a/arch/arm64/include/asm/debug-monitors.h
> +++ b/arch/arm64/include/asm/debug-monitors.h
> @@ -43,22 +43,8 @@ enum debug_el {
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
> +#define local_dbg_enable()	asm("msr	daifclr, #8" : : : "memory")
> +#define local_dbg_disable()	asm("msr	daifset, #8" : : : "memory")

Any reason not to move these to irqflags.h too?

>  #define DBG_ARCH_ID_RESERVED	0	/* In case of ptrace ABI updates. */
>  
> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index b2fcfbc..f163b11 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -90,5 +90,27 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
>  	return flags & PSR_I_BIT;
>  }
>  
> +/*
> + * save and restore debug state
> + */
> +static inline unsigned long local_dbg_save(void)
> +{
> +	unsigned long flags;
> +	asm volatile(
> +		"mrs	%0, daif		// local_dbg_save"
> +		"msr	daifset, #8"
> +		: "=r" (flags) : : "memory");
> +	return flags;
> +}
> +
> +static inline void local_dbg_restore(unsigned long flags)
> +{
> +	asm volatile(
> +		"msr	daif, %0	// local_dbg_restore"
> +		:
> +		: "r" (flags)
> +		: "memory");
> +}
> +
>  #endif
>  #endif
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index 23586bd..774ad04 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -51,7 +51,7 @@ u8 debug_monitors_arch(void)
>  static void mdscr_write(u32 mdscr)
>  {
>  	unsigned long flags;
> -	local_dbg_save(flags);
> +	flags = local_dbg_save();

Why are you changing the API? This is now pointlessly different to irqs.

Will
