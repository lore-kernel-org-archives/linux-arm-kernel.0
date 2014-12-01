From: will.deacon@arm.com (Will Deacon)
Date: Mon,  1 Dec 2014 16:57:11 +0000
Subject: [PATCH v6 5/8] iommu: fix initialization without 'add_device' callback
In-Reply-To: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
Message-ID: <1417453034-21379-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

IOMMU drivers can be initialized from of_iommu helpers. Such drivers don't
need to provide device_add callbacks to operate properly, so there is no
need to fail initialization if the callback is missing.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
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
2.1.1
