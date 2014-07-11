From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 11 Jul 2014 14:16:01 +0200
Subject: [PATCH 02/12] ARM: tegra: Use a function to get the chip ID
In-Reply-To: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
References: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1405080971-7609-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Instead of using a simple variable access to get at the Tegra chip ID,
use a function so that we can run additional code. This can be used to
determine where the chip ID is being accessed without being available.
That in turn will be handy for resolving boot sequence dependencies in
order to convert more code to regular initcalls rather than a sequence
fixed by Tegra SoC setup code.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-tegra/cpuidle.c       |  6 +++---
 arch/arm/mach-tegra/flowctrl.c      |  6 +++---
 arch/arm/mach-tegra/fuse.c          | 19 +++++++++++++------
 arch/arm/mach-tegra/fuse.h          |  6 ------
 arch/arm/mach-tegra/hotplug.c       | 10 +++++-----
 arch/arm/mach-tegra/platsmp.c       | 10 +++++-----
 arch/arm/mach-tegra/pm.c            | 10 +++++-----
 arch/arm/mach-tegra/pmc.c           |  4 ++--
 arch/arm/mach-tegra/powergate.c     |  8 ++++----
 arch/arm/mach-tegra/reset-handler.S |  2 +-
 arch/arm/mach-tegra/reset.c         |  3 ++-
 arch/arm/mach-tegra/sleep-tegra30.S |  2 +-
 arch/arm/mach-tegra/tegra.c         |  3 ++-
 include/linux/tegra-soc.h           | 10 ++++++++++
 14 files changed, 56 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle.c
index 7bc5d8d667fe..b27330c7bf6c 100644
--- a/arch/arm/mach-tegra/cpuidle.c
+++ b/arch/arm/mach-tegra/cpuidle.c
@@ -23,13 +23,13 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/tegra-soc.h>
 
-#include "fuse.h"
 #include "cpuidle.h"
 
 void __init tegra_cpuidle_init(void)
 {
-	switch (tegra_chip_id) {
+	switch (tegra_get_chip_id()) {
 	case TEGRA20:
 		if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
 			tegra20_cpuidle_init();
@@ -49,7 +49,7 @@ void __init tegra_cpuidle_init(void)
 
 void tegra_cpuidle_pcie_irqs_in_use(void)
 {
-	switch (tegra_chip_id) {
+	switch (tegra_get_chip_id()) {
 	case TEGRA20:
 		if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
 			tegra20_cpuidle_pcie_irqs_in_use();
diff --git a/arch/arm/mach-tegra/flowctrl.c b/arch/arm/mach-tegra/flowctrl.c
index fde581d78398..2106b3dd36bd 100644
--- a/arch/arm/mach-tegra/flowctrl.c
+++ b/arch/arm/mach-tegra/flowctrl.c
@@ -22,10 +22,10 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/tegra-soc.h>
 
 #include "flowctrl.h"
 #include "iomap.h"
-#include "fuse.h"
 
 static u8 flowctrl_offset_halt_cpu[] = {
 	FLOW_CTRL_HALT_CPU0_EVENTS,
@@ -76,7 +76,7 @@ void flowctrl_cpu_suspend_enter(unsigned int cpuid)
 	int i;
 
 	reg = flowctrl_read_cpu_csr(cpuid);
-	switch (tegra_chip_id) {
+	switch (tegra_get_chip_id()) {
 	case TEGRA20:
 		/* clear wfe bitmap */
 		reg &= ~TEGRA20_FLOW_CTRL_CSR_WFE_BITMAP;
@@ -117,7 +117,7 @@ void flowctrl_cpu_suspend_exit(unsigned int cpuid)
 
 	/* Disable powergating via flow controller for CPU0 */
 	reg = flowctrl_read_cpu_csr(cpuid);
-	switch (tegra_chip_id) {
+	switch (tegra_get_chip_id()) {
 	case TEGRA20:
 		/* clear wfe bitmap */
 		reg &= ~TEGRA20_FLOW_CTRL_CSR_WFE_BITMAP;
diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
index 573414eaf7ae..e9b01a5cf40e 100644
--- a/arch/arm/mach-tegra/fuse.c
+++ b/arch/arm/mach-tegra/fuse.c
@@ -50,7 +50,6 @@
 int tegra_sku_id;
 int tegra_cpu_process_id;
 int tegra_core_process_id;
-int tegra_chip_id;
 int tegra_cpu_speedo_id;		/* only exist in Tegra30 and later */
 int tegra_soc_speedo_id;
 enum tegra_revision tegra_revision;
@@ -123,7 +122,7 @@ static enum tegra_revision tegra_get_revision(u32 id)
 	case 2:
 		return TEGRA_REVISION_A02;
 	case 3:
-		if (tegra_chip_id == TEGRA20 &&
+		if (tegra_get_chip_id() == TEGRA20 &&
 			(tegra_spare_fuse(18) || tegra_spare_fuse(19)))
 			return TEGRA_REVISION_A03p;
 		else
@@ -154,6 +153,13 @@ u32 tegra_read_chipid(void)
 	return readl_relaxed(IO_ADDRESS(TEGRA_APB_MISC_BASE) + 0x804);
 }
 
+u8 tegra_get_chip_id(void)
+{
+	u32 id = tegra_read_chipid();
+
+	return (id >> 8) & 0xff;
+}
+
 static void __init tegra20_fuse_init_randomness(void)
 {
 	u32 randomness[2];
@@ -184,6 +190,7 @@ void __init tegra_init_fuse(void)
 {
 	u32 id;
 	u32 randomness[5];
+	u8 chip_id;
 
 	u32 reg = readl(IO_ADDRESS(TEGRA_CLK_RESET_BASE + 0x48));
 	reg |= 1 << 28;
@@ -208,9 +215,9 @@ void __init tegra_init_fuse(void)
 
 	id = tegra_read_chipid();
 	randomness[2] = id;
-	tegra_chip_id = (id >> 8) & 0xff;
+	chip_id = (id >> 8) & 0xff;
 
-	switch (tegra_chip_id) {
+	switch (chip_id) {
 	case TEGRA20:
 		tegra_fuse_spare_bit = TEGRA20_FUSE_SPARE_BIT;
 		tegra_init_speedo_data = &tegra20_init_speedo_data;
@@ -223,7 +230,7 @@ void __init tegra_init_fuse(void)
 		tegra_init_speedo_data = &tegra114_init_speedo_data;
 		break;
 	default:
-		pr_warn("Tegra: unknown chip id %d\n", tegra_chip_id);
+		pr_warn("Tegra: unknown chip id %d\n", chip_id);
 		tegra_fuse_spare_bit = TEGRA20_FUSE_SPARE_BIT;
 		tegra_init_speedo_data = &tegra_get_process_id;
 	}
@@ -234,7 +241,7 @@ void __init tegra_init_fuse(void)
 	randomness[4] = (tegra_cpu_speedo_id << 16) | tegra_soc_speedo_id;
 
 	add_device_randomness(randomness, sizeof(randomness));
-	switch (tegra_chip_id) {
+	switch (chip_id) {
 	case TEGRA20:
 		tegra20_fuse_init_randomness();
 		break;
diff --git a/arch/arm/mach-tegra/fuse.h b/arch/arm/mach-tegra/fuse.h
index c01d04785d67..7a08b4b70c8d 100644
--- a/arch/arm/mach-tegra/fuse.h
+++ b/arch/arm/mach-tegra/fuse.h
@@ -26,11 +26,6 @@
 #define SKU_ID_AP25E	27
 #define SKU_ID_T25E	28
 
-#define TEGRA20		0x20
-#define TEGRA30		0x30
-#define TEGRA114	0x35
-#define TEGRA124	0x40
-
 #ifndef __ASSEMBLY__
 enum tegra_revision {
 	TEGRA_REVISION_UNKNOWN = 0,
@@ -45,7 +40,6 @@ enum tegra_revision {
 extern int tegra_sku_id;
 extern int tegra_cpu_process_id;
 extern int tegra_core_process_id;
-extern int tegra_chip_id;
 extern int tegra_cpu_speedo_id;		/* only exist in Tegra30 and later */
 extern int tegra_soc_speedo_id;
 extern enum tegra_revision tegra_revision;
diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index 7842b252dda5..d0a37dcbbb5d 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -11,10 +11,10 @@
 #include <linux/clk/tegra.h>
 #include <linux/kernel.h>
 #include <linux/smp.h>
+#include <linux/tegra-soc.h>
 
 #include <asm/smp_plat.h>
 
-#include "fuse.h"
 #include "sleep.h"
 
 static void (*tegra_hotplug_shutdown)(void);
@@ -52,12 +52,12 @@ void __init tegra_hotplug_init(void)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		return;
 
-	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) && tegra_chip_id == TEGRA20)
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) && tegra_get_chip_id() == TEGRA20)
 		tegra_hotplug_shutdown = tegra20_hotplug_shutdown;
-	if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) && tegra_chip_id == TEGRA30)
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) && tegra_get_chip_id() == TEGRA30)
 		tegra_hotplug_shutdown = tegra30_hotplug_shutdown;
-	if (IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC) && tegra_chip_id == TEGRA114)
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC) && tegra_get_chip_id() == TEGRA114)
 		tegra_hotplug_shutdown = tegra30_hotplug_shutdown;
-	if (IS_ENABLED(CONFIG_ARCH_TEGRA_124_SOC) && tegra_chip_id == TEGRA124)
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_124_SOC) && tegra_get_chip_id() == TEGRA124)
 		tegra_hotplug_shutdown = tegra30_hotplug_shutdown;
 }
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index c403edd0fcc7..9679984650bd 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/jiffies.h>
 #include <linux/smp.h>
+#include <linux/tegra-soc.h>
 
 #include <asm/cacheflush.h>
 #include <asm/mach-types.h>
@@ -28,7 +29,6 @@
 
 #include "common.h"
 #include "flowctrl.h"
-#include "fuse.h"
 #include "iomap.h"
 #include "pmc.h"
 #include "reset.h"
@@ -170,13 +170,13 @@ static int tegra114_boot_secondary(unsigned int cpu, struct task_struct *idle)
 static int tegra_boot_secondary(unsigned int cpu,
 					  struct task_struct *idle)
 {
-	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) && tegra_chip_id == TEGRA20)
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) && tegra_get_chip_id() == TEGRA20)
 		return tegra20_boot_secondary(cpu, idle);
-	if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) && tegra_chip_id == TEGRA30)
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) && tegra_get_chip_id() == TEGRA30)
 		return tegra30_boot_secondary(cpu, idle);
-	if (IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC) && tegra_chip_id == TEGRA114)
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC) && tegra_get_chip_id() == TEGRA114)
 		return tegra114_boot_secondary(cpu, idle);
-	if (IS_ENABLED(CONFIG_ARCH_TEGRA_124_SOC) && tegra_chip_id == TEGRA124)
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_124_SOC) && tegra_get_chip_id() == TEGRA124)
 		return tegra114_boot_secondary(cpu, idle);
 
 	return -EINVAL;
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index ae4826e43171..cd5bb6d876c7 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/suspend.h>
+#include <linux/tegra-soc.h>
 
 #include <asm/cacheflush.h>
 #include <asm/idmap.h>
@@ -35,7 +36,6 @@
 #include <asm/tlbflush.h>
 
 #include "flowctrl.h"
-#include "fuse.h"
 #include "iomap.h"
 #include "pmc.h"
 #include "pm.h"
@@ -53,7 +53,7 @@ static int (*tegra_sleep_func)(unsigned long v2p);
 
 static void tegra_tear_down_cpu_init(void)
 {
-	switch (tegra_chip_id) {
+	switch (tegra_get_chip_id()) {
 	case TEGRA20:
 		if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
 			tegra_tear_down_cpu = tegra20_tear_down_cpu;
@@ -143,7 +143,7 @@ bool tegra_set_cpu_in_lp2(void)
 
 	if ((phy_cpu_id == 0) && cpumask_equal(cpu_lp2_mask, cpu_online_mask))
 		last_cpu = true;
-	else if (tegra_chip_id == TEGRA20 && phy_cpu_id == 1)
+	else if (tegra_get_chip_id() == TEGRA20 && phy_cpu_id == 1)
 		tegra20_cpu_set_resettable_soon();
 
 	spin_unlock(&tegra_lp2_lock);
@@ -212,7 +212,7 @@ static int tegra_sleep_core(unsigned long v2p)
  */
 static bool tegra_lp1_iram_hook(void)
 {
-	switch (tegra_chip_id) {
+	switch (tegra_get_chip_id()) {
 	case TEGRA20:
 		if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
 			tegra20_lp1_iram_hook();
@@ -242,7 +242,7 @@ static bool tegra_lp1_iram_hook(void)
 
 static bool tegra_sleep_core_init(void)
 {
-	switch (tegra_chip_id) {
+	switch (tegra_get_chip_id()) {
 	case TEGRA20:
 		if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
 			tegra20_sleep_core_init();
diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index cff318c17f2c..e255d39f8657 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -21,9 +21,9 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/tegra-powergate.h>
+#include <linux/tegra-soc.h>
 
 #include "flowctrl.h"
-#include "fuse.h"
 #include "pm.h"
 #include "pmc.h"
 #include "sleep.h"
@@ -251,7 +251,7 @@ void tegra_pmc_pm_set(enum tegra_suspend_mode mode)
 	reg |= TEGRA_POWER_CPU_PWRREQ_OE;
 	reg &= ~TEGRA_POWER_EFFECT_LP0;
 
-	switch (tegra_chip_id) {
+	switch (tegra_get_chip_id()) {
 	case TEGRA20:
 	case TEGRA30:
 		break;
diff --git a/arch/arm/mach-tegra/powergate.c b/arch/arm/mach-tegra/powergate.c
index bbffc9e6d498..1408f7e7321d 100644
--- a/arch/arm/mach-tegra/powergate.c
+++ b/arch/arm/mach-tegra/powergate.c
@@ -30,8 +30,8 @@
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/tegra-powergate.h>
+#include <linux/tegra-soc.h>
 
-#include "fuse.h"
 #include "iomap.h"
 
 #define DPD_SAMPLE		0x020
@@ -157,7 +157,7 @@ int tegra_powergate_remove_clamping(int id)
 	 * The Tegra124 GPU has a separate register (with different semantics)
 	 * to remove clamps.
 	 */
-	if (tegra_chip_id == TEGRA124) {
+	if (tegra_get_chip_id() == TEGRA124) {
 		if (id == TEGRA_POWERGATE_3D) {
 			pmc_write(0, GPU_RG_CNTRL);
 			return 0;
@@ -227,7 +227,7 @@ int tegra_cpu_powergate_id(int cpuid)
 
 int __init tegra_powergate_init(void)
 {
-	switch (tegra_chip_id) {
+	switch (tegra_get_chip_id()) {
 	case TEGRA20:
 		tegra_num_powerdomains = 7;
 		break;
@@ -368,7 +368,7 @@ int __init tegra_powergate_debugfs_init(void)
 {
 	struct dentry *d;
 
-	switch (tegra_chip_id) {
+	switch (tegra_get_chip_id()) {
 	case TEGRA20:
 		powergate_name = powergate_name_t20;
 		break;
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index d916c84487ae..be2eaa8e84fb 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -16,12 +16,12 @@
 
 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <linux/tegra-soc.h>
 
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
 
 #include "flowctrl.h"
-#include "fuse.h"
 #include "iomap.h"
 #include "reset.h"
 #include "sleep.h"
diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index b90507922a8c..bb1e5a12d1d7 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -18,6 +18,7 @@
 #include <linux/cpumask.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/tegra-soc.h>
 
 #include <asm/cacheflush.h>
 #include <asm/firmware.h>
@@ -53,7 +54,7 @@ static void __init tegra_cpu_reset_handler_set(const u32 reset_address)
 	 * Prevent further modifications to the physical reset vector.
 	 *  NOTE: Has no effect on chips prior to Tegra30.
 	 */
-	if (tegra_chip_id != TEGRA20) {
+	if (tegra_get_chip_id() != TEGRA20) {
 		reg = readl(sb_ctrl);
 		reg |= 2;
 		writel(reg, sb_ctrl);
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index e240b875183b..3700fe92abd8 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -15,13 +15,13 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/tegra-soc.h>
 
 #include <asm/asm-offsets.h>
 #include <asm/assembler.h>
 #include <asm/cache.h>
 
 #include "flowctrl.h"
-#include "fuse.h"
 #include "irammap.h"
 #include "sleep.h"
 
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 7a9f30289049..e36b81870e66 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -33,6 +33,7 @@
 #include <linux/serial_8250.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
+#include <linux/tegra-soc.h>
 #include <linux/usb/tegra_usb_phy.h>
 
 #include <asm/hardware/cache-l2x0.h>
@@ -104,7 +105,7 @@ static void __init tegra_dt_init(void)
 
 	soc_dev_attr->family = kasprintf(GFP_KERNEL, "Tegra");
 	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%d", tegra_revision);
-	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%d", tegra_chip_id);
+	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%u", tegra_get_chip_id());
 
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
diff --git a/include/linux/tegra-soc.h b/include/linux/tegra-soc.h
index 95f611d78f3a..34c068989806 100644
--- a/include/linux/tegra-soc.h
+++ b/include/linux/tegra-soc.h
@@ -17,6 +17,16 @@
 #ifndef __LINUX_TEGRA_SOC_H_
 #define __LINUX_TEGRA_SOC_H_
 
+#define TEGRA20		0x20
+#define TEGRA30		0x30
+#define TEGRA114	0x35
+#define TEGRA124	0x40
+
+#ifndef __ASSEMBLY__
+
 u32 tegra_read_chipid(void);
+u8 tegra_get_chip_id(void);
+
+#endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_TEGRA_SOC_H_ */
-- 
2.0.1
