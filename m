From: s-anna@ti.com (Suman Anna)
Date: Tue, 8 Jul 2014 11:22:00 -0500
Subject: [PATCH 1/2] remoteproc: use a flag to detect the presence of IOMMU
In-Reply-To: <1404836521-59637-1-git-send-email-s-anna@ti.com>
References: <1404836521-59637-1-git-send-email-s-anna@ti.com>
Message-ID: <1404836521-59637-2-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The remoteproc driver core currently relies on iommu_present() on
the bus the device is on, to perform MMU management. However, this
logic doesn't scale for multi-arch, especially for processors that
do not have an IOMMU. Replace this logic instead by using a h/w
capability flag for the presence of IOMMU in the rproc structure.

The individual platform implementations are required to set this
flag appropriately. The default setting is to not have an MMU.

The OMAP remoteproc driver is updated while at this, to maintain
the functionality with the IOMMU detection logic change in this
patch.

Cc: Sjur Br?ndeland <sjur.brandeland@stericsson.com>
Cc: Robert Tivy <rtivy@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/omap_remoteproc.c |  6 ++++++
 drivers/remoteproc/remoteproc_core.c | 15 ++-------------
 include/linux/remoteproc.h           |  2 ++
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index 5168972..858abf0 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -199,6 +199,12 @@ static int omap_rproc_probe(struct platform_device *pdev)
 
 	oproc = rproc->priv;
 	oproc->rproc = rproc;
+	/*
+	 * All existing OMAP IPU and DSP processors do have an MMU, and
+	 * are expected to use MMU, so this statement suffices.
+	 * XXX: Replace this logic if and when a need arises.
+	 */
+	rproc->has_iommu = true;
 
 	platform_set_drvdata(pdev, rproc);
 
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 3cd85a6..11cdb11 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -94,19 +94,8 @@ static int rproc_enable_iommu(struct rproc *rproc)
 	struct device *dev = rproc->dev.parent;
 	int ret;
 
-	/*
-	 * We currently use iommu_present() to decide if an IOMMU
-	 * setup is needed.
-	 *
-	 * This works for simple cases, but will easily fail with
-	 * platforms that do have an IOMMU, but not for this specific
-	 * rproc.
-	 *
-	 * This will be easily solved by introducing hw capabilities
-	 * that will be set by the remoteproc driver.
-	 */
-	if (!iommu_present(dev->bus)) {
-		dev_dbg(dev, "iommu not found\n");
+	if (!rproc->has_iommu) {
+		dev_dbg(dev, "iommu not present\n");
 		return 0;
 	}
 
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 9e7e745..78b8a9b 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -404,6 +404,7 @@ enum rproc_crash_type {
  * @table_ptr: pointer to the resource table in effect
  * @cached_table: copy of the resource table
  * @table_csum: checksum of the resource table
+ * @has_iommu: flag to indicate if remote processor is behind an MMU
  */
 struct rproc {
 	struct klist_node node;
@@ -435,6 +436,7 @@ struct rproc {
 	struct resource_table *table_ptr;
 	struct resource_table *cached_table;
 	u32 table_csum;
+	bool has_iommu;
 };
 
 /* we currently support only two vrings per rvdev */
-- 
2.0.0
