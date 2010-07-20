From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 20 Jul 2010 13:41:02 +0100
Subject: [RFC PATCH] ARM: Allow lazy cache flushing via PG_arch_1 for
	highmem pages
Message-ID: <20100720124102.7163.46919.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current flush_dcache_page() implementation does not allow lazy cache
flushing for highmem pages (introduced by commit d73cd42) on the
assumption that the temporary kmap mapping would disappear. A subsequent
commit (7e5a69e) allows __flush_dcache_page() to handle highmem pages so
we can allow lazy cache flushing even for highmem pages.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
---
 arch/arm/mm/flush.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index c6844cb..87dd5ff 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -247,7 +247,7 @@ void flush_dcache_page(struct page *page)
 	mapping = page_mapping(page);
 
 #ifndef CONFIG_SMP
-	if (!PageHighMem(page) && mapping && !mapping_mapped(mapping))
+	if (mapping && !mapping_mapped(mapping))
 		set_bit(PG_dcache_dirty, &page->flags);
 	else
 #endif
