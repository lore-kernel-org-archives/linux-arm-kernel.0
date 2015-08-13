From: mathieu@codeaurora.org (Mathieu Olivari)
Date: Thu, 13 Aug 2015 14:33:40 -0700
Subject: [PATCH 3/3] mtd: add SMEM parser for QCOM platforms
In-Reply-To: <1439501620-24073-1-git-send-email-mathieu@codeaurora.org>
References: <1439501620-24073-1-git-send-email-mathieu@codeaurora.org>
Message-ID: <1439501620-24073-4-git-send-email-mathieu@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On QCOM platforms using MTD devices storage (such as IPQ806x), SMEM is
used to store partition layout. This new parser can now be used to read
SMEM and use it to register an MTD layout according to its content.

Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
---
 drivers/mtd/Kconfig          |   7 ++
 drivers/mtd/Makefile         |   1 +
 drivers/mtd/qcom_smem_part.c | 224 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 232 insertions(+)
 create mode 100644 drivers/mtd/qcom_smem_part.c

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index a03ad29..debc887 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -155,6 +155,13 @@ config MTD_BCM47XX_PARTS
 	  This provides partitions parser for devices based on BCM47xx
 	  boards.
 
+config MTD_QCOM_SMEM_PARTS
+	tristate "QCOM SMEM partitioning support"
+	depends on QCOM_SMEM
+	help
+	  This provides partitions parser for QCOM devices using SMEM
+	  such as IPQ806x.
+
 comment "User Modules And Translation Layers"
 
 #
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index 99bb9a1..b3c7de4 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_MTD_AFS_PARTS)	+= afs.o
 obj-$(CONFIG_MTD_AR7_PARTS)	+= ar7part.o
 obj-$(CONFIG_MTD_BCM63XX_PARTS)	+= bcm63xxpart.o
 obj-$(CONFIG_MTD_BCM47XX_PARTS)	+= bcm47xxpart.o
+obj-$(CONFIG_MTD_QCOM_SMEM_PARTS) += qcom_smem_part.o
 
 # 'Users' - code which presents functionality to userspace.
 obj-$(CONFIG_MTD_BLKDEVS)	+= mtd_blkdevs.o
diff --git a/drivers/mtd/qcom_smem_part.c b/drivers/mtd/qcom_smem_part.c
new file mode 100644
index 0000000..6cbf610
--- /dev/null
+++ b/drivers/mtd/qcom_smem_part.c
@@ -0,0 +1,224 @@
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/spi/spi.h>
+#include <linux/module.h>
+
+#include <linux/soc/qcom/smem.h>
+
+/* Processor/host identifier for the application processor */
+#define SMEM_HOST_APPS			0
+
+/* SMEM items index */
+#define SMEM_AARM_PARTITION_TABLE	9
+#define SMEM_BOOT_FLASH_TYPE		421
+#define SMEM_BOOT_FLASH_BLOCK_SIZE	424
+
+/* SMEM Magic values in partition table */
+#define SMEM_PTABLE_MAGIC_1		0x55ee73aa
+#define SMEM_PTABLE_MAGIC_2		0xe35ebddb
+
+/* SMEM Flash types */
+#define SMEM_FLASH_NAND			2
+#define SMEM_FLASH_SPI			6
+
+#define SMEM_PART_NAME_SZ		16
+#define SMEM_PARTS_MAX			32
+
+struct smem_partition {
+	char name[SMEM_PART_NAME_SZ];
+	uint32_t start;
+	uint32_t size;
+	uint32_t attr;
+};
+
+struct smem_partition_table {
+	uint32_t magic[2];
+	uint32_t version;
+	uint32_t len;
+	struct smem_partition parts[SMEM_PARTS_MAX];
+};
+
+static int qcom_smem_get_flash_blksz(uint64_t **smem_blksz)
+{
+	int ret;
+	size_t size;
+
+	ret = qcom_smem_get(SMEM_HOST_APPS, SMEM_BOOT_FLASH_BLOCK_SIZE,
+			    (void **) smem_blksz, &size);
+
+	if (ret < 0) {
+		pr_err("Unable to read flash blksz from SMEM\n");
+		return -ENOENT;
+	}
+
+	if (size != sizeof(**smem_blksz)) {
+		pr_err("Invalid flash blksz size in SMEM\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int qcom_smem_get_flash_type(uint64_t **smem_flash_type)
+{
+	int ret;
+	size_t size;
+
+	ret = qcom_smem_get(SMEM_HOST_APPS, SMEM_BOOT_FLASH_TYPE,
+			    (void **) smem_flash_type, &size);
+
+	if (ret < 0) {
+		pr_err("Unable to read flash type from SMEM\n");
+		return -ENOENT;
+	}
+
+	if (size != sizeof(**smem_flash_type)) {
+		pr_err("Invalid flash type size in SMEM\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int qcom_smem_get_flash_partitions(struct smem_partition_table **pparts)
+{
+	int ret;
+	size_t size;
+
+	ret = qcom_smem_get(SMEM_HOST_APPS, SMEM_AARM_PARTITION_TABLE,
+			    (void **) pparts, &size);
+
+	if (ret < 0) {
+		pr_err("Unable to read partition table from SMEM\n");
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+static int of_dev_node_match(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+static bool is_spi_device(struct device_node *np)
+{
+	struct device *dev;
+
+	dev = bus_find_device(&spi_bus_type, NULL, np, of_dev_node_match);
+	return dev ? true : false;
+}
+
+static int parse_qcom_smem_partitions(struct mtd_info *master,
+				      struct mtd_partition **pparts,
+				      struct mtd_part_parser_data *data)
+{
+	struct smem_partition_table *smem_parts;
+	uint64_t *smem_flash_type, *smem_blksz;
+	struct mtd_partition *mtd_parts;
+	struct device_node *of_node = data->of_node;
+	int i, ret;
+
+	/*
+	 * SMEM will only store the partition table of the boot device.
+	 * If this is not the boot device, do not return any partition.
+	 */
+	ret = qcom_smem_get_flash_type(&smem_flash_type);
+	if (ret < 0)
+		return ret;
+
+	if ((*smem_flash_type == SMEM_FLASH_NAND && !mtd_type_is_nand(master))
+	    || (*smem_flash_type == SMEM_FLASH_SPI && !is_spi_device(of_node)))
+		return 0;
+
+	/*
+	 * Just for sanity purpose, make sure the block size in SMEM matches the
+	 * block size of the MTD device
+	 */
+	ret = qcom_smem_get_flash_blksz(&smem_blksz);
+	if (ret < 0)
+		return ret;
+
+	if (*smem_blksz != master->erasesize) {
+		pr_err("SMEM block size differs from MTD block size\n");
+		return -EINVAL;
+	}
+
+	/* Get partition pointer from SMEM */
+	ret = qcom_smem_get_flash_partitions(&smem_parts);
+	if (ret < 0)
+		return ret;
+
+	if (smem_parts->magic[0] != SMEM_PTABLE_MAGIC_1 ||
+	    smem_parts->magic[1] != SMEM_PTABLE_MAGIC_2) {
+		pr_err("SMEM partition magic invalid\n");
+		return -EINVAL;
+	}
+
+	/* Allocate and populate the mtd structures */
+	mtd_parts = kcalloc(smem_parts->len, sizeof(struct mtd_partition),
+			    GFP_KERNEL);
+	if (mtd_parts == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < smem_parts->len; i++) {
+		struct smem_partition *part = &smem_parts->parts[i];
+
+		mtd_parts[i].name = part->name;
+		mtd_parts[i].size = part->size * (*smem_blksz);
+		mtd_parts[i].offset = part->start * (*smem_blksz);
+
+		/*
+		 * The last SMEM partition may have its size marked as
+		 * something like 0xffffffff, which means "until the end of the
+		 * flash device". In this case, truncate it.
+		 */
+		if (mtd_parts[i].offset + mtd_parts[i].size > master->size)
+			mtd_parts[i].size = master->size - mtd_parts[i].offset;
+	}
+
+	*pparts = mtd_parts;
+
+	return smem_parts->len;
+}
+
+static struct mtd_part_parser qcom_smem_parser = {
+	.owner = THIS_MODULE,
+	.parse_fn = parse_qcom_smem_partitions,
+	.name = "qcom-smem",
+};
+
+static int __init qcom_smem_parser_init(void)
+{
+	register_mtd_parser(&qcom_smem_parser);
+	return 0;
+}
+
+static void __exit qcom_smem_parser_exit(void)
+{
+	deregister_mtd_parser(&qcom_smem_parser);
+}
+
+module_init(qcom_smem_parser_init);
+module_exit(qcom_smem_parser_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Olivari <mathieu@codeaurora.org>");
+MODULE_DESCRIPTION("Parsing code for SMEM based partition tables");
-- 
2.1.4
