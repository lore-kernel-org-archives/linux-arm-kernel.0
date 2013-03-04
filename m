From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 4 Mar 2013 19:40:07 +0800
Subject: [PATCH 03/10] ARM: tegra: get power management configurations for PMC
 from DT
Message-ID: <1362397207-5597-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the system supports deep sleep mode (i.e. suspend), it should have
the power management configuration for PMC in the DT under the sub-node
of PMC. Different system may have different configurations, it should
be parsed from DT.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/pmc.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/pmc.h |  8 +++++
 2 files changed, 91 insertions(+)

diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index b30e921..f30c660 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -20,6 +20,8 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
+#include "pmc.h"
+
 #define PMC_CTRL			0x0
 #define PMC_CTRL_INTR_LOW		(1 << 17)
 #define PMC_PWRGATE_TOGGLE		0x30
@@ -44,6 +46,22 @@ static DEFINE_SPINLOCK(tegra_powergate_lock);
 static void __iomem *tegra_pmc_base;
 static bool tegra_pmc_invert_interrupt;
 
+struct pmc_pm_data {
+	unsigned long cpu_good_time;	/* CPU power good time in uS */
+	unsigned long cpu_off_time;	/* CPU power off time in uS */
+	unsigned long core_osc_time;	/* Core power good osc time in uS */
+	unsigned long core_pmu_time;	/* Core power good pmu time in uS */
+	unsigned long core_off_time;	/* Core power off time in uS */
+	bool corereq_high;		/* Core power request active-high */
+	bool sysclkreq_high;		/* System clock request active-high */
+	bool combined_req;		/* Combined pwr req for CPU & Core */
+	bool cpu_pwr_good_en;		/* CPU power good signal is enabled */
+	u32 lp0_vec_phy_addr;		/* The phy addr of LP0 warm boot code */
+	u32 lp0_vec_size;		/* The size of LP0 warm boot code */
+	enum tegra_suspend_mode suspend_mode;
+};
+static struct pmc_pm_data pmc_pm_data;
+
 static inline u32 tegra_pmc_readl(u32 reg)
 {
 	return readl(tegra_pmc_base + reg);
@@ -143,6 +161,10 @@ static const struct of_device_id matches[] __initconst = {
 static void tegra_pmc_parse_dt(void)
 {
 	struct device_node *np;
+	u32 prop;
+	enum tegra_suspend_mode suspend_mode;
+	u32 core_good_time[2] = {0, 0};
+	u32 lp0_vec[2] = {0, 0};
 
 	np = of_find_matching_node(NULL, matches);
 	BUG_ON(!np);
@@ -151,6 +173,67 @@ static void tegra_pmc_parse_dt(void)
 
 	tegra_pmc_invert_interrupt = of_property_read_bool(np,
 				     "nvidia,invert-interrupt");
+
+	/* Grabbing the power management configurations */
+	if (of_property_read_u32(np, "nvidia,suspend-mode", &prop)) {
+		suspend_mode = TEGRA_SUSPEND_NONE;
+	} else {
+		switch (prop) {
+		case 0:
+			suspend_mode = TEGRA_SUSPEND_LP0;
+			break;
+		case 1:
+			suspend_mode = TEGRA_SUSPEND_LP1;
+			break;
+		case 2:
+			suspend_mode = TEGRA_SUSPEND_LP2;
+			break;
+		default:
+			suspend_mode = TEGRA_SUSPEND_NONE;
+			break;
+		}
+	}
+
+	if (of_property_read_u32(np, "nvidia,cpu-pwr-good-time", &prop))
+		suspend_mode = TEGRA_SUSPEND_NONE;
+	pmc_pm_data.cpu_good_time = prop;
+
+	if (of_property_read_u32(np, "nvidia,cpu-pwr-off-time", &prop))
+		suspend_mode = TEGRA_SUSPEND_NONE;
+	pmc_pm_data.cpu_off_time = prop;
+
+	if (of_property_read_u32_array(np, "nvidia,core-pwr-good-time",
+			core_good_time, ARRAY_SIZE(core_good_time)))
+		suspend_mode = TEGRA_SUSPEND_NONE;
+	pmc_pm_data.core_osc_time = core_good_time[0];
+	pmc_pm_data.core_pmu_time = core_good_time[1];
+
+	if (of_property_read_u32(np, "nvidia,core-pwr-off-time",
+				 &prop))
+		suspend_mode = TEGRA_SUSPEND_NONE;
+	pmc_pm_data.core_off_time = prop;
+
+	pmc_pm_data.corereq_high = of_property_read_bool(np,
+				"nvidia,core-power-req-active-high");
+
+	pmc_pm_data.sysclkreq_high = of_property_read_bool(np,
+				"nvidia,sys-clock-req-active-high");
+
+	pmc_pm_data.combined_req = of_property_read_bool(np,
+				"nvidia,combined-power-req");
+
+	pmc_pm_data.cpu_pwr_good_en = of_property_read_bool(np,
+				"nvidia,cpu-pwr-good-en");
+
+	if (of_property_read_u32_array(np, "nvidia,lp0-vec", lp0_vec,
+				       ARRAY_SIZE(lp0_vec)))
+		if (suspend_mode == TEGRA_SUSPEND_LP0)
+			suspend_mode = TEGRA_SUSPEND_LP1;
+
+	pmc_pm_data.lp0_vec_phy_addr = lp0_vec[0];
+	pmc_pm_data.lp0_vec_size = lp0_vec[1];
+
+	pmc_pm_data.suspend_mode = suspend_mode;
 }
 
 void __init tegra_pmc_init(void)
diff --git a/arch/arm/mach-tegra/pmc.h b/arch/arm/mach-tegra/pmc.h
index 7d44710..1c4b4de 100644
--- a/arch/arm/mach-tegra/pmc.h
+++ b/arch/arm/mach-tegra/pmc.h
@@ -18,6 +18,14 @@
 #ifndef __MACH_TEGRA_PMC_H
 #define __MACH_TEGRA_PMC_H
 
+enum tegra_suspend_mode {
+	TEGRA_SUSPEND_NONE = 0,
+	TEGRA_SUSPEND_LP2,	/* CPU voltage off */
+	TEGRA_SUSPEND_LP1,	/* CPU voltage off, DRAM self-refresh */
+	TEGRA_SUSPEND_LP0,      /* CPU + core voltage off, DRAM self-refresh */
+	TEGRA_MAX_SUSPEND_MODE,
+};
+
 bool tegra_pmc_cpu_is_powered(int cpuid);
 int tegra_pmc_cpu_power_on(int cpuid);
 int tegra_pmc_cpu_remove_clamping(int cpuid);
-- 
1.8.1.1
