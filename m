From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 24 Oct 2009 22:58:40 +0100
Subject: [RFC 03/11] ARM: move __flush_icache_all() out of flush_pfn_alias()
In-Reply-To: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <8ca70e1506b186ae7e711713ad7d4edd5ebb5c49.1256683230.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/flush.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 7f294f3..4e2a4e7 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -35,7 +35,6 @@ static void flush_pfn_alias(unsigned long pfn, unsigned long vaddr)
 	    :
 	    : "r" (to), "r" (to + PAGE_SIZE - L1_CACHE_BYTES), "r" (zero)
 	    : "cc");
-	__flush_icache_all();
 }
 
 void flush_cache_mm(struct mm_struct *mm)
@@ -85,8 +84,10 @@ void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsig
 		return;
 	}
 
-	if (cache_is_vipt_aliasing())
+	if (cache_is_vipt_aliasing()) {
 		flush_pfn_alias(pfn, user_addr);
+		__flush_icache_all();
+	}
 }
 
 void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
@@ -103,6 +104,7 @@ void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
 
 	if (cache_is_vipt_aliasing()) {
 		flush_pfn_alias(page_to_pfn(page), uaddr);
+		__flush_icache_all();
 		return;
 	}
 
@@ -139,9 +141,11 @@ void __flush_dcache_page(struct address_space *mapping, struct page *page)
 	 * we only need to do one flush - which would be at the relevant
 	 * userspace colour, which is congruent with page->index.
 	 */
-	if (mapping && cache_is_vipt_aliasing())
+	if (mapping && cache_is_vipt_aliasing()) {
 		flush_pfn_alias(page_to_pfn(page),
 				page->index << PAGE_CACHE_SHIFT);
+		__flush_icache_all();
+	}
 }
 
 static void __flush_dcache_aliases(struct address_space *mapping, struct page *page)
@@ -242,6 +246,7 @@ void __flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned l
 		 * userspace address only.
 		 */
 		flush_pfn_alias(pfn, vmaddr);
+		__flush_icache_all();
 	}
 
 	/*
-- 
1.6.2.5
