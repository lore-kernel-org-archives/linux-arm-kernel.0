From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 Aug 2010 14:58:06 +0100
Subject: [PATCH 1/9] ARM: Allow lazy cache flushing via PG_arch_1 for
	highmem pages
In-Reply-To: <20100831135435.21304.38960.stgit@e102109-lin.cambridge.arm.com>
References: <20100831135435.21304.38960.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100831135800.21304.31374.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit d73cd42 forced non-lazy cache flushing of highmem pages in
flush_dcache_page(). This isn't needed since __flush_dcache_page()
(called lazily from update_mmu_cache) can handle highmem pages (fixed by
commit 7e5a69e).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
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
