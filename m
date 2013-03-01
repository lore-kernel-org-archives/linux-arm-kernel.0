From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 1 Mar 2013 15:32:11 +0800
Subject: [PATCH V3 2/4] ARM: tegra: pmc: add power on function for secondary
 CPUs
In-Reply-To: <1362123131-3339-1-git-send-email-josephl@nvidia.com>
References: <1362123131-3339-1-git-send-email-josephl@nvidia.com>
Message-ID: <1362123131-3339-2-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the power on function for secondary CPUs in PMC driver, this can
help us to remove legacy powergate driver and add generic power domain
support later.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V3:
* making code more simpler in pmc_powergate_set and is_powered func
V2:
* Don't use ISS_ERR_VALUE for checking error return code
* the CPU power on function only available for secondary CPU which means
  we don't support (cpuid <= 0 || cpuid >= num_possible_cpus())
* adding a WARN_ON when the current power state is same with we want to set
---
 arch/arm/mach-tegra/pmc.c | 101 +++++++++++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-tegra/pmc.h |   4 ++
 2 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index a916eca..b30e921 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -20,8 +20,26 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
-#define PMC_CTRL		0x0
-#define PMC_CTRL_INTR_LOW	(1 << 17)
+#define PMC_CTRL			0x0
+#define PMC_CTRL_INTR_LOW		(1 << 17)
+#define PMC_PWRGATE_TOGGLE		0x30
+#define PMC_PWRGATE_TOGGLE_START	(1 << 8)
+#define PMC_REMOVE_CLAMPING		0x34
+#define PMC_PWRGATE_STATUS		0x38
+
+#define TEGRA_POWERGATE_PCIE	3
+#define TEGRA_POWERGATE_VDEC	4
+#define TEGRA_POWERGATE_CPU1	9
+#define TEGRA_POWERGATE_CPU2	10
+#define TEGRA_POWERGATE_CPU3	11
+
+static u8 tegra_cpu_domains[] = {
+	0xFF,			/* not available for CPU0 */
+	TEGRA_POWERGATE_CPU1,
+	TEGRA_POWERGATE_CPU2,
+	TEGRA_POWERGATE_CPU3,
+};
+static DEFINE_SPINLOCK(tegra_powergate_lock);
 
 static void __iomem *tegra_pmc_base;
 static bool tegra_pmc_invert_interrupt;
@@ -36,6 +54,85 @@ static inline void tegra_pmc_writel(u32 val, u32 reg)
 	writel(val, tegra_pmc_base + reg);
 }
 
+static int tegra_pmc_get_cpu_powerdomain_id(int cpuid)
+{
+	if (cpuid <= 0 || cpuid >= num_possible_cpus())
+		return -EINVAL;
+	return tegra_cpu_domains[cpuid];
+}
+
+static bool tegra_pmc_powergate_is_powered(int id)
+{
+	return (tegra_pmc_readl(PMC_PWRGATE_STATUS) >> id) & 1;
+}
+
+static int tegra_pmc_powergate_set(int id, bool new_state)
+{
+	bool old_state;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tegra_powergate_lock, flags);
+
+	old_state = tegra_pmc_powergate_is_powered(id);
+	WARN_ON(old_state == new_state);
+
+	tegra_pmc_writel(PMC_PWRGATE_TOGGLE_START | id, PMC_PWRGATE_TOGGLE);
+
+	spin_unlock_irqrestore(&tegra_powergate_lock, flags);
+
+	return 0;
+}
+
+static int tegra_pmc_powergate_remove_clamping(int id)
+{
+	u32 mask;
+
+	/*
+	 * Tegra has a bug where PCIE and VDE clamping masks are
+	 * swapped relatively to the partition ids.
+	 */
+	if (id ==  TEGRA_POWERGATE_VDEC)
+		mask = (1 << TEGRA_POWERGATE_PCIE);
+	else if	(id == TEGRA_POWERGATE_PCIE)
+		mask = (1 << TEGRA_POWERGATE_VDEC);
+	else
+		mask = (1 << id);
+
+	tegra_pmc_writel(mask, PMC_REMOVE_CLAMPING);
+
+	return 0;
+}
+
+bool tegra_pmc_cpu_is_powered(int cpuid)
+{
+	int id;
+
+	id = tegra_pmc_get_cpu_powerdomain_id(cpuid);
+	if (id < 0)
+		return false;
+	return tegra_pmc_powergate_is_powered(id);
+}
+
+int tegra_pmc_cpu_power_on(int cpuid)
+{
+	int id;
+
+	id = tegra_pmc_get_cpu_powerdomain_id(cpuid);
+	if (id < 0)
+		return id;
+	return tegra_pmc_powergate_set(id, true);
+}
+
+int tegra_pmc_cpu_remove_clamping(int cpuid)
+{
+	int id;
+
+	id = tegra_pmc_get_cpu_powerdomain_id(cpuid);
+	if (id < 0)
+		return id;
+	return tegra_pmc_powergate_remove_clamping(id);
+}
+
 static const struct of_device_id matches[] __initconst = {
 	{ .compatible = "nvidia,tegra114-pmc" },
 	{ .compatible = "nvidia,tegra30-pmc" },
diff --git a/arch/arm/mach-tegra/pmc.h b/arch/arm/mach-tegra/pmc.h
index 8995ee4..7d44710 100644
--- a/arch/arm/mach-tegra/pmc.h
+++ b/arch/arm/mach-tegra/pmc.h
@@ -18,6 +18,10 @@
 #ifndef __MACH_TEGRA_PMC_H
 #define __MACH_TEGRA_PMC_H
 
+bool tegra_pmc_cpu_is_powered(int cpuid);
+int tegra_pmc_cpu_power_on(int cpuid);
+int tegra_pmc_cpu_remove_clamping(int cpuid);
+
 void tegra_pmc_init(void);
 
 #endif
-- 
1.8.1.1
