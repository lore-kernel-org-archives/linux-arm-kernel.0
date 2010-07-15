From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Jul 2010 16:53:58 +0100
Subject: [PATCH 2/2] ARM: flush_ptrace_access: invalidate all I-caches
In-Reply-To: <1279209238-16234-2-git-send-email-will.deacon@arm.com>
References: <1279209238-16234-1-git-send-email-will.deacon@arm.com>
	<1279209238-16234-2-git-send-email-will.deacon@arm.com>
Message-ID: <1279209238-16234-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

copy_to_user_page can be used by access_process_vm to write to an
executable page of a process using a mapping acquired by kmap.
For systems with I-cache aliasing, flushing the I-cache using the
Kernel mapping may leave stale data in the I-cache if the user
mapping is of a different colour.

This patch replaces the coherent_kern_range call in flush_ptrace_access
with a D-cache flush followed by a system-wide I-cache invalidation.
This is required on all systems where the size of a way in the I-cache
is larger than PAGE_SIZE.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/flush.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index c6844cb..45896a9 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -120,8 +120,8 @@ void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
 
 	/* VIPT non-aliasing cache */
 	if (vma->vm_flags & VM_EXEC) {
-		unsigned long addr = (unsigned long)kaddr;
-		__cpuc_coherent_kern_range(addr, addr + len);
+		__cpuc_flush_dcache_area(kaddr, len);
+		__flush_icache_all();
 #ifdef CONFIG_SMP
 		if (cache_ops_need_broadcast())
 			smp_call_function(flush_ptrace_access_other,
-- 
1.6.3.3
