From: p.pisati@gmail.com (Paolo Pisati)
Date: Wed, 22 Aug 2018 16:55:32 +0200
Subject: [PATCH] ARM: tango: register pm ops only if running on tango hw
Message-ID: <1534949732-3824-1-git-send-email-p.pisati@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a multiplatform kernel, avoid invoking hardware specific pm ops,
when running on a different SOC.

Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 arch/arm/mach-tango/pm.c    | 5 +----
 arch/arm/mach-tango/setup.c | 7 +++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tango/pm.c b/arch/arm/mach-tango/pm.c
index 028e50c..ea8fe20 100644
--- a/arch/arm/mach-tango/pm.c
+++ b/arch/arm/mach-tango/pm.c
@@ -24,10 +24,7 @@ static const struct platform_suspend_ops tango_pm_ops = {
 	.valid = suspend_valid_only_mem,
 };
 
-static int __init tango_pm_init(void)
+void __init tango_pm_init(void)
 {
 	suspend_set_ops(&tango_pm_ops);
-	return 0;
 }
-
-late_initcall(tango_pm_init);
diff --git a/arch/arm/mach-tango/setup.c b/arch/arm/mach-tango/setup.c
index 677dd7b..56a1c0c 100644
--- a/arch/arm/mach-tango/setup.c
+++ b/arch/arm/mach-tango/setup.c
@@ -11,8 +11,15 @@ static void tango_l2c_write(unsigned long val, unsigned int reg)
 
 static const char *const tango_dt_compat[] = { "sigma,tango4", NULL };
 
+#ifdef CONFIG_PM_SLEEP
+extern void tango_pm_init(void);
+#else
+static inline void tango_pm_init(void) {}
+#endif
+
 DT_MACHINE_START(TANGO_DT, "Sigma Tango DT")
 	.dt_compat	= tango_dt_compat,
+	.init_machine	= tango_pm_init,
 	.l2c_aux_mask	= ~0,
 	.l2c_write_sec	= tango_l2c_write,
 MACHINE_END
-- 
2.7.4
