From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 10 Nov 2011 11:32:31 +0200
Subject: [PATCH v4-rebased 7/7] iommu/core: remove the temporary pgsize
 settings
In-Reply-To: <1320917551-11328-1-git-send-email-ohad@wizery.com>
References: <1320917551-11328-1-git-send-email-ohad@wizery.com>
Message-ID: <1320917551-11328-8-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all IOMMU drivers are exporting their supported pgsizes,
we can remove the default pgsize settings in register_iommu().

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/iommu/iommu.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b278458..84cdd8a 100644
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
1.7.5.4
