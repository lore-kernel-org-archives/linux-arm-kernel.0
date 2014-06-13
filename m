From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jun 2014 18:01:15 +0200
Subject: [PATCH 13/14] ARM: exynos: move sysram info to exynos.c
In-Reply-To: <1402675276-538682-1-git-send-email-arnd@arndb.de>
References: <1402675276-538682-1-git-send-email-arnd@arndb.de>
Message-ID: <1402675276-538682-14-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olof Johansson <olof@lixom.net>

This solves a problem with building with CONFIG_SMP=n due to missing
sysram_base_addr (or sysram_ns_base_addr) variables.

The new setup method is more awkward than I'd like for it to be, but
it can't be done in init_early() since ioremap is not yet available,
but it needs to happen before SMP.

Reported-by: Russell King <linux@arm.linux.org.uk>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-exynos/common.h  |  1 +
 arch/arm/mach-exynos/exynos.c  | 29 +++++++++++++++++++++++++++++
 arch/arm/mach-exynos/platsmp.c | 26 ++------------------------
 3 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 16617bd..1ee9176 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -118,6 +118,7 @@ extern void __iomem *sysram_ns_base_addr;
 extern void __iomem *sysram_base_addr;
 void exynos_init_io(void);
 void exynos_restart(enum reboot_mode mode, const char *cmd);
+void exynos_sysram_init(void);
 void exynos_cpuidle_init(void);
 void exynos_cpufreq_init(void);
 void exynos_init_late(void);
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 90aab4d..fb1eadd 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -184,6 +184,28 @@ void __init exynos_cpufreq_init(void)
 	platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
 }
 
+void __iomem *sysram_base_addr;
+void __iomem *sysram_ns_base_addr;
+
+void __init exynos_sysram_init(void)
+{
+	struct device_node *node;
+
+	for_each_compatible_node(node, NULL, "samsung,exynos4210-sysram") {
+		if (!of_device_is_available(node))
+			continue;
+		sysram_base_addr = of_iomap(node, 0);
+		break;
+	}
+
+	for_each_compatible_node(node, NULL, "samsung,exynos4210-sysram-ns") {
+		if (!of_device_is_available(node))
+			continue;
+		sysram_ns_base_addr = of_iomap(node, 0);
+		break;
+	}
+}
+
 void __init exynos_init_late(void)
 {
 	if (of_machine_is_compatible("samsung,exynos5440"))
@@ -271,6 +293,13 @@ static void __init exynos_dt_machine_init(void)
 		}
 	}
 
+	/*
+	 * This is called from smp_prepare_cpus if we've built for SMP, but
+	 * we still need to set it up for PM and firmware ops if not.
+	 */
+	if (!IS_ENABLED(SMP))
+		exynos_sysram_init();
+
 	exynos_cpuidle_init();
 	exynos_cpufreq_init();
 
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index ec02422..1c8d31e 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -32,28 +32,6 @@
 
 extern void exynos4_secondary_startup(void);
 
-void __iomem *sysram_base_addr;
-void __iomem *sysram_ns_base_addr;
-
-static void __init exynos_smp_prepare_sysram(void)
-{
-	struct device_node *node;
-
-	for_each_compatible_node(node, NULL, "samsung,exynos4210-sysram") {
-		if (!of_device_is_available(node))
-			continue;
-		sysram_base_addr = of_iomap(node, 0);
-		break;
-	}
-
-	for_each_compatible_node(node, NULL, "samsung,exynos4210-sysram-ns") {
-		if (!of_device_is_available(node))
-			continue;
-		sysram_ns_base_addr = of_iomap(node, 0);
-		break;
-	}
-}
-
 static inline void __iomem *cpu_boot_reg_base(void)
 {
 	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
@@ -234,11 +212,11 @@ static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
 {
 	int i;
 
+	exynos_sysram_init();
+
 	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
 		scu_enable(scu_base_addr());
 
-	exynos_smp_prepare_sysram();
-
 	/*
 	 * Write the address of secondary startup into the
 	 * system-wide flags register. The boot monitor waits
-- 
1.8.3.2
