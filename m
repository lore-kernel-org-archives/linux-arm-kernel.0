From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Wed, 20 Jul 2016 20:49:21 +0800
Subject: [RFC PATCH] iommu: create direct_mapping after device attached
Message-ID: <1469018961-16367-1-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

For mtk iommu, the domain_finalize was called in device attatch, the mtk
iommu iopgt ops was allocated and initialized in domain_finalize, the
iommu_group_create_direct_mappings would call the map interface to
implement the map. If it's earlier than device attach, there would be NULL
dereference. Move the iommu_group_create_direct_mappings call after device
attached.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/iommu/iommu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3000051..24c671c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -427,14 +427,19 @@ rename:
 
 	dev->iommu_group = group;
 
-	iommu_group_create_direct_mappings(group, dev);
-
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
 	if (group->domain)
 		__iommu_attach_device(group->domain, dev);
 	mutex_unlock(&group->mutex);
 
+	/*
+	 * For some iommu driver like mtk iommu, the map callback was assigned
+	 * after device attached. The direct_mappings would call iommu map and
+	 * dereference NULL if it's called earlier than attach_device.
+	 */
+	iommu_group_create_direct_mappings(group, dev);
+
 	/* Notify any listeners about change to group. */
 	blocking_notifier_call_chain(&group->notifier,
 				     IOMMU_GROUP_NOTIFY_ADD_DEVICE, dev);
-- 
1.8.1.1.dirty
