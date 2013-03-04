From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 4 Mar 2013 19:40:18 +0800
Subject: [PATCH 04/10] ARM: tegra: pm: add platform suspend support
Message-ID: <1362397218-5675-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding suspend to ram support for Tegra platform. There are three suspend
mode for Tegra. The difference were below.

* LP2: CPU voltage off
* LP1: CPU voltage off, DRAM in self-refresh
* LP0: CPU + Core voltage off, DRAM in self-refresh

After this patch, the LP2 suspend mode will be supported.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/common.c |  1 +
 arch/arm/mach-tegra/pm.c     | 75 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/pm.h     |  2 ++
 arch/arm/mach-tegra/pmc.c    | 45 ++++++++++++++++++++++++++
 arch/arm/mach-tegra/pmc.h    |  8 +++++
 5 files changed, 131 insertions(+)

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
index 523604d..334ffdf 100644
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
 
@@ -216,4 +218,77 @@ void tegra_idle_lp2_last(u32 cpu_on_time, u32 cpu_off_time)
 	restore_cpu_complex();
 	cpu_cluster_pm_exit();
 }
+
+static void tegra_suspend_enter_lp2(void)
+{
+	tegra_set_cpu_in_lp2(0);
+}
+
+static void tegra_suspend_exit_lp2(void)
+{
+	tegra_clear_cpu_in_lp2(0);
+}
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
+	tegra_pmc_pm_set(mode);
+	set_power_timers(tegra_pmc_get_cpu_timer(),
+			 tegra_pmc_get_cpu_off_timer());
+
+	local_fiq_disable();
+
+	suspend_cpu_complex();
+	switch (mode) {
+	case TEGRA_SUSPEND_LP2:
+		tegra_suspend_enter_lp2();
+		break;
+	default:
+		break;
+	}
+
+	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
+
+	switch (mode) {
+	case TEGRA_SUSPEND_LP2:
+		tegra_suspend_exit_lp2();
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
+	if (tegra_pmc_get_suspend_mode() == TEGRA_SUSPEND_NONE)
+		return;
+
+	tegra_pmc_suspend_init();
+
+	suspend_set_ops(&tegra_suspend_ops);
+}
 #endif
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 787335c..7eced59 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -32,4 +32,6 @@ bool tegra_set_cpu_in_lp2(int phy_cpu_id);
 void tegra_idle_lp2_last(u32 cpu_on_time, u32 cpu_off_time);
 extern void (*tegra_tear_down_cpu)(void);
 
+void tegra_init_suspend(void);
+
 #endif /* _MACH_TEGRA_PM_H_ */
diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index f30c660..94838d0 100644
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
@@ -151,6 +157,45 @@ int tegra_pmc_cpu_remove_clamping(int cpuid)
 	return tegra_pmc_powergate_remove_clamping(id);
 }
 
+#ifdef CONFIG_PM_SLEEP
+enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void)
+{
+	return pmc_pm_data.suspend_mode;
+}
+
+unsigned long tegra_pmc_get_cpu_timer(void)
+{
+	return pmc_pm_data.cpu_good_time;
+}
+
+unsigned long tegra_pmc_get_cpu_off_timer(void)
+{
+	return pmc_pm_data.cpu_off_time;
+}
+
+void tegra_pmc_pm_set(enum tegra_suspend_mode mode)
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
index 1c4b4de..4452d72 100644
--- a/arch/arm/mach-tegra/pmc.h
+++ b/arch/arm/mach-tegra/pmc.h
@@ -26,6 +26,14 @@ enum tegra_suspend_mode {
 	TEGRA_MAX_SUSPEND_MODE,
 };
 
+#ifdef CONFIG_PM_SLEEP
+enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void);
+unsigned long tegra_pmc_get_cpu_timer(void);
+unsigned long tegra_pmc_get_cpu_off_timer(void);
+void tegra_pmc_pm_set(enum tegra_suspend_mode mode);
+void tegra_pmc_suspend_init(void);
+#endif
+
 bool tegra_pmc_cpu_is_powered(int cpuid);
 int tegra_pmc_cpu_power_on(int cpuid);
 int tegra_pmc_cpu_remove_clamping(int cpuid);
-- 
1.8.1.1
