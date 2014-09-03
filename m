From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed,  3 Sep 2014 12:52:29 +0200
Subject: [PATCH 13/15] drivers: sh: Leave disabling of unused PM domains to
 genpd
In-Reply-To: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1409741551-16437-14-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since genpd at late init, will try to disable unused PM domains we
don't need to do it from here as well.

Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/sh/pm_runtime.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index 72f6381..fe2c2d5 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -75,8 +75,6 @@ static struct pm_clk_notifier_block platform_bus_notifier = {
 	.con_ids = { NULL, },
 };
 
-static bool default_pm_on;
-
 static int __init sh_pm_runtime_init(void)
 {
 	if (IS_ENABLED(CONFIG_ARCH_SHMOBILE_MULTI)) {
@@ -96,16 +94,7 @@ static int __init sh_pm_runtime_init(void)
 			return 0;
 	}
 
-	default_pm_on = true;
 	pm_clk_add_notifier(&platform_bus_type, &platform_bus_notifier);
 	return 0;
 }
 core_initcall(sh_pm_runtime_init);
-
-static int __init sh_pm_runtime_late_init(void)
-{
-	if (default_pm_on)
-		pm_genpd_poweroff_unused();
-	return 0;
-}
-late_initcall(sh_pm_runtime_late_init);
-- 
1.9.1
