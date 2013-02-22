From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 22 Feb 2013 14:24:26 +0800
Subject: [PATCH 2/3] ARM: tegra30: fix the logical detection of power on
 sequence of warm boot CPUs
In-Reply-To: <1361514267-12111-1-git-send-email-josephl@nvidia.com>
References: <1361514267-12111-1-git-send-email-josephl@nvidia.com>
Message-ID: <1361514267-12111-2-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The warm boo sequence of secondary CPUs should wait for the power ready
then removing the clamps.

This did not fix any known or unknown issue, but nice to have this fix.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 4dfc75e..e78d52d 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -91,7 +91,7 @@ static int tegra30_power_up_cpu(unsigned int cpu)
 	if (cpumask_test_cpu(cpu, &tegra_cpu_init_mask)) {
 		timeout = jiffies + msecs_to_jiffies(50);
 		do {
-			if (!tegra_powergate_is_powered(pwrgateid))
+			if (tegra_powergate_is_powered(pwrgateid))
 				goto remove_clamps;
 			udelay(10);
 		} while (time_before(jiffies, timeout));
-- 
1.8.1.1
