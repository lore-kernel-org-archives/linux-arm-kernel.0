From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Sep 2012 10:50:16 +0800
Subject: [PATCH] ARM: highbank: call highbank_pm_init in .init_late hook
Message-ID: <1347850216-1979-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Being a module_init call, highbank_pm_init will cause problem with
multi-platform build running on other platforms.  Call it in the
.init_late hook instead.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-highbank/core.h     |    5 +++++
 arch/arm/mach-highbank/highbank.c |    6 ++++++
 arch/arm/mach-highbank/pm.c       |    4 +---
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-highbank/core.h b/arch/arm/mach-highbank/core.h
index 598ee78..c2e2c46 100644
--- a/arch/arm/mach-highbank/core.h
+++ b/arch/arm/mach-highbank/core.h
@@ -10,5 +10,10 @@ static inline void highbank_lluart_map_io(void) {}
 
 extern void highbank_smc1(int fn, int arg);
 extern void highbank_cpu_die(unsigned int cpu);
+#ifdef CONFIG_PM
+extern void highbank_pm_init(void);
+#else
+static inline void highbank_pm_init(void) {}
+#endif
 
 extern struct smp_operations highbank_smp_ops;
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 709bd72..8b1c5ba 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -156,6 +156,11 @@ static void __init highbank_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
+static void __init highbank_init_late(void)
+{
+	highbank_pm_init();
+}
+
 static const char *highbank_match[] __initconst = {
 	"calxeda,highbank",
 	NULL,
@@ -168,6 +173,7 @@ DT_MACHINE_START(HIGHBANK, "Highbank")
 	.timer		= &highbank_timer,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= highbank_init,
+	.init_late	= highbank_init_late,
 	.dt_compat	= highbank_match,
 	.restart	= highbank_restart,
 MACHINE_END
diff --git a/arch/arm/mach-highbank/pm.c b/arch/arm/mach-highbank/pm.c
index 33b3beb..de866f2 100644
--- a/arch/arm/mach-highbank/pm.c
+++ b/arch/arm/mach-highbank/pm.c
@@ -47,9 +47,7 @@ static const struct platform_suspend_ops highbank_pm_ops = {
 	.valid = suspend_valid_only_mem,
 };
 
-static int __init highbank_pm_init(void)
+void __init highbank_pm_init(void)
 {
 	suspend_set_ops(&highbank_pm_ops);
-	return 0;
 }
-module_init(highbank_pm_init);
-- 
1.7.9.5
