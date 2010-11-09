From: minchan.kim@gmail.com (Minchan Kim)
Date: Tue, 9 Nov 2010 19:34:45 +0900
Subject: [PATCH 1/2] Fix the I-cache invalidation on ARMv6 and later CPUs
In-Reply-To: <1289297870.11461.7.camel@e102109-lin.cambridge.arm.com>
References: <20080606114622.15520.49929.stgit@pc1117.cambridge.arm.com>
	<AANLkTik0_0Eb8G5hEb+DGvE2BDM_mJwwF-Pt1ErTz=Lr@mail.gmail.com>
	<AANLkTim3O9HaOZp7VD3s1+FRU0KmPUrDei9NFDoXWK3y@mail.gmail.com>
	<1289297870.11461.7.camel@e102109-lin.cambridge.arm.com>
Message-ID: <AANLkTikhi3znQs32Qc=ACuH0Kz-WV0xmD-4-JjQv8OqZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 9, 2010 at 7:17 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> On Tue, Nov 9, 2010 at 2:03 PM, Minchan Kim <minchan.kim@gmail.com> wrote:
>> > On Fri, Jun 6, 2008 at 8:46 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> >> This patch adds the I-cache invalidation in update_mmu_cache if the
>> >> corresponding vma is marked as executable. It also invalidates the
>> >> I-cache if a thread migrates to a CPU it never ran on.
>> >
>> > The description says just two place in update_mmu_cache and CPU
>> > migration point.
>> > I agree on it.
>> >
>> >>
>> >> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>> >> ---
>> >>
>> >> ?arch/arm/mm/fault-armv.c ? ? ?| ? ?4 ++++
>> >> ?arch/arm/mm/flush.c ? ? ? ? ? | ? ?2 ++
>> >> ?include/asm-arm/cacheflush.h ?| ? ?7 +++++++
>> >> ?include/asm-arm/mmu_context.h | ? ?5 +++++
>> >> ?4 files changed, 18 insertions(+), 0 deletions(-)
>> >>
>> >> diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
>> >> index 44558d5..fbfa260 100644
>> >> --- a/arch/arm/mm/fault-armv.c
>> >> +++ b/arch/arm/mm/fault-armv.c
>> >> @@ -144,13 +144,17 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
>> >> ? ? ? ?page = pfn_to_page(pfn);
>> >> ? ? ? ?mapping = page_mapping(page);
>> >> ? ? ? ?if (mapping) {
>> >> +#ifndef CONFIG_SMP
>> >> ? ? ? ? ? ? ? ?int dirty = test_and_clear_bit(PG_dcache_dirty, &page->flags);
>> >>
>> >> ? ? ? ? ? ? ? ?if (dirty)
>> >> ? ? ? ? ? ? ? ? ? ? ? ?__flush_dcache_page(mapping, page);
>> >> +#endif
>> >>
>> >> ? ? ? ? ? ? ? ?if (cache_is_vivt())
>> >> ? ? ? ? ? ? ? ? ? ? ? ?make_coherent(mapping, vma, addr, pfn);
>> >> + ? ? ? ? ? ? ? else if (vma->vm_flags & VM_EXEC)
>> >> + ? ? ? ? ? ? ? ? ? ? ? __flush_icache_all();
>> >> ? ? ? ?}
>> >> ?}
>> >>
>> >> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
>> >> index 9df507d..029ee65 100644
>> >> --- a/arch/arm/mm/flush.c
>> >> +++ b/arch/arm/mm/flush.c
>> >> @@ -199,6 +199,8 @@ void flush_dcache_page(struct page *page)
>> >> ? ? ? ? ? ? ? ?__flush_dcache_page(mapping, page);
>> >> ? ? ? ? ? ? ? ?if (mapping && cache_is_vivt())
>> >> ? ? ? ? ? ? ? ? ? ? ? ?__flush_dcache_aliases(mapping, page);
>> >> + ? ? ? ? ? ? ? else if (mapping)
>> >> + ? ? ? ? ? ? ? ? ? ? ? __flush_icache_all();
>> >> ? ? ? ?}
>> >
>> > Here, let me ask questions.
>> > 1. Why do we flush icache in ?flush_dcache_page? Does it really needed?
>
> Note that these functions are changed slightly in 2.6.37-rc1, but we
> still do the I-cache flushing.
>
> There reason is that the page being modified may already be mapped in
> user space and may be a code page as well. The kernel may call this

Yes. That's my point. We can't know code or not in that context(ie,
flush_dcache_page).

> function after it modified the page and therefore we need to ensure the
> I-D cache coherency.

Yes. Only if the page is code page.
(I might miss something.That's why I ask a question).

>
> IMHO, the API could be slightly improved since the kernel calls this
> function even before reading a page cache page but we don't really need
> to invalidate the I-cache at that point.

Agree.

>
>> > 2. If we really need it, should we even flush it in !VM_EXEC?
>
> We don't have the vma in flush_dcache_page to be able to check for
> VM_EXEC.

Yes. We did it in update_mmu_cache through VM_EXEC check.

In 2.6.37-rc1, we flushes icache without VM_EXEC check in set_pte_at
which doesn't have VMA, either.
Could we move the icache flush to update_mmu_cache again?
I think it's right place to update_mmu_cache like old behavior.
What was the problem in there?

Thanks for the quick response, Catalin.


-- 
Kind regards,
Minchan Kim
