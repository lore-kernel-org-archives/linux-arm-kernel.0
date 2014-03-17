From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:13:35 +0000
Subject: [PATCH 01/44] ARM: l2c: remove outer_inv_all() method
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLBP-0002bl-Ub@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No one ever calls this function anywhere in the kernel, so let's
completely remove it from the outer cache API and turn it into an
internal-only thing.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/outercache.h | 8 --------
 arch/arm/mm/cache-feroceon-l2.c   | 1 -
 arch/arm/mm/cache-l2x0.c          | 5 -----
 3 files changed, 14 deletions(-)

diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index f94784f0e3a6..0e4420858990 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -28,7 +28,6 @@ struct outer_cache_fns {
 	void (*clean_range)(unsigned long, unsigned long);
 	void (*flush_range)(unsigned long, unsigned long);
 	void (*flush_all)(void);
-	void (*inv_all)(void);
 	void (*disable)(void);
 #ifdef CONFIG_OUTER_CACHE_SYNC
 	void (*sync)(void);
@@ -63,12 +62,6 @@ static inline void outer_flush_all(void)
 		outer_cache.flush_all();
 }
 
-static inline void outer_inv_all(void)
-{
-	if (outer_cache.inv_all)
-		outer_cache.inv_all();
-}
-
 static inline void outer_disable(void)
 {
 	if (outer_cache.disable)
@@ -90,7 +83,6 @@ static inline void outer_clean_range(phys_addr_t start, phys_addr_t end)
 static inline void outer_flush_range(phys_addr_t start, phys_addr_t end)
 { }
 static inline void outer_flush_all(void) { }
-static inline void outer_inv_all(void) { }
 static inline void outer_disable(void) { }
 static inline void outer_resume(void) { }
 
diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
index aae891820f8f..901a0f7280dc 100644
--- a/arch/arm/mm/cache-feroceon-l2.c
+++ b/arch/arm/mm/cache-feroceon-l2.c
@@ -345,7 +345,6 @@ void __init feroceon_l2_init(int __l2_wt_override)
 	outer_cache.inv_range = feroceon_l2_inv_range;
 	outer_cache.clean_range = feroceon_l2_clean_range;
 	outer_cache.flush_range = feroceon_l2_flush_range;
-	outer_cache.inv_all = l2_inv_all;
 
 	enable_l2();
 
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 7abde2ce8973..f9985e5a208c 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -414,7 +414,6 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 		outer_cache.flush_range = l2x0_flush_range;
 		outer_cache.sync = l2x0_cache_sync;
 		outer_cache.flush_all = l2x0_flush_all;
-		outer_cache.inv_all = l2x0_inv_all;
 		outer_cache.disable = l2x0_disable;
 	}
 
@@ -884,7 +883,6 @@ static const struct l2x0_of_data pl310_data = {
 		.flush_range = l2x0_flush_range,
 		.sync        = l2x0_cache_sync,
 		.flush_all   = l2x0_flush_all,
-		.inv_all     = l2x0_inv_all,
 		.disable     = l2x0_disable,
 	},
 };
@@ -899,7 +897,6 @@ static const struct l2x0_of_data l2x0_data = {
 		.flush_range = l2x0_flush_range,
 		.sync        = l2x0_cache_sync,
 		.flush_all   = l2x0_flush_all,
-		.inv_all     = l2x0_inv_all,
 		.disable     = l2x0_disable,
 	},
 };
@@ -914,7 +911,6 @@ static const struct l2x0_of_data aurora_with_outer_data = {
 		.flush_range = aurora_flush_range,
 		.sync        = l2x0_cache_sync,
 		.flush_all   = l2x0_flush_all,
-		.inv_all     = l2x0_inv_all,
 		.disable     = l2x0_disable,
 	},
 };
@@ -946,7 +942,6 @@ static const struct l2x0_of_data bcm_l2x0_data = {
 		.flush_range = bcm_flush_range,
 		.sync        = l2x0_cache_sync,
 		.flush_all   = l2x0_flush_all,
-		.inv_all     = l2x0_inv_all,
 		.disable     = l2x0_disable,
 	},
 };
-- 
1.8.3.1
