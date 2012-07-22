From: will.deacon@arm.com (Will Deacon)
Date: Sun, 22 Jul 2012 14:03:55 +0100
Subject: [PATCH] ARM: mm: avoid attempting to flush the gate_vma with
 VIVT caches
In-Reply-To: <500AC109.3060708@xenomai.org>
References: <1342455826-9425-1-git-send-email-will.deacon@arm.com>
 <20120719122814.GE29153@mudshark.cambridge.arm.com>
 <5009C26B.6080901@xenomai.org> <500AAC2B.5060300@xenomai.org>
 <20120721143517.GB26790@mudshark.cambridge.arm.com>
 <500ABF78.10208@xenomai.org> <500AC109.3060708@xenomai.org>
Message-ID: <20120722130355.GA29138@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 21, 2012 at 03:47:37PM +0100, Gilles Chanteperdrix wrote:
> On 07/21/2012 04:40 PM, Gilles Chanteperdrix wrote:
> > On 07/21/2012 04:35 PM, Will Deacon wrote:
> >> Hi Gilles,
> >>
> >> On Sat, Jul 21, 2012 at 02:18:35PM +0100, Gilles Chanteperdrix wrote:
> >>> On 07/20/2012 10:41 PM, Gilles Chanteperdrix wrote:
> >>>> Being 0 or 1 whether we want to flush the vector page (I believe we do
> >>>> not want to flush it, but am not sure).
> >>>
> >>> Actually, I believe we want to flush the vector page, at least on
> >>> systems with VIVT cache: on systems with VIVT cache, the vector page is
> >>> writeable in kernel mode, so may have been modified, and the address
> >>> used by elf_core_dump is not the vectors address, but the address in the
> >>> kernel direct-mapped RAM region where the vector page was allocated, so
> >>> there is a cache aliasing issue.
> >>
> >> It may be writable, but we never actually write to it after it has been
> >> initialised so there's no need to worry about caching issues (the cache is
> >> flushed in devicemaps_init).
> > 
> > Except if CONFIG_TLS_REG_EMUL is enabled
> 
> is disabled I mean.

Well spotted! I disagree about the address being flushed though -- it looks
to me like we flush from 0xffff0000 - 0xffff1000, which is what we want. Why
do you think we're flushing from the linear mapping?

Anyway, the TLS issue can easily be resolved by changing my previous patch so
that we flush unconditionally when there's no mm (see below).

In the meantime, I'll remove the old patch from the patch system while we
address your remaining concerns.

Cheers,

Will

---8<---

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 8cf828e..e4448e1 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -217,7 +217,7 @@ vivt_flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned
 {
        struct mm_struct *mm = vma->vm_mm;
 
-       if (mm && cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm)))
+       if (!mm || cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm)))
                __cpuc_flush_user_range(start & PAGE_MASK, PAGE_ALIGN(end),
                                        vma->vm_flags);
 }
@@ -227,7 +227,7 @@ vivt_flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsig
 {
        struct mm_struct *mm = vma->vm_mm;
 
-       if (mm && cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm))) {
+       if (!mm || cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm))) {
                unsigned long addr = user_addr & PAGE_MASK;
                __cpuc_flush_user_range(addr, addr + PAGE_SIZE, vma->vm_flags);
        }
