From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 11 Jul 2014 15:43:03 +0200
Subject: [PATCH] ARM: EXYNOS: Fix build with PM_SLEEP=n
Message-ID: <1405086183-24715-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix building of exynos defconfig with disabled PM_SLEEP:
CONFIG_PM_SLEEP=n
CONFIG_PM_SLEEP_SMP=n
CONFIG_SUSPEND=n

The build error messages:
arch/arm/mach-exynos/built-in.o: In function `exynos_boot_secondary':
arch/arm/mach-exynos/platsmp.c:111: undefined reference to `exynos_cpu_power_state'
arch/arm/mach-exynos/platsmp.c:112: undefined reference to `exynos_cpu_power_up'
arch/arm/mach-exynos/platsmp.c:116: undefined reference to `exynos_cpu_power_state'
make: *** [vmlinux] Error 1

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-exynos/common.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index f8daa9cc5617..966ecf195265 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -149,9 +149,15 @@ struct exynos_pmu_conf {
 };
 
 extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
+#ifdef CONFIG_PM_SLEEP
 extern void exynos_cpu_power_down(int cpu);
 extern void exynos_cpu_power_up(int cpu);
 extern int  exynos_cpu_power_state(int cpu);
+#else
+extern inline void exynos_cpu_power_down(int cpu) {}
+extern inline void exynos_cpu_power_up(int cpu) {}
+extern inline int  exynos_cpu_power_state(int cpu) { return 0; }
+#endif
 extern void exynos_cluster_power_down(int cluster);
 extern void exynos_cluster_power_up(int cluster);
 extern int  exynos_cluster_power_state(int cluster);
-- 
1.9.1
