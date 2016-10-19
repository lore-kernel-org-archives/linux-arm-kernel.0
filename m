From: sergio.prado@e-labworks.com (Sergio Prado)
Date: Wed, 19 Oct 2016 17:52:05 -0200
Subject: [PATCH v2 3/3] mtd: s3c2410: parse the device configuration from OF
 node
In-Reply-To: <1476906725-22613-1-git-send-email-sergio.prado@e-labworks.com>
References: <1476906725-22613-1-git-send-email-sergio.prado@e-labworks.com>
Message-ID: <1476906725-22613-4-git-send-email-sergio.prado@e-labworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allows configuring Samsung's s3c2410 memory controller using a
devicetree.

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
---
 drivers/mtd/nand/s3c2410.c                     | 155 ++++++++++++++++++++++---
 include/linux/platform_data/mtd-nand-s3c2410.h |   1 +
 2 files changed, 140 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index 371db0d48135..52f768f01b0d 100644
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
@@ -185,6 +187,22 @@ struct s3c2410_nand_info {
 #endif
 };
 
+struct s3c24XX_nand_devtype_data {
+	enum s3c_cpu_type type;
+};
+
+static const struct s3c24XX_nand_devtype_data s3c2410_nand_devtype_data = {
+	.type = TYPE_S3C2410,
+};
+
+static const struct s3c24XX_nand_devtype_data s3c2412_nand_devtype_data = {
+	.type = TYPE_S3C2412,
+};
+
+static const struct s3c24XX_nand_devtype_data s3c2440_nand_devtype_data = {
+	.type = TYPE_S3C2440,
+};
+
 /* conversion functions */
 
 static struct s3c2410_nand_mtd *s3c2410_nand_mtd_toours(struct mtd_info *mtd)
@@ -794,6 +812,34 @@ static int s3c2410_nand_add_partition(struct s3c2410_nand_info *info,
 	return -ENODEV;
 }
 
+static int s3c2410_nand_setup_data_interface(struct mtd_info *mtd,
+					     const struct nand_data_interface *conf,
+					     bool check_only)
+{
+	struct s3c2410_nand_info *info = s3c2410_nand_mtd_toinfo(mtd);
+	struct s3c2410_platform_nand *pdata = info->platform;
+	struct device_node *np = info->device->of_node;
+	const struct nand_sdr_timings *timings;
+	int tacls;
+
+	/* auto-detect timings when booting with a device tree */
+	if (np) {
+		timings = nand_get_sdr_timings(conf);
+		if (IS_ERR(timings))
+			return -ENOTSUPP;
+
+		tacls = timings->tCLS_min - timings->tWP_min;
+		if (tacls < 0)
+			tacls = 0;
+
+		pdata->tacls  = DIV_ROUND_UP(tacls, 1000);
+		pdata->twrph0 = DIV_ROUND_UP(timings->tWP_min, 1000);
+		pdata->twrph1 = DIV_ROUND_UP(timings->tCLH_min, 1000);
+	}
+
+	return 0;
+}
+
 /**
  * s3c2410_nand_init_chip - initialise a single instance of an chip
  * @info: The base NAND controller the chip is on.
@@ -811,9 +857,12 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 	struct nand_chip *chip = &nmtd->chip;
 	void __iomem *regs = info->regs;
 
+	nand_set_flash_node(chip, set->of_node);
+
 	chip->write_buf    = s3c2410_nand_write_buf;
 	chip->read_buf     = s3c2410_nand_read_buf;
 	chip->select_chip  = s3c2410_nand_select_chip;
+	chip->setup_data_interface = s3c2410_nand_setup_data_interface;
 	chip->chip_delay   = 50;
 	nand_set_controller_data(chip, nmtd);
 	chip->options	   = set->options;
@@ -859,12 +908,9 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 	chip->ecc.mode = info->platform->ecc_mode;
 
 	/* If you use u-boot BBT creation code, specifying this flag will
-	 * let the kernel fish out the BBT from the NAND, and also skip the
-	 * full NAND scan that can take 1/2s or so. Little things... */
-	if (set->flash_bbt) {
+	 * let the kernel fish out the BBT from the NAND */
+	if (set->flash_bbt)
 		chip->bbt_options |= NAND_BBT_USE_FLASH;
-		chip->options |= NAND_SKIP_BBTSCAN;
-	}
 }
 
 /**
@@ -943,6 +989,77 @@ static int s3c2410_nand_update_chip(struct s3c2410_nand_info *info,
 		return -EINVAL;
 	}
 
+	if (chip->bbt_options & NAND_BBT_USE_FLASH)
+		chip->options |= NAND_SKIP_BBTSCAN;
+
+	return 0;
+}
+
+static const struct of_device_id s3c24xx_nand_dt_ids[] = {
+	{
+		.compatible = "samsung,s3c2410-nand",
+		.data = &s3c2410_nand_devtype_data,
+	}, {
+		.compatible = "samsung,s3c2412-nand", /* also compatible with s3c6400 */
+		.data = &s3c2412_nand_devtype_data,
+	}, {
+		.compatible = "samsung,s3c2440-nand",
+		.data = &s3c2440_nand_devtype_data,
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
+	struct s3c2410_nand_set *sets;
+
+	devtype_data = of_device_get_match_data(&pdev->dev);
+	if (!devtype_data)
+		return -ENODEV;
+
+	info->cpu_type = devtype_data->type;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pdev->dev.platform_data = pdata;
+
+	pdata->nr_sets = of_get_child_count(np);
+	if (!pdata->nr_sets)
+		return 0;
+
+	sets = devm_kzalloc(&pdev->dev, sizeof(*sets) * pdata->nr_sets, GFP_KERNEL);
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
+		of_node_get(child);
+
+		sets++;
+	}
+
+	return 0;
+}
+
+static int s3c24xx_nand_probe_pdata(struct platform_device *pdev)
+{
+	struct s3c2410_nand_info *info = platform_get_drvdata(pdev);
+
+	info->cpu_type = platform_get_device_id(pdev)->driver_data;
+
 	return 0;
 }
 
@@ -955,8 +1072,7 @@ static int s3c2410_nand_update_chip(struct s3c2410_nand_info *info,
 */
 static int s3c24xx_nand_probe(struct platform_device *pdev)
 {
-	struct s3c2410_platform_nand *plat = to_nand_plat(pdev);
-	enum s3c_cpu_type cpu_type;
+	struct s3c2410_platform_nand *plat;
 	struct s3c2410_nand_info *info;
 	struct s3c2410_nand_mtd *nmtd;
 	struct s3c2410_nand_set *sets;
@@ -966,8 +1082,6 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
 	int nr_sets;
 	int setno;
 
-	cpu_type = platform_get_device_id(pdev)->driver_data;
-
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (info == NULL) {
 		err = -ENOMEM;
@@ -989,6 +1103,16 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
 
 	s3c2410_nand_clk_set_state(info, CLOCK_ENABLE);
 
+	if (pdev->dev.of_node)
+		err = s3c24xx_nand_probe_dt(pdev);
+	else
+		err = s3c24xx_nand_probe_pdata(pdev);
+
+	if (err)
+		goto exit_error;
+
+	plat = to_nand_plat(pdev);
+
 	/* allocate and map the resource */
 
 	/* currently we assume we have the one resource */
@@ -997,7 +1121,6 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
 
 	info->device	= &pdev->dev;
 	info->platform	= plat;
-	info->cpu_type	= cpu_type;
 
 	info->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(info->regs)) {
@@ -1007,12 +1130,6 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "mapped registers at %p\n", info->regs);
 
-	/* initialise the hardware */
-
-	err = s3c2410_nand_inithw(info);
-	if (err != 0)
-		goto exit_error;
-
 	sets = (plat != NULL) ? plat->sets : NULL;
 	nr_sets = (plat != NULL) ? plat->nr_sets : 1;
 
@@ -1056,6 +1173,11 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
 			sets++;
 	}
 
+	/* initialise the hardware */
+	err = s3c2410_nand_inithw(info);
+	if (err != 0)
+		goto exit_error;
+
 	err = s3c2410_nand_cpufreq_register(info);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to init cpufreq support\n");
@@ -1156,6 +1278,7 @@ static int s3c24xx_nand_resume(struct platform_device *dev)
 	.id_table	= s3c24xx_driver_ids,
 	.driver		= {
 		.name	= "s3c24xx-nand",
+		.of_match_table = s3c24xx_nand_dt_ids,
 	},
 };
 
diff --git a/include/linux/platform_data/mtd-nand-s3c2410.h b/include/linux/platform_data/mtd-nand-s3c2410.h
index 729af13d1773..f01659026b26 100644
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
