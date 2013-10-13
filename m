From: eranpublic@yahoo.com (Eran Ben-Avi)
Date: Sun, 13 Oct 2013 19:44:39 +0300
Subject: [PATCH] ARM: l2x0: define l2x0_cache_sync according to
 OUTER_CACHE_SYNC selection
Message-ID: <1381682679-23418-1-git-send-email-eranpublic@yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Always define outer_cache_fns sync member and conditionally assign
l2x0_cache_sync depends on OUTER_CACHE_SYNC selection state.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Eran Ben-Avi <benavi@marvell.com>
---
 arch/arm/include/asm/outercache.h |    2 --
 arch/arm/mm/cache-l2x0.c          |    4 ++++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index f94784f..697317c 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -30,9 +30,7 @@ struct outer_cache_fns {
 	void (*flush_all)(void);
 	void (*inv_all)(void);
 	void (*disable)(void);
-#ifdef CONFIG_OUTER_CACHE_SYNC
 	void (*sync)(void);
-#endif
 	void (*set_debug)(unsigned long);
 	void (*resume)(void);
 };
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 447da6f..5f3a0ca 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -128,6 +128,7 @@ static inline void l2x0_flush_line(unsigned long addr)
 }
 #endif
 
+#ifdef CONFIG_OUTER_CACHE_SYNC
 static void l2x0_cache_sync(void)
 {
 	unsigned long flags;
@@ -136,6 +137,9 @@ static void l2x0_cache_sync(void)
 	cache_sync();
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
+#else
+#define l2x0_cache_sync	NULL
+#endif
 
 static void __l2x0_flush_all(void)
 {
-- 
1.7.10.4
