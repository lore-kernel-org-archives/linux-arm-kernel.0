From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 18 Oct 2016 17:04:13 +0100
Subject: [PATCH v6 15/16] drivers: acpi: iort: add single mapping function
In-Reply-To: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
References: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
Message-ID: <20161018160414.1228-16-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current IORT id mapping API requires components to provide
an input requester ID (a Bus-Device-Function (BDF) identifier for
PCI devices) to translate an input identifier to an output
identifier through an IORT range mapping.

Named components do not have an identifiable source ID therefore
their respective input/output mapping can only be defined in
IORT tables through single mappings, that provide a translation
that does not require any input identifier.

Current IORT interface for requester id mappings (iort_node_map_rid())
is not suitable for components that do not provide a requester id,
so it cannot be used for IORT named components.

Add an interface to the IORT API to enable retrieval of id
by allowing an indexed walk of the single mappings array for
a given component, therefore completing the IORT mapping API.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/arm64/iort.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index f205d41..db7b153 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -318,6 +318,45 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
 	return 0;
 }
 
+static
+struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
+					u32 *id_out, u8 type_mask,
+					int index)
+{
+	struct acpi_iort_node *parent;
+	struct acpi_iort_id_mapping *map;
+
+	if (!node->mapping_offset || !node->mapping_count ||
+				     index >= node->mapping_count)
+		return NULL;
+
+	map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
+			   node->mapping_offset);
+
+	/* Firmware bug! */
+	if (!map->output_reference) {
+		pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
+		       node, node->type);
+		return NULL;
+	}
+
+	parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
+			       map->output_reference);
+
+	if (!(IORT_TYPE_MASK(parent->type) & type_mask))
+		return NULL;
+
+	if (map[index].flags & ACPI_IORT_ID_SINGLE_MAPPING) {
+		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
+		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
+			*id_out = map[index].output_base;
+			return parent;
+		}
+	}
+
+	return NULL;
+}
+
 static struct acpi_iort_node *iort_node_map_rid(struct acpi_iort_node *node,
 						u32 rid_in, u32 *rid_out,
 						u8 type_mask)
-- 
2.10.0
