From: mathieu@codeaurora.org (Mathieu Olivari)
Date: Fri, 14 Aug 2015 12:08:44 -0700
Subject: [PATCH 3/3] mtd: add SMEM parser for QCOM platforms
In-Reply-To: <55CD386A.5070801@codeaurora.org>
References: <1439501620-24073-1-git-send-email-mathieu@codeaurora.org>
 <1439501620-24073-4-git-send-email-mathieu@codeaurora.org>
 <55CD386A.5070801@codeaurora.org>
Message-ID: <20150814190835.GA16804@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 05:38:02PM -0700, Stephen Boyd wrote:
> On 08/13/2015 02:33 PM, Mathieu Olivari wrote:
> >diff --git a/drivers/mtd/qcom_smem_part.c b/drivers/mtd/qcom_smem_part.c
> >new file mode 100644
> >index 0000000..6cbf610
> >--- /dev/null
> >+++ b/drivers/mtd/qcom_smem_part.c
> >
> >+#define SMEM_PARTS_MAX			32
> >+
> >+struct smem_partition {
> >+	char name[SMEM_PART_NAME_SZ];
> >+	uint32_t start;
> >+	uint32_t size;
> >+	uint32_t attr;
> 
> Is this little endian? __le32? I think so.
Yes. I'll make the change.
> 
> >+};
> >+
> >+struct smem_partition_table {
> >+	uint32_t magic[2];
> >+	uint32_t version;
> >+	uint32_t len;
> 
> Same for these being little endian. And if so, please make magic into a byte
> array of size 8 and then do a memcmp with another static byte array.
Done.
> 
> >+	struct smem_partition parts[SMEM_PARTS_MAX];
> >+};
> >+
> >+static int qcom_smem_get_flash_blksz(uint64_t **smem_blksz)
> 
> I don't know, but I prefer u64 because it's short and sweet. But I'm not the
> maintainer here.
Agreed.
> 
> >+{
> >+	int ret;
> >+	size_t size;
> >+
> >+	ret = qcom_smem_get(SMEM_HOST_APPS, SMEM_BOOT_FLASH_BLOCK_SIZE,
> >+			    (void **) smem_blksz, &size);
> 
> Is the cast necessary?
Compiler will issue a warning if it's not there.
> 
> >+
> >+	if (ret < 0) {
> >+		pr_err("Unable to read flash blksz from SMEM\n");
> >+		return -ENOENT;
> >+	}
> >+
> >+	if (size != sizeof(**smem_blksz)) {
> >+		pr_err("Invalid flash blksz size in SMEM\n");
> >+		return -EINVAL;
> >+	}
> >+
> >+	return 0;
> >+}
> >+
> >+static int qcom_smem_get_flash_type(uint64_t **smem_flash_type)
> >+{
> >+	int ret;
> >+	size_t size;
> >+
> >+	ret = qcom_smem_get(SMEM_HOST_APPS, SMEM_BOOT_FLASH_TYPE,
> >+			    (void **) smem_flash_type, &size);
> >+
> >+	if (ret < 0) {
> >+		pr_err("Unable to read flash type from SMEM\n");
> >+		return -ENOENT;
> >+	}
> >+
> >+	if (size != sizeof(**smem_flash_type)) {
> >+		pr_err("Invalid flash type size in SMEM\n");
> >+		return -EINVAL;
> >+	}
> >+
> >+	return 0;
> >+}
> >+
> >+static int qcom_smem_get_flash_partitions(struct smem_partition_table **pparts)
> >+{
> >+	int ret;
> >+	size_t size;
> >+
> >+	ret = qcom_smem_get(SMEM_HOST_APPS, SMEM_AARM_PARTITION_TABLE,
> >+			    (void **) pparts, &size);
> >+
> >+	if (ret < 0) {
> >+		pr_err("Unable to read partition table from SMEM\n");
> >+		return -ENOENT;
> >+	}
> >+
> >+	return 0;
> >+}
> >+
> >+static int of_dev_node_match(struct device *dev, void *data)
> >+{
> >+	return dev->of_node == data;
> >+}
> >+
> >+static bool is_spi_device(struct device_node *np)
> >+{
> >+	struct device *dev;
> >+
> >+	dev = bus_find_device(&spi_bus_type, NULL, np, of_dev_node_match);
> 
> I'm pretty sure this holds a reference to the device that needs to be
> released with put_device().
You're right. I'll add the corresponding put_device().
> 
> >+	return dev ? true : false;
> >+}
> >+
> >+static int parse_qcom_smem_partitions(struct mtd_info *master,
> >+				      struct mtd_partition **pparts,
> >+				      struct mtd_part_parser_data *data)
> >+{
> >+	struct smem_partition_table *smem_parts;
> >+	uint64_t *smem_flash_type, *smem_blksz;
> >+	struct mtd_partition *mtd_parts;
> >+	struct device_node *of_node = data->of_node;
> >+	int i, ret;
> >+
> >+	/*
> >+	 * SMEM will only store the partition table of the boot device.
> >+	 * If this is not the boot device, do not return any partition.
> >+	 */
> >+	ret = qcom_smem_get_flash_type(&smem_flash_type);
> >+	if (ret < 0)
> >+		return ret;
> >+
> >+	if ((*smem_flash_type == SMEM_FLASH_NAND && !mtd_type_is_nand(master))
> >+	    || (*smem_flash_type == SMEM_FLASH_SPI && !is_spi_device(of_node)))
> >+		return 0;
> >+
> >+	/*
> >+	 * Just for sanity purpose, make sure the block size in SMEM matches the
> >+	 * block size of the MTD device
> >+	 */
> >+	ret = qcom_smem_get_flash_blksz(&smem_blksz);
> >+	if (ret < 0)
> >+		return ret;
> >+
> >+	if (*smem_blksz != master->erasesize) {
> >+		pr_err("SMEM block size differs from MTD block size\n");
> >+		return -EINVAL;
> >+	}
> >+
> >+	/* Get partition pointer from SMEM */
> >+	ret = qcom_smem_get_flash_partitions(&smem_parts);
> >+	if (ret < 0)
> >+		return ret;
> >+
> >+	if (smem_parts->magic[0] != SMEM_PTABLE_MAGIC_1 ||
> >+	    smem_parts->magic[1] != SMEM_PTABLE_MAGIC_2) {
> >+		pr_err("SMEM partition magic invalid\n");
> >+		return -EINVAL;
> >+	}
> >+
> >+	/* Allocate and populate the mtd structures */
> >+	mtd_parts = kcalloc(smem_parts->len, sizeof(struct mtd_partition),
> 
> sizeof(*mtd_parts)?
OK.
> 
> >+			    GFP_KERNEL);
> >+	if (mtd_parts == NULL)
> 
> if (!mtd_parts) is more kernel style.
OK.
> 
> >+		return -ENOMEM;
> >+
> >+	for (i = 0; i < smem_parts->len; i++) {
> >+		struct smem_partition *part = &smem_parts->parts[i];
> >+
> >+		mtd_parts[i].name = part->name;
> >+		mtd_parts[i].size = part->size * (*smem_blksz);
> >+		mtd_parts[i].offset = part->start * (*smem_blksz);
> >+
> >+		/*
> >+		 * The last SMEM partition may have its size marked as
> >+		 * something like 0xffffffff, which means "until the end of the
> >+		 * flash device". In this case, truncate it.
> >+		 */
> >+		if (mtd_parts[i].offset + mtd_parts[i].size > master->size)
> >+			mtd_parts[i].size = master->size - mtd_parts[i].offset;
> 
> That is 7 mtd_parts[i]. instances. Consider making a local variable pointer
> instead. Actually we could make two pointers for smem_parts->part and
> mtd_parts and increment both in the loop to make tighter code.
OK; I'll simplify it by making a new pointer.
> 
> >+	}
> >+
> >+	*pparts = mtd_parts;
> 
> Oh we already have the pointer, so just do this assignment before iterating.
pparts is an argument; I'd rather not make double use of it for clarity
purpose. I'll create a new one similar to the SMEM one instead.
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
