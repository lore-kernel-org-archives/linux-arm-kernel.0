From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 7 Jan 2013 10:56:14 +0800
Subject: [PATCH] ARM: tegra30: make the wait time of CPU power up to
 proportional to HZ
Message-ID: <1357527374-31055-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It would rather to use the API of time_to_jiffies than a constant number
of jiffies for the wait time of CPU power up.

Based on the work by:
Sang-Hun Lee <sanlee@nvidia.com>

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/platsmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 60daf9f..6867030 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -90,7 +90,7 @@ static int tegra30_power_up_cpu(unsigned int cpu)
 	 * next time around.
 	 */
 	if (cpumask_test_cpu(cpu, &tegra_cpu_init_mask)) {
-		timeout = jiffies + 5*HZ;
+		timeout = jiffies + msecs_to_jiffies(50);
 		do {
 			if (!tegra_powergate_is_powered(pwrgateid))
 				goto remove_clamps;
@@ -110,7 +110,7 @@ static int tegra30_power_up_cpu(unsigned int cpu)
 			return ret;
 
 		/* Wait for the power to come up. */
-		timeout = jiffies + 10*HZ;
+		timeout = jiffies + msecs_to_jiffies(100);
 		while (tegra_powergate_is_powered(pwrgateid)) {
 			if (time_after(jiffies, timeout))
 				return -ETIMEDOUT;
-- 
1.8.0.3
