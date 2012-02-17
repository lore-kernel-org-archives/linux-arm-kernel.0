From: rmallon@gmail.com (Ryan Mallon)
Date: Fri, 17 Feb 2012 11:28:29 +1100
Subject: [PATCH 1/5] ARM: protect usage of cr_alignment by #ifdef
 CONFIG_CPU_CP15
In-Reply-To: <1329423490-15580-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20120216200143.GS14173@pengutronix.de>
 <1329423490-15580-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <4F3D9F2D.2090209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/02/12 07:18, Uwe Kleine-K?nig wrote:

> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/include/asm/system.h |    2 ++
>  arch/arm/kernel/entry-armv.S  |    4 ++++
>  arch/arm/kernel/head-common.S |   10 ++++++++--
>  arch/arm/kernel/setup.c       |    8 ++++++--
>  arch/arm/mm/alignment.c       |    6 ++++++
>  arch/arm/mm/mmu.c             |    8 +++++++-
>  6 files changed, 33 insertions(+), 5 deletions(-)

Hi Uwe,

Couple of points below,

Thanks,
~Ryan

> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> index e4c96cc..de46477 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -185,6 +185,7 @@ extern unsigned int user_debug;
>  #define set_mb(var, value)	do { var = value; smp_mb(); } while (0)
>  #define nop() __asm__ __volatile__("mov\tr0,r0\t@ nop\n\t");
>  
> +#ifdef CONFIG_CPU_CP15
>  extern unsigned long cr_no_alignment;	/* defined in entry-armv.S */
>  extern unsigned long cr_alignment;	/* defined in entry-armv.S */
>  
> @@ -224,6 +225,7 @@ static inline void set_copro_access(unsigned int val)
>  	  : : "r" (val) : "cc");
>  	isb();
>  }
> +#endif
>  
>  /*
>   * switch_mm() may do a full cache flush over the context switch,
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index be16a48..a6f2ef5 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -314,8 +314,10 @@ __pabt_svc:
>  ENDPROC(__pabt_svc)
>  
>  	.align	5
> +#ifdef CONFIG_CPU_CP15
>  .LCcralign:
>  	.word	cr_alignment
> +#endif
>  #ifdef MULTI_DABORT
>  .LCprocfns:
>  	.word	processor
> @@ -1146,12 +1148,14 @@ __vectors_end:
>  
>  	.data
>  
> +#ifdef CONFIG_CPU_CP15
>  	.globl	cr_alignment
>  	.globl	cr_no_alignment
>  cr_alignment:
>  	.space	4
>  cr_no_alignment:
>  	.space	4
> +#endif
>  
>  #ifdef CONFIG_MULTI_IRQ_HANDLER
>  	.globl	handle_arch_irq
> diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
> index 854bd22..5ca01bb 100644
> --- a/arch/arm/kernel/head-common.S
> +++ b/arch/arm/kernel/head-common.S
> @@ -98,8 +98,10 @@ __mmap_switched:
>  	str	r9, [r4]			@ Save processor ID
>  	str	r1, [r5]			@ Save machine type
>  	str	r2, [r6]			@ Save atags pointer
> -	bic	r4, r0, #CR_A			@ Clear 'A' bit
> -	stmia	r7, {r0, r4}			@ Save control register values
> +	cmp	r7, #0
> +	itt	ne
> +	bicne	r4, r0, #CR_A			@ Clear 'A' bit
> +	stmneia	r7, {r0, r4}			@ Save control register values


Can the cr_alignment variable ever have a value of zero if CONFIG_CPU_15
is enabled? If so you fail to do the stmnia which is possibly not
correct? Why do the registers not need to be stored if cr_alignment is
zero? I think this at least deserves a comment explaining.

Also, couldn't it just be done like this:

#ifndef CONFIG_CPU_CP15
	bic	r4, r0, #CR_A
	stimia	r7, {r0, r4}
#endif

Since r7 will always be zero in the !CP15 case?

>  	b	start_kernel
>  ENDPROC(__mmap_switched)
>  
> @@ -113,7 +115,11 @@ __mmap_switched_data:
>  	.long	processor_id			@ r4
>  	.long	__machine_arch_type		@ r5
>  	.long	__atags_pointer			@ r6
> +#ifdef CONFIG_CPU_CP15
>  	.long	cr_alignment			@ r7
> +#else
> +	.long	0
> +#endif
>  	.long	init_thread_union + THREAD_START_SP @ sp
>  	.size	__mmap_switched_data, . - __mmap_switched_data
>  
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index a255c39..50d3df8 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -472,9 +472,13 @@ static void __init setup_processor(void)
>  	cpu_cache = *list->cache;
>  #endif
>  
> -	printk("CPU: %s [%08x] revision %d (ARMv%s), cr=%08lx\n",
> +	printk("CPU: %s [%08x] revision %d (ARMv%s)",
>  	       cpu_name, read_cpuid_id(), read_cpuid_id() & 15,
> -	       proc_arch[cpu_architecture()], cr_alignment);
> +	       proc_arch[cpu_architecture()]);
> +
> +#ifdef CONFIG_CPU_CP15
> +	printk(KERN_CONT ", cr=%08lx\n", cr_alignment);


#else
	printk(KERN_CONT "\n");

?

> +#endif

>  
>  	snprintf(init_utsname()->machine, __NEW_UTS_LEN + 1, "%s%c",
>  		 list->arch_name, ENDIANNESS);
> diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
> index caf14dc..119d178 100644
> --- a/arch/arm/mm/alignment.c
> +++ b/arch/arm/mm/alignment.c
> @@ -89,7 +89,11 @@ core_param(alignment, ai_usermode, int, 0600);
>  /* Return true if and only if the ARMv6 unaligned access model is in use. */
>  static bool cpu_is_v6_unaligned(void)
>  {
> +#ifdef CONFIG_CPU_CP15
>  	return cpu_architecture() >= CPU_ARCH_ARMv6 && (cr_alignment & CR_U);
> +#else
> +	return 0;

> +#endif

>  }
>  
>  static int safe_usermode(int new_usermode, bool warn)
> @@ -961,12 +965,14 @@ static int __init alignment_init(void)
>  		return -ENOMEM;
>  #endif
>  
> +#ifdef CONFIG_CPU_CP15
>  	if (cpu_is_v6_unaligned()) {
>  		cr_alignment &= ~CR_A;
>  		cr_no_alignment &= ~CR_A;
>  		set_cr(cr_alignment);
>  		ai_usermode = safe_usermode(ai_usermode, false);
>  	}
> +#endif
>  
>  	hook_fault_code(FAULT_CODE_ALIGNMENT, do_alignment, SIGBUS, BUS_ADRALN,
>  			"alignment exception");
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 94c5a0c..f6dbe1a 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -109,8 +109,10 @@ static int __init early_cachepolicy(char *p)
>  
>  		if (memcmp(p, cache_policies[i].policy, len) == 0) {
>  			cachepolicy = i;
> +#ifdef CONFIG_CPU_CP15
>  			cr_alignment &= ~cache_policies[i].cr_mask;
>  			cr_no_alignment &= ~cache_policies[i].cr_mask;
> +#endif
>  			break;
>  		}
>  	}
> @@ -128,7 +130,9 @@ static int __init early_cachepolicy(char *p)
>  		cachepolicy = CPOLICY_WRITEBACK;
>  	}
>  	flush_cache_all();
> +#ifdef CONFIG_CPU_CP15
>  	set_cr(cr_alignment);
> +#endif
>  	return 0;
>  }
>  early_param("cachepolicy", early_cachepolicy);
> @@ -163,6 +167,7 @@ static int __init early_ecc(char *p)
>  early_param("ecc", early_ecc);
>  #endif
>  
> +#ifdef CONFIG_CPU_CP15
>  static int __init noalign_setup(char *__unused)
>  {
>  	cr_alignment &= ~CR_A;
> @@ -171,8 +176,9 @@ static int __init noalign_setup(char *__unused)
>  	return 1;
>  }
>  __setup("noalign", noalign_setup);
> +#endif
>  
> -#ifndef CONFIG_SMP
> +#if !defined(CONFIG_SMP) && defined(CONFIG_CPU_CP15)
>  void adjust_cr(unsigned long mask, unsigned long set)
>  {
>  	unsigned long flags;
