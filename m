From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 10 Jun 2013 18:26:54 +0800
Subject: [PATCH 6/6] mtd: ofpart: add compatible check for child nodes
In-Reply-To: <1370860014-1770-1-git-send-email-josh.wu@atmel.com>
References: <1370860014-1770-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1370860014-1770-7-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the child node has compatible property then it is a driver not partition.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 drivers/mtd/ofpart.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ofpart.c b/drivers/mtd/ofpart.c
index 553d6d6..61ce1f8 100644
--- a/drivers/mtd/ofpart.c
+++ b/drivers/mtd/ofpart.c
@@ -20,6 +20,10 @@
 #include <linux/slab.h>
 #include <linux/mtd/partitions.h>
 
+static bool node_has_compatible(struct device_node *pp, int *len)
+{
+	return of_get_property(pp, "compatible", len);
+}
 static int parse_ofpart_partitions(struct mtd_info *master,
 				   struct mtd_partition **pparts,
 				   struct mtd_part_parser_data *data)
@@ -40,8 +44,13 @@ static int parse_ofpart_partitions(struct mtd_info *master,
 	/* First count the subnodes */
 	pp = NULL;
 	nr_parts = 0;
-	while ((pp = of_get_next_child(node, pp)))
+	while ((pp = of_get_next_child(node, pp))) {
+		int len;
+		if (node_has_compatible(pp, &len))
+			continue;
+
 		nr_parts++;
+	}
 
 	if (nr_parts == 0)
 		return 0;
@@ -57,6 +66,9 @@ static int parse_ofpart_partitions(struct mtd_info *master,
 		int len;
 		int a_cells, s_cells;
 
+		if (node_has_compatible(pp, &len))
+			continue;
+
 		reg = of_get_property(pp, "reg", &len);
 		if (!reg) {
 			nr_parts--;
-- 
1.7.9.5
