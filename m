From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Fri, 26 Apr 2013 14:17:18 +0200
Subject: [PATCH 5/5] mfd: ab8500-sysctrl: let sysctrl driver work without pdata
In-Reply-To: <1366978638-967-1-git-send-email-fabio.baltieri@linaro.org>
References: <1366978638-967-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1366978638-967-6-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A check for a valid plat->sysctrl was introduced in:

2377e52 mfd: ab8500-sysctrl: Error check clean up

but the driver works just fine even without that initialization data.
This patch removes the check and let the driver go ahead with probe.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 drivers/mfd/ab8500-sysctrl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index b851692..eadae4d 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -104,7 +104,7 @@ void ab8500_restart(char mode, const char *cmd)
 
 	plat = dev_get_platdata(sysctrl_dev->parent);
 	pdata = plat->sysctrl;
-	if (pdata->reboot_reason_code)
+	if (pdata && pdata->reboot_reason_code)
 		reason = pdata->reboot_reason_code(cmd);
 	else
 		pr_warn("[%s] No reboot reason set. Default reason %d\n",
@@ -188,7 +188,7 @@ static int ab8500_sysctrl_probe(struct platform_device *pdev)
 
 	plat = dev_get_platdata(pdev->dev.parent);
 
-	if (!(plat && plat->sysctrl))
+	if (!plat)
 		return -EINVAL;
 
 	sysctrl_dev = &pdev->dev;
@@ -197,7 +197,6 @@ static int ab8500_sysctrl_probe(struct platform_device *pdev)
 		pm_power_off = ab8500_power_off;
 
 	pdata = plat->sysctrl;
-
 	if (pdata) {
 		int last, ret, i, j;
 
-- 
1.8.1.3
