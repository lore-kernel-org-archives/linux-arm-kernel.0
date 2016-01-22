From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Fri, 22 Jan 2016 16:40:26 +0800
Subject: [RFC PATCH 2/5] cpufreq: mt8173: Remove platform device registration
 code
In-Reply-To: <1453452029-20843-1-git-send-email-pi-cheng.chen@linaro.org>
References: <1453452029-20843-1-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <1453452029-20843-3-git-send-email-pi-cheng.chen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For MT8173 platform requirement, to make SVS (Smart Voltage Scaling)
work correctly, the initialization of SVS engine should be later then
thermal controller and prior to cpufreq driver. Remove the platform
device registration code of mt8173-cpufreq and it will be later added
in SVS driver code after SVS initialization done to ensure the platform
specific initialization flow.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
---
 drivers/cpufreq/mt8173-cpufreq.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index 1efba34..1ede917 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -577,7 +577,6 @@ static struct platform_driver mt8173_cpufreq_platdrv = {
 
 static int mt8173_cpufreq_driver_init(void)
 {
-	struct platform_device *pdev;
 	int err;
 
 	if (!of_machine_is_compatible("mediatek,mt8173"))
@@ -587,18 +586,6 @@ static int mt8173_cpufreq_driver_init(void)
 	if (err)
 		return err;
 
-	/*
-	 * Since there's no place to hold device registration code and no
-	 * device tree based way to match cpufreq driver yet, both the driver
-	 * and the device registration codes are put here to handle defer
-	 * probing.
-	 */
-	pdev = platform_device_register_simple("mt8173-cpufreq", -1, NULL, 0);
-	if (IS_ERR(pdev)) {
-		pr_err("failed to register mtk-cpufreq platform device\n");
-		return PTR_ERR(pdev);
-	}
-
 	return 0;
 }
 device_initcall(mt8173_cpufreq_driver_init);
-- 
1.9.1
