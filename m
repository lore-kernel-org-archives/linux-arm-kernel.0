From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 27 Sep 2013 19:16:35 +0200
Subject: [PATCH] ARM: ux500: cpuidle: fix section mismatch
Message-ID: <1380302195-18678-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dbx500_cpuidle_probe is tagged as an __init section but the variable
dbx500_cpuidle_plat_driver is not.

The dbx500_cpuidle_probe could not be declared as __init because of macro
module_platform_driver builds the exit function, tags as __exit and this one
refers to the dbx500_cpuidle_plat_driver which is an __initdata.

That leads to a section mismatch.

Fix it by removing the __init tag for the probe function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-ux500.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-ux500.c b/drivers/cpuidle/cpuidle-ux500.c
index e056465..5e35804 100644
--- a/drivers/cpuidle/cpuidle-ux500.c
+++ b/drivers/cpuidle/cpuidle-ux500.c
@@ -111,7 +111,7 @@ static struct cpuidle_driver ux500_idle_driver = {
 	.state_count = 2,
 };
 
-static int __init dbx500_cpuidle_probe(struct platform_device *pdev)
+static int dbx500_cpuidle_probe(struct platform_device *pdev)
 {
 	/* Configure wake up reasons */
 	prcmu_enable_wakeups(PRCMU_WAKEUP(ARM) | PRCMU_WAKEUP(RTC) |
-- 
1.7.9.5
