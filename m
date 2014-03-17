From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:16:25 +0000
Subject: [PATCH 34/44] ARM: outer cache: add documentation of outer cache
 functions
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLE9-0002e9-02@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add some documentation to cover the outer cache functions so that their
requirements can be better understood.  Of particular note are the
flush_all() and disable() methods which must not be called except in
very specific circumstances.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/outercache.h | 48 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index 0e4420858990..bd80540fe8b9 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -39,35 +39,75 @@ struct outer_cache_fns {
 extern struct outer_cache_fns outer_cache;
 
 #ifdef CONFIG_OUTER_CACHE
-
+/**
+ * outer_inv_range: invalidate range of outer cache lines
+ * @start: starting physical address, inclusive
+ * @end: end physical address, exclusive
+ */
 static inline void outer_inv_range(phys_addr_t start, phys_addr_t end)
 {
 	if (outer_cache.inv_range)
 		outer_cache.inv_range(start, end);
 }
+
+/**
+ * outer_clean_range: clean dirty outer cache lines
+ * @start: starting physical address, inclusive
+ * @end: end physical address, exclusive
+ */
 static inline void outer_clean_range(phys_addr_t start, phys_addr_t end)
 {
 	if (outer_cache.clean_range)
 		outer_cache.clean_range(start, end);
 }
+
+/**
+ * outer_flush_range: clean and invalidate outer cache lines
+ * @start: starting physical address, inclusive
+ * @end: end physical address, exclusive
+ */
 static inline void outer_flush_range(phys_addr_t start, phys_addr_t end)
 {
 	if (outer_cache.flush_range)
 		outer_cache.flush_range(start, end);
 }
 
+/**
+ * outer_flush_all: clean and invalidate all cache lines in the outer cache
+ *
+ * Note: depending on implementation, this may not be atomic - it must
+ * only be called with interrupts disabled and no other active outer
+ * cache masters.
+ *
+ * It is intended that this function is only used by implementations
+ * needing to override the outer_cache.disable() method due to security.
+ * (Some implementations perform this as a clean followed by an invalidate.)
+ */
 static inline void outer_flush_all(void)
 {
 	if (outer_cache.flush_all)
 		outer_cache.flush_all();
 }
 
+/**
+ * outer_disable: clean, invalidate and disable the outer cache
+ *
+ * Disable the outer cache, ensuring that any data contained in the outer
+ * cache is pushed out to lower levels of system memory.  The note and
+ * conditions above concerning outer_flush_all() applies here.
+ */
 static inline void outer_disable(void)
 {
 	if (outer_cache.disable)
 		outer_cache.disable();
 }
 
+/**
+ * outer_resume: restore the cache configuration and re-enable outer cache
+ *
+ * Restore any configuration that the cache had when previously enabled,
+ * and re-enable the outer cache.
+ */
 static inline void outer_resume(void)
 {
 	if (outer_cache.resume)
@@ -89,6 +129,12 @@ static inline void outer_resume(void) { }
 #endif
 
 #ifdef CONFIG_OUTER_CACHE_SYNC
+/**
+ * outer_sync: perform a sync point for outer cache
+ *
+ * Ensure that all outer cache operations are complete and any store
+ * buffers are drained.
+ */
 static inline void outer_sync(void)
 {
 	if (outer_cache.sync)
-- 
1.8.3.1
