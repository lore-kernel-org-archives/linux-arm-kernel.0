From: mathieu@codeaurora.org (Mathieu Olivari)
Date: Tue, 18 Aug 2015 14:04:20 -0700
Subject: [PATCH v4 3/3] mtd: add SMEM parser for QCOM platforms
In-Reply-To: <1439931860-7473-1-git-send-email-mathieu@codeaurora.org>
References: <1439931860-7473-1-git-send-email-mathieu@codeaurora.org>
Message-ID: <1439931860-7473-4-git-send-email-mathieu@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On QCOM platforms using MTD devices storage (such as IPQ806x), SMEM is
used to store partition layout. This new parser can now be used to read
SMEM and use it to register an MTD layout according to its content.

Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
---

Notes:
    v2:
    *Release the SPI device reference after looking it up (put_device())
    *Represent SMEM data as __le32 rather than u32
    *Move new DT nodes in their proper respective location
    *Address readability concerns in MTD parser
    
    v3:
    *Redefine SMEM functions prototypes for better readability
    *Duplicate MTD name instead of pointing to SMEM string location in case
     mtd layer tries to free it
    *Rework some of the comments
    
    v4:
    *Fix case in the license string

 drivers/mtd/Kconfig          |   7 ++
 drivers/mtd/Makefile         |   1 +
 drivers/mtd/qcom_smem_part.c | 246 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 254 insertions(+)
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
index 0000000..b4f8acc
--- /dev/null
+++ b/drivers/mtd/qcom_smem_part.c
@@ -0,0 +1,246 @@
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
+#define QCOM_SMEM_GLOBAL		0
+
+/* SMEM items index */
+#define SMEM_AARM_PARTITION_TABLE	9
+#define SMEM_BOOT_FLASH_TYPE		421
+#define SMEM_BOOT_FLASH_BLOCK_SIZE	424
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
+	__le32 start;
+	__le32 size;
+	__le32 attr;
+};
+
+struct smem_partition_table {
+	u8 magic[8];
+	__le32 version;
+	__le32 len;
+	struct smem_partition parts[SMEM_PARTS_MAX];
+};
+
+/* SMEM Magic values in partition table */
+static const u8 SMEM_PTABLE_MAGIC[] = {
+	0xaa, 0x73, 0xee, 0x55,
+	0xdb, 0xbd, 0x5e, 0xe3,
+};
+
+static int qcom_smem_get_flash_blksz(void)
+{
+	int ret;
+	size_t size;
+	u64 *smem_blksz;
+
+	ret = qcom_smem_get(QCOM_SMEM_GLOBAL, SMEM_BOOT_FLASH_BLOCK_SIZE,
+			    (void **) &smem_blksz, &size);
+
+	if (ret < 0) {
+		pr_err("Unable to read flash blksz from SMEM\n");
+		return -ENOENT;
+	}
+
+	if (size != sizeof(*smem_blksz)) {
+		pr_err("Invalid flash blksz size in SMEM\n");
+		return -EINVAL;
+	}
+
+	/* Sanity check block size value before casting it */
+	if (*smem_blksz > INT_MAX) {
+		pr_err("Invalid flash block size in SMEM\n");
+		return -EINVAL;
+	}
+
+	return (int) *smem_blksz;
+}
+
+static int qcom_smem_get_flash_type(void)
+{
+	int ret;
+	size_t size;
+	u64 *smem_flash_type;
+
+	ret = qcom_smem_get(QCOM_SMEM_GLOBAL, SMEM_BOOT_FLASH_TYPE,
+			    (void **) &smem_flash_type, &size);
+
+	if (ret < 0) {
+		pr_err("Unable to read flash type from SMEM\n");
+		return -ENOENT;
+	}
+
+	if (size != sizeof(*smem_flash_type)) {
+		pr_err("Invalid flash type size in SMEM\n");
+		return -EINVAL;
+	}
+
+	/* Sanity check flash type value before casting it */
+	if (*smem_flash_type > INT_MAX) {
+		pr_err("Invalid flash type in SMEM\n");
+		return -EINVAL;
+	}
+
+	return (int) *smem_flash_type;
+}
+
+static struct smem_partition *qcom_smem_get_flash_partitions(size_t *count)
+{
+	struct smem_partition_table *smem_parts;
+	int ret;
+
+	ret = qcom_smem_get(QCOM_SMEM_GLOBAL, SMEM_AARM_PARTITION_TABLE,
+			    (void **) &smem_parts, NULL);
+
+	if (ret < 0) {
+		pr_err("Unable to read partition table from SMEM\n");
+		return ERR_PTR(-ENOENT);
+	}
+
+	if (memcmp(SMEM_PTABLE_MAGIC, smem_parts->magic,
+		   sizeof(SMEM_PTABLE_MAGIC))) {
+		pr_err("SMEM partition magic invalid\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (le32_to_cpu(smem_parts->version) != 3) {
+		pr_err("SMEM version unsupported\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	*count = le32_to_cpu(smem_parts->len);
+
+	return smem_parts->parts;
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
+	if (!dev)
+		return false;
+
+	put_device(dev);
+	return true;
+}
+
+static int parse_qcom_smem_partitions(struct mtd_info *master,
+				      struct mtd_partition **pparts,
+				      struct mtd_part_parser_data *data)
+{
+	struct smem_partition *smem_part;
+	int smem_flash_type, smem_blksz;
+	size_t nbparts = 0, len;
+	struct mtd_partition *mtd_parts;
+	struct device_node *of_node = data->of_node;
+
+	/* Only parse partitions on the specified memory type */
+	smem_flash_type = qcom_smem_get_flash_type();
+	if (smem_flash_type < 0)
+		return smem_flash_type;
+
+	if ((smem_flash_type == SMEM_FLASH_NAND && !mtd_type_is_nand(master))
+	    || (smem_flash_type == SMEM_FLASH_SPI && !is_spi_device(of_node)))
+		return 0;
+
+	/* Make sure the block size in SMEM matches the block size in MTD */
+	smem_blksz = qcom_smem_get_flash_blksz();
+	if (smem_blksz < 0)
+		return smem_blksz;
+
+	if (smem_blksz != master->erasesize) {
+		pr_err("SMEM block size differs from MTD block size\n");
+		return -EINVAL;
+	}
+
+	/* Get partition pointer from SMEM */
+	smem_part = qcom_smem_get_flash_partitions(&nbparts);
+	if (IS_ERR_OR_NULL(smem_part))
+		return -EINVAL;
+
+	/* Allocate and populate the mtd structures */
+	mtd_parts = kcalloc(nbparts, sizeof(*mtd_parts), GFP_KERNEL);
+	if (!mtd_parts)
+		return -ENOMEM;
+
+	*pparts = mtd_parts;
+	len = nbparts;
+
+	while (len--) {
+		mtd_parts->name = kstrdup(smem_part->name, GFP_KERNEL);
+		mtd_parts->size = le32_to_cpu(smem_part->size) * smem_blksz;
+		mtd_parts->offset = le32_to_cpu(smem_part->start) * smem_blksz;
+
+		/*
+		 * The last SMEM partition may have its size marked as
+		 * something like 0xffffffff, which means "until the end of the
+		 * flash device". In this case, truncate it.
+		 */
+		if (mtd_parts->offset + mtd_parts->size > master->size)
+			mtd_parts->size = master->size - mtd_parts->offset;
+
+		smem_part++;
+		mtd_parts++;
+	}
+
+	return nbparts;
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
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Mathieu Olivari <mathieu@codeaurora.org>");
+MODULE_DESCRIPTION("Parsing code for SMEM based partition tables");
-- 
2.1.4
