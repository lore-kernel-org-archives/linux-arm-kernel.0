From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Mar 2014 19:29:35 +0100
Subject: [PATCH] ARM: prima2: build reset code standalone
Message-ID: <3158149.XI9lgY9por@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The prima2 platform code currently depends on the rstc
implementation and that in turn depends on the reset
controller framework. This removes the platform dependency
by letting the driver access arm_pm_restart directly
to turn the driver into a standalone entity, and also
removes the dependency on the reset controller framework
by using "if (IS_ENABLED(CONFIG_RESET_CONTROLLER))". This
will cause all code that is used for the reset controller
to be dropped by the compiler if the framework is disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---

The problem only shows up in our for-next branch, I'd apply the
patch right away if I get an Ack.

diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index 3b8865a..47c7819 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -37,7 +37,6 @@ DT_MACHINE_START(ATLAS6_DT, "Generic ATLAS6 (Flattened Device Tree)")
 	.map_io         = sirfsoc_map_io,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = atlas6_dt_match,
-	.restart	= sirfsoc_restart,
 MACHINE_END
 #endif
 
@@ -53,7 +52,6 @@ DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
 	.dma_zone_size	= SZ_256M,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = prima2_dt_match,
-	.restart	= sirfsoc_restart,
 MACHINE_END
 #endif
 
@@ -69,6 +67,5 @@ DT_MACHINE_START(MARCO_DT, "Generic MARCO (Flattened Device Tree)")
 	.map_io         = sirfsoc_map_io,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = marco_dt_match,
-	.restart	= sirfsoc_restart,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-prima2/common.h b/arch/arm/mach-prima2/common.h
index 4b768060..07d3e5e 100644
--- a/arch/arm/mach-prima2/common.h
+++ b/arch/arm/mach-prima2/common.h
@@ -23,7 +23,6 @@ extern void sirfsoc_secondary_startup(void);
 extern void sirfsoc_cpu_die(unsigned int cpu);
 
 extern void __init sirfsoc_of_irq_init(void);
-extern void sirfsoc_restart(enum reboot_mode, const char *);
 extern asmlinkage void __exception_irq_entry sirfsoc_handle_irq(struct pt_regs *regs);
 
 #ifndef CONFIG_DEBUG_LL
diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
index a599767..4887a2a 100644
--- a/arch/arm/mach-prima2/rstc.c
+++ b/arch/arm/mach-prima2/rstc.c
@@ -17,9 +17,11 @@
 #include <linux/reboot.h>
 #include <linux/reset-controller.h>
 
+#include <asm/system_misc.h>
+
 #define SIRFSOC_RSTBIT_NUM	64
 
-void __iomem *sirfsoc_rstc_base;
+static void __iomem *sirfsoc_rstc_base;
 static DEFINE_MUTEX(rstc_lock);
 
 static int sirfsoc_reset_module(struct reset_controller_dev *rcdev,
@@ -71,6 +73,13 @@ static struct reset_controller_dev sirfsoc_reset_controller = {
 	.nr_resets = SIRFSOC_RSTBIT_NUM,
 };
 
+#define SIRFSOC_SYS_RST_BIT  BIT(31)
+
+static void sirfsoc_restart(enum reboot_mode mode, const char *cmd)
+{
+	writel(SIRFSOC_SYS_RST_BIT, sirfsoc_rstc_base);
+}
+
 static int sirfsoc_rstc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -81,8 +90,10 @@ static int sirfsoc_rstc_probe(struct platform_device *pdev)
 	}
 
 	sirfsoc_reset_controller.of_node = np;
+	arm_pm_restart = sirfsoc_restart;
 
-	reset_controller_register(&sirfsoc_reset_controller);
+	if (IS_ENABLED(CONFIG_RESET_CONTROLLER))
+		reset_controller_register(&sirfsoc_reset_controller);
 
 	return 0;
 }
@@ -107,10 +118,3 @@ static int __init sirfsoc_rstc_init(void)
 	return platform_driver_register(&sirfsoc_rstc_driver);
 }
 subsys_initcall(sirfsoc_rstc_init);
-
-#define SIRFSOC_SYS_RST_BIT  BIT(31)
-
-void sirfsoc_restart(enum reboot_mode mode, const char *cmd)
-{
-	writel(SIRFSOC_SYS_RST_BIT, sirfsoc_rstc_base);
-}
