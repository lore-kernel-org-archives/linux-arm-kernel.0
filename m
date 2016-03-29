From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 29 Mar 2016 10:38:24 +0900
Subject: [PATCH 2/2] ARM: uniphier: initialize outer cache for secondary CPUs
In-Reply-To: <1459215505-18035-1-git-send-email-yamada.masahiro@socionext.com>
References: <1459215505-18035-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1459215505-18035-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some parts of this outer cache need per-CPU initialization.  The
registers for controlling active ways are banked for each CPU.

Each secondary CPU should activate ways at its boot-up.  Otherwise,
the data in the outer cache are not refilled in case of cache miss
from secondary CPUs, making data access extremely inefficient.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/include/asm/hardware/cache-uniphier.h |  5 +++++
 arch/arm/mach-uniphier/platsmp.c               |  1 +
 arch/arm/mm/cache-uniphier.c                   | 19 ++++++++++++++++---
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-uniphier.h b/arch/arm/include/asm/hardware/cache-uniphier.h
index 102e3fb..6bfa9d5 100644
--- a/arch/arm/include/asm/hardware/cache-uniphier.h
+++ b/arch/arm/include/asm/hardware/cache-uniphier.h
@@ -19,6 +19,7 @@
 
 #ifdef CONFIG_CACHE_UNIPHIER
 int uniphier_cache_init(void);
+void uniphier_cache_secondary_init(void);
 int uniphier_cache_l2_is_enabled(void);
 void uniphier_cache_l2_touch_range(unsigned long start, unsigned long end);
 void uniphier_cache_l2_set_locked_ways(u32 way_mask);
@@ -28,6 +29,10 @@ static inline int uniphier_cache_init(void)
 	return -ENODEV;
 }
 
+static inline void uniphier_cache_secondary_init(void)
+{
+}
+
 static inline int uniphier_cache_l2_is_enabled(void)
 {
 	return 0;
diff --git a/arch/arm/mach-uniphier/platsmp.c b/arch/arm/mach-uniphier/platsmp.c
index 285b684..80c04cf 100644
--- a/arch/arm/mach-uniphier/platsmp.c
+++ b/arch/arm/mach-uniphier/platsmp.c
@@ -226,6 +226,7 @@ static int __init uniphier_smp_boot_secondary(unsigned int cpu,
 static void __init uniphier_smp_secondary_init(unsigned int cpu)
 {
 	uniphier_smp_fixup_cache_broadcast();
+	uniphier_cache_secondary_init();
 }
 
 static const struct smp_operations uniphier_smp_ops __initconst = {
diff --git a/arch/arm/mm/cache-uniphier.c b/arch/arm/mm/cache-uniphier.c
index a6fa7b7..4e6f352 100644
--- a/arch/arm/mm/cache-uniphier.c
+++ b/arch/arm/mm/cache-uniphier.c
@@ -314,16 +314,24 @@ static void uniphier_cache_disable(void)
 	uniphier_cache_flush_all();
 }
 
+static void __init uniphier_cache_activate_all_ways(void)
+{
+	struct uniphier_cache_data *data;
+
+	list_for_each_entry(data, &uniphier_cache_list, list)
+		__uniphier_cache_set_locked_ways(data, 0);
+}
+
 static void __init uniphier_cache_enable(void)
 {
 	struct uniphier_cache_data *data;
 
 	uniphier_cache_inv_all();
 
-	list_for_each_entry(data, &uniphier_cache_list, list) {
+	list_for_each_entry(data, &uniphier_cache_list, list)
 		__uniphier_cache_enable(data, true);
-		__uniphier_cache_set_locked_ways(data, 0);
-	}
+
+	uniphier_cache_activate_all_ways();
 }
 
 static void uniphier_cache_sync(void)
@@ -542,3 +550,8 @@ int __init uniphier_cache_init(void)
 
 	return ret;
 }
+
+void uniphier_cache_secondary_init(void)
+{
+	uniphier_cache_activate_all_ways();
+}
-- 
1.9.1
