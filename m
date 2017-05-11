From: zhangshaokun@hisilicon.com (Shaokun Zhang)
Date: Thu, 11 May 2017 16:19:32 +0800
Subject: [PATCH] arm64: mm: check length in sync_icache_aliases for performance
Message-ID: <1494490772-203184-1-git-send-email-zhangshaokun@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sync_icache_aliases calls flush_icache_range if icache is non-aliasing
policy[see 0a28714 ("arm64: Use PoU cache instr for I/D coherency")].
  
If icache uses non-aliasing and page size is 64K, it will broadcast 1K
DVMs(IC IVAU) to other cpu cores per page. In multi-cores system, so many
DVMs would degenerate performance. Even if page size is 4K, 64 DVMs will
be broadcasted and executed.
 
This patch fixes this issue using invalidation icache all instread of by
VA when length is one or multiple PAGE_SIZE, especailly for
__sync_icache_dcache.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 arch/arm64/mm/flush.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 21a8d82..f71da2d 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -29,7 +29,7 @@ void sync_icache_aliases(void *kaddr, unsigned long len)
 {
 	unsigned long addr = (unsigned long)kaddr;
 
-	if (icache_is_aliasing()) {
+	if ((len >= PAGE_SIZE) || icache_is_aliasing()) {
 		__clean_dcache_area_pou(kaddr, len);
 		__flush_icache_all();
 	} else {
-- 
1.9.1
