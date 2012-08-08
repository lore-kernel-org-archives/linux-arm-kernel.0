From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 08 Aug 2012 15:05:47 -0000
Subject: [RFC 1/6] arm: cache-l2x0: make outer_cache_fns a field of
 l2x0_of_data
In-Reply-To: <1344438307-8468-1-git-send-email-gregory.clement@free-electrons.com>
References: <1344438307-8468-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1344438307-8468-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of having multiple functions belonging to outer_cache and
filling this structure on the fly, use a outer_cache_fns field inside
l2x0_of_data and just memcopy it into outer_cache depending of the
type of the l2x0 cache. For non DT case, the former code was kept.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Barry Song <21cnbao@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
---
 arch/arm/mm/cache-l2x0.c |   38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 2a8e380..3591940 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -39,7 +39,7 @@ struct l2x0_regs l2x0_saved_regs;
 struct l2x0_of_data {
 	void (*setup)(const struct device_node *, u32 *, u32 *);
 	void (*save)(void);
-	void (*resume)(void);
+	struct outer_cache_fns outer_cache;
 };
 
 static inline void cache_wait_way(void __iomem *reg, unsigned long mask)
@@ -376,6 +376,7 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 		writel_relaxed(1, l2x0_base + L2X0_CTRL);
 	}
 
+#ifndef CONFIG_OF
 	outer_cache.inv_range = l2x0_inv_range;
 	outer_cache.clean_range = l2x0_clean_range;
 	outer_cache.flush_range = l2x0_flush_range;
@@ -383,6 +384,7 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 	outer_cache.flush_all = l2x0_flush_all;
 	outer_cache.inv_all = l2x0_inv_all;
 	outer_cache.disable = l2x0_disable;
+#endif
 
 	printk(KERN_INFO "%s cache controller enabled\n", type);
 	printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x, Cache size: %d B\n",
@@ -533,15 +535,34 @@ static void pl310_resume(void)
 }
 
 static const struct l2x0_of_data pl310_data = {
-	pl310_of_setup,
-	pl310_save,
-	pl310_resume,
+	.setup = pl310_of_setup,
+	.save  = pl310_save,
+	.outer_cache = {
+		.resume      = pl310_resume,
+		.inv_range   = l2x0_inv_range,
+		.clean_range = l2x0_clean_range,
+		.flush_range = l2x0_flush_range,
+		.sync        = l2x0_cache_sync,
+		.flush_all   = l2x0_flush_all,
+		.inv_all     = l2x0_inv_all,
+		.disable     = l2x0_disable,
+		.set_debug   = pl310_set_debug,
+	},
 };
 
 static const struct l2x0_of_data l2x0_data = {
-	l2x0_of_setup,
-	NULL,
-	l2x0_resume,
+	.setup = l2x0_of_setup,
+	.save  = NULL,
+	.outer_cache = {
+		.resume      = l2x0_resume,
+		.inv_range   = l2x0_inv_range,
+		.clean_range = l2x0_clean_range,
+		.flush_range = l2x0_flush_range,
+		.sync        = l2x0_cache_sync,
+		.flush_all   = l2x0_flush_all,
+		.inv_all     = l2x0_inv_all,
+		.disable     = l2x0_disable,
+	},
 };
 
 static const struct of_device_id l2x0_ids[] __initconst = {
@@ -583,7 +604,8 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 
 	l2x0_init(l2x0_base, aux_val, aux_mask);
 
-	outer_cache.resume = data->resume;
+	memcpy(&outer_cache, &data->outer_cache, sizeof(outer_cache));
+
 	return 0;
 }
 #endif
-- 
1.7.9.5
