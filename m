From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 17 Oct 2011 13:27:26 +0200
Subject: [PATCH v4 7/7] iommu/core: remove the temporary pgsize settings
In-Reply-To: <1318850846-16066-1-git-send-email-ohad@wizery.com>
References: <1318850846-16066-1-git-send-email-ohad@wizery.com>
Message-ID: <1318850846-16066-8-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all IOMMU drivers are exporting their supported pgsizes,
we can remove the default pgsize settings in register_iommu().

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/iommu/iommu.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 91df958..ff8d524 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -49,16 +49,6 @@ int bus_set_iommu(struct bus_type *bus, struct iommu_ops *ops)
 	if (bus->iommu_ops != NULL)
 		return -EBUSY;
 
-	/*
-	 * Set the default pgsize values, which retain the existing
-	 * IOMMU API behavior: drivers will be called to map
-	 * regions that are sized/aligned to order of 4KiB pages.
-	 *
-	 * This will be removed once all drivers are migrated.
-	 */
-	if (!ops->pgsize_bitmap)
-		ops->pgsize_bitmap = ~0xFFFUL;
-
 	bus->iommu_ops = ops;
 
 	/* Do IOMMU specific setup for this bus-type */
-- 
1.7.4.1
