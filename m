From: shailendra.capricorn@gmail.com (Shailendra Verma)
Date: Thu, 21 May 2015 23:59:41 +0530
Subject: [PATCH] cpufreq:exynos-cpufreq - Fix for memory leak in case SOC name
 does not match.
Message-ID: <1432232981-3917-1-git-send-email-shailendra.capricorn@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During probe free the memory allocated to "exynos_info" in case of unknown
SOC type.

Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/cpufreq/exynos-cpufreq.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 82d2fbb..b77923a 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -182,6 +182,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 		ret = exynos5250_cpufreq_init(exynos_info);
 	} else {
 		pr_err("%s: Unknown SoC type\n", __func__);
+		kfree(exynos_info);
 		return -ENODEV;
 	}
 
-- 
1.7.9.5
