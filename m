From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 1 Oct 2018 11:28:17 +0100
Subject: [PATCH 2/5] arm64: mm: introduce 52-bit userspace support
In-Reply-To: <20180927144833.i5j7ma6ftf3g7bxu@capper-debian.cambridge.arm.com>
References: <20180829124543.25314-1-steve.capper@arm.com>
 <20180829124543.25314-3-steve.capper@arm.com>
 <20180921174031.GD238853@arrakis.emea.arm.com>
 <20180927135031.iwpszzerpbnubi2h@capper-debian.cambridge.arm.com>
 <20180927144833.i5j7ma6ftf3g7bxu@capper-debian.cambridge.arm.com>
Message-ID: <20181001102815.GB131162@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2018 at 02:48:43PM +0000, Steve Capper wrote:
> On Thu, Sep 27, 2018 at 02:50:32PM +0100, Steve Capper wrote:
> > On Fri, Sep 21, 2018 at 06:40:31PM +0100, Catalin Marinas wrote:
> > > > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > > > index 1bdeca8918a6..8449e266cd46 100644
> > > > --- a/arch/arm64/include/asm/pgtable.h
> > > > +++ b/arch/arm64/include/asm/pgtable.h
> > > > @@ -577,11 +577,21 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
> > > >  #define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
> > > >  
> > > >  /* to find an entry in a page-table-directory */
> > > > -#define pgd_index(addr)		(((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
> > > > +#define pgd_index(addr, ptrs)		(((addr) >> PGDIR_SHIFT) & ((ptrs) - 1))
> > > > +#define _pgd_offset_raw(pgd, addr, ptrs) ((pgd) + pgd_index(addr, ptrs))
> > > > +#define pgd_offset_raw(pgd, addr)	(_pgd_offset_raw(pgd, addr, PTRS_PER_PGD))
> > > >  
> > > > -#define pgd_offset_raw(pgd, addr)	((pgd) + pgd_index(addr))
> > > > +static inline pgd_t *pgd_offset(const struct mm_struct *mm, unsigned long addr)
> > > > +{
> > > > +	pgd_t *ret;
> > > > +
> > > > +	if (IS_ENABLED(CONFIG_ARM64_TRY_52BIT_VA) && (addr < TASK_SIZE))
> > > > +		ret = _pgd_offset_raw(mm->pgd, addr, 1ULL << (vabits_user - PGDIR_SHIFT));
> > > > +	else
> > > > +		ret = pgd_offset_raw(mm->pgd, addr);
> > > >  
> > > > -#define pgd_offset(mm, addr)	(pgd_offset_raw((mm)->pgd, (addr)))
> > > > +	return ret;
> > > > +}
> > > >  
> > > >  /* to find an entry in a kernel page-table-directory */
> > > >  #define pgd_offset_k(addr)	pgd_offset(&init_mm, addr)
> > > 
> > > We can decouple pgd_offset_k() from pgd_offset() and there wouldn't be a
> > > need to check the addr < TASK_SIZE. Do we have any case where
> > > pgd_offset() is used on a kernel address?
> > 
> > Unfortunately there are a few cases where pgd_offset is used instead of
> > pgd_offset_k, I'll see if I can fix these in a separate patch and that
> > would then simplify this patch.
> 
> So it turns out that __change_memory_common, calls apply_to_page_range
> which then calls pgd_offset...

Ah, James Morse had a plan to change apply_to_page_range() for other
reasons but I'm not sure whether that would have helped.

> Is it worth changing __change_memory_common, or would it be better to
> introduce a check in pgd_offset (can also check the mm parameter)?

The problem here doesn't seem to be __change_memory_common() but rather
apply_to_page_range(). Since there are other users of this API (e.g.
alloc_vm_area()), I think we should just change pgd_offset(). Would a
check on the (mm == &init_mm) be sufficient? Otherwise, we could do a
test on bit 55 of the address.

-- 
Catalin
