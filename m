From: sergio.prado@e-labworks.com (Sergio Prado)
Date: Sat, 17 Sep 2016 12:22:40 -0300
Subject: [PATCH] mtd: s3c2410: add device tree support
Message-ID: <1474125760-28168-1-git-send-email-sergio.prado@e-labworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested on FriendlyARM Mini2440

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
---
 .../devicetree/bindings/mtd/samsung-s3c2410.txt    |  70 +++++++++++
 drivers/mtd/nand/s3c2410.c                         | 129 ++++++++++++++++++++-
 include/linux/platform_data/mtd-nand-s3c2410.h     |   1 +
 3 files changed, 195 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt

diff --git a/Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt b/Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt
new file mode 100644
index 000000000000..1c39f6cf483b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt
@@ -0,0 +1,70 @@
+* Samsung S3C2410 and compatible NAND flash controller
+
+Required properties:
+- compatible : The possible values are:
+	"samsung,s3c2410-nand"
+	"samsung,s3c2412-nand"
+	"samsung,s3c2440-nand"
+	"samsung,s3c6400-nand"
+- reg : register's location and length.
+- #address-cells, #size-cells : see nand.txt
+- clocks : phandle to the nand controller clock
+- clock-names : must contain "nand"
+
+Optional properties:
+- samsung,tacls : time for active CLE/ALE to nWE/nOE
+- samsung,twrph0 : active time for nWE/nOE
+- samsung,twrph1 : time for release CLE/ALE from nWE/nOE inactive
+- samsung,ignore_unset_ecc : boolean to ignore error when we have
+                             0xff,0xff,0xff read ECC, on the
+                             assumption that it is an un-eccd page
+
+Optional children nodes:
+Children nodes representing the available nand chips.
+
+Optional children properties:
+- nand-ecc-mode : see nand.txt
+- nand-on-flash-bbt : see nand.txt
+
+Each children device node may optionally contain a 'partitions' sub-node,
+which further contains sub-nodes describing the flash partition mapping.
+See partition.txt for more detail.
+
+Example:
+
+nand at 4e000000 {
+	compatible = "samsung,s3c2440-nand";
+	reg = <0x4e000000 0x40>;
+
+	#address-cells = <1>;
+        #size-cells = <0>;
+
+	clocks = <&clocks HCLK_NAND>;
+	clock-names = "nand";
+
+	samsung,tacls = <0>;
+	samsung,twrph0 = <25>;
+	samsung,twrph1 = <15>;
+	samsung,ignore_unset_ecc;
+
+	nand at 0 {
+		nand-ecc-mode = "soft";
+		nand-on-flash-bbt;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "u-boot";
+				reg = <0 0x040000>;
+			};
+
+			partition at 40000 {
+				label = "kernel";
+				reg = <0x040000 0x500000>;
+			};
+		};
+	};
+};
diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index d9309cf0ce2e..ecbb9c9c1e9a 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -39,6 +39,8 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
@@ -185,6 +187,26 @@ struct s3c2410_nand_info {
 #endif
 };
 
+struct s3c24XX_nand_devtype_data {
+	enum s3c_cpu_type type;
+};
+
+struct s3c24XX_nand_devtype_data s3c2410_nand_devtype_data = {
+	.type = TYPE_S3C2410,
+};
+
+struct s3c24XX_nand_devtype_data s3c2412_nand_devtype_data = {
+	.type = TYPE_S3C2412,
+};
+
+struct s3c24XX_nand_devtype_data s3c2440_nand_devtype_data = {
+	.type = TYPE_S3C2440,
+};
+
+struct s3c24XX_nand_devtype_data s3c6400_nand_devtype_data = {
+	.type = TYPE_S3C2412,
+};
+
 /* conversion functions */
 
 static struct s3c2410_nand_mtd *s3c2410_nand_mtd_toours(struct mtd_info *mtd)
@@ -813,6 +835,8 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 	struct nand_chip *chip = &nmtd->chip;
 	void __iomem *regs = info->regs;
 
+	nand_set_flash_node(chip, set->of_node);
+
 	chip->write_buf    = s3c2410_nand_write_buf;
 	chip->read_buf     = s3c2410_nand_read_buf;
 	chip->select_chip  = s3c2410_nand_select_chip;
@@ -947,6 +971,96 @@ static void s3c2410_nand_update_chip(struct s3c2410_nand_info *info,
 	}
 }
 
+#ifdef CONFIG_OF_MTD
+static const struct of_device_id s3c24xx_nand_dt_ids[] = {
+	{
+		.compatible = "samsung,s3c2410-nand",
+		.data = &s3c2410_nand_devtype_data,
+	}, {
+		.compatible = "samsung,s3c2412-nand",
+		.data = &s3c2412_nand_devtype_data,
+	}, {
+		.compatible = "samsung,s3c2440-nand",
+		.data = &s3c2440_nand_devtype_data,
+	}, {
+		.compatible = "samsung,s3c6400-nand",
+		.data = &s3c6400_nand_devtype_data,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, s3c24xx_nand_dt_ids);
+
+static int s3c24xx_nand_probe_dt(struct platform_device *pdev)
+{
+	const struct s3c24XX_nand_devtype_data *devtype_data;
+	struct s3c2410_platform_nand *pdata;
+	struct s3c2410_nand_info *info = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node, *child;
+	const struct of_device_id *of_id;
+	struct s3c2410_nand_set *sets;
+
+	of_id = of_match_device(s3c24xx_nand_dt_ids, &pdev->dev);
+	if (!of_id)
+		return 1;
+
+	devtype_data = of_id->data;
+	info->cpu_type = devtype_data->type;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pdev->dev.platform_data = pdata;
+
+	of_property_read_u32(np, "samsung,tacls",  &pdata->tacls);
+	of_property_read_u32(np, "samsung,twrph0", &pdata->twrph0);
+	of_property_read_u32(np, "samsung,twrph1", &pdata->twrph1);
+
+	if (of_get_property(np, "samsung,ignore_unset_ecc", NULL))
+		pdata->ignore_unset_ecc = 1;
+
+	pdata->nr_sets = of_get_child_count(np);
+	if (!pdata->nr_sets)
+		return 0;
+
+	sets = devm_kzalloc(&pdev->dev, sizeof(*sets) * pdata->nr_sets,
+			   GFP_KERNEL);
+	if (!sets)
+		return -ENOMEM;
+
+	pdata->sets = sets;
+
+	for_each_available_child_of_node(np, child) {
+
+		sets->name = (char *)child->name;
+		sets->of_node = child;
+		sets->nr_chips = 1;
+
+		if (!of_property_match_string(child, "nand-ecc-mode", "none"))
+			sets->disable_ecc = 1;
+
+		if (of_get_property(child, "nand-on-flash-bbt", NULL))
+			sets->flash_bbt = 1;
+
+		sets++;
+	}
+
+	return 0;
+}
+#else
+static int s3c24xx_nand_probe_dt(struct platform_device *pdev)
+{
+	return 1;
+}
+#endif
+
+static void s3c24xx_nand_probe_pdata(struct platform_device *pdev)
+{
+	struct s3c2410_nand_info *info = platform_get_drvdata(pdev);
+
+	info->cpu_type = platform_get_device_id(pdev)->driver_data;
+}
+
 /* s3c24xx_nand_probe
  *
  * called by device layer when it finds a device matching
@@ -956,8 +1070,7 @@ static void s3c2410_nand_update_chip(struct s3c2410_nand_info *info,
 */
 static int s3c24xx_nand_probe(struct platform_device *pdev)
 {
-	struct s3c2410_platform_nand *plat = to_nand_plat(pdev);
-	enum s3c_cpu_type cpu_type;
+	struct s3c2410_platform_nand *plat;
 	struct s3c2410_nand_info *info;
 	struct s3c2410_nand_mtd *nmtd;
 	struct s3c2410_nand_set *sets;
@@ -967,8 +1080,6 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
 	int nr_sets;
 	int setno;
 
-	cpu_type = platform_get_device_id(pdev)->driver_data;
-
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (info == NULL) {
 		err = -ENOMEM;
@@ -991,6 +1102,14 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
 
 	s3c2410_nand_clk_set_state(info, CLOCK_ENABLE);
 
+	err = s3c24xx_nand_probe_dt(pdev);
+	if (err > 0)
+		s3c24xx_nand_probe_pdata(pdev);
+	else if (err < 0)
+		goto exit_error;
+
+	plat = to_nand_plat(pdev);
+
 	/* allocate and map the resource */
 
 	/* currently we assume we have the one resource */
@@ -999,7 +1118,6 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
 
 	info->device	= &pdev->dev;
 	info->platform	= plat;
-	info->cpu_type	= cpu_type;
 
 	info->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(info->regs)) {
@@ -1156,6 +1274,7 @@ static struct platform_driver s3c24xx_nand_driver = {
 	.id_table	= s3c24xx_driver_ids,
 	.driver		= {
 		.name	= "s3c24xx-nand",
+		.of_match_table = s3c24xx_nand_dt_ids,
 	},
 };
 
diff --git a/include/linux/platform_data/mtd-nand-s3c2410.h b/include/linux/platform_data/mtd-nand-s3c2410.h
index c55e42ee57fa..9d20871e4bbd 100644
--- a/include/linux/platform_data/mtd-nand-s3c2410.h
+++ b/include/linux/platform_data/mtd-nand-s3c2410.h
@@ -40,6 +40,7 @@ struct s3c2410_nand_set {
 	char			*name;
 	int			*nr_map;
 	struct mtd_partition	*partitions;
+	struct device_node	*of_node;
 };
 
 struct s3c2410_platform_nand {
-- 
1.9.1
