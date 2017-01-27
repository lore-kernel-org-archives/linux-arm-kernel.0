From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 27 Jan 2017 10:10:37 +0100
Subject: [PATCH 2/2] memory: atmel-ebi: Properly handle multiple reference to
 the same CS
In-Reply-To: <1485508237-30178-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1485508237-30178-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1485508237-30178-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some devices are defining several sub-ranges within the same CS iomem
range. In this case, we should not duplicate the EBI device config.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/memory/atmel-ebi.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 2c4c9a1978bc..46657eaaedf6 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -449,12 +449,31 @@ static int at91_ebi_dev_setup(struct at91_ebi *ebi, struct device_node *np,
 	struct at91_ebi_dev_config conf = { };
 	struct device *dev = ebi->dev;
 	struct at91_ebi_dev *ebid;
-	int ret, numcs = 0, i;
+	unsigned long cslines = 0;
+	int ret, numcs = 0, nentries, i;
 	bool apply = false;
+	u32 cs;
 
-	numcs = of_property_count_elems_of_size(np, "reg",
-						reg_cells * sizeof(u32));
-	if (numcs <= 0) {
+	nentries = of_property_count_elems_of_size(np, "reg",
+						   reg_cells * sizeof(u32));
+	for (i = 0; i < nentries; i++) {
+		ret = of_property_read_u32_index(np, "reg", i * reg_cells,
+						 &cs);
+		if (ret)
+			return ret;
+
+		if (cs >= AT91_MATRIX_EBI_NUM_CS ||
+		    !(ebi->caps->available_cs & BIT(cs))) {
+			dev_err(dev, "invalid reg property in %s\n",
+				np->full_name);
+			return -EINVAL;
+		}
+
+		if (!test_and_set_bit(cs, &cslines))
+			numcs++;
+	}
+
+	if (!numcs) {
 		dev_err(dev, "invalid reg property in %s\n", np->full_name);
 		return -EINVAL;
 	}
@@ -473,21 +492,8 @@ static int at91_ebi_dev_setup(struct at91_ebi *ebi, struct device_node *np,
 	else if (ret)
 		apply = true;
 
-	for (i = 0; i < numcs; i++) {
-		u32 cs;
-
-		ret = of_property_read_u32_index(np, "reg", i * reg_cells,
-						 &cs);
-		if (ret)
-			return ret;
-
-		if (cs > AT91_MATRIX_EBI_NUM_CS ||
-		    !(ebi->caps->available_cs & BIT(cs))) {
-			dev_err(dev, "invalid reg property in %s\n",
-				np->full_name);
-			return -EINVAL;
-		}
-
+	i = 0;
+	for_each_set_bit(cs, &cslines, AT91_MATRIX_EBI_NUM_CS) {
 		ebid->configs[i].cs = cs;
 
 		if (apply) {
@@ -506,6 +512,8 @@ static int at91_ebi_dev_setup(struct at91_ebi *ebi, struct device_node *np,
 		if (ebi->ebi_csa && apply)
 			regmap_field_update_bits(ebi->ebi_csa,
 						 BIT(cs), 0);
+
+		i++;
 	}
 
 	list_add_tail(&ebid->node, &ebi->devs);
-- 
2.7.4
