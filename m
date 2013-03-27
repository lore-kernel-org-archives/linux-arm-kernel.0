From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Mar 2013 10:34:30 +0000
Subject: [PATCH 1/4] ARM: tlb: don't perform inner-shareable invalidation
 for local TLB ops
In-Reply-To: <1364235581-17900-2-git-send-email-will.deacon@arm.com>
References: <1364235581-17900-1-git-send-email-will.deacon@arm.com>
 <1364235581-17900-2-git-send-email-will.deacon@arm.com>
Message-ID: <20130327103429.GB801@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 06:19:38PM +0000, Will Deacon wrote:
> @@ -352,22 +369,33 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
>  		dsb();
>  
>  	if (possible_tlb_flags & (TLB_V3_FULL|TLB_V4_U_FULL|TLB_V4_D_FULL|TLB_V4_I_FULL)) {
> -		if (cpumask_test_cpu(get_cpu(), mm_cpumask(mm))) {
> +		if (!cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm))) {
>  			tlb_op(TLB_V3_FULL, "c6, c0, 0", zero);
>  			tlb_op(TLB_V4_U_FULL, "c8, c7, 0", zero);
>  			tlb_op(TLB_V4_D_FULL, "c8, c6, 0", zero);
>  			tlb_op(TLB_V4_I_FULL, "c8, c5, 0", zero);
>  		}
> -		put_cpu();

Why is this change needed? You only flush the local TLB if the mm never
wasn't active on this processor?

> @@ -398,6 +426,21 @@ local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
>  	tlb_op(TLB_V6_U_PAGE, "c8, c7, 1", uaddr);
>  	tlb_op(TLB_V6_D_PAGE, "c8, c6, 1", uaddr);
>  	tlb_op(TLB_V6_I_PAGE, "c8, c5, 1", uaddr);
> +
> +	if (tlb_flag(TLB_BARRIER))
> +		dsb();
> +}
> +
> +static inline void
> +__flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
> +{
> +	const unsigned int __tlb_flag = __cpu_tlb_flags;
> +
> +	uaddr = (uaddr & PAGE_MASK) | ASID(vma->vm_mm);
> +
> +	if (tlb_flag(TLB_WB))
> +		dsb();
> +

I guess here we could just have a single *_tlb_page() variant. I
couldn't find any place where we call the local_flush_tlb_page()
explicitly, I guess we don't really need local semantics. On ARMv6 SMP,
they are local anyway.

If we have a single *_tlb_page() function, you would need to drop the
TLB_V6_*_PAGE from the v8 possible TLB ops.

>  #ifdef CONFIG_ARM_ERRATA_720789
>  	tlb_op(TLB_V7_UIS_PAGE, "c8, c3, 3", uaddr & PAGE_MASK);
>  #else
> @@ -428,6 +471,22 @@ static inline void local_flush_tlb_kernel_page(unsigned long kaddr)
>  	tlb_op(TLB_V6_U_PAGE, "c8, c7, 1", kaddr);
>  	tlb_op(TLB_V6_D_PAGE, "c8, c6, 1", kaddr);
>  	tlb_op(TLB_V6_I_PAGE, "c8, c5, 1", kaddr);
> +
> +	if (tlb_flag(TLB_BARRIER)) {
> +		dsb();
> +		isb();
> +	}
> +}

I have some worries with this function. It is used by set_top_pte() and
it really doesn't look like it has local-only semantics. For example,
you use it do flush the I-cache aliases and this must target all the
CPUs because of speculative prefetches, which means that set_top_pte()
must set the new alias on all the CPUs.

Highmem mappings need to be revisited as well.

> --- a/arch/arm/mm/context.c
> +++ b/arch/arm/mm/context.c
> @@ -134,10 +134,7 @@ static void flush_context(unsigned int cpu)
>  	}
>  
>  	/* Queue a TLB invalidate and flush the I-cache if necessary. */
> -	if (!tlb_ops_need_broadcast())
> -		cpumask_set_cpu(cpu, &tlb_flush_pending);
> -	else
> -		cpumask_setall(&tlb_flush_pending);
> +	cpumask_setall(&tlb_flush_pending);

That's a good change ;)

-- 
Catalin
