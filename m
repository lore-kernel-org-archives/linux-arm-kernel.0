From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Sat, 10 Nov 2018 22:02:22 +0100
Subject: [PATCH 1/3] ARM: cache-l2x0: share l2x0_base with PMU code
In-Reply-To: <cover.1541882833.git.mirq-linux@rere.qmqm.pl>
References: <cover.1541882833.git.mirq-linux@rere.qmqm.pl>
Message-ID: <bece26283d1a4f48c20b7e526332b4a696670fcb.1541882833.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid l2x0_base duplication with PMU driver by sharing it
and using l2x0_name as the 'enabled' flag instead. Since l2x0_name is
not used for anything else, mark it as __initdata.

This will also be needed for cache maintenance with Trusted Foundations
firmware.

Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
---
 arch/arm/include/asm/hardware/cache-l2x0.h | 6 ++++--
 arch/arm/mm/cache-l2x0-pmu.c               | 9 +++------
 arch/arm/mm/cache-l2x0.c                   | 6 +++---
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 736292b42fca..665eb0758417 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -167,11 +167,11 @@ static inline int l2x0_of_init(u32 aux_val, u32 aux_mask)
 #endif
 
 #ifdef CONFIG_CACHE_L2X0_PMU
-void l2x0_pmu_register(void __iomem *base, u32 part);
+void l2x0_pmu_register(u32 part);
 void l2x0_pmu_suspend(void);
 void l2x0_pmu_resume(void);
 #else
-static inline void l2x0_pmu_register(void __iomem *base, u32 part) {}
+static inline void l2x0_pmu_register(u32 part) {}
 static inline void l2x0_pmu_suspend(void) {}
 static inline void l2x0_pmu_resume(void) {}
 #endif
@@ -193,6 +193,8 @@ struct l2x0_regs {
 	unsigned long aux2_ctrl;
 };
 
+extern void __iomem *l2x0_base;
+extern u32 l2x0_way_mask;	/* Bitmask of active ways */
 extern struct l2x0_regs l2x0_saved_regs;
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
index afe5b4c7b164..6be335ae4e2f 100644
--- a/arch/arm/mm/cache-l2x0-pmu.c
+++ b/arch/arm/mm/cache-l2x0-pmu.c
@@ -29,11 +29,10 @@
 
 #define PMU_NR_COUNTERS 2
 
-static void __iomem *l2x0_base;
 static struct pmu *l2x0_pmu;
 static cpumask_t pmu_cpu;
 
-static const char *l2x0_name;
+static const char *__initdata l2x0_name = NULL;
 
 static ktime_t l2x0_pmu_poll_period;
 static struct hrtimer l2x0_pmu_hrtimer;
@@ -491,7 +490,7 @@ void l2x0_pmu_resume(void)
 	l2x0_pmu_enable(l2x0_pmu);
 }
 
-void __init l2x0_pmu_register(void __iomem *base, u32 part)
+void __init l2x0_pmu_register(u32 part)
 {
 	/*
 	 * Determine whether we support the PMU, and choose the name for sysfs.
@@ -516,15 +515,13 @@ void __init l2x0_pmu_register(void __iomem *base, u32 part)
 	default:
 		return;
 	}
-
-	l2x0_base = base;
 }
 
 static __init int l2x0_pmu_init(void)
 {
 	int ret;
 
-	if (!l2x0_base)
+	if (!l2x0_name)
 		return 0;
 
 	l2x0_pmu = kzalloc(sizeof(*l2x0_pmu), GFP_KERNEL);
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index ea1e70ff4568..2b6a023fea3f 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -48,13 +48,13 @@ struct l2c_init_data {
 
 #define CACHE_LINE_SIZE		32
 
-static void __iomem *l2x0_base;
 static const struct l2c_init_data *l2x0_data;
 static DEFINE_RAW_SPINLOCK(l2x0_lock);
-static u32 l2x0_way_mask;	/* Bitmask of active ways */
 static u32 l2x0_size;
 static unsigned long sync_reg_offset = L2X0_CACHE_SYNC;
 
+void __iomem *l2x0_base;
+u32 l2x0_way_mask;	/* Bitmask of active ways */
 struct l2x0_regs l2x0_saved_regs;
 
 static bool l2x0_bresp_disable;
@@ -900,7 +900,7 @@ static int __init __l2c_init(const struct l2c_init_data *data,
 	pr_info("%s: CACHE_ID 0x%08x, AUX_CTRL 0x%08x\n",
 		data->type, cache_id, aux);
 
-	l2x0_pmu_register(l2x0_base, cache_id);
+	l2x0_pmu_register(cache_id);
 
 	return 0;
 }
-- 
2.19.1
