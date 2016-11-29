From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 29 Nov 2016 21:39:38 +0800
Subject: [PATCH v4 10/11] ACPI: ARM64: IORT: rework iort_node_get_id() for
 NC->SMMU->ITS case
In-Reply-To: <1480426779-31387-1-git-send-email-guohanjun@huawei.com>
References: <1480426779-31387-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1480426779-31387-11-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

iort_node_get_id() for now only support NC(named componant)->SMMU
or NC->ITS cases, we also have other device topology such NC->
SMMU->ITS, so rework iort_node_get_id() for those cases.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/acpi/arm64/iort.c | 59 ++++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 8714f70..2e2d231 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -292,22 +292,28 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
 	return status;
 }
 
-static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
-		       u32 *rid_out)
+static int iort_id_single_map(struct acpi_iort_id_mapping *map, u8 type,
+			      u32 *rid_out)
 {
 	/* Single mapping does not care for input id */
 	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
 		if (type == ACPI_IORT_NODE_NAMED_COMPONENT ||
 		    type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
-			*rid_out = map->output_base;
+			if (rid_out)
+				*rid_out = map->output_base;
 			return 0;
 		}
 
 		pr_warn(FW_BUG "[map %p] SINGLE MAPPING flag not allowed for node type %d, skipping ID map\n",
 			map, type);
-		return -ENXIO;
 	}
 
+	return -ENXIO;
+}
+
+static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
+		       u32 *rid_out)
+{
 	if (rid_in < map->input_base ||
 	    (rid_in >= map->input_base + map->id_count))
 		return -ENXIO;
@@ -324,33 +330,34 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 	struct acpi_iort_node *parent;
 	struct acpi_iort_id_mapping *map;
 
-	if (!node->mapping_offset || !node->mapping_count ||
-				     index >= node->mapping_count)
-		return NULL;
-
-	map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
-			   node->mapping_offset);
+	while (node) {
+		if (!node->mapping_offset || !node->mapping_count ||
+					     index >= node->mapping_count)
+			return NULL;
 
-	/* Firmware bug! */
-	if (!map->output_reference) {
-		pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
-		       node, node->type);
-		return NULL;
-	}
+		map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
+				   node->mapping_offset);
 
-	parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
-			       map->output_reference);
+		/* Firmware bug! */
+		if (!map->output_reference) {
+			pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
+			       node, node->type);
+			return NULL;
+		}
 
-	if (!(IORT_TYPE_MASK(parent->type) & type_mask))
-		return NULL;
+		parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
+				      map->output_reference);
 
-	if (map[index].flags & ACPI_IORT_ID_SINGLE_MAPPING) {
-		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
-		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
-			if (id_out)
-				*id_out = map[index].output_base;
-			return parent;
+		/* go upstream to find its parent */
+		if (!(IORT_TYPE_MASK(parent->type) & type_mask)) {
+			node = parent;
+			continue;
 		}
+
+		if (iort_id_single_map(&map[index], node->type, id_out))
+			break;
+
+		return parent;
 	}
 
 	return NULL;
-- 
1.7.12.4
