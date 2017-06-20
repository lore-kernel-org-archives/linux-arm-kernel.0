From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Tue, 20 Jun 2017 12:37:17 +0530
Subject: [PATCH v2 2/2] acpi, gicv3-its,
 numa: Adding numa node mapping for gic-its units
In-Reply-To: <1497942437-1390-1-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1497942437-1390-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <1497942437-1390-3-git-send-email-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add code to parse SRAT ITS Affinity sub table as defined in ACPI 6.2
Later in per device probe, ITS devices are mapped to
numa node using ITS id to proximity domain mapping.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 76 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 45ea1933..5865a75 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1833,6 +1833,78 @@ static int __init its_of_probe(struct device_node *node)
 
 #define ACPI_GICV3_ITS_MEM_SIZE (SZ_128K)
 
+#ifdef CONFIG_ACPI_NUMA
+struct its_srat_map {
+	u32			numa_node;  /* numa node id */
+	u32			its_id;  /* GIC ITS ID */
+	struct list_head	entry;
+};
+
+static LIST_HEAD(its_srat_maps);
+
+static int acpi_get_its_numa_node(u32 its_id)
+{
+	struct its_srat_map *srat_map;
+
+	list_for_each_entry(srat_map, &its_srat_maps, entry) {
+		if (its_id == srat_map->its_id)
+			return srat_map->numa_node;
+	}
+	return NUMA_NO_NODE;
+}
+
+static int __init
+gic_acpi_parse_srat_its(struct acpi_subtable_header *header,
+			 const unsigned long end)
+{
+	int pxm, node;
+	struct its_srat_map *srat_map;
+	struct acpi_srat_its_affinity *its_affinity;
+
+	its_affinity = (struct acpi_srat_its_affinity *)header;
+	if (!its_affinity)
+		return -EINVAL;
+
+	if (its_affinity->header.length <
+			sizeof(struct acpi_srat_its_affinity)) {
+		pr_err("SRAT:ITS: Invalid SRAT header length: %d\n",
+			its_affinity->header.length);
+		return -EINVAL;
+	}
+
+	pxm = its_affinity->proximity_domain;
+	node = acpi_map_pxm_to_node(pxm);
+
+	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
+		pr_err("SRAT:ITS Invalid numa node %d\n", node);
+		return -EINVAL;
+	}
+
+	srat_map = kzalloc(sizeof(*srat_map), GFP_KERNEL);
+	if (!srat_map)
+		return -ENOMEM;
+
+	srat_map->numa_node = node;
+	srat_map->its_id = its_affinity->its_id;
+	list_add(&srat_map->entry, &its_srat_maps);
+	pr_info("ACPI: NUMA: SRAT: ITS: PXM %d -> ITS_ID %d -> NODE %d\n",
+		srat_map->its_id, pxm, node);
+
+	return 0;
+}
+
+static int __init acpi_table_parse_srat_its(void)
+{
+	return acpi_table_parse_entries(ACPI_SIG_SRAT,
+					sizeof(struct acpi_table_srat),
+					ACPI_SRAT_TYPE_GIC_ITS_AFFINITY,
+					gic_acpi_parse_srat_its, 0);
+}
+#else
+#define acpi_table_parse_srat_its(void) { }
+#define acpi_get_its_numa_node(its_id) NUMA_NO_NODE
+#endif
+
 static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
 					  const unsigned long end)
 {
@@ -1861,7 +1933,8 @@ static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
 		goto dom_err;
 	}
 
-	err = its_probe_one(&res, dom_handle, NUMA_NO_NODE);
+	err = its_probe_one(&res, dom_handle,
+			acpi_get_its_numa_node(its_entry->translation_id));
 	if (!err)
 		return 0;
 
@@ -1873,6 +1946,7 @@ static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
 
 static void __init its_acpi_probe(void)
 {
+	acpi_table_parse_srat_its();
 	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
 			      gic_acpi_parse_madt_its, 0);
 }
-- 
1.8.1.4
