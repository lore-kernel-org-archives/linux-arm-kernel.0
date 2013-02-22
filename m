From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 22 Feb 2013 14:44:50 +0800
Subject: [PATCH 3/4] ARM: tegra30: platsmp: replace the CPU power on function
 in PMC driver
In-Reply-To: <1361515491-16199-1-git-send-email-josephl@nvidia.com>
References: <1361515491-16199-1-git-send-email-josephl@nvidia.com>
Message-ID: <1361515491-16199-4-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the CPU power on function in PMC driver to bring up secondary CPUs,
because we are going to re-factor powergate driver to support generic
power domain. It will be removed later and added the generic power domain
support in PMC driver.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/platsmp.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 41971ac..601bd0c 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -26,11 +26,10 @@
 #include <asm/smp_scu.h>
 #include <asm/smp_plat.h>
 
-#include <mach/powergate.h>
-
 #include "fuse.h"
 #include "flowctrl.h"
 #include "reset.h"
+#include "pmc.h"
 
 #include "common.h"
 #include "iomap.h"
@@ -80,14 +79,10 @@ static int tegra20_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 static int tegra30_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	int ret, pwrgateid;
+	int ret;
 	unsigned long timeout;
 
 	cpu = cpu_logical_map(cpu);
-	pwrgateid = tegra_cpu_powergate_id(cpu);
-	if (pwrgateid < 0)
-		return pwrgateid;
-
 	tegra_put_cpu_in_reset(cpu);
 	flowctrl_write_cpu_halt(cpu, 0);
 
@@ -108,7 +103,7 @@ static int tegra30_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	if (cpumask_test_cpu(cpu, &tegra_cpu_init_mask)) {
 		timeout = jiffies + msecs_to_jiffies(50);
 		do {
-			if (tegra_powergate_is_powered(pwrgateid))
+			if (tegra_pmc_cpu_is_powered(cpu))
 				goto remove_clamps;
 			udelay(10);
 		} while (time_before(jiffies, timeout));
@@ -120,14 +115,14 @@ static int tegra30_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * be un-gated by un-toggling the power gate register
 	 * manually.
 	 */
-	if (!tegra_powergate_is_powered(pwrgateid)) {
-		ret = tegra_powergate_power_on(pwrgateid);
+	if (!tegra_pmc_cpu_is_powered(cpu)) {
+		ret = tegra_pmc_cpu_power_on(cpu);
 		if (ret)
 			return ret;
 
 		/* Wait for the power to come up. */
 		timeout = jiffies + msecs_to_jiffies(100);
-		while (tegra_powergate_is_powered(pwrgateid)) {
+		while (tegra_pmc_cpu_is_powered(cpu)) {
 			if (time_after(jiffies, timeout))
 				return -ETIMEDOUT;
 			udelay(10);
@@ -140,7 +135,7 @@ remove_clamps:
 	udelay(10);
 
 	/* Remove I/O clamps. */
-	ret = tegra_powergate_remove_clamping(pwrgateid);
+	ret = tegra_pmc_cpu_remove_clamping(cpu);
 	if (ret)
 		return ret;
 
-- 
1.8.1.1
