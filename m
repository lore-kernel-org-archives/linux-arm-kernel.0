From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 28 May 2013 12:14:41 -0600
Subject: [PATCH V2] ARM: tegra: add cpu_disable for hotplug
Message-ID: <1369764881-20520-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joseph Lo <josephl@nvidia.com>

The Tegra114 could hotplug the CPU0, but the common cpu_disable didn't
support that. Adding a Tegra specific cpu_disable function for it.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
[swarren: adjusted the switch statement to be future-proof]
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/common.h  |    1 +
 arch/arm/mach-tegra/hotplug.c |   11 +++++++++++
 arch/arm/mach-tegra/platsmp.c |    1 +
 3 files changed, 13 insertions(+)

diff --git a/arch/arm/mach-tegra/common.h b/arch/arm/mach-tegra/common.h
index 5900cc4..32f8eb3 100644
--- a/arch/arm/mach-tegra/common.h
+++ b/arch/arm/mach-tegra/common.h
@@ -2,3 +2,4 @@ extern struct smp_operations tegra_smp_ops;
 
 extern int tegra_cpu_kill(unsigned int cpu);
 extern void tegra_cpu_die(unsigned int cpu);
+extern int tegra_cpu_disable(unsigned int cpu);
diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index d07f152..a52c10e 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -46,6 +46,17 @@ void __ref tegra_cpu_die(unsigned int cpu)
 	BUG();
 }
 
+int tegra_cpu_disable(unsigned int cpu)
+{
+	switch (tegra_chip_id) {
+	case TEGRA20:
+	case TEGRA30:
+		return cpu == 0 ? -EPERM : 0;
+	default:
+		return 0;
+	}
+}
+
 void __init tegra_hotplug_init(void)
 {
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 554aedc..24db4ac 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -196,5 +196,6 @@ struct smp_operations tegra_smp_ops __initdata = {
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_kill		= tegra_cpu_kill,
 	.cpu_die		= tegra_cpu_die,
+	.cpu_disable		= tegra_cpu_disable,
 #endif
 };
-- 
1.7.10.4
