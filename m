From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 11 Oct 2017 12:39:39 -0700
Subject: [PATCH 01/11] Initialize the mapping of KASan shadow memory
In-Reply-To: <20171011082227.20546-2-liuwenliang@huawei.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-2-liuwenliang@huawei.com>
Message-ID: <b53b3281-5eef-7cbd-c7d3-5417d764667b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2017 01:22 AM, Abbott Liu wrote:
> From: Andrey Ryabinin <a.ryabinin@samsung.com>
> 
> This patch initializes KASan shadow region's page table and memory.
> There are two stage for KASan initializing:
> 1. At early boot stage the whole shadow region is mapped to just
>    one physical page (kasan_zero_page). It's finished by the function
>    kasan_early_init which is called by __mmap_switched(arch/arm/kernel/
>    head-common.S)
> 
> 2. After the calling of paging_init, we use kasan_zero_page as zero
>    shadow for some memory that KASan don't need to track, and we alloc
>    new shadow space for the other memory that KASan need to track. These
>    issues are finished by the function kasan_init which is call by setup_arch.
> 
> Cc: Andrey Ryabinin <a.ryabinin@samsung.com>
> Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
> ---

[snip]

				\
> @@ -140,6 +149,30 @@ extern void cpu_resume(void);
>  		pg &= ~0x3fff;				\
>  		(pgd_t *)phys_to_virt(pg);		\
>  	})
> +
> +#define cpu_set_ttbr(nr, val)					\
> +	do {							\
> +		u64 ttbr = val;					\
> +		__asm__("mcr	p15, 0, %0, c2, c0, 0"		\
> +			: : "r" (ttbr));			\
> +	} while (0)

nr seems to be unused here?

> +
> +#define cpu_get_ttbr(nr)					\
> +	({							\
> +		unsigned long ttbr;				\
> +		__asm__("mrc	p15, 0, %0, c2, c0, 0"		\
> +			: "=r" (ttbr));				\
> +		ttbr;						\
> +	})
> +
> +#define cpu_set_ttbr0(val)					\
> +	do {							\
> +		u64 ttbr = val;					\
> +		__asm__("mcr	p15, 0, %0, c2, c0, 0"		\
> +			: : "r" (ttbr));			\
> +	} while (0)
> +

Why is not cpu_set_ttbr0() not using cpu_set_ttbr()?

> +
>  #endif
>  
>  #else	/*!CONFIG_MMU */
> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
> index 1d468b5..52c4858 100644
> --- a/arch/arm/include/asm/thread_info.h
> +++ b/arch/arm/include/asm/thread_info.h
> @@ -16,7 +16,11 @@
>  #include <asm/fpstate.h>
>  #include <asm/page.h>
>  
> +#ifdef CONFIG_KASAN
> +#define THREAD_SIZE_ORDER       2
> +#else
>  #define THREAD_SIZE_ORDER	1
> +#endif
>  #define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
>  #define THREAD_START_SP		(THREAD_SIZE - 8)
>  
> diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
> index 8733012..c17f4a2 100644
> --- a/arch/arm/kernel/head-common.S
> +++ b/arch/arm/kernel/head-common.S
> @@ -101,7 +101,11 @@ __mmap_switched:
>  	str	r2, [r6]			@ Save atags pointer
>  	cmp	r7, #0
>  	strne	r0, [r7]			@ Save control register values
> +#ifdef CONFIG_KASAN
> +	b	kasan_early_init
> +#else
>  	b	start_kernel
> +#endif

Please don't make this "exclusive" just conditionally call
kasan_early_init(), remove the call to start_kernel from
kasan_early_init and keep the call to start_kernel here.

>  ENDPROC(__mmap_switched)
>  
>  	.align	2

[snip]

> +void __init kasan_early_init(void)
> +{
> +	struct proc_info_list *list;
> +
> +	/*
> +	 * locate processor in the list of supported processor
> +	 * types.  The linker builds this table for us from the
> +	 * entries in arch/arm/mm/proc-*.S
> +	 */
> +	list = lookup_processor_type(read_cpuid_id());
> +	if (list) {
> +#ifdef MULTI_CPU
> +		processor = *list->proc;
> +#endif
> +	}

I could not quite spot in your patch series when do you need this
information?
-- 
Florian
