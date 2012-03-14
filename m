From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 14 Mar 2012 11:24:36 -0400 (EDT)
Subject: [PATCH v3 1/5] ARM: protect usage of cr_alignment by #ifdef
 CONFIG_CPU_CP15
In-Reply-To: <1331720483-10075-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20120314101928.GA29474@pengutronix.de>
 <1331720483-10075-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <alpine.LFD.2.02.1203141103080.24151@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Mar 2012, Uwe Kleine-K?nig wrote:

> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

I think you could reduce the amount of #ifdef's significantly here.  
While the cr_alignment variable and its sister are of no use in a 
no-CP15 system, you could still leave them there initialized to zero and 
only conditionally compile out the CP15 modifyers with a dummy version.  
This is only 2 words wasted in your kernel image to keep the code 
cleaner.

More comments below.

> index 854bd22..efeb2d0 100644
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

The kernel is compiled with -mimplicit-it so you do not need to specify 
any it here.

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
> +#endif
>  

Again, you could just leave the original display, with cr=00000000 which 
is a fairly good representation of reality.

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

Same here.  With cr_alignment set to zero, you don't need the above 
#ifdef.

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

Here the #ifdef is probably legitimate.

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

Probably here as well.

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

However it might be best to provide a dummy set_cr() instead of 
#ifdef'ing it out everywhere.


Nicolas
