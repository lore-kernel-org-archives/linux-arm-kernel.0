From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 20 Jul 2010 18:12:07 +0100
Subject: [PATCH 1/5] ARM: Allow lazy cache flushing via PG_arch_1 for
	highmem pages
In-Reply-To: <20100720171201.19582.85920.stgit@e102109-lin.cambridge.arm.com>
References: <20100720171201.19582.85920.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100720171207.19582.56915.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit d73cd42 forced non-lazy cache flushing of highmem pages in
flush_dcache_page(). This isn't needed since __flush_dcache_page()
(called lazily from update_mmu_cache) can handle highmem pages (fixed by
commit 7e5a69e).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
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
