From: s-anna@ti.com (Suman Anna)
Date: Fri, 28 Feb 2014 14:42:33 -0600
Subject: [PATCHv3 02/13] iommu/omap: fix error return paths in
 omap_iommu_attach()
In-Reply-To: <1393620164-14633-1-git-send-email-s-anna@ti.com>
References: <1393620164-14633-1-git-send-email-s-anna@ti.com>
Message-ID: <1393620164-14633-3-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are couple of issues with the error return paths in
omap_iommu_attach():
1. omap_iommu_attach() returns NULL or ERR_PTR in case of error,
   but omap_iommu_attach_dev() only checks for IS_ERR. Thus a NULL
   return value (in case driver_find_device fails) will cause the
   kernel to panic when omap_iommu_attach_dev() dereferences the
   pointer.
2. A try_module_get() failure returns a valid success value as
   returned from iommu_enable().

Both the above issues have been fixed up to return the proper
ERR_PTR.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/iommu/omap-iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index fff2ffd..647e4ba 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -863,7 +863,7 @@ static int device_match_by_alias(struct device *dev, void *data)
  **/
 static struct omap_iommu *omap_iommu_attach(const char *name, u32 *iopgd)
 {
-	int err = -ENOMEM;
+	int err;
 	struct device *dev;
 	struct omap_iommu *obj;
 
@@ -871,7 +871,7 @@ static struct omap_iommu *omap_iommu_attach(const char *name, u32 *iopgd)
 				(void *)name,
 				device_match_by_alias);
 	if (!dev)
-		return NULL;
+		return ERR_PTR(-ENODEV);
 
 	obj = to_iommu(dev);
 
@@ -890,8 +890,10 @@ static struct omap_iommu *omap_iommu_attach(const char *name, u32 *iopgd)
 		goto err_enable;
 	flush_iotlb_all(obj);
 
-	if (!try_module_get(obj->owner))
+	if (!try_module_get(obj->owner)) {
+		err = -ENODEV;
 		goto err_module;
+	}
 
 	spin_unlock(&obj->iommu_lock);
 
-- 
1.9.0
