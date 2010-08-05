From: will.deacon@arm.com (Will Deacon)
Date: Thu,  5 Aug 2010 11:36:49 +0100
Subject: [PATCH 2/2] ARM: flush_ptrace_access: invalidate correct I-cache alias
In-Reply-To: <1281004609-7563-2-git-send-email-will.deacon@arm.com>
References: <1281004609-7563-1-git-send-email-will.deacon@arm.com>
	<1281004609-7563-2-git-send-email-will.deacon@arm.com>
Message-ID: <1281004609-7563-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

copy_to_user_page can be used by access_process_vm to write to an
executable page of a process using a mapping acquired by kmap.
For systems with I-cache aliasing, flushing the I-cache using the
Kernel mapping may leave stale data in the I-cache if the user
mapping is of a different colour.

This patch introduces a flush_icache_alias function to flush.c,
which calls flush_icache_range with a mapping of the specified
colour. flush_ptrace_access is then modified to call this new
function instead of coherent_kern_range in the case of an aliasing
I-cache and a non-aliasing D-cache.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/flush.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index c6844cb..25c771c 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -39,6 +39,18 @@ static void flush_pfn_alias(unsigned long pfn, unsigned long vaddr)
 	    : "cc");
 }
 
+static void flush_icache_alias(unsigned long pfn, unsigned long vaddr, unsigned long len)
+{
+	unsigned long colour = CACHE_COLOUR(vaddr);
+	unsigned long offset = vaddr & (PAGE_SIZE - 1);
+	unsigned long to;
+
+	set_pte_ext(TOP_PTE(ALIAS_FLUSH_START) + colour, pfn_pte(pfn, PAGE_KERNEL), 0);
+	to = ALIAS_FLUSH_START + (colour << PAGE_SHIFT) + offset;
+	flush_tlb_kernel_page(to);
+	flush_icache_range(to, to + len);
+}
+
 void flush_cache_mm(struct mm_struct *mm)
 {
 	if (cache_is_vivt()) {
@@ -89,8 +101,10 @@ void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsig
 	if (vma->vm_flags & VM_EXEC && icache_is_vivt_asid_tagged())
 		__flush_icache_all();
 }
+
 #else
-#define flush_pfn_alias(pfn,vaddr)	do { } while (0)
+#define flush_pfn_alias(pfn,vaddr)		do { } while (0)
+#define flush_icache_alias(pfn,vaddr,len)	do { } while (0)
 #endif
 
 #ifdef CONFIG_SMP
@@ -118,10 +132,13 @@ void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
 		return;
 	}
 
-	/* VIPT non-aliasing cache */
+	/* VIPT non-aliasing D-cache */
 	if (vma->vm_flags & VM_EXEC) {
 		unsigned long addr = (unsigned long)kaddr;
-		__cpuc_coherent_kern_range(addr, addr + len);
+		if (icache_is_vipt_aliasing())
+			flush_icache_alias(page_to_pfn(page), uaddr, len);
+		else
+			__cpuc_coherent_kern_range(addr, addr + len);
 #ifdef CONFIG_SMP
 		if (cache_ops_need_broadcast())
 			smp_call_function(flush_ptrace_access_other,
-- 
1.6.3.3
