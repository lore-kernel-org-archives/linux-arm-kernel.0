From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 15 Jan 2013 13:08:20 +0000
Subject: [PATCH v7 1/3] ARM: make cr_alignment read-only #ifndef
 CONFIG_CPU_CP15
In-Reply-To: <1350462872-16805-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1350462872-16805-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1350462872-16805-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <50F554C4.3020903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 17/10/12 09:34, Uwe Kleine-K?nig wrote:
> This makes cr_alignment a constant 0 to break code that tries to modify
> the value as it's likely that it's built on wrong assumption when
> CONFIG_CPU_CP15 isn't defined. For code that is only reading the value 0
> is more or less a fine value to report.
>

Without the context of some of the discussion that was had on the list 
about how/why to do this, this description is a bit confusing...

I found myself asking "Why do we not #ifdef out uses of cr_alignment 
based on CONFIG_CPU_CP15" - a question which it seems is answered by you 
and Nicolas here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/089968.html

So, perhaps it would help to have a little bit more context in this 
commit message?

I know that the cr_alignment stuff is currently tied up with 
CONFIG_CPU_15, but I wonder if you looked at using the CCR.UNALIGN_TRP 
bit and wiring that in to alignment trapping code? Is it something you 
think would make sense for the work you're doing?

Also, see a couple of minor style/commenting points below...

> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> unchanged since v6
>   arch/arm/include/asm/cp15.h   |   11 ++++++++++-
>   arch/arm/kernel/head-common.S |    9 +++++++--
>   arch/arm/mm/alignment.c       |    2 ++
>   arch/arm/mm/mmu.c             |   17 +++++++++++++++++
>   4 files changed, 36 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
> index 5ef4d80..d814435 100644
> --- a/arch/arm/include/asm/cp15.h
> +++ b/arch/arm/include/asm/cp15.h
> @@ -42,6 +42,8 @@
>   #define vectors_high()	(0)
>   #endif
>
> +#ifdef CONFIG_CPU_CP15
> +
>   extern unsigned long cr_no_alignment;	/* defined in entry-armv.S */
>   extern unsigned long cr_alignment;	/* defined in entry-armv.S */
>
> @@ -82,6 +84,13 @@ static inline void set_copro_access(unsigned int val)
>   	isb();
>   }
>
> -#endif
> +#else /* ifdef CONFIG_CPU_CP15 */
> +
> +#define cr_no_alignment	UL(0)
> +#define cr_alignment	UL(0)
> +
> +#endif /* ifdef CONFIG_CPU_CP15 / else */
> +
> +#endif /* ifndef __ASSEMBLY__ */
>
>   #endif
> diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
> index 854bd22..2f560c5 100644
> --- a/arch/arm/kernel/head-common.S
> +++ b/arch/arm/kernel/head-common.S
> @@ -98,8 +98,9 @@ __mmap_switched:
>   	str	r9, [r4]			@ Save processor ID
>   	str	r1, [r5]			@ Save machine type
>   	str	r2, [r6]			@ Save atags pointer
> -	bic	r4, r0, #CR_A			@ Clear 'A' bit
> -	stmia	r7, {r0, r4}			@ Save control register values
> +	cmp	r7, #0
> +	bicne	r4, r0, #CR_A			@ Clear 'A' bit
> +	stmneia	r7, {r0, r4}			@ Save control register values
>   	b	start_kernel
>   ENDPROC(__mmap_switched)
>
> @@ -113,7 +114,11 @@ __mmap_switched_data:
>   	.long	processor_id			@ r4
>   	.long	__machine_arch_type		@ r5
>   	.long	__atags_pointer			@ r6
> +#ifdef CONFIG_CPU_CP15
>   	.long	cr_alignment			@ r7
> +#else
> +	.long	0

This value still gets loaded in to r7, so it might be worth keeping the 
comments going... They certainly help when reading the code.

> +#endif
>   	.long	init_thread_union + THREAD_START_SP @ sp
>   	.size	__mmap_switched_data, . - __mmap_switched_data
>
> diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
> index b9f60eb..5748094 100644
> --- a/arch/arm/mm/alignment.c
> +++ b/arch/arm/mm/alignment.c
> @@ -962,12 +962,14 @@ static int __init alignment_init(void)
>   		return -ENOMEM;
>   #endif
>
> +#ifdef CONFIG_CPU_CP15
>   	if (cpu_is_v6_unaligned()) {
>   		cr_alignment &= ~CR_A;
>   		cr_no_alignment &= ~CR_A;
>   		set_cr(cr_alignment);
>   		ai_usermode = safe_usermode(ai_usermode, false);
>   	}
> +#endif
>
>   	hook_fault_code(FAULT_CODE_ALIGNMENT, do_alignment, SIGBUS, BUS_ADRALN,
>   			"alignment exception");
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 941dfb9..b675918 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -97,6 +97,7 @@ static struct cachepolicy cache_policies[] __initdata = {
>   	}
>   };
>
> +#ifdef CONFIG_CPU_CP15
>   /*
>    * These are useful for identifying cache coherency
>    * problems by allowing the cache or the cache and
> @@ -195,6 +196,22 @@ void adjust_cr(unsigned long mask, unsigned long set)
>   }
>   #endif
>
> +#else

When you read this file in its complete form there's a lot of code 
(including more preprocessor stuff) between the #ifdef and the #else.

Could you add

#else /* ifdef CONFIG_CPU_CP15 */

like you have in the other cases?

Jonny
