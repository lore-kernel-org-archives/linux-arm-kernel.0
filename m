From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Fri, 17 Jun 2016 18:10:03 +0000
Subject: [PATCH -next] PM / devfreq: event: Fix return value check in
 exynos_nocp_parse_dt()
Message-ID: <1466187003-19823-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function platform_get_resource() returns NULL
pointer not ERR_PTR(). Remove unneeded error handling on the result
of a call to platform_get_resource() since the value is passed to
devm_ioremap_resource().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/devfreq/event/exynos-nocp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
index 6b6a5f3..a584140 100644
--- a/drivers/devfreq/event/exynos-nocp.c
+++ b/drivers/devfreq/event/exynos-nocp.c
@@ -220,9 +220,6 @@ static int exynos_nocp_parse_dt(struct platform_device *pdev,
 
 	/* Maps the memory mapped IO to control nocp register */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (IS_ERR(res))
-		return PTR_ERR(res);
-
 	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
