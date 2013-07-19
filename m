From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 19 Jul 2013 17:25:23 +0800
Subject: [PATCH V4 1/4] Revert "ARM: tegra: add cpu_disable for hotplug"
In-Reply-To: <1374225926-26832-1-git-send-email-josephl@nvidia.com>
References: <1374225926-26832-1-git-send-email-josephl@nvidia.com>
Message-ID: <1374225926-26832-2-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 510bb595de26f90e5bb7c4a1e2a584e38398cf00.

The Tegra114 support CPU0 hotplug function in HW physically, but it needs
other software to make it work normally after we add CPU idle power down
mode support. So remove them for now.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V4:
* remove the CPU0 hot plug support due to miss of SW support
---
 arch/arm/mach-tegra/common.h  |  1 -
 arch/arm/mach-tegra/hotplug.c | 11 -----------
 arch/arm/mach-tegra/platsmp.c |  1 -
 3 files changed, 13 deletions(-)

diff --git a/arch/arm/mach-tegra/common.h b/arch/arm/mach-tegra/common.h
index 32f8eb3..5900cc4 100644
--- a/arch/arm/mach-tegra/common.h
+++ b/arch/arm/mach-tegra/common.h
@@ -2,4 +2,3 @@ extern struct smp_operations tegra_smp_ops;
 
 extern int tegra_cpu_kill(unsigned int cpu);
 extern void tegra_cpu_die(unsigned int cpu);
-extern int tegra_cpu_disable(unsigned int cpu);
diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index a52c10e..d07f152 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -46,17 +46,6 @@ void __ref tegra_cpu_die(unsigned int cpu)
 	BUG();
 }
 
-int tegra_cpu_disable(unsigned int cpu)
-{
-	switch (tegra_chip_id) {
-	case TEGRA20:
-	case TEGRA30:
-		return cpu == 0 ? -EPERM : 0;
-	default:
-		return 0;
-	}
-}
-
 void __init tegra_hotplug_init(void)
 {
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 97b33a2..2d02036 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -196,6 +196,5 @@ struct smp_operations tegra_smp_ops __initdata = {
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_kill		= tegra_cpu_kill,
 	.cpu_die		= tegra_cpu_die,
-	.cpu_disable		= tegra_cpu_disable,
 #endif
 };
-- 
1.8.3.2
