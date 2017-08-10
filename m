From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Aug 2017 16:52:31 +0200
Subject: [PATCH] arm64: fix pmem interface definition
Message-ID: <20170810145253.2124019-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Defining the two functions as 'static inline' and exporting them
leads to the interesting case where we can use the interface
from loadable modules, but not from built-in drivers, as shown
in this link failure:

vers/nvdimm/claim.o: In function `nsio_rw_bytes':
claim.c:(.text+0x1b8): undefined reference to `arch_invalidate_pmem'
drivers/nvdimm/pmem.o: In function `pmem_dax_flush':
pmem.c:(.text+0x11c): undefined reference to `arch_wb_cache_pmem'
drivers/nvdimm/pmem.o: In function `pmem_make_request':
pmem.c:(.text+0x5a4): undefined reference to `arch_invalidate_pmem'
pmem.c:(.text+0x650): undefined reference to `arch_invalidate_pmem'
pmem.c:(.text+0x6d4): undefined reference to `arch_invalidate_pmem'

This removes the bogus 'static inline'.

Fixes: d50e071fdaa3 ("arm64: Implement pmem API support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/mm/flush.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 280f90ff33a2..e36ed5087b5c 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -85,7 +85,7 @@ EXPORT_SYMBOL(flush_dcache_page);
 EXPORT_SYMBOL(flush_icache_range);
 
 #ifdef CONFIG_ARCH_HAS_PMEM_API
-static inline void arch_wb_cache_pmem(void *addr, size_t size)
+void arch_wb_cache_pmem(void *addr, size_t size)
 {
 	/* Ensure order against any prior non-cacheable writes */
 	dmb(osh);
@@ -93,7 +93,7 @@ static inline void arch_wb_cache_pmem(void *addr, size_t size)
 }
 EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
 
-static inline void arch_invalidate_pmem(void *addr, size_t size)
+void arch_invalidate_pmem(void *addr, size_t size)
 {
 	__inval_dcache_area(addr, size);
 }
-- 
2.9.0
