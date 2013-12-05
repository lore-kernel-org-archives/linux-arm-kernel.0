From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 5 Dec 2013 14:29:21 -0500 (EST)
Subject: [PATCH] clean up cache handling in core code
Message-ID: <alpine.LFD.2.10.1312051426230.31246@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

----- Message Text -----
We have a handy macro to replace open coded __cpuc_flush_dcache_area(()
and outer_clean_range() sequences. Let's use it. No functional change.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index 26020a03f6..87c5f1b595 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -35,8 +35,7 @@ void mcpm_set_early_poke(unsigned cpu, unsigned cluster,
 	unsigned long *poke = &mcpm_entry_early_pokes[cluster][cpu][0];
 	poke[0] = poke_phys_addr;
 	poke[1] = poke_val;
-	__cpuc_flush_dcache_area((void *)poke, 8);
-	outer_clean_range(__pa(poke), __pa(poke + 2));
+	__sync_cache_range_w(poke, 2 * sizeof(*poke));
 }
 
 static const struct mcpm_platform_ops *platform_ops;
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index dc894ab362..8c61325b8b 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -105,8 +105,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	secondary_data.pgdir = get_arch_pgd(idmap_pgd);
 	secondary_data.swapper_pg_dir = get_arch_pgd(swapper_pg_dir);
 #endif
-	__cpuc_flush_dcache_area(&secondary_data, sizeof(secondary_data));
-	outer_clean_range(__pa(&secondary_data), __pa(&secondary_data + 1));
+	sync_cache_w(&secondary_data);
 
 	/*
 	 * Now bring the CPU into our world.
