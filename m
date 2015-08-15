From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Fri, 14 Aug 2015 22:48:17 -0700
Subject: [PATCH 3/3] mtd: add SMEM parser for QCOM platforms
In-Reply-To: <1439599573-3932-4-git-send-email-mathieu@codeaurora.org>
References: <1439599573-3932-1-git-send-email-mathieu@codeaurora.org>
 <1439599573-3932-4-git-send-email-mathieu@codeaurora.org>
Message-ID: <20150815054817.GM13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 14 Aug 17:46 PDT 2015, Mathieu Olivari wrote:

> On QCOM platforms using MTD devices storage (such as IPQ806x), SMEM is
> used to store partition layout. This new parser can now be used to read
> SMEM and use it to register an MTD layout according to its content.
> 

Nice to see another user of the smem code :)

> diff --git a/drivers/mtd/qcom_smem_part.c b/drivers/mtd/qcom_smem_part.c
[..]
> +
> +/* Processor/host identifier for the application processor */
> +#define SMEM_HOST_APPS			0

This makes me wonder if there will ever be an apps partition. I would
have picked QCOM_SMEM_HOST_ANY, but I don't know what future platforms
might hold for us.


And as a side note, I think I will propose that we rename that define
QCOM_SMEM_GLOBAL.

> +
> +/* SMEM items index */
> +#define SMEM_AARM_PARTITION_TABLE	9
> +#define SMEM_BOOT_FLASH_TYPE		421
> +#define SMEM_BOOT_FLASH_BLOCK_SIZE	424
> +
> +/* SMEM Flash types */
> +#define SMEM_FLASH_NAND			2
> +#define SMEM_FLASH_SPI			6
> +
> +#define SMEM_PART_NAME_SZ		16
> +#define SMEM_PARTS_MAX			32
> +
> +struct smem_partition {
> +	char name[SMEM_PART_NAME_SZ];
> +	__le32 start;
> +	__le32 size;
> +	__le32 attr;
> +};
> +
> +struct smem_partition_table {
> +	u8 magic[8];
> +	__le32 version;
> +	__le32 len;
> +	struct smem_partition parts[SMEM_PARTS_MAX];
> +};
> +
> +/* SMEM Magic values in partition table */
> +static const u8 SMEM_PTABLE_MAGIC[] = {
> +	0xaa, 0x73, 0xee, 0x55,
> +	0xdb, 0xbd, 0x5e, 0xe3,
> +};
> +
> +static int qcom_smem_get_flash_blksz(u64 **smem_blksz)

Instead of passing pointers around I think you should just make this
function return < 0 for errors and >= 0 for the requested data. You can
probably still have it as an int, as the current values are well below
the size of the int.

> +{
> +	int ret;
> +	size_t size;
> +
> +	ret = qcom_smem_get(SMEM_HOST_APPS, SMEM_BOOT_FLASH_BLOCK_SIZE,
> +			    (void **) smem_blksz, &size);
> +
> +	if (ret < 0) {
> +		pr_err("Unable to read flash blksz from SMEM\n");
> +		return -ENOENT;
> +	}
> +
> +	if (size != sizeof(**smem_blksz)) {
> +		pr_err("Invalid flash blksz size in SMEM\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_smem_get_flash_type(u64 **smem_flash_type)

Same as above.

> +{
> +	int ret;
> +	size_t size;
> +
> +	ret = qcom_smem_get(SMEM_HOST_APPS, SMEM_BOOT_FLASH_TYPE,
> +			    (void **) smem_flash_type, &size);
> +
> +	if (ret < 0) {
> +		pr_err("Unable to read flash type from SMEM\n");
> +		return -ENOENT;
> +	}
> +
> +	if (size != sizeof(**smem_flash_type)) {
> +		pr_err("Invalid flash type size in SMEM\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_smem_get_flash_partitions(struct smem_partition_table **pparts)
> +{
> +	int ret;
> +	size_t size;
> +
> +	ret = qcom_smem_get(SMEM_HOST_APPS, SMEM_AARM_PARTITION_TABLE,
> +			    (void **) pparts, &size);
> +

If you don't care about the size just pass NULL as the last argument.

> +	if (ret < 0) {
> +		pr_err("Unable to read partition table from SMEM\n");
> +		return -ENOENT;
> +	}

I think it would be cleaner if you had this function check the magic and
version and then return the partition pointer. That is:

static smem_partition *qcom_smem_get_flash_partitions(size_t *count)


And make *count = le32_to_cpu(table->len); so you don't have to care
about that below.

(And use NULL or ERR_PTR for the error paths)

> +
> +	return 0;
> +}
> +
> +static int of_dev_node_match(struct device *dev, void *data)
> +{
> +	return dev->of_node == data;
> +}
> +
> +static bool is_spi_device(struct device_node *np)
> +{
> +	struct device *dev;
> +
> +	dev = bus_find_device(&spi_bus_type, NULL, np, of_dev_node_match);
> +	if (!dev)
> +		return false;
> +
> +	put_device(dev);
> +	return true;
> +}
> +
> +static int parse_qcom_smem_partitions(struct mtd_info *master,
> +				      struct mtd_partition **pparts,
> +				      struct mtd_part_parser_data *data)
> +{
> +	struct smem_partition_table *smem_parts;
> +	u64 *smem_flash_type, *smem_blksz;
> +	struct mtd_partition *mtd_parts;
> +	struct device_node *of_node = data->of_node;
> +	int i, ret;
> +
> +	/*
> +	 * SMEM will only store the partition table of the boot device.
> +	 * If this is not the boot device, do not return any partition.
> +	 */

I guess this is the result of below checks, but it's not describing
what's actually done here. I think it should say "only parse
partitions on the specified memory type" or something like that.

> +	ret = qcom_smem_get_flash_type(&smem_flash_type);
> +	if (ret < 0)
> +		return ret;
> +
> +	if ((*smem_flash_type == SMEM_FLASH_NAND && !mtd_type_is_nand(master))
> +	    || (*smem_flash_type == SMEM_FLASH_SPI && !is_spi_device(of_node)))
> +		return 0;
> +
> +	/*
> +	 * Just for sanity purpose, make sure the block size in SMEM matches the
> +	 * block size of the MTD device
> +	 */

Well, this is not only for sanity purpose, as you multiply all sizes
with this number below...

> +	ret = qcom_smem_get_flash_blksz(&smem_blksz);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (*smem_blksz != master->erasesize) {
> +		pr_err("SMEM block size differs from MTD block size\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Get partition pointer from SMEM */
> +	ret = qcom_smem_get_flash_partitions(&smem_parts);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (memcmp(SMEM_PTABLE_MAGIC, smem_parts->magic,
> +		   sizeof(SMEM_PTABLE_MAGIC))) {
> +		pr_err("SMEM partition magic invalid\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Allocate and populate the mtd structures */
> +	mtd_parts = kcalloc(le32_to_cpu(smem_parts->len), sizeof(*mtd_parts),
> +			    GFP_KERNEL);
> +	if (!mtd_parts)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < smem_parts->len; i++) {

This might have the wrong endian...

> +		struct smem_partition *s_part = &smem_parts->parts[i];
> +		struct mtd_partition *m_part = &mtd_parts[i];

I think Stephens suggestion was that you assign *pparts before looping
and then you simply do:

*pparts = mtd_parts;

while (len--) {
	..

	s_part++;
	mtd_parts++;
}

> +
> +		m_part->name = s_part->name;

I tried to follow the mtd code, and I believe that this pointer might
be freed in free_partition(). If so you must kstrdup it here.

> +		m_part->size = le32_to_cpu(s_part->size) * (*smem_blksz);
> +		m_part->offset = le32_to_cpu(s_part->start) * (*smem_blksz);
> +
> +		/*
> +		 * The last SMEM partition may have its size marked as
> +		 * something like 0xffffffff, which means "until the end of the
> +		 * flash device". In this case, truncate it.
> +		 */
> +		if (m_part->offset + m_part->size > master->size)
> +			m_part->size = master->size - m_part->offset;
> +	}
> +
> +	*pparts = mtd_parts;
> +
> +	return smem_parts->len;

Again, this might be in the wrong endian.

> +}
> +
> +static struct mtd_part_parser qcom_smem_parser = {
> +	.owner = THIS_MODULE,
> +	.parse_fn = parse_qcom_smem_partitions,
> +	.name = "qcom-smem",
> +};
> +
> +static int __init qcom_smem_parser_init(void)
> +{
> +	register_mtd_parser(&qcom_smem_parser);
> +	return 0;
> +}
> +
> +static void __exit qcom_smem_parser_exit(void)
> +{
> +	deregister_mtd_parser(&qcom_smem_parser);
> +}
> +
> +module_init(qcom_smem_parser_init);
> +module_exit(qcom_smem_parser_exit);

Mostly unrelated to this patch; This makes me appreciate the
module_platform_driver() macro, would be nice to see a patch that
introduces something similar for partition parsers.

> +
> +MODULE_LICENSE("GPL");

Are you sure you don't mean "GPL v2" here?

> +MODULE_AUTHOR("Mathieu Olivari <mathieu@codeaurora.org>");
> +MODULE_DESCRIPTION("Parsing code for SMEM based partition tables");

Regards,
Bjorn
