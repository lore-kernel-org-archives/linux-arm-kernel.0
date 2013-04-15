From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Apr 2013 16:53:05 -0600
Subject: [PATCH] ARM: tegra: pm: fix build error w/o PM_SLEEP
Message-ID: <1366066385-18246-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joseph Lo <josephl@nvidia.com>

This fixes the building error when the PM_SLEEP is disabled. The fucntional
defintion of "tegra_pm_validate_suspend_mode" without "static inline"
would become a multiple definition error.

Reported-by: Rhyland Klein <rklein@nvidia.com>
Signed-off-by: Joseph Lo <josephl@nvidia.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Arnd, Olof, can you please apply this to arm-soc too.

It probably should be applied wherever Tegra's for-3.10/soc branch was
merged, since it fixes up code that was introduced in that branch. I have
checked it applies cleanly to that Tegra branch, and doesn't cause any
merge issues with at least other Tegra for-3.10 branches.

 arch/arm/mach-tegra/pm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 9d2d038..778a4aa 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -39,7 +39,7 @@ enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
 				enum tegra_suspend_mode mode);
 void tegra_init_suspend(void);
 #else
-enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
+static inline enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
 				enum tegra_suspend_mode mode)
 {
 	return TEGRA_SUSPEND_NONE;
-- 
1.7.10.4
