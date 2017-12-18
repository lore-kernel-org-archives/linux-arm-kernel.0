From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Dec 2017 14:41:11 +0100
Subject: [PATCH] ARM: B15: fix unused label warnings
Message-ID: <20171218134126.2913861-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new conditionally compiled code leaves some labels and one
variable unreferenced when CONFIG_HOTPLUG_CPU and CONFIG_PM_SLEEP
are disabled:

arch/arm/mm/cache-b15-rac.c: In function 'b15_rac_init':
arch/arm/mm/cache-b15-rac.c:353:1: error: label 'out_unmap' defined but not used [-Werror=unused-label]
 out_unmap:
 ^~~~~~~~~
arch/arm/mm/cache-b15-rac.c:351:1: error: label 'out_cpu_dead' defined but not used [-Werror=unused-label]
 out_cpu_dead:
 ^~~~~~~~~~~~
At top level:
arch/arm/mm/cache-b15-rac.c:53:12: error: 'rac_config0_reg' defined but not used [-Werror=unused-variable]

This adds more #ifdefs around them.

Fixes: 55de88778f4b ("ARM: 8726/1: B15: Add CPU hotplug awareness")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Florian, if this looks good to you, please forward the fix into Russell's
patch tracker, otherwise just send a better fix.
---
 arch/arm/mm/cache-b15-rac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mm/cache-b15-rac.c b/arch/arm/mm/cache-b15-rac.c
index f76988790011..24cb3b7a0501 100644
--- a/arch/arm/mm/cache-b15-rac.c
+++ b/arch/arm/mm/cache-b15-rac.c
@@ -50,7 +50,10 @@ extern void v7_flush_kern_cache_all(void);
 
 static void __iomem *b15_rac_base;
 static DEFINE_SPINLOCK(rac_lock);
+
+#if IS_ENABLED(CONFIG_HOTPLUG_CPU) || IS_ENABLED(CONFIG_PM_SLEEP)
 static u32 rac_config0_reg;
+#endif
 
 /* Initialization flag to avoid checking for b15_rac_base, and to prevent
  * multi-platform kernels from crashing here as well.
@@ -348,11 +351,13 @@ static int __init b15_rac_init(void)
 
 	goto out;
 
+#ifdef CONFIG_HOTPLUG_CPU
 out_cpu_dead:
 	cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CACHE_B15_RAC_DYING);
 out_unmap:
 	unregister_reboot_notifier(&b15_rac_reboot_nb);
 	iounmap(b15_rac_base);
+#endif
 out:
 	of_node_put(dn);
 	return ret;
-- 
2.9.0
