From: vkale@apm.com (Vinayak Kale)
Date: Wed,  5 Feb 2014 15:04:36 +0530
Subject: [PATCH] arm64: add DSB after icache flush in __flush_icache_all()
Message-ID: <1391592876-18627-1-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DSB after icache flush to complete the cache maintenance operation.
The function __flush_icache_all() is used only for user space mappings
and an ISB is not required because of an exception return before executing
user instructions. An exception return would behave like an ISB.

Signed-off-by: Vinayak Kale <vkale@apm.com>
---
 arch/arm64/include/asm/cacheflush.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index fea9ee3..88932498 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -116,6 +116,7 @@ extern void flush_dcache_page(struct page *);
 static inline void __flush_icache_all(void)
 {
 	asm("ic	ialluis");
+	dsb();
 }
 
 #define flush_dcache_mmap_lock(mapping) \
-- 
1.7.9.5
