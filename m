From: will.deacon@arm.com (Will Deacon)
Date: Mon, 18 Jun 2012 16:00:15 +0100
Subject: kernel fault in get_dump_page on at91
In-Reply-To: <4FDC8141.2030209@xenomai.org>
References: <4FDC8141.2030209@xenomai.org>
Message-ID: <20120618150015.GG8358@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 16, 2012 at 01:51:13PM +0100, Gilles Chanteperdrix wrote:
> 
> Hi,

Hello Gilles,

> The function get_dump_page calls vivt_flush_cache_page which tests if
> the current cpu belongs to mm_cpumask(vma->vm_mm), but vma->vm_mm is
> NULL for the vector page.
> 
> Setting gate_vma.vm_mm to &init_mm seems to avoid the issue, but I am
> not sure this is the right thing to do.

I don't think that is the right thing to do -- instead we should check that
vm_mm isn't NULL before dereferencing it:


diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 004c1bc..b35c376 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -215,7 +215,8 @@ static inline void vivt_flush_cache_mm(struct mm_struct *mm)
 static inline void
 vivt_flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
 {
-       if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm)))
+       if (!vma->vm_mm ||
+           cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm)))
                __cpuc_flush_user_range(start & PAGE_MASK, PAGE_ALIGN(end),
                                        vma->vm_flags);
 }
@@ -223,7 +224,8 @@ vivt_flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned
 static inline void
 vivt_flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsigned long pfn)
 {
-       if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
+       if (!vma->vm_mm ||
+           cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
                unsigned long addr = user_addr & PAGE_MASK;
                __cpuc_flush_user_range(addr, addr + PAGE_SIZE, vma->vm_flags);
        }


The bit that worries me is that code like this isn't confined to vivt cache
flushing. We also have similar sequences for ptrace flushing and TLB
maintenance. The former is probably ok since the gate_vma isn't
writable/COWable but can we guarantee that TLB page flushing routines won't
be called on the gate_vma?

Will
