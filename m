From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  7 Jul 2014 16:16:50 +0200
Subject: [PATCH 2/2] ARM: tegra: Convert PMC to a driver
In-Reply-To: <1404742610-4951-1-git-send-email-thierry.reding@gmail.com>
References: <1404742610-4951-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1404742610-4951-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

This commit converts the PMC support code to a platform driver. Because
the boot process needs to call into this driver very early, set up a
minimalistic environment via an early initcall.

While at it, also move the driver out to drivers/power so that it can be
shared with 64-bit SoCs.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-tegra/Makefile    |   2 -
 arch/arm/mach-tegra/board.h     |   7 -
 arch/arm/mach-tegra/platsmp.c   |   1 -
 arch/arm/mach-tegra/pm.c        |  30 +-
 arch/arm/mach-tegra/pm.h        |  10 +-
 arch/arm/mach-tegra/pmc.c       | 402 -----------------
 arch/arm/mach-tegra/pmc.h       |  62 ---
 arch/arm/mach-tegra/powergate.c | 503 ---------------------
 arch/arm/mach-tegra/tegra.c     |   6 -
 drivers/power/Makefile          |   1 +
 drivers/power/tegra-pmc.c       | 948 ++++++++++++++++++++++++++++++++++++++++
 include/linux/tegra-soc.h       |  46 ++
 12 files changed, 1018 insertions(+), 1000 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/pmc.c
 delete mode 100644 arch/arm/mach-tegra/pmc.h
 delete mode 100644 arch/arm/mach-tegra/powergate.c
 create mode 100644 drivers/power/tegra-pmc.c

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index c303b55de22e..e48a74458c25 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -2,9 +2,7 @@ asflags-y				+= -march=armv7-a
 
 obj-y                                   += io.o
 obj-y                                   += irq.o
-obj-y					+= pmc.o
 obj-y					+= flowctrl.o
-obj-y					+= powergate.o
 obj-y					+= pm.o
 obj-y					+= reset.o
 obj-y					+= reset-handler.o
diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h
index bcf5dbf69d58..da90c89296b9 100644
--- a/arch/arm/mach-tegra/board.h
+++ b/arch/arm/mach-tegra/board.h
@@ -28,13 +28,6 @@
 void __init tegra_map_common_io(void);
 void __init tegra_init_irq(void);
 
-int __init tegra_powergate_init(void);
-#if defined(CONFIG_ARCH_TEGRA_2x_SOC) && defined(CONFIG_DEBUG_FS)
-int __init tegra_powergate_debugfs_init(void);
-#else
-static inline int tegra_powergate_debugfs_init(void) { return 0; }
-#endif
-
 void __init tegra_paz00_wifikill_init(void);
 
 #endif
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index d9878acae3d2..1862d44cc0d6 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -28,7 +28,6 @@
 
 #include "flowctrl.h"
 #include "reset.h"
-#include "pmc.h"
 
 #include "common.h"
 #include "iomap.h"
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index d7e6370ea8dc..41e6b1910dcc 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -39,7 +39,6 @@
 #include "reset.h"
 #include "flowctrl.h"
 #include "pm.h"
-#include "pmc.h"
 #include "sleep.h"
 
 #ifdef CONFIG_PM_SLEEP
@@ -166,9 +165,29 @@ static int tegra_sleep_cpu(unsigned long v2p)
 	return 0;
 }
 
+static void tegra_pm_set(enum tegra_suspend_mode mode)
+{
+	u32 value;
+
+	switch (tegra_chip_id) {
+	case TEGRA20:
+	case TEGRA30:
+		break;
+	default:
+		/* Turn off CRAIL */
+		value = flowctrl_read_cpu_csr(0);
+		value &= ~FLOW_CTRL_CSR_ENABLE_EXT_MASK;
+		value |= FLOW_CTRL_CSR_ENABLE_EXT_CRAIL;
+		flowctrl_write_cpu_csr(0, value);
+		break;
+	}
+
+	tegra_pmc_enter_suspend_mode(mode);
+}
+
 void tegra_idle_lp2_last(void)
 {
-	tegra_pmc_pm_set(TEGRA_SUSPEND_LP2);
+	tegra_pm_set(TEGRA_SUSPEND_LP2);
 
 	cpu_cluster_pm_enter();
 	suspend_cpu_complex();
@@ -267,8 +286,6 @@ static bool tegra_sleep_core_init(void)
 
 static void tegra_suspend_enter_lp1(void)
 {
-	tegra_pmc_suspend();
-
 	/* copy the reset vector & SDRAM shutdown code into IRAM */
 	memcpy(iram_save_addr, IO_ADDRESS(TEGRA_IRAM_LPx_RESUME_AREA),
 		iram_save_size);
@@ -280,8 +297,6 @@ static void tegra_suspend_enter_lp1(void)
 
 static void tegra_suspend_exit_lp1(void)
 {
-	tegra_pmc_resume();
-
 	/* restore IRAM */
 	memcpy(IO_ADDRESS(TEGRA_IRAM_LPx_RESUME_AREA), iram_save_addr,
 		iram_save_size);
@@ -306,7 +321,7 @@ static int tegra_suspend_enter(suspend_state_t state)
 
 	pr_info("Entering suspend state %s\n", lp_state[mode]);
 
-	tegra_pmc_pm_set(mode);
+	tegra_pm_set(mode);
 
 	local_fiq_disable();
 
@@ -354,7 +369,6 @@ void __init tegra_init_suspend(void)
 		return;
 
 	tegra_tear_down_cpu_init();
-	tegra_pmc_suspend_init();
 
 	if (mode >= TEGRA_SUSPEND_LP1) {
 		if (!tegra_lp1_iram_hook() || !tegra_sleep_core_init()) {
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index f4a89698e5b0..83bc87583446 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -21,12 +21,11 @@
 #ifndef _MACH_TEGRA_PM_H_
 #define _MACH_TEGRA_PM_H_
 
-#include "pmc.h"
-
 struct tegra_lp1_iram {
 	void	*start_addr;
 	void	*end_addr;
 };
+
 extern struct tegra_lp1_iram tegra_lp1_iram;
 extern void (*tegra_sleep_core_finish)(unsigned long v2p);
 
@@ -42,15 +41,8 @@ void tegra_idle_lp2_last(void);
 extern void (*tegra_tear_down_cpu)(void);
 
 #ifdef CONFIG_PM_SLEEP
-enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
-				enum tegra_suspend_mode mode);
 void tegra_init_suspend(void);
 #else
-static inline enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
-				enum tegra_suspend_mode mode)
-{
-	return TEGRA_SUSPEND_NONE;
-}
 static inline void tegra_init_suspend(void) {}
 #endif
 
diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
deleted file mode 100644
index e1677c0a78db..000000000000
--- a/arch/arm/mach-tegra/pmc.c
+++ /dev/null
@@ -1,402 +0,0 @@
-/*
- * Copyright (C) 2012,2013 NVIDIA CORPORATION. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/clk.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/tegra-powergate.h>
-#include <linux/tegra-soc.h>
-
-#include "flowctrl.h"
-#include "pm.h"
-#include "pmc.h"
-#include "sleep.h"
-
-#define TEGRA_POWER_SYSCLK_POLARITY	(1 << 10)  /* sys clk polarity */
-#define TEGRA_POWER_SYSCLK_OE		(1 << 11)  /* system clock enable */
-#define TEGRA_POWER_EFFECT_LP0		(1 << 14)  /* LP0 when CPU pwr gated */
-#define TEGRA_POWER_CPU_PWRREQ_POLARITY	(1 << 15)  /* CPU pwr req polarity */
-#define TEGRA_POWER_CPU_PWRREQ_OE	(1 << 16)  /* CPU pwr req enable */
-
-#define PMC_CTRL			0x0
-#define PMC_CTRL_INTR_LOW		(1 << 17)
-#define PMC_PWRGATE_TOGGLE		0x30
-#define PMC_PWRGATE_TOGGLE_START	(1 << 8)
-#define PMC_REMOVE_CLAMPING		0x34
-#define PMC_PWRGATE_STATUS		0x38
-
-#define PMC_SCRATCH0			0x50
-#define PMC_SCRATCH0_MODE_RECOVERY	(1 << 31)
-#define PMC_SCRATCH0_MODE_BOOTLOADER	(1 << 30)
-#define PMC_SCRATCH0_MODE_RCM		(1 << 1)
-#define PMC_SCRATCH0_MODE_MASK		(PMC_SCRATCH0_MODE_RECOVERY | \
-					 PMC_SCRATCH0_MODE_BOOTLOADER | \
-					 PMC_SCRATCH0_MODE_RCM)
-
-#define PMC_CPUPWRGOOD_TIMER	0xc8
-#define PMC_CPUPWROFF_TIMER	0xcc
-
-static u8 tegra_cpu_domains[] = {
-	0xFF,			/* not available for CPU0 */
-	TEGRA_POWERGATE_CPU1,
-	TEGRA_POWERGATE_CPU2,
-	TEGRA_POWERGATE_CPU3,
-};
-static DEFINE_SPINLOCK(tegra_powergate_lock);
-
-static bool tegra_pmc_invert_interrupt;
-static struct clk *tegra_pclk;
-void __iomem *tegra_pmc_base;
-
-struct pmc_pm_data {
-	u32 cpu_good_time;	/* CPU power good time in uS */
-	u32 cpu_off_time;	/* CPU power off time in uS */
-	u32 core_osc_time;	/* Core power good osc time in uS */
-	u32 core_pmu_time;	/* Core power good pmu time in uS */
-	u32 core_off_time;	/* Core power off time in uS */
-	bool corereq_high;	/* Core power request active-high */
-	bool sysclkreq_high;	/* System clock request active-high */
-	bool combined_req;	/* Combined pwr req for CPU & Core */
-	bool cpu_pwr_good_en;	/* CPU power good signal is enabled */
-	u32 lp0_vec_phy_addr;	/* The phy addr of LP0 warm boot code */
-	u32 lp0_vec_size;	/* The size of LP0 warm boot code */
-	enum tegra_suspend_mode suspend_mode;
-};
-static struct pmc_pm_data pmc_pm_data;
-
-static int tegra_pmc_get_cpu_powerdomain_id(int cpuid)
-{
-	if (cpuid <= 0 || cpuid >= num_possible_cpus())
-		return -EINVAL;
-	return tegra_cpu_domains[cpuid];
-}
-
-static bool tegra_pmc_powergate_is_powered(int id)
-{
-	return (tegra_pmc_readl(PMC_PWRGATE_STATUS) >> id) & 1;
-}
-
-static int tegra_pmc_powergate_set(int id, bool new_state)
-{
-	bool old_state;
-	unsigned long flags;
-
-	spin_lock_irqsave(&tegra_powergate_lock, flags);
-
-	old_state = tegra_pmc_powergate_is_powered(id);
-	WARN_ON(old_state == new_state);
-
-	tegra_pmc_writel(PMC_PWRGATE_TOGGLE_START | id, PMC_PWRGATE_TOGGLE);
-
-	spin_unlock_irqrestore(&tegra_powergate_lock, flags);
-
-	return 0;
-}
-
-static int tegra_pmc_powergate_remove_clamping(int id)
-{
-	u32 mask;
-
-	/*
-	 * Tegra has a bug where PCIE and VDE clamping masks are
-	 * swapped relatively to the partition ids.
-	 */
-	if (id ==  TEGRA_POWERGATE_VDEC)
-		mask = (1 << TEGRA_POWERGATE_PCIE);
-	else if	(id == TEGRA_POWERGATE_PCIE)
-		mask = (1 << TEGRA_POWERGATE_VDEC);
-	else
-		mask = (1 << id);
-
-	tegra_pmc_writel(mask, PMC_REMOVE_CLAMPING);
-
-	return 0;
-}
-
-bool tegra_pmc_cpu_is_powered(int cpuid)
-{
-	int id;
-
-	id = tegra_pmc_get_cpu_powerdomain_id(cpuid);
-	if (id < 0)
-		return false;
-	return tegra_pmc_powergate_is_powered(id);
-}
-
-int tegra_pmc_cpu_power_on(int cpuid)
-{
-	int id;
-
-	id = tegra_pmc_get_cpu_powerdomain_id(cpuid);
-	if (id < 0)
-		return id;
-	return tegra_pmc_powergate_set(id, true);
-}
-
-int tegra_pmc_cpu_remove_clamping(int cpuid)
-{
-	int id;
-
-	id = tegra_pmc_get_cpu_powerdomain_id(cpuid);
-	if (id < 0)
-		return id;
-	return tegra_pmc_powergate_remove_clamping(id);
-}
-
-void tegra_pmc_restart(enum reboot_mode mode, const char *cmd)
-{
-	u32 val;
-
-	val = tegra_pmc_readl(PMC_SCRATCH0);
-	val &= ~PMC_SCRATCH0_MODE_MASK;
-
-	if (cmd) {
-		if (strcmp(cmd, "recovery") == 0)
-			val |= PMC_SCRATCH0_MODE_RECOVERY;
-
-		if (strcmp(cmd, "bootloader") == 0)
-			val |= PMC_SCRATCH0_MODE_BOOTLOADER;
-
-		if (strcmp(cmd, "forced-recovery") == 0)
-			val |= PMC_SCRATCH0_MODE_RCM;
-	}
-
-	tegra_pmc_writel(val, PMC_SCRATCH0);
-
-	val = tegra_pmc_readl(0);
-	val |= 0x10;
-	tegra_pmc_writel(val, 0);
-}
-
-#ifdef CONFIG_PM_SLEEP
-static void set_power_timers(u32 us_on, u32 us_off, unsigned long rate)
-{
-	unsigned long long ticks;
-	unsigned long long pclk;
-	static unsigned long tegra_last_pclk;
-
-	if (WARN_ON_ONCE(rate <= 0))
-		pclk = 100000000;
-	else
-		pclk = rate;
-
-	if ((rate != tegra_last_pclk)) {
-		ticks = (us_on * pclk) + 999999ull;
-		do_div(ticks, 1000000);
-		tegra_pmc_writel((unsigned long)ticks, PMC_CPUPWRGOOD_TIMER);
-
-		ticks = (us_off * pclk) + 999999ull;
-		do_div(ticks, 1000000);
-		tegra_pmc_writel((unsigned long)ticks, PMC_CPUPWROFF_TIMER);
-		wmb();
-	}
-	tegra_last_pclk = pclk;
-}
-
-enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void)
-{
-	return pmc_pm_data.suspend_mode;
-}
-
-void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode)
-{
-	if (mode < TEGRA_SUSPEND_NONE || mode >= TEGRA_MAX_SUSPEND_MODE)
-		return;
-
-	pmc_pm_data.suspend_mode = mode;
-}
-
-void tegra_pmc_suspend(void)
-{
-	tegra_pmc_writel(virt_to_phys(tegra_resume), PMC_SCRATCH41);
-}
-
-void tegra_pmc_resume(void)
-{
-	tegra_pmc_writel(0x0, PMC_SCRATCH41);
-}
-
-void tegra_pmc_pm_set(enum tegra_suspend_mode mode)
-{
-	u32 reg, csr_reg;
-	unsigned long rate = 0;
-
-	reg = tegra_pmc_readl(PMC_CTRL);
-	reg |= TEGRA_POWER_CPU_PWRREQ_OE;
-	reg &= ~TEGRA_POWER_EFFECT_LP0;
-
-	switch (tegra_chip_id) {
-	case TEGRA20:
-	case TEGRA30:
-		break;
-	default:
-		/* Turn off CRAIL */
-		csr_reg = flowctrl_read_cpu_csr(0);
-		csr_reg &= ~FLOW_CTRL_CSR_ENABLE_EXT_MASK;
-		csr_reg |= FLOW_CTRL_CSR_ENABLE_EXT_CRAIL;
-		flowctrl_write_cpu_csr(0, csr_reg);
-		break;
-	}
-
-	switch (mode) {
-	case TEGRA_SUSPEND_LP1:
-		rate = 32768;
-		break;
-	case TEGRA_SUSPEND_LP2:
-		rate = clk_get_rate(tegra_pclk);
-		break;
-	default:
-		break;
-	}
-
-	set_power_timers(pmc_pm_data.cpu_good_time, pmc_pm_data.cpu_off_time,
-			 rate);
-
-	tegra_pmc_writel(reg, PMC_CTRL);
-}
-
-void tegra_pmc_suspend_init(void)
-{
-	u32 reg;
-
-	/* Always enable CPU power request */
-	reg = tegra_pmc_readl(PMC_CTRL);
-	reg |= TEGRA_POWER_CPU_PWRREQ_OE;
-	tegra_pmc_writel(reg, PMC_CTRL);
-
-	reg = tegra_pmc_readl(PMC_CTRL);
-
-	if (!pmc_pm_data.sysclkreq_high)
-		reg |= TEGRA_POWER_SYSCLK_POLARITY;
-	else
-		reg &= ~TEGRA_POWER_SYSCLK_POLARITY;
-
-	/* configure the output polarity while the request is tristated */
-	tegra_pmc_writel(reg, PMC_CTRL);
-
-	/* now enable the request */
-	reg |= TEGRA_POWER_SYSCLK_OE;
-	tegra_pmc_writel(reg, PMC_CTRL);
-}
-#endif
-
-static const struct of_device_id matches[] __initconst = {
-	{ .compatible = "nvidia,tegra124-pmc" },
-	{ .compatible = "nvidia,tegra114-pmc" },
-	{ .compatible = "nvidia,tegra30-pmc" },
-	{ .compatible = "nvidia,tegra20-pmc" },
-	{ }
-};
-
-void __init tegra_pmc_init_irq(void)
-{
-	struct device_node *np;
-	u32 val;
-
-	np = of_find_matching_node(NULL, matches);
-	BUG_ON(!np);
-
-	tegra_pmc_base = of_iomap(np, 0);
-
-	tegra_pmc_invert_interrupt = of_property_read_bool(np,
-				     "nvidia,invert-interrupt");
-
-	val = tegra_pmc_readl(PMC_CTRL);
-	if (tegra_pmc_invert_interrupt)
-		val |= PMC_CTRL_INTR_LOW;
-	else
-		val &= ~PMC_CTRL_INTR_LOW;
-	tegra_pmc_writel(val, PMC_CTRL);
-}
-
-void __init tegra_pmc_init(void)
-{
-	struct device_node *np;
-	u32 prop;
-	enum tegra_suspend_mode suspend_mode;
-	u32 core_good_time[2] = {0, 0};
-	u32 lp0_vec[2] = {0, 0};
-
-	np = of_find_matching_node(NULL, matches);
-	BUG_ON(!np);
-
-	tegra_pclk = of_clk_get_by_name(np, "pclk");
-	WARN_ON(IS_ERR(tegra_pclk));
-
-	/* Grabbing the power management configurations */
-	if (of_property_read_u32(np, "nvidia,suspend-mode", &prop)) {
-		suspend_mode = TEGRA_SUSPEND_NONE;
-	} else {
-		switch (prop) {
-		case 0:
-			suspend_mode = TEGRA_SUSPEND_LP0;
-			break;
-		case 1:
-			suspend_mode = TEGRA_SUSPEND_LP1;
-			break;
-		case 2:
-			suspend_mode = TEGRA_SUSPEND_LP2;
-			break;
-		default:
-			suspend_mode = TEGRA_SUSPEND_NONE;
-			break;
-		}
-	}
-	suspend_mode = tegra_pm_validate_suspend_mode(suspend_mode);
-
-	if (of_property_read_u32(np, "nvidia,cpu-pwr-good-time", &prop))
-		suspend_mode = TEGRA_SUSPEND_NONE;
-	pmc_pm_data.cpu_good_time = prop;
-
-	if (of_property_read_u32(np, "nvidia,cpu-pwr-off-time", &prop))
-		suspend_mode = TEGRA_SUSPEND_NONE;
-	pmc_pm_data.cpu_off_time = prop;
-
-	if (of_property_read_u32_array(np, "nvidia,core-pwr-good-time",
-			core_good_time, ARRAY_SIZE(core_good_time)))
-		suspend_mode = TEGRA_SUSPEND_NONE;
-	pmc_pm_data.core_osc_time = core_good_time[0];
-	pmc_pm_data.core_pmu_time = core_good_time[1];
-
-	if (of_property_read_u32(np, "nvidia,core-pwr-off-time",
-				 &prop))
-		suspend_mode = TEGRA_SUSPEND_NONE;
-	pmc_pm_data.core_off_time = prop;
-
-	pmc_pm_data.corereq_high = of_property_read_bool(np,
-				"nvidia,core-power-req-active-high");
-
-	pmc_pm_data.sysclkreq_high = of_property_read_bool(np,
-				"nvidia,sys-clock-req-active-high");
-
-	pmc_pm_data.combined_req = of_property_read_bool(np,
-				"nvidia,combined-power-req");
-
-	pmc_pm_data.cpu_pwr_good_en = of_property_read_bool(np,
-				"nvidia,cpu-pwr-good-en");
-
-	if (of_property_read_u32_array(np, "nvidia,lp0-vec", lp0_vec,
-				       ARRAY_SIZE(lp0_vec)))
-		if (suspend_mode == TEGRA_SUSPEND_LP0)
-			suspend_mode = TEGRA_SUSPEND_LP1;
-
-	pmc_pm_data.lp0_vec_phy_addr = lp0_vec[0];
-	pmc_pm_data.lp0_vec_size = lp0_vec[1];
-
-	pmc_pm_data.suspend_mode = suspend_mode;
-}
diff --git a/arch/arm/mach-tegra/pmc.h b/arch/arm/mach-tegra/pmc.h
deleted file mode 100644
index 139a30867cb2..000000000000
--- a/arch/arm/mach-tegra/pmc.h
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * Copyright (C) 2012 NVIDIA CORPORATION. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- */
-
-#ifndef __MACH_TEGRA_PMC_H
-#define __MACH_TEGRA_PMC_H
-
-#include <linux/io.h>
-#include <linux/reboot.h>
-
-enum tegra_suspend_mode {
-	TEGRA_SUSPEND_NONE = 0,
-	TEGRA_SUSPEND_LP2,	/* CPU voltage off */
-	TEGRA_SUSPEND_LP1,	/* CPU voltage off, DRAM self-refresh */
-	TEGRA_SUSPEND_LP0,      /* CPU + core voltage off, DRAM self-refresh */
-	TEGRA_MAX_SUSPEND_MODE,
-};
-
-#ifdef CONFIG_PM_SLEEP
-enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void);
-void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode);
-void tegra_pmc_suspend(void);
-void tegra_pmc_resume(void);
-void tegra_pmc_pm_set(enum tegra_suspend_mode mode);
-void tegra_pmc_suspend_init(void);
-#endif
-
-extern void __iomem *tegra_pmc_base;
-
-static inline u32 tegra_pmc_readl(u32 reg)
-{
-	return readl(tegra_pmc_base + reg);
-}
-
-static inline void tegra_pmc_writel(u32 val, u32 reg)
-{
-	writel(val, tegra_pmc_base + reg);
-}
-
-bool tegra_pmc_cpu_is_powered(int cpuid);
-int tegra_pmc_cpu_power_on(int cpuid);
-int tegra_pmc_cpu_remove_clamping(int cpuid);
-
-void tegra_pmc_restart(enum reboot_mode mode, const char *cmd);
-
-void tegra_pmc_init_irq(void);
-void tegra_pmc_init(void);
-
-#endif
diff --git a/arch/arm/mach-tegra/powergate.c b/arch/arm/mach-tegra/powergate.c
deleted file mode 100644
index c90f303aad4a..000000000000
--- a/arch/arm/mach-tegra/powergate.c
+++ /dev/null
@@ -1,503 +0,0 @@
-/*
- * drivers/powergate/tegra-powergate.c
- *
- * Copyright (c) 2010 Google, Inc
- *
- * Author:
- *	Colin Cross <ccross@google.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/clk.h>
-#include <linux/debugfs.h>
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/export.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/reset.h>
-#include <linux/seq_file.h>
-#include <linux/spinlock.h>
-#include <linux/clk/tegra.h>
-#include <linux/tegra-powergate.h>
-#include <linux/tegra-soc.h>
-
-#include "pmc.h"
-
-#define DPD_SAMPLE		0x020
-#define  DPD_SAMPLE_ENABLE	(1 << 0)
-#define  DPD_SAMPLE_DISABLE	(0 << 0)
-
-#define PWRGATE_TOGGLE		0x30
-#define  PWRGATE_TOGGLE_START	(1 << 8)
-
-#define REMOVE_CLAMPING		0x34
-
-#define PWRGATE_STATUS		0x38
-
-#define IO_DPD_REQ		0x1b8
-#define  IO_DPD_REQ_CODE_IDLE	(0 << 30)
-#define  IO_DPD_REQ_CODE_OFF	(1 << 30)
-#define  IO_DPD_REQ_CODE_ON	(2 << 30)
-#define  IO_DPD_REQ_CODE_MASK	(3 << 30)
-
-#define IO_DPD_STATUS		0x1bc
-#define IO_DPD2_REQ		0x1c0
-#define IO_DPD2_STATUS		0x1c4
-#define SEL_DPD_TIM		0x1c8
-
-#define GPU_RG_CNTRL		0x2d4
-
-static int tegra_num_powerdomains;
-static int tegra_num_cpu_domains;
-static const u8 *tegra_cpu_domains;
-
-static const u8 tegra30_cpu_domains[] = {
-	TEGRA_POWERGATE_CPU,
-	TEGRA_POWERGATE_CPU1,
-	TEGRA_POWERGATE_CPU2,
-	TEGRA_POWERGATE_CPU3,
-};
-
-static const u8 tegra114_cpu_domains[] = {
-	TEGRA_POWERGATE_CPU0,
-	TEGRA_POWERGATE_CPU1,
-	TEGRA_POWERGATE_CPU2,
-	TEGRA_POWERGATE_CPU3,
-};
-
-static const u8 tegra124_cpu_domains[] = {
-	TEGRA_POWERGATE_CPU0,
-	TEGRA_POWERGATE_CPU1,
-	TEGRA_POWERGATE_CPU2,
-	TEGRA_POWERGATE_CPU3,
-};
-
-static DEFINE_SPINLOCK(tegra_powergate_lock);
-
-static int tegra_powergate_set(int id, bool new_state)
-{
-	bool status;
-	unsigned long flags;
-
-	spin_lock_irqsave(&tegra_powergate_lock, flags);
-
-	status = tegra_pmc_readl(PWRGATE_STATUS) & (1 << id);
-
-	if (status == new_state) {
-		spin_unlock_irqrestore(&tegra_powergate_lock, flags);
-		return 0;
-	}
-
-	tegra_pmc_writel(PWRGATE_TOGGLE_START | id, PWRGATE_TOGGLE);
-
-	spin_unlock_irqrestore(&tegra_powergate_lock, flags);
-
-	return 0;
-}
-
-int tegra_powergate_power_on(int id)
-{
-	if (id < 0 || id >= tegra_num_powerdomains)
-		return -EINVAL;
-
-	return tegra_powergate_set(id, true);
-}
-
-int tegra_powergate_power_off(int id)
-{
-	if (id < 0 || id >= tegra_num_powerdomains)
-		return -EINVAL;
-
-	return tegra_powergate_set(id, false);
-}
-EXPORT_SYMBOL(tegra_powergate_power_off);
-
-int tegra_powergate_is_powered(int id)
-{
-	u32 status;
-
-	if (id < 0 || id >= tegra_num_powerdomains)
-		return -EINVAL;
-
-	status = tegra_pmc_readl(PWRGATE_STATUS) & (1 << id);
-	return !!status;
-}
-
-int tegra_powergate_remove_clamping(int id)
-{
-	u32 mask;
-
-	if (id < 0 || id >= tegra_num_powerdomains)
-		return -EINVAL;
-
-	/*
-	 * The Tegra124 GPU has a separate register (with different semantics)
-	 * to remove clamps.
-	 */
-	if (tegra_chip_id == TEGRA124) {
-		if (id == TEGRA_POWERGATE_3D) {
-			tegra_pmc_writel(0, GPU_RG_CNTRL);
-			return 0;
-		}
-	}
-
-	/*
-	 * Tegra 2 has a bug where PCIE and VDE clamping masks are
-	 * swapped relatively to the partition ids
-	 */
-	if (id == TEGRA_POWERGATE_VDEC)
-		mask = (1 << TEGRA_POWERGATE_PCIE);
-	else if (id == TEGRA_POWERGATE_PCIE)
-		mask = (1 << TEGRA_POWERGATE_VDEC);
-	else
-		mask = (1 << id);
-
-	tegra_pmc_writel(mask, REMOVE_CLAMPING);
-
-	return 0;
-}
-EXPORT_SYMBOL(tegra_powergate_remove_clamping);
-
-/* Must be called with clk disabled, and returns with clk enabled */
-int tegra_powergate_sequence_power_up(int id, struct clk *clk,
-					struct reset_control *rst)
-{
-	int ret;
-
-	reset_control_assert(rst);
-
-	ret = tegra_powergate_power_on(id);
-	if (ret)
-		goto err_power;
-
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		goto err_clk;
-
-	udelay(10);
-
-	ret = tegra_powergate_remove_clamping(id);
-	if (ret)
-		goto err_clamp;
-
-	udelay(10);
-	reset_control_deassert(rst);
-
-	return 0;
-
-err_clamp:
-	clk_disable_unprepare(clk);
-err_clk:
-	tegra_powergate_power_off(id);
-err_power:
-	return ret;
-}
-EXPORT_SYMBOL(tegra_powergate_sequence_power_up);
-
-int tegra_cpu_powergate_id(int cpuid)
-{
-	if (cpuid > 0 && cpuid < tegra_num_cpu_domains)
-		return tegra_cpu_domains[cpuid];
-
-	return -EINVAL;
-}
-
-int __init tegra_powergate_init(void)
-{
-	switch (tegra_chip_id) {
-	case TEGRA20:
-		tegra_num_powerdomains = 7;
-		break;
-	case TEGRA30:
-		tegra_num_powerdomains = 14;
-		tegra_num_cpu_domains = 4;
-		tegra_cpu_domains = tegra30_cpu_domains;
-		break;
-	case TEGRA114:
-		tegra_num_powerdomains = 23;
-		tegra_num_cpu_domains = 4;
-		tegra_cpu_domains = tegra114_cpu_domains;
-		break;
-	case TEGRA124:
-		tegra_num_powerdomains = 25;
-		tegra_num_cpu_domains = 4;
-		tegra_cpu_domains = tegra124_cpu_domains;
-		break;
-	default:
-		/* Unknown Tegra variant. Disable powergating */
-		tegra_num_powerdomains = 0;
-		break;
-	}
-
-	return 0;
-}
-
-#ifdef CONFIG_DEBUG_FS
-
-static const char * const *powergate_name;
-
-static const char * const powergate_name_t20[] = {
-	[TEGRA_POWERGATE_CPU]	= "cpu",
-	[TEGRA_POWERGATE_3D]	= "3d",
-	[TEGRA_POWERGATE_VENC]	= "venc",
-	[TEGRA_POWERGATE_VDEC]	= "vdec",
-	[TEGRA_POWERGATE_PCIE]	= "pcie",
-	[TEGRA_POWERGATE_L2]	= "l2",
-	[TEGRA_POWERGATE_MPE]	= "mpe",
-};
-
-static const char * const powergate_name_t30[] = {
-	[TEGRA_POWERGATE_CPU]	= "cpu0",
-	[TEGRA_POWERGATE_3D]	= "3d0",
-	[TEGRA_POWERGATE_VENC]	= "venc",
-	[TEGRA_POWERGATE_VDEC]	= "vdec",
-	[TEGRA_POWERGATE_PCIE]	= "pcie",
-	[TEGRA_POWERGATE_L2]	= "l2",
-	[TEGRA_POWERGATE_MPE]	= "mpe",
-	[TEGRA_POWERGATE_HEG]	= "heg",
-	[TEGRA_POWERGATE_SATA]	= "sata",
-	[TEGRA_POWERGATE_CPU1]	= "cpu1",
-	[TEGRA_POWERGATE_CPU2]	= "cpu2",
-	[TEGRA_POWERGATE_CPU3]	= "cpu3",
-	[TEGRA_POWERGATE_CELP]	= "celp",
-	[TEGRA_POWERGATE_3D1]	= "3d1",
-};
-
-static const char * const powergate_name_t114[] = {
-	[TEGRA_POWERGATE_CPU]	= "crail",
-	[TEGRA_POWERGATE_3D]	= "3d",
-	[TEGRA_POWERGATE_VENC]	= "venc",
-	[TEGRA_POWERGATE_VDEC]	= "vdec",
-	[TEGRA_POWERGATE_MPE]	= "mpe",
-	[TEGRA_POWERGATE_HEG]	= "heg",
-	[TEGRA_POWERGATE_CPU1]	= "cpu1",
-	[TEGRA_POWERGATE_CPU2]	= "cpu2",
-	[TEGRA_POWERGATE_CPU3]	= "cpu3",
-	[TEGRA_POWERGATE_CELP]	= "celp",
-	[TEGRA_POWERGATE_CPU0]	= "cpu0",
-	[TEGRA_POWERGATE_C0NC]	= "c0nc",
-	[TEGRA_POWERGATE_C1NC]	= "c1nc",
-	[TEGRA_POWERGATE_DIS]	= "dis",
-	[TEGRA_POWERGATE_DISB]	= "disb",
-	[TEGRA_POWERGATE_XUSBA]	= "xusba",
-	[TEGRA_POWERGATE_XUSBB]	= "xusbb",
-	[TEGRA_POWERGATE_XUSBC]	= "xusbc",
-};
-
-static const char * const powergate_name_t124[] = {
-	[TEGRA_POWERGATE_CPU]	= "crail",
-	[TEGRA_POWERGATE_3D]	= "3d",
-	[TEGRA_POWERGATE_VENC]	= "venc",
-	[TEGRA_POWERGATE_PCIE]	= "pcie",
-	[TEGRA_POWERGATE_VDEC]	= "vdec",
-	[TEGRA_POWERGATE_L2]	= "l2",
-	[TEGRA_POWERGATE_MPE]	= "mpe",
-	[TEGRA_POWERGATE_HEG]	= "heg",
-	[TEGRA_POWERGATE_SATA]	= "sata",
-	[TEGRA_POWERGATE_CPU1]	= "cpu1",
-	[TEGRA_POWERGATE_CPU2]	= "cpu2",
-	[TEGRA_POWERGATE_CPU3]	= "cpu3",
-	[TEGRA_POWERGATE_CELP]	= "celp",
-	[TEGRA_POWERGATE_CPU0]	= "cpu0",
-	[TEGRA_POWERGATE_C0NC]	= "c0nc",
-	[TEGRA_POWERGATE_C1NC]	= "c1nc",
-	[TEGRA_POWERGATE_SOR]	= "sor",
-	[TEGRA_POWERGATE_DIS]	= "dis",
-	[TEGRA_POWERGATE_DISB]	= "disb",
-	[TEGRA_POWERGATE_XUSBA]	= "xusba",
-	[TEGRA_POWERGATE_XUSBB]	= "xusbb",
-	[TEGRA_POWERGATE_XUSBC]	= "xusbc",
-	[TEGRA_POWERGATE_VIC]	= "vic",
-	[TEGRA_POWERGATE_IRAM]	= "iram",
-};
-
-static int powergate_show(struct seq_file *s, void *data)
-{
-	int i;
-
-	seq_printf(s, " powergate powered\n");
-	seq_printf(s, "------------------\n");
-
-	for (i = 0; i < tegra_num_powerdomains; i++) {
-		if (!powergate_name[i])
-			continue;
-
-		seq_printf(s, " %9s %7s\n", powergate_name[i],
-			tegra_powergate_is_powered(i) ? "yes" : "no");
-	}
-
-	return 0;
-}
-
-static int powergate_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, powergate_show, inode->i_private);
-}
-
-static const struct file_operations powergate_fops = {
-	.open		= powergate_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-int __init tegra_powergate_debugfs_init(void)
-{
-	struct dentry *d;
-
-	switch (tegra_chip_id) {
-	case TEGRA20:
-		powergate_name = powergate_name_t20;
-		break;
-	case TEGRA30:
-		powergate_name = powergate_name_t30;
-		break;
-	case TEGRA114:
-		powergate_name = powergate_name_t114;
-		break;
-	case TEGRA124:
-		powergate_name = powergate_name_t124;
-		break;
-	}
-
-	if (powergate_name) {
-		d = debugfs_create_file("powergate", S_IRUGO, NULL, NULL,
-			&powergate_fops);
-		if (!d)
-			return -ENOMEM;
-	}
-
-	return 0;
-}
-
-#endif
-
-static int tegra_io_rail_prepare(int id, unsigned long *request,
-				 unsigned long *status, unsigned int *bit)
-{
-	unsigned long rate, value;
-	struct clk *clk;
-
-	*bit = id % 32;
-
-	/*
-	 * There are two sets of 30 bits to select IO rails, but bits 30 and
-	 * 31 are control bits rather than IO rail selection bits.
-	 */
-	if (id > 63 || *bit == 30 || *bit == 31)
-		return -EINVAL;
-
-	if (id < 32) {
-		*status = IO_DPD_STATUS;
-		*request = IO_DPD_REQ;
-	} else {
-		*status = IO_DPD2_STATUS;
-		*request = IO_DPD2_REQ;
-	}
-
-	clk = clk_get_sys(NULL, "pclk");
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	rate = clk_get_rate(clk);
-	clk_put(clk);
-
-	tegra_pmc_writel(DPD_SAMPLE_ENABLE, DPD_SAMPLE);
-
-	/* must be at least 200 ns, in APB (PCLK) clock cycles */
-	value = DIV_ROUND_UP(1000000000, rate);
-	value = DIV_ROUND_UP(200, value);
-	tegra_pmc_writel(value, SEL_DPD_TIM);
-
-	return 0;
-}
-
-static int tegra_io_rail_poll(unsigned long offset, unsigned long mask,
-			      unsigned long val, unsigned long timeout)
-{
-	unsigned long value;
-
-	timeout = jiffies + msecs_to_jiffies(timeout);
-
-	while (time_after(timeout, jiffies)) {
-		value = tegra_pmc_readl(offset);
-		if ((value & mask) == val)
-			return 0;
-
-		usleep_range(250, 1000);
-	}
-
-	return -ETIMEDOUT;
-}
-
-static void tegra_io_rail_unprepare(void)
-{
-	tegra_pmc_writel(DPD_SAMPLE_DISABLE, DPD_SAMPLE);
-}
-
-int tegra_io_rail_power_on(int id)
-{
-	unsigned long request, status, value;
-	unsigned int bit, mask;
-	int err;
-
-	err = tegra_io_rail_prepare(id, &request, &status, &bit);
-	if (err < 0)
-		return err;
-
-	mask = 1 << bit;
-
-	value = tegra_pmc_readl(request);
-	value |= mask;
-	value &= ~IO_DPD_REQ_CODE_MASK;
-	value |= IO_DPD_REQ_CODE_OFF;
-	tegra_pmc_writel(value, request);
-
-	err = tegra_io_rail_poll(status, mask, 0, 250);
-	if (err < 0)
-		return err;
-
-	tegra_io_rail_unprepare();
-
-	return 0;
-}
-EXPORT_SYMBOL(tegra_io_rail_power_on);
-
-int tegra_io_rail_power_off(int id)
-{
-	unsigned long request, status, value;
-	unsigned int bit, mask;
-	int err;
-
-	err = tegra_io_rail_prepare(id, &request, &status, &bit);
-	if (err < 0)
-		return err;
-
-	mask = 1 << bit;
-
-	value = tegra_pmc_readl(request);
-	value |= mask;
-	value &= ~IO_DPD_REQ_CODE_MASK;
-	value |= IO_DPD_REQ_CODE_ON;
-	tegra_pmc_writel(value, request);
-
-	err = tegra_io_rail_poll(status, mask, mask, 250);
-	if (err < 0)
-		return err;
-
-	tegra_io_rail_unprepare();
-
-	return 0;
-}
-EXPORT_SYMBOL(tegra_io_rail_power_off);
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index ab6544576eac..087b66a77c34 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -49,7 +49,6 @@
 #include "flowctrl.h"
 #include "iomap.h"
 #include "irq.h"
-#include "pmc.h"
 #include "pm.h"
 #include "reset.h"
 #include "sleep.h"
@@ -75,14 +74,12 @@ static void __init tegra_init_early(void)
 	of_register_trusted_foundations();
 	tegra_init_fuse();
 	tegra_cpu_reset_handler_init();
-	tegra_powergate_init();
 	tegra_hotplug_init();
 	tegra_flowctrl_init();
 }
 
 static void __init tegra_dt_init_irq(void)
 {
-	tegra_pmc_init_irq();
 	tegra_init_irq();
 	irqchip_init();
 	tegra_legacy_irq_syscore_init();
@@ -94,8 +91,6 @@ static void __init tegra_dt_init(void)
 	struct soc_device *soc_dev;
 	struct device *parent = NULL;
 
-	tegra_pmc_init();
-
 	tegra_clocks_apply_init_table();
 
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
@@ -145,7 +140,6 @@ static void __init tegra_dt_init_late(void)
 
 	tegra_init_suspend();
 	tegra_cpuidle_init();
-	tegra_powergate_debugfs_init();
 
 	for (i = 0; i < ARRAY_SIZE(board_init_funcs); i++) {
 		if (of_machine_is_compatible(board_init_funcs[i].machine)) {
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index d7a0b9dfd7ad..12b874b01dfb 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_POWER_SUPPLY) += supply/
 obj-$(CONFIG_POWER_RESET) += reset/
 obj-$(CONFIG_POWER_AVS) += avs/
 
+obj-$(CONFIG_ARCH_TEGRA) += tegra-pmc.o
diff --git a/drivers/power/tegra-pmc.c b/drivers/power/tegra-pmc.c
new file mode 100644
index 000000000000..fa587028dc3c
--- /dev/null
+++ b/drivers/power/tegra-pmc.c
@@ -0,0 +1,948 @@
+/*
+ * drivers/soc/tegra/pmc.c
+ *
+ * Copyright (c) 2010 Google, Inc
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/clk/tegra.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/reset.h>
+#include <linux/seq_file.h>
+#include <linux/spinlock.h>
+#include <linux/tegra-powergate.h>
+#include <linux/tegra-soc.h>
+
+#define PMC_CNTRL			0x0
+#define  PMC_CNTRL_SYSCLK_POLARITY	(1 << 10)  /* sys clk polarity */
+#define  PMC_CNTRL_SYSCLK_OE		(1 << 11)  /* system clock enable */
+#define  PMC_CNTRL_SIDE_EFFECT_LP0	(1 << 14)  /* LP0 when CPU pwr gated */
+#define  PMC_CNTRL_CPU_PWRREQ_POLARITY	(1 << 15)  /* CPU pwr req polarity */
+#define  PMC_CNTRL_CPU_PWRREQ_OE	(1 << 16)  /* CPU pwr req enable */
+#define  PMC_CNTRL_INTR_POLARITY	(1 << 17)  /* inverts INTR polarity */
+
+#define DPD_SAMPLE			0x020
+#define  DPD_SAMPLE_ENABLE		(1 << 0)
+#define  DPD_SAMPLE_DISABLE		(0 << 0)
+
+#define PWRGATE_TOGGLE			0x30
+#define  PWRGATE_TOGGLE_START		(1 << 8)
+
+#define REMOVE_CLAMPING			0x34
+
+#define PWRGATE_STATUS			0x38
+
+#define PMC_SCRATCH0			0x50
+#define  PMC_SCRATCH0_MODE_RECOVERY	(1 << 31)
+#define  PMC_SCRATCH0_MODE_BOOTLOADER	(1 << 30)
+#define  PMC_SCRATCH0_MODE_RCM		(1 << 1)
+#define  PMC_SCRATCH0_MODE_MASK		(PMC_SCRATCH0_MODE_RECOVERY | \
+					 PMC_SCRATCH0_MODE_BOOTLOADER | \
+					 PMC_SCRATCH0_MODE_RCM)
+
+#define PMC_CPUPWRGOOD_TIMER		0xc8
+#define PMC_CPUPWROFF_TIMER		0xcc
+
+#define PMC_SCRATCH41			0x140
+
+#define IO_DPD_REQ			0x1b8
+#define  IO_DPD_REQ_CODE_IDLE		(0 << 30)
+#define  IO_DPD_REQ_CODE_OFF		(1 << 30)
+#define  IO_DPD_REQ_CODE_ON		(2 << 30)
+#define  IO_DPD_REQ_CODE_MASK		(3 << 30)
+
+#define IO_DPD_STATUS			0x1bc
+#define IO_DPD2_REQ			0x1c0
+#define IO_DPD2_STATUS			0x1c4
+#define SEL_DPD_TIM			0x1c8
+
+#define GPU_RG_CNTRL			0x2d4
+
+struct tegra_pmc_soc {
+	unsigned int num_powergates;
+	const char *const *powergates;
+	unsigned int num_cpu_powergates;
+	const u8 *cpu_powergates;
+};
+
+/**
+ * struct tegra_pmc - NVIDIA Tegra PMC
+ * @base: pointer to I/O remapped register region
+ * @clk: pointer to pclk clock
+ * @rate: currently configured rate of pclk
+ * @suspend_mode: lowest suspend mode available
+ * @cpu_good_time: CPU power good time (in microseconds)
+ * @cpu_off_time: CPU power off time (in microsecends)
+ * @core_osc_time: core power good OSC time (in microseconds)
+ * @core_pmu_time: core power good PMU time (in microseconds)
+ * @core_off_time: core power off time (in microseconds)
+ * @corereq_high: core power request is active-high
+ * @sysclkreq_high: system clock request is active-high
+ * @combined_req: combined power request for CPU & core
+ * @cpu_pwr_good_en: CPU power good signal is enabled
+ * @lp0_vec_phys: physical base address of the LP0 warm boot code
+ * @lp0_vec_size: size of the LP0 warm boot code
+ * @powergates_lock: mutex for power gate register access
+ */
+struct tegra_pmc {
+	void __iomem *base;
+	struct clk *clk;
+
+	const struct tegra_pmc_soc *soc;
+
+	unsigned long rate;
+
+	enum tegra_suspend_mode suspend_mode;
+	u32 cpu_good_time;
+	u32 cpu_off_time;
+	u32 core_osc_time;
+	u32 core_pmu_time;
+	u32 core_off_time;
+	bool corereq_high;
+	bool sysclkreq_high;
+	bool combined_req;
+	bool cpu_pwr_good_en;
+	u32 lp0_vec_phys;
+	u32 lp0_vec_size;
+
+	struct mutex powergates_lock;
+};
+
+static struct tegra_pmc *pmc = &(struct tegra_pmc) {
+	.base = NULL,
+	.suspend_mode = TEGRA_SUSPEND_NONE,
+};
+
+static u32 tegra_pmc_readl(unsigned long offset)
+{
+	return readl(pmc->base + offset);
+}
+
+static void tegra_pmc_writel(u32 value, unsigned long offset)
+{
+	writel(value, pmc->base + offset);
+}
+
+/**
+ * tegra_powergate_set() - set the state of a partition
+ * @id: partition ID
+ * @new_state: new state of the partition
+ */
+static int tegra_powergate_set(int id, bool new_state)
+{
+	bool status;
+
+	mutex_lock(&pmc->powergates_lock);
+
+	status = tegra_pmc_readl(PWRGATE_STATUS) & (1 << id);
+
+	if (status == new_state) {
+		mutex_unlock(&pmc->powergates_lock);
+		return 0;
+	}
+
+	tegra_pmc_writel(PWRGATE_TOGGLE_START | id, PWRGATE_TOGGLE);
+
+	mutex_unlock(&pmc->powergates_lock);
+
+	return 0;
+}
+
+/**
+ * tegra_powergate_power_on() - power on partition
+ * @id: partition ID
+ */
+int tegra_powergate_power_on(int id)
+{
+	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
+		return -EINVAL;
+
+	return tegra_powergate_set(id, true);
+}
+
+/**
+ * tegra_powergate_power_off() - power off partition
+ * @id: partition ID
+ */
+int tegra_powergate_power_off(int id)
+{
+	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
+		return -EINVAL;
+
+	return tegra_powergate_set(id, false);
+}
+EXPORT_SYMBOL(tegra_powergate_power_off);
+
+/**
+ * tegra_powergate_is_powered() - check if partition is powered
+ * @id: partition ID
+ */
+int tegra_powergate_is_powered(int id)
+{
+	u32 status;
+
+	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
+		return -EINVAL;
+
+	status = tegra_pmc_readl(PWRGATE_STATUS) & (1 << id);
+	return !!status;
+}
+
+/**
+ * tegra_powergate_remove_clamping() - remove power clamps for partition
+ * @id: partition ID
+ */
+int tegra_powergate_remove_clamping(int id)
+{
+	u32 mask;
+
+	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
+		return -EINVAL;
+
+	/*
+	 * The Tegra124 GPU has a separate register (with different semantics)
+	 * to remove clamps.
+	 */
+	if (tegra_chip_id == TEGRA124) {
+		if (id == TEGRA_POWERGATE_3D) {
+			tegra_pmc_writel(0, GPU_RG_CNTRL);
+			return 0;
+		}
+	}
+
+	/*
+	 * Tegra 2 has a bug where PCIE and VDE clamping masks are
+	 * swapped relatively to the partition ids
+	 */
+	if (id == TEGRA_POWERGATE_VDEC)
+		mask = (1 << TEGRA_POWERGATE_PCIE);
+	else if (id == TEGRA_POWERGATE_PCIE)
+		mask = (1 << TEGRA_POWERGATE_VDEC);
+	else
+		mask = (1 << id);
+
+	tegra_pmc_writel(mask, REMOVE_CLAMPING);
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_powergate_remove_clamping);
+
+/**
+ * tegra_powergate_sequence_power_up() - power up partition
+ * @id: partition ID
+ * @clk: clock for partition
+ * @rst: reset for partition
+ *
+ * Must be called with clk disabled, and returns with clk enabled.
+ */
+int tegra_powergate_sequence_power_up(int id, struct clk *clk,
+				      struct reset_control *rst)
+{
+	int ret;
+
+	reset_control_assert(rst);
+
+	ret = tegra_powergate_power_on(id);
+	if (ret)
+		goto err_power;
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		goto err_clk;
+
+	usleep_range(10, 20);
+
+	ret = tegra_powergate_remove_clamping(id);
+	if (ret)
+		goto err_clamp;
+
+	usleep_range(10, 20);
+	reset_control_deassert(rst);
+
+	return 0;
+
+err_clamp:
+	clk_disable_unprepare(clk);
+err_clk:
+	tegra_powergate_power_off(id);
+err_power:
+	return ret;
+}
+EXPORT_SYMBOL(tegra_powergate_sequence_power_up);
+
+/**
+ * tegra_get_cpu_powergate_id() - convert from CPU ID to partition ID
+ * @cpuid: CPU partition ID
+ *
+ * Returns the partition ID corresponding to the CPU partition ID or a
+ * negative error code on failure.
+ */
+static int tegra_get_cpu_powergate_id(int cpuid)
+{
+	if (pmc->soc && cpuid > 0 && cpuid < pmc->soc->num_cpu_powergates)
+		return pmc->soc->cpu_powergates[cpuid];
+
+	return -EINVAL;
+}
+
+/**
+ * tegra_pmc_cpu_is_powered() - check if CPU partition is powered
+ * @cpuid: CPU partition ID
+ */
+bool tegra_pmc_cpu_is_powered(int cpuid)
+{
+	int id;
+
+	id = tegra_get_cpu_powergate_id(cpuid);
+	if (id < 0)
+		return false;
+
+	return tegra_powergate_is_powered(id);
+}
+
+/**
+ * tegra_pmc_cpu_power_on() - power on CPU partition
+ * @cpuid: CPU partition ID
+ */
+int tegra_pmc_cpu_power_on(int cpuid)
+{
+	int id;
+
+	id = tegra_get_cpu_powergate_id(cpuid);
+	if (id < 0)
+		return id;
+
+	return tegra_powergate_set(id, true);
+}
+
+/**
+ * tegra_pmc_cpu_remove_clamping() - remove power clamps for CPU partition
+ * @cpuid: CPU partition ID
+ */
+int tegra_pmc_cpu_remove_clamping(int cpuid)
+{
+	int id;
+
+	id = tegra_get_cpu_powergate_id(cpuid);
+	if (id < 0)
+		return id;
+
+	return tegra_powergate_remove_clamping(id);
+}
+
+/**
+ * tegra_pmc_restart() - reboot the system
+ * @mode: which mode to reboot in
+ * @cmd: reboot command
+ */
+void tegra_pmc_restart(enum reboot_mode mode, const char *cmd)
+{
+	u32 value;
+
+	value = tegra_pmc_readl(PMC_SCRATCH0);
+	value &= ~PMC_SCRATCH0_MODE_MASK;
+
+	if (cmd) {
+		if (strcmp(cmd, "recovery") == 0)
+			value |= PMC_SCRATCH0_MODE_RECOVERY;
+
+		if (strcmp(cmd, "bootloader") == 0)
+			value |= PMC_SCRATCH0_MODE_BOOTLOADER;
+
+		if (strcmp(cmd, "forced-recovery") == 0)
+			value |= PMC_SCRATCH0_MODE_RCM;
+	}
+
+	tegra_pmc_writel(value, PMC_SCRATCH0);
+
+	value = tegra_pmc_readl(0);
+	value |= 0x10;
+	tegra_pmc_writel(value, 0);
+}
+
+static int powergate_show(struct seq_file *s, void *data)
+{
+	unsigned int i;
+
+	seq_printf(s, " powergate powered\n");
+	seq_printf(s, "------------------\n");
+
+	for (i = 0; i < pmc->soc->num_powergates; i++) {
+		if (!pmc->soc->powergates[i])
+			continue;
+
+		seq_printf(s, " %9s %7s\n", pmc->soc->powergates[i],
+			   tegra_powergate_is_powered(i) ? "yes" : "no");
+	}
+
+	return 0;
+}
+
+static int powergate_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, powergate_show, inode->i_private);
+}
+
+static const struct file_operations powergate_fops = {
+	.open = powergate_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int tegra_powergate_debugfs_init(void)
+{
+	struct dentry *d;
+
+	d = debugfs_create_file("powergate", S_IRUGO, NULL, NULL,
+				&powergate_fops);
+	if (!d)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int tegra_io_rail_prepare(int id, unsigned long *request,
+				 unsigned long *status, unsigned int *bit)
+{
+	unsigned long rate, value;
+	struct clk *clk;
+
+	*bit = id % 32;
+
+	/*
+	 * There are two sets of 30 bits to select IO rails, but bits 30 and
+	 * 31 are control bits rather than IO rail selection bits.
+	 */
+	if (id > 63 || *bit == 30 || *bit == 31)
+		return -EINVAL;
+
+	if (id < 32) {
+		*status = IO_DPD_STATUS;
+		*request = IO_DPD_REQ;
+	} else {
+		*status = IO_DPD2_STATUS;
+		*request = IO_DPD2_REQ;
+	}
+
+	clk = clk_get_sys(NULL, "pclk");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	rate = clk_get_rate(clk);
+	clk_put(clk);
+
+	tegra_pmc_writel(DPD_SAMPLE_ENABLE, DPD_SAMPLE);
+
+	/* must be@least 200 ns, in APB (PCLK) clock cycles */
+	value = DIV_ROUND_UP(1000000000, rate);
+	value = DIV_ROUND_UP(200, value);
+	tegra_pmc_writel(value, SEL_DPD_TIM);
+
+	return 0;
+}
+
+static int tegra_io_rail_poll(unsigned long offset, unsigned long mask,
+			      unsigned long val, unsigned long timeout)
+{
+	unsigned long value;
+
+	timeout = jiffies + msecs_to_jiffies(timeout);
+
+	while (time_after(timeout, jiffies)) {
+		value = tegra_pmc_readl(offset);
+		if ((value & mask) == val)
+			return 0;
+
+		usleep_range(250, 1000);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static void tegra_io_rail_unprepare(void)
+{
+	tegra_pmc_writel(DPD_SAMPLE_DISABLE, DPD_SAMPLE);
+}
+
+int tegra_io_rail_power_on(int id)
+{
+	unsigned long request, status, value;
+	unsigned int bit, mask;
+	int err;
+
+	err = tegra_io_rail_prepare(id, &request, &status, &bit);
+	if (err < 0)
+		return err;
+
+	mask = 1 << bit;
+
+	value = tegra_pmc_readl(request);
+	value |= mask;
+	value &= ~IO_DPD_REQ_CODE_MASK;
+	value |= IO_DPD_REQ_CODE_OFF;
+	tegra_pmc_writel(value, request);
+
+	err = tegra_io_rail_poll(status, mask, 0, 250);
+	if (err < 0)
+		return err;
+
+	tegra_io_rail_unprepare();
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_io_rail_power_on);
+
+int tegra_io_rail_power_off(int id)
+{
+	unsigned long request, status, value;
+	unsigned int bit, mask;
+	int err;
+
+	err = tegra_io_rail_prepare(id, &request, &status, &bit);
+	if (err < 0)
+		return err;
+
+	mask = 1 << bit;
+
+	value = tegra_pmc_readl(request);
+	value |= mask;
+	value &= ~IO_DPD_REQ_CODE_MASK;
+	value |= IO_DPD_REQ_CODE_ON;
+	tegra_pmc_writel(value, request);
+
+	err = tegra_io_rail_poll(status, mask, mask, 250);
+	if (err < 0)
+		return err;
+
+	tegra_io_rail_unprepare();
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_io_rail_power_off);
+
+enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void)
+{
+	return pmc->suspend_mode;
+}
+
+void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode)
+{
+	if (mode < TEGRA_SUSPEND_NONE || mode >= TEGRA_MAX_SUSPEND_MODE)
+		return;
+
+	pmc->suspend_mode = mode;
+}
+
+void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
+{
+	unsigned long long rate = 0;
+	u32 value;
+
+	switch (mode) {
+	case TEGRA_SUSPEND_LP1:
+		rate = 32768;
+		break;
+
+	case TEGRA_SUSPEND_LP2:
+		rate = clk_get_rate(pmc->clk);
+		break;
+
+	default:
+		break;
+	}
+
+	if (WARN_ON_ONCE(rate == 0))
+		rate = 100000000;
+
+	if (rate != pmc->rate) {
+		u64 ticks;
+
+		ticks = pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
+		do_div(ticks, USEC_PER_SEC);
+		tegra_pmc_writel(ticks, PMC_CPUPWRGOOD_TIMER);
+
+		ticks = pmc->cpu_off_time * rate + USEC_PER_SEC - 1;
+		do_div(ticks, USEC_PER_SEC);
+		tegra_pmc_writel(ticks, PMC_CPUPWROFF_TIMER);
+
+		wmb();
+
+		pmc->rate = rate;
+	}
+
+	value = tegra_pmc_readl(PMC_CNTRL);
+	value &= ~PMC_CNTRL_SIDE_EFFECT_LP0;
+	value |= PMC_CNTRL_CPU_PWRREQ_OE;
+	tegra_pmc_writel(value, PMC_CNTRL);
+}
+
+static int tegra_pmc_parse_dt(struct tegra_pmc *pmc, struct device_node *np)
+{
+	u32 value, values[2];
+
+	if (of_property_read_u32(np, "nvidia,suspend-mode", &value)) {
+	} else {
+		switch (value) {
+		case 0:
+			pmc->suspend_mode = TEGRA_SUSPEND_LP0;
+			break;
+
+		case 1:
+			pmc->suspend_mode = TEGRA_SUSPEND_LP1;
+			break;
+
+		case 2:
+			pmc->suspend_mode = TEGRA_SUSPEND_LP2;
+			break;
+
+		default:
+			pmc->suspend_mode = TEGRA_SUSPEND_NONE;
+			break;
+		}
+	}
+
+	pmc->suspend_mode = tegra_pm_validate_suspend_mode(pmc->suspend_mode);
+
+	if (of_property_read_u32(np, "nvidia,cpu-pwr-good-time", &value))
+		pmc->suspend_mode = TEGRA_SUSPEND_NONE;
+
+	pmc->cpu_good_time = value;
+
+	if (of_property_read_u32(np, "nvidia,cpu-pwr-off-time", &value))
+		pmc->suspend_mode = TEGRA_SUSPEND_NONE;
+
+	pmc->cpu_off_time = value;
+
+	if (of_property_read_u32_array(np, "nvidia,core-pwr-good-time",
+				       values, ARRAY_SIZE(values)))
+		pmc->suspend_mode = TEGRA_SUSPEND_NONE;
+
+	pmc->core_osc_time = values[0];
+	pmc->core_pmu_time = values[1];
+
+	if (of_property_read_u32(np, "nvidia,core-pwr-off-time", &value))
+		pmc->suspend_mode = TEGRA_SUSPEND_NONE;
+
+	pmc->core_off_time = value;
+
+	pmc->corereq_high = of_property_read_bool(np,
+				"nvidia,core-power-req-active-high");
+
+	pmc->sysclkreq_high = of_property_read_bool(np,
+				"nvidia,sys-clock-req-active-high");
+
+	pmc->combined_req = of_property_read_bool(np,
+				"nvidia,combined-power-req");
+
+	pmc->cpu_pwr_good_en = of_property_read_bool(np,
+				"nvidia,cpu-pwr-good-en");
+
+	if (of_property_read_u32_array(np, "nvidia,lp0-vec", values,
+				       ARRAY_SIZE(values)))
+		if (pmc->suspend_mode == TEGRA_SUSPEND_LP0)
+			pmc->suspend_mode = TEGRA_SUSPEND_LP1;
+
+	pmc->lp0_vec_phys = values[0];
+	pmc->lp0_vec_size = values[1];
+
+	return 0;
+}
+
+static void tegra_pmc_init(struct tegra_pmc *pmc)
+{
+	u32 value;
+
+	/* Always enable CPU power request */
+	value = tegra_pmc_readl(PMC_CNTRL);
+	value |= PMC_CNTRL_CPU_PWRREQ_OE;
+	tegra_pmc_writel(value, PMC_CNTRL);
+
+	value = tegra_pmc_readl(PMC_CNTRL);
+
+	if (pmc->sysclkreq_high)
+		value &= ~PMC_CNTRL_SYSCLK_POLARITY;
+	else
+		value |= PMC_CNTRL_SYSCLK_POLARITY;
+
+	/* configure the output polarity while the request is tristated */
+	tegra_pmc_writel(value, PMC_CNTRL);
+
+	/* now enable the request */
+	value = tegra_pmc_readl(PMC_CNTRL);
+	value |= PMC_CNTRL_SYSCLK_OE;
+	tegra_pmc_writel(value, PMC_CNTRL);
+}
+
+static int tegra_pmc_probe(struct platform_device *pdev)
+{
+	void __iomem *base = pmc->base;
+	struct resource *res;
+	int err;
+
+	err = tegra_pmc_parse_dt(pmc, pdev->dev.of_node);
+	if (err < 0)
+		return err;
+
+	/* take over the memory region from the early initialization */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pmc->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pmc->base))
+		return PTR_ERR(pmc->base);
+
+	iounmap(base);
+
+	pmc->clk = devm_clk_get(&pdev->dev, "pclk");
+	if (IS_ERR(pmc->clk)) {
+		err = PTR_ERR(pmc->clk);
+		dev_err(&pdev->dev, "failed to get pclk: %d\n", err);
+		return err;
+	}
+
+	tegra_pmc_init(pmc);
+
+	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
+		err = tegra_powergate_debugfs_init();
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int tegra_pmc_suspend(struct device *dev)
+{
+	tegra_pmc_writel(virt_to_phys(tegra_resume), PMC_SCRATCH41);
+
+	return 0;
+}
+
+static int tegra_pmc_resume(struct device *dev)
+{
+	tegra_pmc_writel(0x0, PMC_SCRATCH41);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(tegra_pmc_pm_ops, tegra_pmc_suspend, tegra_pmc_resume);
+
+static const char * const tegra20_powergates[] = {
+	[TEGRA_POWERGATE_CPU] = "cpu",
+	[TEGRA_POWERGATE_3D] = "3d",
+	[TEGRA_POWERGATE_VENC] = "venc",
+	[TEGRA_POWERGATE_VDEC] = "vdec",
+	[TEGRA_POWERGATE_PCIE] = "pcie",
+	[TEGRA_POWERGATE_L2] = "l2",
+	[TEGRA_POWERGATE_MPE] = "mpe",
+};
+
+static const struct tegra_pmc_soc tegra20_pmc_soc = {
+	.num_powergates = ARRAY_SIZE(tegra20_powergates),
+	.powergates = tegra20_powergates,
+	.num_cpu_powergates = 0,
+	.cpu_powergates = NULL,
+};
+
+static const char * const tegra30_powergates[] = {
+	[TEGRA_POWERGATE_CPU] = "cpu0",
+	[TEGRA_POWERGATE_3D] = "3d0",
+	[TEGRA_POWERGATE_VENC] = "venc",
+	[TEGRA_POWERGATE_VDEC] = "vdec",
+	[TEGRA_POWERGATE_PCIE] = "pcie",
+	[TEGRA_POWERGATE_L2] = "l2",
+	[TEGRA_POWERGATE_MPE] = "mpe",
+	[TEGRA_POWERGATE_HEG] = "heg",
+	[TEGRA_POWERGATE_SATA] = "sata",
+	[TEGRA_POWERGATE_CPU1] = "cpu1",
+	[TEGRA_POWERGATE_CPU2] = "cpu2",
+	[TEGRA_POWERGATE_CPU3] = "cpu3",
+	[TEGRA_POWERGATE_CELP] = "celp",
+	[TEGRA_POWERGATE_3D1] = "3d1",
+};
+
+static const u8 tegra30_cpu_powergates[] = {
+	TEGRA_POWERGATE_CPU,
+	TEGRA_POWERGATE_CPU1,
+	TEGRA_POWERGATE_CPU2,
+	TEGRA_POWERGATE_CPU3,
+};
+
+static const struct tegra_pmc_soc tegra30_pmc_soc = {
+	.num_powergates = ARRAY_SIZE(tegra20_powergates),
+	.powergates = tegra30_powergates,
+	.num_cpu_powergates = ARRAY_SIZE(tegra30_cpu_powergates),
+	.cpu_powergates = tegra30_cpu_powergates,
+};
+
+static const char * const tegra114_powergates[] = {
+	[TEGRA_POWERGATE_CPU] = "crail",
+	[TEGRA_POWERGATE_3D] = "3d",
+	[TEGRA_POWERGATE_VENC] = "venc",
+	[TEGRA_POWERGATE_VDEC] = "vdec",
+	[TEGRA_POWERGATE_MPE] = "mpe",
+	[TEGRA_POWERGATE_HEG] = "heg",
+	[TEGRA_POWERGATE_CPU1] = "cpu1",
+	[TEGRA_POWERGATE_CPU2] = "cpu2",
+	[TEGRA_POWERGATE_CPU3] = "cpu3",
+	[TEGRA_POWERGATE_CELP] = "celp",
+	[TEGRA_POWERGATE_CPU0] = "cpu0",
+	[TEGRA_POWERGATE_C0NC] = "c0nc",
+	[TEGRA_POWERGATE_C1NC] = "c1nc",
+	[TEGRA_POWERGATE_DIS] = "dis",
+	[TEGRA_POWERGATE_DISB] = "disb",
+	[TEGRA_POWERGATE_XUSBA] = "xusba",
+	[TEGRA_POWERGATE_XUSBB] = "xusbb",
+	[TEGRA_POWERGATE_XUSBC] = "xusbc",
+};
+
+static const u8 tegra114_cpu_powergates[] = {
+	TEGRA_POWERGATE_CPU0,
+	TEGRA_POWERGATE_CPU1,
+	TEGRA_POWERGATE_CPU2,
+	TEGRA_POWERGATE_CPU3,
+};
+
+static const struct tegra_pmc_soc tegra114_pmc_soc = {
+	.num_powergates = ARRAY_SIZE(tegra114_powergates),
+	.powergates = tegra114_powergates,
+	.num_cpu_powergates = ARRAY_SIZE(tegra114_cpu_powergates),
+	.cpu_powergates = tegra114_cpu_powergates,
+};
+
+static const char * const tegra124_powergates[] = {
+	[TEGRA_POWERGATE_CPU] = "crail",
+	[TEGRA_POWERGATE_3D] = "3d",
+	[TEGRA_POWERGATE_VENC] = "venc",
+	[TEGRA_POWERGATE_PCIE] = "pcie",
+	[TEGRA_POWERGATE_VDEC] = "vdec",
+	[TEGRA_POWERGATE_L2] = "l2",
+	[TEGRA_POWERGATE_MPE] = "mpe",
+	[TEGRA_POWERGATE_HEG] = "heg",
+	[TEGRA_POWERGATE_SATA] = "sata",
+	[TEGRA_POWERGATE_CPU1] = "cpu1",
+	[TEGRA_POWERGATE_CPU2] = "cpu2",
+	[TEGRA_POWERGATE_CPU3] = "cpu3",
+	[TEGRA_POWERGATE_CELP] = "celp",
+	[TEGRA_POWERGATE_CPU0] = "cpu0",
+	[TEGRA_POWERGATE_C0NC] = "c0nc",
+	[TEGRA_POWERGATE_C1NC] = "c1nc",
+	[TEGRA_POWERGATE_SOR] = "sor",
+	[TEGRA_POWERGATE_DIS] = "dis",
+	[TEGRA_POWERGATE_DISB] = "disb",
+	[TEGRA_POWERGATE_XUSBA] = "xusba",
+	[TEGRA_POWERGATE_XUSBB] = "xusbb",
+	[TEGRA_POWERGATE_XUSBC] = "xusbc",
+	[TEGRA_POWERGATE_VIC] = "vic",
+	[TEGRA_POWERGATE_IRAM] = "iram",
+};
+
+static const u8 tegra124_cpu_powergates[] = {
+	TEGRA_POWERGATE_CPU0,
+	TEGRA_POWERGATE_CPU1,
+	TEGRA_POWERGATE_CPU2,
+	TEGRA_POWERGATE_CPU3,
+};
+
+static const struct tegra_pmc_soc tegra124_pmc_soc = {
+	.num_powergates = ARRAY_SIZE(tegra124_powergates),
+	.powergates = tegra124_powergates,
+	.num_cpu_powergates = ARRAY_SIZE(tegra124_cpu_powergates),
+	.cpu_powergates = tegra124_cpu_powergates,
+};
+
+static const struct of_device_id tegra_pmc_match[] = {
+	{ .compatible = "nvidia,tegra124-pmc", .data = &tegra124_pmc_soc },
+	{ .compatible = "nvidia,tegra114-pmc", .data = &tegra114_pmc_soc },
+	{ .compatible = "nvidia,tegra30-pmc", .data = &tegra30_pmc_soc },
+	{ .compatible = "nvidia,tegra20-pmc", .data = &tegra20_pmc_soc },
+	{ }
+};
+
+static struct platform_driver tegra_pmc_driver = {
+	.driver = {
+		.name = "tegra-pmc",
+		.suppress_bind_attrs = true,
+		.of_match_table = tegra_pmc_match,
+		.pm = &tegra_pmc_pm_ops,
+	},
+	.probe = tegra_pmc_probe,
+};
+module_platform_driver(tegra_pmc_driver);
+
+/*
+ * Early initialization to allow access to registers in the very early boot
+ * process.
+ */
+static int __init tegra_pmc_early_init(void)
+{
+	const struct of_device_id *match;
+	struct device_node *np;
+	struct resource regs;
+	bool invert;
+	u32 value;
+
+	np = of_find_matching_node_and_match(NULL, tegra_pmc_match, &match);
+	if (!np) {
+		pr_warn("PMC device node not found, disabling powergating\n");
+
+		regs.start = 0x7000e400;
+		regs.end = 0x7000e7ff;
+		regs.flags = IORESOURCE_MEM;
+
+		pr_warn("Using memory region %pR\n", &regs);
+	} else {
+		pmc->soc = match->data;
+	}
+
+	if (of_address_to_resource(np, 0, &regs) < 0) {
+		pr_err("failed to get PMC registers\n");
+		return -ENXIO;
+	}
+
+	pmc->base = ioremap_nocache(regs.start, resource_size(&regs));
+	if (!pmc->base) {
+		pr_err("failed to map PMC registers\n");
+		return -ENXIO;
+	}
+
+	mutex_init(&pmc->powergates_lock);
+
+	invert = of_property_read_bool(np, "nvidia,invert-interrupt");
+
+	value = tegra_pmc_readl(PMC_CNTRL);
+
+	if (invert)
+		value |= PMC_CNTRL_INTR_POLARITY;
+	else
+		value &= ~PMC_CNTRL_INTR_POLARITY;
+
+	tegra_pmc_writel(value, PMC_CNTRL);
+
+	return 0;
+}
+early_initcall(tegra_pmc_early_init);
diff --git a/include/linux/tegra-soc.h b/include/linux/tegra-soc.h
index fcf65ecbecca..c9013eaa167b 100644
--- a/include/linux/tegra-soc.h
+++ b/include/linux/tegra-soc.h
@@ -27,6 +27,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/reboot.h>
+
 enum tegra_revision {
 	TEGRA_REVISION_UNKNOWN = 0,
 	TEGRA_REVISION_A01,
@@ -59,6 +61,50 @@ int tegra_fuse_readl(u32 offset, u32 *val);
 extern int tegra_chip_id;
 extern struct tegra_sku_info tegra_sku_info;
 
+/*
+ * PMC
+ */
+enum tegra_suspend_mode {
+	TEGRA_SUSPEND_NONE = 0,
+	TEGRA_SUSPEND_LP2,      /* CPU voltage off */
+	TEGRA_SUSPEND_LP1,      /* CPU voltage off, DRAM self-refresh */
+	TEGRA_SUSPEND_LP0,      /* CPU + core voltage off, DRAM self-refresh */
+	TEGRA_MAX_SUSPEND_MODE,
+};
+
+#ifdef CONFIG_PM_SLEEP
+enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void);
+void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode);
+void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode);
+
+bool tegra_pmc_cpu_is_powered(int cpuid);
+int tegra_pmc_cpu_power_on(int cpuid);
+int tegra_pmc_cpu_remove_clamping(int cpuid);
+
+void tegra_pmc_restart(enum reboot_mode mode, const char *cmd);
+#endif
+
+/*
+ * PM
+ */
+#ifdef CONFIG_PM_SLEEP
+enum tegra_suspend_mode
+tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode);
+
+/* low-level resume entry point */
+void tegra_resume(void);
+#else
+static inline enum tegra_suspend_mode
+tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode)
+{
+	return TEGRA_SUSPEND_NONE;
+}
+
+static inline void tegra_resume(void)
+{
+}
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_TEGRA_SOC_H_ */
-- 
2.0.1
