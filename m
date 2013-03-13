From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 13 Mar 2013 16:01:18 +0800
Subject: [PATCH V3 4/9] ARM: tegra: pm: add platform suspend support
In-Reply-To: <1363161683-20825-1-git-send-email-josephl@nvidia.com>
References: <1363161683-20825-1-git-send-email-josephl@nvidia.com>
Message-ID: <1363161683-20825-5-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding suspend to RAM support for Tegra platform. There are three suspend
mode for Tegra. The difference were below.

* LP2: CPU voltage off
* LP1: CPU voltage off, DRAM in self-refresh
* LP0: CPU + Core voltage off, DRAM in self-refresh

After this patch, the LP2 suspend mode will be supported.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V3:
* add a protection for only support LP2 suspend mode
V2:
* add the PM_SLEEP protection for "tegra_init_suspend"
* remove "tegra_suspend_{enter/exit}_lp2"
* refactor the "tegra_pmc_pm_set" for non-used parameter
* replace "unsigned long" with "u32" for tegra_pmc_get_cpu_time
---
 arch/arm/mach-tegra/common.c |  1 +
 arch/arm/mach-tegra/pm.c     | 71 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/pm.h     |  6 ++++
 arch/arm/mach-tegra/pmc.c    | 53 +++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/pmc.h    |  9 ++++++
 5 files changed, 140 insertions(+)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index bc7268a..fd67efa 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -65,6 +65,7 @@ void __init tegra_dt_init_irq(void)
 	tegra_init_irq();
 	irqchip_init();
 	tegra_legacy_irq_syscore_init();
+	tegra_init_suspend();
 }
 #endif
 
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 0494f73..915e13b 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -22,6 +22,7 @@
 #include <linux/cpumask.h>
 #include <linux/delay.h>
 #include <linux/cpu_pm.h>
+#include <linux/suspend.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/clk/tegra.h>
@@ -38,6 +39,7 @@
 #include "flowctrl.h"
 #include "fuse.h"
 #include "sleep.h"
+#include "pmc.h"
 
 #define TEGRA_POWER_CPU_PWRREQ_OE	(1 << 16)  /* CPU pwr req enable */
 
@@ -197,4 +199,73 @@ void tegra_idle_lp2_last(u32 cpu_on_time, u32 cpu_off_time)
 	restore_cpu_complex();
 	cpu_cluster_pm_exit();
 }
+
+static const char *lp_state[TEGRA_MAX_SUSPEND_MODE] = {
+	[TEGRA_SUSPEND_NONE] = "none",
+	[TEGRA_SUSPEND_LP2] = "LP2",
+	[TEGRA_SUSPEND_LP1] = "LP1",
+	[TEGRA_SUSPEND_LP0] = "LP0",
+};
+
+static int __cpuinit tegra_suspend_enter(suspend_state_t state)
+{
+	enum tegra_suspend_mode mode = tegra_pmc_get_suspend_mode();
+
+	if (WARN_ON(mode < TEGRA_SUSPEND_NONE ||
+		    mode >= TEGRA_MAX_SUSPEND_MODE))
+		return -EINVAL;
+
+	pr_info("Entering suspend state %s\n", lp_state[mode]);
+
+	tegra_pmc_pm_set();
+	set_power_timers(tegra_pmc_get_cpu_good_time(),
+			 tegra_pmc_get_cpu_off_time());
+
+	local_fiq_disable();
+
+	suspend_cpu_complex();
+	switch (mode) {
+	case TEGRA_SUSPEND_LP2:
+		tegra_set_cpu_in_lp2(0);
+		break;
+	default:
+		break;
+	}
+
+	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
+
+	switch (mode) {
+	case TEGRA_SUSPEND_LP2:
+		tegra_clear_cpu_in_lp2(0);
+		break;
+	default:
+		break;
+	}
+	restore_cpu_complex();
+
+	local_fiq_enable();
+
+	return 0;
+}
+
+static const struct platform_suspend_ops tegra_suspend_ops = {
+	.valid		= suspend_valid_only_mem,
+	.enter		= tegra_suspend_enter,
+};
+
+void __init tegra_init_suspend(void)
+{
+	enum tegra_suspend_mode mode = tegra_pmc_get_suspend_mode();
+
+	if (mode == TEGRA_SUSPEND_NONE)
+		return;
+
+	tegra_pmc_suspend_init();
+
+	/* We only support LP2 suspend mode right now. */
+	if (mode > TEGRA_SUSPEND_LP2)
+		tegra_pmc_set_suspend_mode(TEGRA_SUSPEND_LP2);
+
+	suspend_set_ops(&tegra_suspend_ops);
+}
 #endif
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 787335c..e7cbfeb 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -32,4 +32,10 @@ bool tegra_set_cpu_in_lp2(int phy_cpu_id);
 void tegra_idle_lp2_last(u32 cpu_on_time, u32 cpu_off_time);
 extern void (*tegra_tear_down_cpu)(void);
 
+#ifdef CONFIG_PM_SLEEP
+void tegra_init_suspend(void);
+#else
+static inline void tegra_init_suspend(void) {}
+#endif
+
 #endif /* _MACH_TEGRA_PM_H_ */
diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index d331f87..f0c5435 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -20,7 +20,13 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
+#include "fuse.h"
 #include "pmc.h"
+#include "sleep.h"
+
+#define TEGRA_POWER_EFFECT_LP0		(1 << 14)  /* LP0 when CPU pwr gated */
+#define TEGRA_POWER_CPU_PWRREQ_POLARITY	(1 << 15)  /* CPU pwr req polarity */
+#define TEGRA_POWER_CPU_PWRREQ_OE	(1 << 16)  /* CPU pwr req enable */
 
 #define PMC_CTRL			0x0
 #define PMC_CTRL_INTR_LOW		(1 << 17)
@@ -151,6 +157,53 @@ int tegra_pmc_cpu_remove_clamping(int cpuid)
 	return tegra_pmc_powergate_remove_clamping(id);
 }
 
+#ifdef CONFIG_PM_SLEEP
+enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void)
+{
+	return pmc_pm_data.suspend_mode;
+}
+
+void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode)
+{
+	if (mode < TEGRA_SUSPEND_NONE || mode >= TEGRA_MAX_SUSPEND_MODE)
+		return;
+
+	pmc_pm_data.suspend_mode = mode;
+}
+
+u32 tegra_pmc_get_cpu_good_time(void)
+{
+	return pmc_pm_data.cpu_good_time;
+}
+
+u32 tegra_pmc_get_cpu_off_time(void)
+{
+	return pmc_pm_data.cpu_off_time;
+}
+
+void tegra_pmc_pm_set(void)
+{
+	u32 reg;
+
+	reg = tegra_pmc_readl(PMC_CTRL);
+	reg |= TEGRA_POWER_CPU_PWRREQ_OE;
+	reg &= ~TEGRA_POWER_EFFECT_LP0;
+
+	tegra_pmc_writel(reg, PMC_CTRL);
+}
+
+void tegra_pmc_suspend_init(void)
+{
+	u32 reg;
+
+	/* Always enable CPU power request; just normal polarity is supported */
+	reg = tegra_pmc_readl(PMC_CTRL);
+	BUG_ON(reg & TEGRA_POWER_CPU_PWRREQ_POLARITY);
+	reg |= TEGRA_POWER_CPU_PWRREQ_OE;
+	tegra_pmc_writel(reg, PMC_CTRL);
+}
+#endif
+
 static const struct of_device_id matches[] __initconst = {
 	{ .compatible = "nvidia,tegra114-pmc" },
 	{ .compatible = "nvidia,tegra30-pmc" },
diff --git a/arch/arm/mach-tegra/pmc.h b/arch/arm/mach-tegra/pmc.h
index 1c4b4de..72b2cee 100644
--- a/arch/arm/mach-tegra/pmc.h
+++ b/arch/arm/mach-tegra/pmc.h
@@ -26,6 +26,15 @@ enum tegra_suspend_mode {
 	TEGRA_MAX_SUSPEND_MODE,
 };
 
+#ifdef CONFIG_PM_SLEEP
+enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void);
+void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode);
+u32 tegra_pmc_get_cpu_good_time(void);
+u32 tegra_pmc_get_cpu_off_time(void);
+void tegra_pmc_pm_set(void);
+void tegra_pmc_suspend_init(void);
+#endif
+
 bool tegra_pmc_cpu_is_powered(int cpuid);
 int tegra_pmc_cpu_power_on(int cpuid);
 int tegra_pmc_cpu_remove_clamping(int cpuid);
-- 
1.8.1.5
