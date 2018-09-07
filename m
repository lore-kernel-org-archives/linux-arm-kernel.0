From: james.morse@arm.com (James Morse)
Date: Fri, 7 Sep 2018 10:58:22 +0100
Subject: [RESEND PATCH v4 5/6] arm64/mm: Populate the swapper_pg_dir by
 fixmap.
In-Reply-To: <20180822095432.12125-6-yaojun8558363@gmail.com>
References: <20180822095432.12125-1-yaojun8558363@gmail.com>
 <20180822095432.12125-6-yaojun8558363@gmail.com>
Message-ID: <2bf9b9d1-271c-f85e-5a98-0eb74f2fedd9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jun,

On 22/08/18 10:54, Jun Yao wrote:
> Since we will move the swapper_pg_dir to rodata section, we need a
> way to update it. The fixmap can handle it. When the swapper_pg_dir
> needs to be updated, we map it dynamically. The map will be
> canceled after the update is complete. In this way, we can defend
> against KSMA(Kernel Space Mirror Attack).


> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 46ef21ebfe47..d5c3df99af7b 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -428,8 +435,32 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  				 PUD_TYPE_TABLE)
>  #endif
>  
> +extern spinlock_t swapper_pgdir_lock;

Hmmm, it would be good if we could avoid exposing this lock.
Wherever this ends up needs to include spinlock.h, and we don't have to do that
in arch headers today.


>  static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>  {
> +#ifdef __PAGETABLE_PMD_FOLDED
> +	if (in_swapper_pgdir(pmdp)) {
> +		pmd_t *fixmap_pmdp;
> +
> +		spin_lock(&swapper_pgdir_lock);
> +		fixmap_pmdp = (pmd_t *)pgd_set_fixmap(__pa(pmdp));
> +		WRITE_ONCE(*fixmap_pmdp, pmd);
> +		dsb(ishst);
> +		pgd_clear_fixmap();
> +		spin_unlock(&swapper_pgdir_lock);
> +		return;
> +	}
> +#endif

You have this pattern multiple times, it ought to be a macro. (Any reason why
the last copy for pgd is different?)

Putting all this directly into the inlined helper is noisy and risks bloating
the locations it appears. Could we do the in_swappper_pgdir() test, and if it
passes call some out-of-line set_swapper_pgd() that lives in mm/mmu.c? Once we
know we're using the fixmap I don't think there is a benefit to inline-ing the code.

Doing this would avoid moving the extern defines and p?d_set_fixmap() helpers
around in this header and let us avoid extern-ing the lock or including
spinlock.h in here.


>  	WRITE_ONCE(*pmdp, pmd);
>  	dsb(ishst);
>  }
> @@ -480,6 +511,19 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
>  
>  static inline void set_pud(pud_t *pudp, pud_t pud)
>  {
> +#ifdef __PAGETABLE_PUD_FOLDED
> +	if (in_swapper_pgdir(pudp)) {
> +		pud_t *fixmap_pudp;
> +
> +		spin_lock(&swapper_pgdir_lock);
> +		fixmap_pudp = (pud_t *)pgd_set_fixmap(__pa(pudp));

This is a bit subtle: are you using the pgd fixmap entry because the path from
map_mem() uses the other three?

Using the pgd fix slot for a pud looks a bit strange to me, but its arguably a
side-effect of the folding.

I see this called 68 times during boot on a 64K/42bit-VA, 65 of which appear to
be during paging_init(). What do you think to keeping paging_init()s use of the
pgd fixmap for swapper_pg_dir, deliberately to skip the in_swapper_pgdir() test
during paging_init()?


> +		WRITE_ONCE(*fixmap_pudp, pud);

> +		dsb(ishst);
> +		pgd_clear_fixmap();

Hmm,

p?d_clear_fixmap() is done by calling __set_fixmap(FIX_P?G, 0, __pgprot(0)).

__set_fixmap() calls flush_tlb_kernel_range() if the flags are 0.

flush_tlb_kernel_range() has a dsb(ishst) before it does the maintenance, (even
via flush_tlb_all()).

I think we can replace replace the dsb() before each p?d_clear_fixmap() call
with a comment that the flush_tlb_*() will do it for us. Something like:

|/*
| * We need dsb(ishst) here to ensure the page-table-walker sees our new entry
| * before set_p?d() returns. The fixmap's flush_tlb_kernel_range() via
| * clear_fixmap() does this for us.
| */


> +		spin_unlock(&swapper_pgdir_lock);
> +		return;
> +	}
> +#endif
>  	WRITE_ONCE(*pudp, pud);
>  	dsb(ishst);
>  }


Thanks,

James
