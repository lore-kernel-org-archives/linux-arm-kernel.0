From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 3 Apr 2013 19:31:46 +0800
Subject: [PATCH V6 3/9] ARM: dt: tegra: add bindings of power management
 configurations for PMC
In-Reply-To: <1364988712-24797-1-git-send-email-josephl@nvidia.com>
References: <1364988712-24797-1-git-send-email-josephl@nvidia.com>
Message-ID: <1364988712-24797-4-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PMC mostly controls the entry and exit of the system from different
sleep modes. Different platform or system may have different configurations.
The power management configurations of PMC is represented as some properties.
The system needs to define the properties when the system supports deep sleep
mode (i.e. suspend).

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: devicetree-discuss at lists.ozlabs.org
Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V6:
* no change
V5:
* fix typos
V4:
* no change
V3:
* fix typos
V2:
* squash the patches that defined the PM bindings for PMC and the
  implementation
* replace the "unsigned long" with "u32" for the variables that are parsed
  from DT
---
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 38 ++++++++++
 arch/arm/mach-tegra/pmc.c                          | 83 ++++++++++++++++++++++
 arch/arm/mach-tegra/pmc.h                          |  8 +++
 3 files changed, 129 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
index ee529b1..1608a54 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
@@ -1,5 +1,9 @@
 NVIDIA Tegra Power Management Controller (PMC)
 
+The PMC block interacts with an external Power Management Unit. The PMC
+mostly controls the entry and exit of the system from different sleep
+modes. It provides power-gating controllers for SoC and CPU power-islands.
+
 Required properties:
 - name : Should be pmc
 - compatible : Should contain "nvidia,tegra<chip>-pmc".
@@ -15,6 +19,32 @@ Optional properties:
   signal is fed into the PMC. This signal is optionally inverted, and then
   fed into the ARM GIC. The PMC is not involved in the detection or
   handling of this interrupt signal, merely its inversion.
+- nvidia,suspend-mode : The suspend mode that the platform should use.
+  Valid values are 0, 1 and 2:
+  0 (LP0): CPU + Core voltage off and DRAM in self-refresh
+  1 (LP1): CPU voltage off and DRAM in self-refresh
+  2 (LP2): CPU voltage off
+- nvidia,core-power-req-active-high : Boolean, core power request active-high
+- nvidia,sys-clock-req-active-high : Boolean, system clock request active-high
+- nvidia,combined-power-req : Boolean, combined power request for CPU & Core
+- nvidia,cpu-pwr-good-en : Boolean, CPU power good signal (from PMIC to PMC)
+			   is enabled.
+
+Required properties when nvidia,suspend-mode is specified:
+- nvidia,cpu-pwr-good-time : CPU power good time in uS.
+- nvidia,cpu-pwr-off-time : CPU power off time in uS.
+- nvidia,core-pwr-good-time : <Oscillator-stable-time Power-stable-time>
+			      Core power good time in uS.
+- nvidia,core-pwr-off-time : Core power off time in uS.
+
+Required properties when nvidia,suspend-mode=<0>:
+- nvidia,lp0-vec : <start length> Starting address and length of LP0 vector
+  The LP0 vector contains the warm boot code that is executed by AVP when
+  resuming from the LP0 state. The AVP (Audio-Video Processor) is an ARM7
+  processor and always being the first boot processor when chip is power on
+  or resume from deep sleep mode. When the system is resumed from the deep
+  sleep mode, the warm boot code will restore some PLLs, clocks and then
+  bring up CPU0 for resuming the system.
 
 Example:
 
@@ -25,6 +55,14 @@ pmc at 7000f400 {
 	clocks = <&tegra_car 110>, <&clk32k_in>;
 	clock-names = "pclk", "clk32k_in";
 	nvidia,invert-interrupt;
+	nvidia,suspend-mode = <1>;
+	nvidia,cpu-pwr-good-time = <2000>;
+	nvidia,cpu-pwr-off-time = <100>;
+	nvidia,core-pwr-good-time = <3845 3845>;
+	nvidia,core-pwr-off-time = <458>;
+	nvidia,core-power-req-active-high;
+	nvidia,sys-clock-req-active-high;
+	nvidia,lp0-vec = <0xbdffd000 0x2000>;
 };
 
 / Tegra board dts file
diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index faa33e8..e896826 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -21,6 +21,8 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
+#include "pmc.h"
+
 #define PMC_CTRL			0x0
 #define PMC_CTRL_INTR_LOW		(1 << 17)
 #define PMC_PWRGATE_TOGGLE		0x30
@@ -49,6 +51,22 @@ static void __iomem *tegra_pmc_base;
 static bool tegra_pmc_invert_interrupt;
 static struct clk *tegra_pclk;
 
+struct pmc_pm_data {
+	u32 cpu_good_time;	/* CPU power good time in uS */
+	u32 cpu_off_time;	/* CPU power off time in uS */
+	u32 core_osc_time;	/* Core power good osc time in uS */
+	u32 core_pmu_time;	/* Core power good pmu time in uS */
+	u32 core_off_time;	/* Core power off time in uS */
+	bool corereq_high;	/* Core power request active-high */
+	bool sysclkreq_high;	/* System clock request active-high */
+	bool combined_req;	/* Combined pwr req for CPU & Core */
+	bool cpu_pwr_good_en;	/* CPU power good signal is enabled */
+	u32 lp0_vec_phy_addr;	/* The phy addr of LP0 warm boot code */
+	u32 lp0_vec_size;	/* The size of LP0 warm boot code */
+	enum tegra_suspend_mode suspend_mode;
+};
+static struct pmc_pm_data pmc_pm_data;
+
 static inline u32 tegra_pmc_readl(u32 reg)
 {
 	return readl(tegra_pmc_base + reg);
@@ -176,6 +194,10 @@ static const struct of_device_id matches[] __initconst = {
 static void tegra_pmc_parse_dt(void)
 {
 	struct device_node *np;
+	u32 prop;
+	enum tegra_suspend_mode suspend_mode;
+	u32 core_good_time[2] = {0, 0};
+	u32 lp0_vec[2] = {0, 0};
 
 	np = of_find_matching_node(NULL, matches);
 	BUG_ON(!np);
@@ -186,6 +208,67 @@ static void tegra_pmc_parse_dt(void)
 				     "nvidia,invert-interrupt");
 	tegra_pclk = of_clk_get_by_name(np, "pclk");
 	WARN_ON(IS_ERR(tegra_pclk));
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
index 22f16c9..6bc0fc09 100644
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
 #ifdef CONFIG_PM_SLEEP
 void set_power_timers(unsigned long us_on, unsigned long us_off);
 #endif
-- 
1.8.2
