From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 11 Jan 2017 23:06:32 +0800
Subject: [PATCH v7 08/15] ACPI: IORT: rename iort_node_map_rid() to make it
 generic
In-Reply-To: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1484147199-4267-9-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

iort_node_map_rid() was designed for both PCI and platform
device, but the rid means requester id is for ITS mappings,
rename iort_node_map_rid() to iort_node_map_id() and update
its argument names to make it more generic.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/acpi/arm64/iort.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 208eac9..069a690 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -355,11 +355,11 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 	return NULL;
 }
 
-static struct acpi_iort_node *iort_node_map_rid(struct acpi_iort_node *node,
-						u32 rid_in, u32 *rid_out,
-						u8 type_mask)
+static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
+					       u32 id_in, u32 *id_out,
+					       u8 type_mask)
 {
-	u32 rid = rid_in;
+	u32 id = id_in;
 
 	/* Parse the ID mapping tree to find specified node type */
 	while (node) {
@@ -367,8 +367,8 @@ static struct acpi_iort_node *iort_node_map_rid(struct acpi_iort_node *node,
 		int i;
 
 		if (IORT_TYPE_MASK(node->type) & type_mask) {
-			if (rid_out)
-				*rid_out = rid;
+			if (id_out)
+				*id_out = id;
 			return node;
 		}
 
@@ -385,9 +385,9 @@ static struct acpi_iort_node *iort_node_map_rid(struct acpi_iort_node *node,
 			goto fail_map;
 		}
 
-		/* Do the RID translation */
+		/* Do the ID translation */
 		for (i = 0; i < node->mapping_count; i++, map++) {
-			if (!iort_id_map(map, node->type, rid, &rid))
+			if (!iort_id_map(map, node->type, id, &id))
 				break;
 		}
 
@@ -399,9 +399,9 @@ static struct acpi_iort_node *iort_node_map_rid(struct acpi_iort_node *node,
 	}
 
 fail_map:
-	/* Map input RID to output RID unchanged on mapping failure*/
-	if (rid_out)
-		*rid_out = rid_in;
+	/* Map input ID to output ID unchanged on mapping failure */
+	if (id_out)
+		*id_out = id_in;
 
 	return NULL;
 }
@@ -439,7 +439,7 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 	if (!node)
 		return req_id;
 
-	iort_node_map_rid(node, req_id, &dev_id, IORT_MSI_TYPE);
+	iort_node_map_id(node, req_id, &dev_id, IORT_MSI_TYPE);
 	return dev_id;
 }
 
@@ -462,7 +462,7 @@ static int iort_dev_find_its_id(struct device *dev, u32 req_id,
 	if (!node)
 		return -ENXIO;
 
-	node = iort_node_map_rid(node, req_id, NULL, IORT_MSI_TYPE);
+	node = iort_node_map_id(node, req_id, NULL, IORT_MSI_TYPE);
 	if (!node)
 		return -ENXIO;
 
@@ -591,8 +591,8 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 		if (!node)
 			return NULL;
 
-		parent = iort_node_map_rid(node, rid, &streamid,
-					   IORT_IOMMU_TYPE);
+		parent = iort_node_map_id(node, rid, &streamid,
+					  IORT_IOMMU_TYPE);
 
 		ops = iort_iommu_xlate(dev, parent, streamid);
 
-- 
1.9.1
