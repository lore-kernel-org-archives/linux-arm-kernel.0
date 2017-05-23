From: sricharan@codeaurora.org (Sricharan R)
Date: Tue, 23 May 2017 18:31:33 +0530
Subject: [PATCH v5 5/5] ACPI/IORT: Move the check to get iommu_ops from
 translated fwspec
In-Reply-To: <1495544493-14219-1-git-send-email-sricharan@codeaurora.org>
References: <1495544493-14219-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1495544493-14219-5-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

With IOMMU probe deferral, iort_iommu_configure can be called
multiple times for the same device. Hence we have a check
to see if the device's fwspec is already translated and return
the iommu_ops from that directly. But the check is wrongly
placed in iort_iommu_xlate, which breaks devices with multiple
sids. Move the check to iort_iommu_configure.

Fixes: 5a1bb638d567 ("drivers: acpi: Handle IOMMU lookup failure with deferred probing or error")
Tested-by: Nate Watterson <nwatters@codeaurora.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---

[v5] new patch

 drivers/acpi/arm64/iort.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 16e101f..797b28d 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -666,14 +666,6 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
 	int ret = -ENODEV;
 	struct fwnode_handle *iort_fwnode;
 
-	/*
-	 * If we already translated the fwspec there
-	 * is nothing left to do, return the iommu_ops.
-	 */
-	ops = iort_fwspec_iommu_ops(dev->iommu_fwspec);
-	if (ops)
-		return ops;
-
 	if (node) {
 		iort_fwnode = iort_get_fwnode(node);
 		if (!iort_fwnode)
@@ -735,6 +727,14 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 	u32 streamid = 0;
 	int err;
 
+	/*
+	 * If we already translated the fwspec there
+	 * is nothing left to do, return the iommu_ops.
+	 */
+	ops = iort_fwspec_iommu_ops(dev->iommu_fwspec);
+	if (ops)
+		return ops;
+
 	if (dev_is_pci(dev)) {
 		struct pci_bus *bus = to_pci_dev(dev)->bus;
 		u32 rid;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
