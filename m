From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 26 Jul 2017 18:15:49 +0800
Subject: [PATCH v3] irqchip/gic-v3-its: Allow GIC ITS number more than
 MAX_NUMNODES
Message-ID: <1501064149-37285-1-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

When enabling ITS NUMA support on D05, I got the boot log:

[    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
[    0.000000] SRAT: PXM 0 -> ITS 1 -> Node 0
[    0.000000] SRAT: PXM 0 -> ITS 2 -> Node 0
[    0.000000] SRAT: PXM 1 -> ITS 3 -> Node 1
[    0.000000] SRAT: ITS affinity exceeding max count[4]

This is wrong on D05 as we have 8 ITSs with 4 NUMA nodes.

So dynamically alloc the memory needed instead of using
its_srat_maps[MAX_NUMNODES], which count the number of
ITS entry(ies) in SRAT and alloc its_srat_maps as needed,
then build the mapping of numa node to ITS ID. Of course,
its_srat_maps will be freed after ITS probing because
we don't need that after boot.

After doing this, I got what I wanted:

[    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
[    0.000000] SRAT: PXM 0 -> ITS 1 -> Node 0
[    0.000000] SRAT: PXM 0 -> ITS 2 -> Node 0
[    0.000000] SRAT: PXM 1 -> ITS 3 -> Node 1
[    0.000000] SRAT: PXM 2 -> ITS 4 -> Node 2
[    0.000000] SRAT: PXM 2 -> ITS 5 -> Node 2
[    0.000000] SRAT: PXM 2 -> ITS 6 -> Node 2
[    0.000000] SRAT: PXM 3 -> ITS 7 -> Node 3

Fixes: dbd2b8267233 ("irqchip/gic-v3-its: Add ACPI NUMA node mapping")
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---

v2->v3:
  - Remove the NULL check for its_srat_maps as its_in_srat will be 0;
  - Add warning if alloc memory failed for its_srat_maps;
  - Update commit log as Lorenzo suggested;
  - Add review tag

 drivers/irqchip/irq-gic-v3-its.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 3ccdf76..bf70115 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1847,7 +1847,7 @@ struct its_srat_map {
 	u32	its_id;
 };
 
-static struct its_srat_map its_srat_maps[MAX_NUMNODES] __initdata;
+static struct its_srat_map *its_srat_maps __initdata;
 static int its_in_srat __initdata;
 
 static int __init acpi_get_its_numa_node(u32 its_id)
@@ -1861,6 +1861,12 @@ static int __init acpi_get_its_numa_node(u32 its_id)
 	return NUMA_NO_NODE;
 }
 
+static int __init gic_acpi_match_srat_its(struct acpi_subtable_header *header,
+					  const unsigned long end)
+{
+	return 0;
+}
+
 static int __init gic_acpi_parse_srat_its(struct acpi_subtable_header *header,
 			 const unsigned long end)
 {
@@ -1877,12 +1883,6 @@ static int __init gic_acpi_parse_srat_its(struct acpi_subtable_header *header,
 		return -EINVAL;
 	}
 
-	if (its_in_srat >= MAX_NUMNODES) {
-		pr_err("SRAT: ITS affinity exceeding max count[%d]\n",
-				MAX_NUMNODES);
-		return -EINVAL;
-	}
-
 	node = acpi_map_pxm_to_node(its_affinity->proximity_domain);
 
 	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
@@ -1901,14 +1901,37 @@ static int __init gic_acpi_parse_srat_its(struct acpi_subtable_header *header,
 
 static void __init acpi_table_parse_srat_its(void)
 {
+	int count;
+
+	count = acpi_table_parse_entries(ACPI_SIG_SRAT,
+			sizeof(struct acpi_table_srat),
+			ACPI_SRAT_TYPE_GIC_ITS_AFFINITY,
+			gic_acpi_match_srat_its, 0);
+	if (count <= 0)
+		return;
+
+	its_srat_maps = kmalloc(count * sizeof(struct its_srat_map),
+				GFP_KERNEL);
+	if (!its_srat_maps) {
+		pr_warn("SRAT: Failed to allocate memory for its_srat_maps!\n");
+		return;
+	}
+
 	acpi_table_parse_entries(ACPI_SIG_SRAT,
 			sizeof(struct acpi_table_srat),
 			ACPI_SRAT_TYPE_GIC_ITS_AFFINITY,
 			gic_acpi_parse_srat_its, 0);
 }
+
+/* free the its_srat_maps after ITS probing */
+static void __init acpi_its_srat_maps_free(void)
+{
+	kfree(its_srat_maps);
+}
 #else
 static void __init acpi_table_parse_srat_its(void)	{ }
 static int __init acpi_get_its_numa_node(u32 its_id) { return NUMA_NO_NODE; }
+static void __init acpi_its_srat_maps_free(void) { }
 #endif
 
 static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
@@ -1955,6 +1978,7 @@ static void __init its_acpi_probe(void)
 	acpi_table_parse_srat_its();
 	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
 			      gic_acpi_parse_madt_its, 0);
+	acpi_its_srat_maps_free();
 }
 #else
 static void __init its_acpi_probe(void) { }
-- 
1.7.12.4
