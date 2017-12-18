From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Dec 2017 17:52:58 +0100
Subject: [PATCH] [v2] ARM: B15: fix unused label warnings
Message-ID: <20171218165307.1472231-1-arnd@arndb.de>
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

This replaces the existing #ifdef conditionals with IS_ENABLED()
checks that let the compiler figure out for itself which code to
drop.

Fixes: 55de88778f4b ("ARM: 8726/1: B15: Add CPU hotplug awareness")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use fewer #ifdef rather than adding more
---
 arch/arm/mm/cache-b15-rac.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mm/cache-b15-rac.c b/arch/arm/mm/cache-b15-rac.c
index f76988790011..d9586ba2e63c 100644
--- a/arch/arm/mm/cache-b15-rac.c
+++ b/arch/arm/mm/cache-b15-rac.c
@@ -50,6 +50,7 @@ extern void v7_flush_kern_cache_all(void);
 
 static void __iomem *b15_rac_base;
 static DEFINE_SPINLOCK(rac_lock);
+
 static u32 rac_config0_reg;
 
 /* Initialization flag to avoid checking for b15_rac_base, and to prevent
@@ -175,7 +176,6 @@ static struct notifier_block b15_rac_reboot_nb = {
 	.notifier_call	= b15_rac_reboot_notifier,
 };
 
-#ifdef CONFIG_HOTPLUG_CPU
 /* The CPU hotplug case is the most interesting one, we basically need to make
  * sure that the RAC is disabled for the entire system prior to having a CPU
  * die, in particular prior to this dying CPU having exited the coherency
@@ -253,9 +253,7 @@ static int b15_rac_dead_cpu(unsigned int cpu)
 
 	return 0;
 }
-#endif /* CONFIG_HOTPLUG_CPU */
 
-#ifdef CONFIG_PM_SLEEP
 static int b15_rac_suspend(void)
 {
 	/* Suspend the read-ahead cache oeprations, forcing our cache
@@ -286,7 +284,6 @@ static struct syscore_ops b15_rac_syscore_ops = {
 	.suspend	= b15_rac_suspend,
 	.resume		= b15_rac_resume,
 };
-#endif
 
 static int __init b15_rac_init(void)
 {
@@ -315,23 +312,22 @@ static int __init b15_rac_init(void)
 		goto out;
 	}
 
-#ifdef CONFIG_HOTPLUG_CPU
-	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ARM_CACHE_B15_RAC_DEAD,
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+		ret = cpuhp_setup_state_nocalls(CPUHP_AP_ARM_CACHE_B15_RAC_DEAD,
 					"arm/cache-b15-rac:dead",
 					NULL, b15_rac_dead_cpu);
-	if (ret)
-		goto out_unmap;
+		if (ret)
+			goto out_unmap;
 
-	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
+		ret = cpuhp_setup_state_nocalls(CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
 					"arm/cache-b15-rac:dying",
 					NULL, b15_rac_dying_cpu);
-	if (ret)
-		goto out_cpu_dead;
-#endif
+		if (ret)
+			goto out_cpu_dead;
+	}
 
-#ifdef CONFIG_PM_SLEEP
-	register_syscore_ops(&b15_rac_syscore_ops);
-#endif
+	if (IS_ENABLED(CONFIG_PM_SLEEP))
+		register_syscore_ops(&b15_rac_syscore_ops);
 
 	spin_lock(&rac_lock);
 	reg = __raw_readl(b15_rac_base + RAC_CONFIG0_REG);
-- 
2.9.0
