From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 21 Jul 2014 10:36:09 +0200
Subject: [PATCH 1/3] cpuidle: exynos: Allow to use the driver without AFTR
Message-ID: <1405931771-24100-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the driver to be used when AFTR enter function is not provided
(device platform data is NULL).

This actually does not give any special energy-saving benefits but
allows to track the idle time of each core. Additionally it is a safe
way to validate supplied platform data.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/cpuidle/cpuidle-exynos.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-exynos.c b/drivers/cpuidle/cpuidle-exynos.c
index 7c0151263828..5325a394be7e 100644
--- a/drivers/cpuidle/cpuidle-exynos.c
+++ b/drivers/cpuidle/cpuidle-exynos.c
@@ -77,7 +77,10 @@ static int exynos_cpuidle_probe(struct platform_device *pdev)
 {
 	int ret;
 
+	/* If NULL enter only WFI */
 	exynos_enter_aftr = (void *)(pdev->dev.platform_data);
+	if (!exynos_enter_aftr)
+		exynos_idle_driver.state_count = 1;
 
 	ret = cpuidle_register(&exynos_idle_driver, NULL);
 	if (ret) {
-- 
1.9.1
