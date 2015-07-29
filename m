From: hramrach@gmail.com (Michal Suchanek)
Date: Wed, 29 Jul 2015 11:54:54 +0200
Subject: [RFC PATCH 1/2] dt: mtd: ofpart: use compatible for partitions
In-Reply-To: <cover.1438170519.git.hramrach@gmail.com>
References: <cover.1438170519.git.hramrach@gmail.com>
Message-ID: <43664a3e43716ef4a7a9a2c25c5e673f011f89f1.1438170519.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ofpart is confused when nodes without compatible that are not partitions
exist so add compatible for partitions to make tevicetrees unambiguous.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 .../devicetree/bindings/mtd/partition.txt          |  7 +++++-
 drivers/mtd/ofpart.c                               | 26 +++++++++++++---------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/partition.txt b/Documentation/devicetree/bindings/mtd/partition.txt
index 8e5557d..6308c56 100644
--- a/Documentation/devicetree/bindings/mtd/partition.txt
+++ b/Documentation/devicetree/bindings/mtd/partition.txt
@@ -4,7 +4,7 @@ Partitions can be represented by sub-nodes of an mtd device. This can be used
 on platforms which have strong conventions about which portions of a flash are
 used for what purposes, but which don't use an on-flash partition table such
 as RedBoot.
-NOTE: if the sub-node has a compatible string, then it is not a partition.
+NOTE: the subnode should have compatible string linux,ofpart-partition
 
 #address-cells & #size-cells must both be present in the mtd device. There are
 two valid values for both:
@@ -32,12 +32,14 @@ flash at 0 {
 	#size-cells = <1>;
 
 	partition at 0 {
+		compatible = "linux,ofpart-partition";
 		label = "u-boot";
 		reg = <0x0000000 0x100000>;
 		read-only;
 	};
 
 	uimage at 100000 {
+		compatible = "linux,ofpart-partition";
 		reg = <0x0100000 0x200000>;
 	};
 };
@@ -48,6 +50,7 @@ flash at 1 {
 
 	/* a 4 GiB partition */
 	partition at 0 {
+		compatible = "linux,ofpart-partition";
 		label = "filesystem";
 		reg = <0x00000000 0x1 0x00000000>;
 	};
@@ -59,12 +62,14 @@ flash at 2 {
 
 	/* an 8 GiB partition */
 	partition at 0 {
+		compatible = "linux,ofpart-partition";
 		label = "filesystem #1";
 		reg = <0x0 0x00000000 0x2 0x00000000>;
 	};
 
 	/* a 4 GiB partition */
 	partition at 200000000 {
+		compatible = "linux,ofpart-partition";
 		label = "filesystem #2";
 		reg = <0x2 0x00000000 0x1 0x00000000>;
 	};
diff --git a/drivers/mtd/ofpart.c b/drivers/mtd/ofpart.c
index aa26c32..f64830b 100644
--- a/drivers/mtd/ofpart.c
+++ b/drivers/mtd/ofpart.c
@@ -20,9 +20,14 @@
 #include <linux/slab.h>
 #include <linux/mtd/partitions.h>
 
-static bool node_has_compatible(struct device_node *pp)
+const char * OFPART_COMPATIBLE = "linux,ofpart-partition";
+
+static bool node_is_compatible(struct device_node *pp)
 {
-	return of_get_property(pp, "compatible", NULL);
+	return of_get_property(pp, "reg", NULL) &&
+		(!of_get_property(pp, "compatible", NULL) ||
+		!strcmp(OFPART_COMPATIBLE,
+			of_get_property(pp, "compatible", NULL)));
 }
 
 static int parse_ofpart_partitions(struct mtd_info *master,
@@ -45,7 +50,7 @@ static int parse_ofpart_partitions(struct mtd_info *master,
 	/* First count the subnodes */
 	nr_parts = 0;
 	for_each_child_of_node(node,  pp) {
-		if (node_has_compatible(pp))
+		if (!node_is_compatible(pp))
 			continue;
 
 		nr_parts++;
@@ -64,14 +69,11 @@ static int parse_ofpart_partitions(struct mtd_info *master,
 		int len;
 		int a_cells, s_cells;
 
-		if (node_has_compatible(pp))
+		if (!node_is_compatible(pp))
 			continue;
 
+		/* this should exist due to node_is_compatible */
 		reg = of_get_property(pp, "reg", &len);
-		if (!reg) {
-			nr_parts--;
-			continue;
-		}
 
 		a_cells = of_n_addr_cells(pp);
 		s_cells = of_n_size_cells(pp);
@@ -89,15 +91,19 @@ static int parse_ofpart_partitions(struct mtd_info *master,
 		if (of_get_property(pp, "lock", &len))
 			(*pparts)[i].mask_flags |= MTD_POWERUP_LOCK;
 
+		if (!of_get_property(pp, "compatible", NULL))
+			pr_warn("%s: DT subnode without compatible parsed as ofpart partition!\n",
+				 node->full_name);
+
 		i++;
 	}
 
 	if (!i) {
 		of_node_put(pp);
-		pr_err("No valid partition found on %s\n", node->full_name);
+		pr_notice("No valid ofpart partition found on %s\n",
+			  node->full_name);
 		kfree(*pparts);
 		*pparts = NULL;
-		return -EINVAL;
 	}
 
 	return nr_parts;
-- 
2.1.4
