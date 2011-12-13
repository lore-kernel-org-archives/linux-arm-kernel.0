From: pullip.cho@samsung.com (KyongHo Cho)
Date: Tue, 13 Dec 2011 16:14:26 +0900
Subject: [PATCH] iommu: Initialize domain->handler in iommu_domain_alloc()
Message-ID: <1323760466-30333-1-git-send-email-pullip.cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since it is not guaranteed that an iommu driver initializes in its
domain_init() function, it must be initialized with NULL to prevent
calling a function in an arbitrary location when iommu fault occurred.

Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
---
 drivers/iommu/iommu.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7cc3c65..1afb896 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -148,6 +148,7 @@ struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
 		return NULL;
 
 	domain->ops = bus->iommu_ops;
+	domain->handler = NULL;
 
 	ret = domain->ops->domain_init(domain);
 	if (ret)
-- 
1.7.1
