From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 6 Jul 2011 09:56:56 +0100
Subject: A few other cache related optimizations for Cortex-A9.
In-Reply-To: <CAN_5kQBszi=hV1RVjyKO6gOhOuymGjsMwLk6ORaWpkaL-4USxA@mail.gmail.com>
References: <CAN_5kQBszi=hV1RVjyKO6gOhOuymGjsMwLk6ORaWpkaL-4USxA@mail.gmail.com>
Message-ID: <20110706085656.GA32020@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 04:14:57AM +0100, heechul Yun wrote:
> I found a few other places which, I believe, are not necessary for Cortex-A9.
> 
> diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
> index bdba6c6..6d5a847 100644
> --- a/arch/arm/mm/copypage-v6.c
> +++ b/arch/arm/mm/copypage-v6.c
> @@ -41,7 +41,9 @@ static void v6_copy_user_highpage_nonaliasing(struct page *to,
>         kfrom = kmap_atomic(from, KM_USER0);
>         kto = kmap_atomic(to, KM_USER1);
>         copy_page(kto, kfrom);
> +#ifndef CONFIG_CPU_CACHE_V7
>         __cpuc_flush_dcache_area(kto, PAGE_SIZE);
> +#endif
>         kunmap_atomic(kto, KM_USER1);
>         kunmap_atomic(kfrom, KM_USER0);
>  }
> 
> On handling COW page fault, the above function is called to copy the
> page content of the parent to a newly allocate page frame for the
> child. Again, since D cache of A9 is PIPT, we do not need to flush the
> page as in x86. This modification improves lmbench (fork/exec/shell)
> performance by 4-6%.

See commit 115b2247 introducing this. We indeed have a PIPT like cache
on A9 but it is a Harvard architecture with separate I and D caches. It
happened in the past that we got a COW for text page and the I and D
cache became incoherent. Since then, the dynamic linker has been fixed
and no longer causes this. We could add a check for VM_EXEC in
vma->vm_flags.

But I wonder whether we still need this flush after commit c0177800
where we assume that a new page cache page has dirty D-cache (and we
later flush the caches via set_pte_at).

> I think above two patches work for least Cortex-A9 although I am not
> sure the use of CONFIG_CPU_CACHE_V7 is appropriate.

We need to check the ID_MMFR1 register as there are other ARMv7 cores
that cannot do page table walks in the L1 cache.

-- 
Catalin
