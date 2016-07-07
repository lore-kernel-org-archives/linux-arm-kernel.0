From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Thu,  7 Jul 2016 02:59:32 +0000
Subject: [PATCH -next v2] iommu/exynos: Fix return value check in
 exynos_iommu_of_setup()
In-Reply-To: <1467807354-26503-1-git-send-email-weiyj_lk@163.com>
References: <1467807354-26503-1-git-send-email-weiyj_lk@163.com>
Message-ID: <1467860372-6940-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function of_platform_device_create() returns
NULL pointer not ERR_PTR(). The IS_ERR() test in the return value
check should be replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
v1 -> v2: chenge the error code to -ENODEV
---
 drivers/iommu/exynos-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 33dcc29..9b23059 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1345,8 +1345,8 @@ static int __init exynos_iommu_of_setup(struct device_node *np)
 		exynos_iommu_init();
 
 	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
+	if (!pdev)
+		return -ENODEV;
 
 	/*
 	 * use the first registered sysmmu device for performing
