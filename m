From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 25 Oct 2009 11:25:50 +0000
Subject: [RFC 08/11] ARM: Avoid evaluating page_address() multiple times
In-Reply-To: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <44c8d10c778430e959f79b7fb3380a786cae6a28.1256683230.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

page_address() is a function call rather than a macro, and so:

	if (page_address(page))
		do_something(page_address(page));

results in two calls to this function.  This is unnecessary; remove
the duplication.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/flush.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 4fa3d4d..dc66f86 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -113,6 +113,8 @@ void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
 
 void __flush_dcache_page(struct address_space *mapping, struct page *page)
 {
+	void *addr = page_address(page);
+
 	/*
 	 * Writeback any data associated with the kernel mapping of this
 	 * page.  This ensures that data in the physical page is mutually
@@ -123,9 +125,9 @@ void __flush_dcache_page(struct address_space *mapping, struct page *page)
 	 * kmap_atomic() doesn't set the page virtual address, and
 	 * kunmap_atomic() takes care of cache flushing already.
 	 */
-	if (page_address(page))
+	if (addr)
 #endif
-		__cpuc_flush_dcache_page(page_address(page));
+		__cpuc_flush_dcache_page(addr);
 
 	/*
 	 * If this is a page cache page, and we have an aliasing VIPT cache,
-- 
1.6.2.5
