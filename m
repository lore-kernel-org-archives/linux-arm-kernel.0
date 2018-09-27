From: Steve.Capper@arm.com (Steve Capper)
Date: Thu, 27 Sep 2018 13:50:42 +0000
Subject: [PATCH 2/5] arm64: mm: introduce 52-bit userspace support
In-Reply-To: <20180921174031.GD238853@arrakis.emea.arm.com>
References: <20180829124543.25314-1-steve.capper@arm.com>
 <20180829124543.25314-3-steve.capper@arm.com>
 <20180921174031.GD238853@arrakis.emea.arm.com>
Message-ID: <20180927135031.iwpszzerpbnubi2h@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Fri, Sep 21, 2018 at 06:40:31PM +0100, Catalin Marinas wrote:
> On Wed, Aug 29, 2018 at 01:45:40PM +0100, Steve Capper wrote:
> > On arm64 there is optional support for a 52-bit virtual address space.
> > To exploit this one has to be running with a 64KB page size and be
> > running on hardware that supports this.
> > 
> > For an arm64 kernel supporting a 48 bit VA with a 64KB page size,
> > a few changes are needed to support a 52-bit userspace:
> >  * TCR_EL1.T0SZ needs to be 12 instead of 16,
> >  * pgd_offset needs to work with a different PTRS_PER_PGD,
> >  * PGD_SIZE needs to be increased,
> >  * TASK_SIZE needs to reflect the new size.
> 
> I will comment on the general approach here. We indeed need TASK_SIZE
> and T0SZ to be variable based on the supported feature. However, I think
> PGD_SIZE can be fixed to cover 52-bit VA all the time, we just need to
> ensure that we allocate a bigger pgd when this option is enabled.
> 
> When the 52-bit VA is not present, everything still works as normal as
> the pgd entries for a 48-bit VA are written at the beginning of the pgd.
> There is no need to change pgd_offset/index etc.
> 

I will tighten up the wording above to indicate constant, variable
depending on 52-bit support.

> > A future patch enables CONFIG_ARM64_TRY_52BIT_VA (which essentially
> > activates this patch) as we need to also change the mmap logic to maintain
> > compatibility with a userspace that expects at most 48-bits of VA.
> 
> And I would just drop the "TRY" part in the above config (but mention it
> in the help text that it is used only if available).
> 

Sure :-).

> > diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
> > index 2e05bcd944c8..7f50804a677e 100644
> > --- a/arch/arm64/include/asm/pgalloc.h
> > +++ b/arch/arm64/include/asm/pgalloc.h
> > @@ -27,7 +27,11 @@
> >  #define check_pgt_cache()		do { } while (0)
> >  
> >  #define PGALLOC_GFP	(GFP_KERNEL | __GFP_ZERO)
> > +#ifdef CONFIG_ARM64_TRY_52BIT_VA
> > +#define PGD_SIZE	((1 << (52 - PGDIR_SHIFT)) * sizeof(pgd_t))
> > +#else
> >  #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
> > +#endif
> 
> OK, so you've already made the PGD_SIZE static here (unless changed in
> subsequent patches). 
> 

Yes PGD_SIZE should be static, the problem is PTRS_PER_PGD needs to reflect a
48-bit VA for kernels (as the kernel addresses are "negative"), so can't
be used to compute PGD_SIZE.

> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index 1bdeca8918a6..8449e266cd46 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -577,11 +577,21 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
> >  #define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
> >  
> >  /* to find an entry in a page-table-directory */
> > -#define pgd_index(addr)		(((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
> > +#define pgd_index(addr, ptrs)		(((addr) >> PGDIR_SHIFT) & ((ptrs) - 1))
> > +#define _pgd_offset_raw(pgd, addr, ptrs) ((pgd) + pgd_index(addr, ptrs))
> > +#define pgd_offset_raw(pgd, addr)	(_pgd_offset_raw(pgd, addr, PTRS_PER_PGD))
> >  
> > -#define pgd_offset_raw(pgd, addr)	((pgd) + pgd_index(addr))
> > +static inline pgd_t *pgd_offset(const struct mm_struct *mm, unsigned long addr)
> > +{
> > +	pgd_t *ret;
> > +
> > +	if (IS_ENABLED(CONFIG_ARM64_TRY_52BIT_VA) && (addr < TASK_SIZE))
> > +		ret = _pgd_offset_raw(mm->pgd, addr, 1ULL << (vabits_user - PGDIR_SHIFT));
> > +	else
> > +		ret = pgd_offset_raw(mm->pgd, addr);
> >  
> > -#define pgd_offset(mm, addr)	(pgd_offset_raw((mm)->pgd, (addr)))
> > +	return ret;
> > +}
> >  
> >  /* to find an entry in a kernel page-table-directory */
> >  #define pgd_offset_k(addr)	pgd_offset(&init_mm, addr)
> 
> We can decouple pgd_offset_k() from pgd_offset() and there wouldn't be a
> need to check the addr < TASK_SIZE. Do we have any case where
> pgd_offset() is used on a kernel address?
>

Unfortunately there are a few cases where pgd_offset is used instead of
pgd_offset_k, I'll see if I can fix these in a separate patch and that
would then simplify this patch.

> > diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> > index 46c9d9ff028c..ba63b8a8dac1 100644
> > --- a/arch/arm64/include/asm/processor.h
> > +++ b/arch/arm64/include/asm/processor.h
> > @@ -19,13 +19,13 @@
> >  #ifndef __ASM_PROCESSOR_H
> >  #define __ASM_PROCESSOR_H
> >  
> > -#define TASK_SIZE_64		(UL(1) << VA_BITS)
> > -
> > -#define KERNEL_DS	UL(-1)
> > -#define USER_DS		(TASK_SIZE_64 - 1)
> > -
> > +#define KERNEL_DS		UL(-1)
> > +#define _USER_DS(vabits)	((UL(1) << (vabits)) - 1)
> >  #ifndef __ASSEMBLY__
> >  
> > +extern u64 vabits_user;
> > +#define TASK_SIZE_64		(UL(1) << vabits_user)
> > +#define USER_DS			_USER_DS(vabits_user)
> >  #define DEFAULT_MAP_WINDOW_64	(UL(1) << VA_BITS)
> 
> Can we keep USER_DS to TASK_SIZE_64 (static)? I don't see what we gain
> by making it dynamic, all we want is that it doesn't overlap with the
> KERNEL_DS (similarly we don't have a different USER_DS for 32-bit tasks
> here).

Sure thing, I was probably being overly paranoid before.

> 
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index e238b7932096..4807fee515b6 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -1006,6 +1006,14 @@ static bool has_hw_dbm(const struct arm64_cpu_capabilities *cap,
> >  
> >  #endif
> >  
> > +#ifdef CONFIG_ARM64_TRY_52BIT_VA
> > +extern u64 vabits_user;
> > +static bool has_52bit_vas(const struct arm64_cpu_capabilities *entry, int __unused)
> 
> Nitpick: just s/vas/va/ to match the config option naming.
> 

Thanks :-)

> > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > index 09dbea221a27..72b4b0b069b9 100644
> > --- a/arch/arm64/kernel/entry.S
> > +++ b/arch/arm64/kernel/entry.S
> > @@ -189,7 +189,11 @@ alternative_cb_end
> >  	/* Save the task's original addr_limit and set USER_DS */
> >  	ldr	x20, [tsk, #TSK_TI_ADDR_LIMIT]
> >  	str	x20, [sp, #S_ORIG_ADDR_LIMIT]
> > -	mov	x20, #USER_DS
> > +alternative_if	ARM64_HAS_52BIT_VA
> > +	mov	x20, #_USER_DS(52)
> > +alternative_else
> > +	mov	x20, #_USER_DS(VA_BITS)
> > +alternative_endif
> 
> Why is this needed? Can't we just use 52 all the time?
>

This was me trying to keep the limit as low as possible, I can relax
this to a 52-bit constant and this will still be disjoint from the
kernel space.

> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index b0853069702f..6b7d32990b25 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -316,6 +316,19 @@ __create_page_tables:
> >  	adrp	x0, idmap_pg_dir
> >  	adrp	x3, __idmap_text_start		// __pa(__idmap_text_start)
> >  
> > +#ifdef CONFIG_ARM64_TRY_52BIT_VA
> > +	mrs_s	x6, SYS_ID_AA64MMFR2_EL1
> > +	and	x6, x6, #(0xf << ID_AA64MMFR2_LVA_SHIFT)
> > +	mov	x5, #52
> > +	cbnz	x6, 1f
> > +#endif
> > +	mov	x5, #VA_BITS
> > +1:
> > +	adr_l	x6, vabits_user
> > +	str	x5, [x6]
> > +	dmb	sy
> > +	dc	ivac, x6		// Invalidate potentially stale cache line
> 
> I wonder whether we could get away with not setting vabits_user until
> has_52bit_va(), especially since it's meant for user space. For idmap,
> this matches the PA and while we support 52-bit PA, we've never
> supported a 52-bit idmap. Even if we do, I don't think setting
> vabits_user early is necessary.

I think it makes sense to have 52-bits detected earlier as this will
allow T0SZ to be set correctly earlier. I'll see if I can simplify
things.

> 
> > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> > index 03646e6a2ef4..4834bd434143 100644
> > --- a/arch/arm64/mm/proc.S
> > +++ b/arch/arm64/mm/proc.S
> > @@ -441,7 +441,15 @@ ENTRY(__cpu_setup)
> >  	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
> >  			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
> >  			TCR_TBI0 | TCR_A1
> > -	tcr_set_idmap_t0sz	x10, x9
> > +
> > +#ifdef CONFIG_ARM64_TRY_52BIT_VA
> > +	ldr_l 		x9, vabits_user
> > +	sub		x9, xzr, x9
> > +	add		x9, x9, #64
> > +#else
> > +	ldr_l		x9, idmap_t0sz
> > +#endif
> > +	tcr_set_t0sz	x10, x9
> 
> This is probably sufficient for 52-bit idmap, together with a statically
> allocated idmap_pg_dir (which we do anyway, using a full page IIUC).

That was my thinking too. Also with the EFI map, that is allocated by
the kernel (thus no "straggler" entries mapped high) so that also has T0SZ==12.

Cheers,
-- 
Steve
