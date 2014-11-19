From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 19 Nov 2014 12:15:31 +0100
Subject: [PATCH v3 02/19] iommu: fix initialization without 'add_device'
 callback
In-Reply-To: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1416395748-10731-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IOMMU drivers can be initialized from of_iommu helpers. Such drivers don't
need to provide device_add callbacks to operate properly, so there is no
need to fail initialization if the callback is missing.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ed8b04867b1f..02f798b7e295 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -737,7 +737,7 @@ static int add_iommu_group(struct device *dev, void *data)
 	const struct iommu_ops *ops = cb->ops;
 
 	if (!ops->add_device)
-		return -ENODEV;
+		return 0;
 
 	WARN_ON(dev->iommu_group);
 
-- 
1.9.2
