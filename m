From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri,  2 Sep 2011 20:32:33 +0300
Subject: [PATCH 4/7] iommu/omap: ->unmap() should return order of unmapped page
In-Reply-To: <1314984756-4400-1-git-send-email-ohad@wizery.com>
References: <1314984756-4400-1-git-send-email-ohad@wizery.com>
Message-ID: <1314984756-4400-5-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Users of the IOMMU API (kvm specifically) assume that iommu_unmap()
returns the order of the unmapped page.

Fix omap_iommu_unmap() to do so and adopt omap-iovmm accordingly.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/iommu/omap-iommu.c |   13 ++++---------
 drivers/iommu/omap-iovmm.c |    2 +-
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 4311bc3..bd5f606 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1081,18 +1081,13 @@ static int omap_iommu_unmap(struct iommu_domain *domain, unsigned long da,
 	struct omap_iommu_domain *omap_domain = domain->priv;
 	struct omap_iommu *oiommu = omap_domain->iommu_dev;
 	struct device *dev = oiommu->dev;
-	size_t bytes = PAGE_SIZE << order;
-	size_t ret;
+	size_t unmap_size;
 
-	dev_dbg(dev, "unmapping da 0x%lx size 0x%x\n", da, bytes);
+	dev_dbg(dev, "unmapping da 0x%lx order %d\n", da, order);
 
-	ret = iopgtable_clear_entry(oiommu, da);
-	if (ret != bytes) {
-		dev_err(dev, "entry @ 0x%lx was %d; not %d\n", da, ret, bytes);
-		return -EINVAL;
-	}
+	unmap_size = iopgtable_clear_entry(oiommu, da);
 
-	return 0;
+	return unmap_size ? get_order(unmap_size) : -EINVAL;
 }
 
 static int
diff --git a/drivers/iommu/omap-iovmm.c b/drivers/iommu/omap-iovmm.c
index 39bdb92..e8fdb88 100644
--- a/drivers/iommu/omap-iovmm.c
+++ b/drivers/iommu/omap-iovmm.c
@@ -480,7 +480,7 @@ static void unmap_iovm_area(struct iommu_domain *domain, struct omap_iommu *obj,
 		order = get_order(bytes);
 
 		err = iommu_unmap(domain, start, order);
-		if (err)
+		if (err < 0)
 			break;
 
 		dev_dbg(obj->dev, "%s: unmap %08x(%x) %08x\n",
-- 
1.7.4.1
