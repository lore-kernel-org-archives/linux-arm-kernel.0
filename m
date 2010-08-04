From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Aug 2010 12:24:48 +0100
Subject: [PATCH 2/2] ARM: flush_ptrace_access: invalidate all I-caches
In-Reply-To: <20100715163216.GI29322@n2100.arm.linux.org.uk>
References: <1279209238-16234-1-git-send-email-will.deacon@arm.com>
	<1279209238-16234-2-git-send-email-will.deacon@arm.com>
	<1279209238-16234-3-git-send-email-will.deacon@arm.com>
	<20100715163216.GI29322@n2100.arm.linux.org.uk>
Message-ID: <001701cb33c7$a6535a20$f2fa0e60$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> Subject: Re: [PATCH 2/2] ARM: flush_ptrace_access: invalidate all I-caches
> 
> On Thu, Jul 15, 2010 at 04:53:58PM +0100, Will Deacon wrote:
> > copy_to_user_page can be used by access_process_vm to write to an
> > executable page of a process using a mapping acquired by kmap.
> > For systems with I-cache aliasing, flushing the I-cache using the
> > Kernel mapping may leave stale data in the I-cache if the user
> > mapping is of a different colour.
> >
> > This patch replaces the coherent_kern_range call in flush_ptrace_access
> > with a D-cache flush followed by a system-wide I-cache invalidation.
> > This is required on all systems where the size of a way in the I-cache
> > is larger than PAGE_SIZE.
> >
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/mm/flush.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> > index c6844cb..45896a9 100644
> > --- a/arch/arm/mm/flush.c
> > +++ b/arch/arm/mm/flush.c
> > @@ -120,8 +120,8 @@ void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
> >
> >  	/* VIPT non-aliasing cache */
> >  	if (vma->vm_flags & VM_EXEC) {
> > -		unsigned long addr = (unsigned long)kaddr;
> > -		__cpuc_coherent_kern_range(addr, addr + len);
> > +		__cpuc_flush_dcache_area(kaddr, len);
> > +		__flush_icache_all();
> 
> NAK.
> 

How about something like this instead?:

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index c6844cb..6b03043 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -20,10 +20,9 @@
 
 #include "mm.h"
 
-#ifdef CONFIG_CPU_CACHE_VIPT
-
 #define ALIAS_FLUSH_START      0xffff4000
 
+#ifdef CONFIG_CPU_CACHE_VIPT
 static void flush_pfn_alias(unsigned long pfn, unsigned long vaddr)
 {
        unsigned long to = ALIAS_FLUSH_START + (CACHE_COLOUR(vaddr) << PAGE_SHIFT);
@@ -93,6 +92,18 @@ void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsig
 #define flush_pfn_alias(pfn,vaddr)     do { } while (0)
 #endif
 
+static void flush_icache_alias(unsigned long pfn, unsigned long vaddr, unsigned long len)
+{
+       unsigned long colour = CACHE_COLOUR(vaddr);
+       unsigned long offset = vaddr & (PAGE_SIZE - 1);
+       unsigned long to;
+
+       set_pte_ext(TOP_PTE(ALIAS_FLUSH_START) + colour, pfn_pte(pfn, PAGE_KERNEL), 0);
+       to = ALIAS_FLUSH_START + (colour << PAGE_SHIFT) + offset;
+       flush_tlb_kernel_page(to);
+       flush_icache_range(to, to + len);
+}
+
 #ifdef CONFIG_SMP
 static void flush_ptrace_access_other(void *args)
 {
@@ -120,8 +131,7 @@ void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
 
        /* VIPT non-aliasing cache */
        if (vma->vm_flags & VM_EXEC) {
-               unsigned long addr = (unsigned long)kaddr;
-               __cpuc_coherent_kern_range(addr, addr + len);
+               flush_icache_alias(page_to_pfn(page), uaddr, len);
 #ifdef CONFIG_SMP
                if (cache_ops_need_broadcast())
                        smp_call_function(flush_ptrace_access_other,

That way we only use __flush_icache_all for non-aliasing D-caches in
the case that we have to broadcast the flushing using IPI.

Will
