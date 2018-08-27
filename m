From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Mon, 27 Aug 2018 13:26:43 +0300
Subject: [RESEND PATCH v2 2/3] mtd: spi-nor: parse SFDP Sector Map Parameter
 Table
In-Reply-To: <20180827102644.7323-1-tudor.ambarus@microchip.com>
References: <20180827102644.7323-1-tudor.ambarus@microchip.com>
Message-ID: <20180827102644.7323-3-tudor.ambarus@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the SFDP (JESD216B) Sector Map Parameter Table. This
table is optional, but when available, we parse it to identify the
location and size of sectors within the main data array of the
flash memory device and to identify which Erase Types are supported by
each sector.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 269 +++++++++++++++++++++++++++++++++++++++---
 include/linux/mtd/spi-nor.h   |  11 ++
 2 files changed, 264 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index c1e8169..522d5aa 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2085,6 +2085,35 @@ spi_nor_set_pp_settings(struct spi_nor_pp_command *pp,
  */
 
 /**
+ * spi_nor_read_raw() - raw read of serial flash memory. read_opcode,
+ * addr_width and read_dummy members of the struct spi_nor should be previously
+ * set.
+ * @nor:	pointer to a 'struct spi_nor'
+ * @addr:	offset in the serial flash memory
+ * @len:	number of bytes to read
+ * @buf:	buffer where the data is copied into
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_read_raw(struct spi_nor *nor, u32 addr, size_t len, u8 *buf)
+{
+	int ret;
+
+	while (len) {
+		ret = nor->read(nor, addr, len, buf);
+		if (!ret || ret > len)
+			return -EIO;
+		if (ret < 0)
+			return ret;
+
+		buf += ret;
+		addr += ret;
+		len -= ret;
+	}
+	return 0;
+}
+
+/**
  * spi_nor_read_sfdp() - read Serial Flash Discoverable Parameters.
  * @nor:	pointer to a 'struct spi_nor'
  * @addr:	offset in the SFDP area to start reading data from
@@ -2111,22 +2140,8 @@ static int spi_nor_read_sfdp(struct spi_nor *nor, u32 addr,
 	nor->addr_width = 3;
 	nor->read_dummy = 8;
 
-	while (len) {
-		ret = nor->read(nor, addr, len, (u8 *)buf);
-		if (!ret || ret > len) {
-			ret = -EIO;
-			goto read_err;
-		}
-		if (ret < 0)
-			goto read_err;
+	ret = spi_nor_read_raw(nor, addr, len, buf);
 
-		buf += ret;
-		addr += ret;
-		len -= ret;
-	}
-	ret = 0;
-
-read_err:
 	nor->read_opcode = read_opcode;
 	nor->addr_width = addr_width;
 	nor->read_dummy = read_dummy;
@@ -2646,6 +2661,228 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	return 0;
 }
 
+#define SMPT_CMD_ADDRESS_LEN_MASK		GENMASK(23, 22)
+#define SMPT_CMD_ADDRESS_LEN_0			(0x0UL << 22)
+#define SMPT_CMD_ADDRESS_LEN_3			(0x1UL << 22)
+#define SMPT_CMD_ADDRESS_LEN_4			(0x2UL << 22)
+#define SMPT_CMD_ADDRESS_LEN_USE_CURRENT	(0x3UL << 22)
+
+#define SMPT_CMD_READ_DUMMY_MASK		GENMASK(19, 16)
+#define SMPT_CMD_READ_DUMMY_SHIFT		16
+#define SMPT_CMD_READ_DUMMY(_cmd) \
+	((_cmd & SMPT_CMD_READ_DUMMY_MASK) >> SMPT_CMD_READ_DUMMY_SHIFT)
+#define SMPT_CMD_READ_DUMMY_IS_VARIABLE		0xfUL
+
+#define SMPT_CMD_READ_DATA_MASK			GENMASK(31, 24)
+#define SMPT_CMD_READ_DATA_SHIFT		24
+#define SMPT_CMD_READ_DATA(_cmd) \
+	((_cmd & SMPT_CMD_READ_DATA_MASK) >> SMPT_CMD_READ_DATA_SHIFT)
+
+#define SMPT_CMD_OPCODE_MASK			GENMASK(15, 8)
+#define SMPT_CMD_OPCODE_SHIFT			8
+#define SMPT_CMD_OPCODE(_cmd) \
+	((_cmd & SMPT_CMD_OPCODE_MASK) >> SMPT_CMD_OPCODE_SHIFT)
+
+#define SMPT_MAP_REGION_COUNT_MASK		GENMASK(23, 16)
+#define SMPT_MAP_REGION_COUNT_SHIFT		16
+#define SMPT_MAP_REGION_COUNT(_header) \
+	(((_header & SMPT_MAP_REGION_COUNT_MASK) >> \
+	  SMPT_MAP_REGION_COUNT_SHIFT) + 1)
+
+#define SMPT_MAP_ID_MASK			GENMASK(15, 8)
+#define SMPT_MAP_ID_SHIFT			8
+#define SMPT_MAP_ID(_header) ((_header & SMPT_MAP_ID_MASK) >> SMPT_MAP_ID_SHIFT)
+
+#define SMPT_MAP_REGION_SIZE_MASK		GENMASK(31, 8)
+#define SMPT_MAP_REGION_SIZE_SHIFT		8
+#define SMPT_MAP_REGION_SIZE(_region) \
+	((((_region & SMPT_MAP_REGION_SIZE_MASK) >> \
+	   SMPT_MAP_REGION_SIZE_SHIFT) + 1) * 256)
+
+#define SMPT_MAP_REGION_ERASE_TYPE_MASK		GENMASK(3, 0)
+#define SMPT_MAP_REGION_ERASE_TYPE(_region) \
+	(_region & SMPT_MAP_REGION_ERASE_TYPE_MASK)
+
+#define SMPT_DESC_TYPE_MAP			BIT(1)
+#define SMPT_DESC_END				BIT(0)
+
+static u8 spi_nor_smpt_addr_width(const struct spi_nor *nor, const u32 settings)
+{
+	switch (settings & SMPT_CMD_ADDRESS_LEN_MASK) {
+	case SMPT_CMD_ADDRESS_LEN_0:
+		return 0;
+	case SMPT_CMD_ADDRESS_LEN_3:
+		return 3;
+	case SMPT_CMD_ADDRESS_LEN_4:
+		return 4;
+	case SMPT_CMD_ADDRESS_LEN_USE_CURRENT:
+		/* fall through */
+	default:
+		return nor->addr_width;
+	}
+}
+
+static u8 spi_nor_smpt_read_dummy(const struct spi_nor *nor, const u32 settings)
+{
+	u8 read_dummy = SMPT_CMD_READ_DUMMY(settings);
+
+	if (read_dummy == SMPT_CMD_READ_DUMMY_IS_VARIABLE)
+		return nor->read_dummy;
+	return read_dummy;
+}
+
+static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt)
+{
+	const u32 *ret = NULL;
+	u32 i, addr;
+	int err;
+	u8 addr_width, read_opcode, read_dummy;
+	u8 read_data_mask, data_byte, map_id;
+
+	addr_width = nor->addr_width;
+	read_dummy = nor->read_dummy;
+	read_opcode = nor->read_opcode;
+
+	map_id = 0;
+	i = 0;
+	/* Determine if there are any optional Detection Command Descriptors */
+	while (!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
+		read_data_mask = SMPT_CMD_READ_DATA(smpt[i]);
+		nor->addr_width = spi_nor_smpt_addr_width(nor, smpt[i]);
+		nor->read_dummy = spi_nor_smpt_read_dummy(nor, smpt[i]);
+		nor->read_opcode = SMPT_CMD_OPCODE(smpt[i]);
+		addr = smpt[i + 1];
+
+		err = spi_nor_read_raw(nor, addr, 1, &data_byte);
+		if (err)
+			goto out;
+
+		/*
+		 * Build an index value that is used to select the Sector Map
+		 * Configuration that is currently in use.
+		 */
+		map_id = map_id << 1 | (!(data_byte & read_data_mask) ? 0 : 1);
+		i = i + 2;
+	}
+
+	/* Find the matching configuration map */
+	while (SMPT_MAP_ID(smpt[i]) != map_id) {
+		if (smpt[i] & SMPT_DESC_END)
+			goto out;
+		/* increment the table index to the next map */
+		i += SMPT_MAP_REGION_COUNT(smpt[i]) + 1;
+	}
+
+	ret = smpt + i;
+	/* fall through */
+out:
+	nor->addr_width = addr_width;
+	nor->read_dummy = read_dummy;
+	nor->read_opcode = read_opcode;
+	return ret;
+}
+
+static void
+spi_nor_region_check_overlay(struct spi_nor_erase_region *region,
+			     const struct spi_nor_erase_type *erase,
+			     const u8 erase_type)
+{
+	int i;
+
+	for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++) {
+		if (!(erase_type & BIT(i)))
+			continue;
+		if (region->size & erase[i].size_mask) {
+			spi_nor_region_mark_overlay(region);
+			return;
+		}
+	}
+}
+
+static int spi_nor_init_non_uniform_erase_map(struct spi_nor *nor,
+					      const u32 *smpt)
+{
+	struct spi_nor_erase_map *map = &nor->erase_map;
+	const struct spi_nor_erase_type *erase = map->erase_type;
+	struct spi_nor_erase_region *region;
+	u64 offset;
+	u32 region_count;
+	int i, j;
+	u8 erase_type;
+
+	region_count = SMPT_MAP_REGION_COUNT(*smpt);
+	region = devm_kcalloc(nor->dev, region_count, sizeof(*region),
+			      GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+	map->regions = region;
+
+	map->uniform_erase_type = 0xff;
+	offset = 0;
+	for (i = 0; i < region_count; i++) {
+		j = i + 1; /* index for the region dword */
+		region[i].size = SMPT_MAP_REGION_SIZE(smpt[j]);
+		erase_type = SMPT_MAP_REGION_ERASE_TYPE(smpt[j]);
+		region[i].offset = offset | erase_type;
+
+		spi_nor_region_check_overlay(&region[i], erase, erase_type);
+
+		/*
+		 * Save the erase types that are supported in all regions and
+		 * can erase the entire flash memory.
+		 */
+		map->uniform_erase_type &= erase_type;
+
+		offset = (region[i].offset & ~SNOR_ERASE_FLAGS_MASK) +
+			 region[i].size;
+	}
+
+	spi_nor_region_mark_end(&region[i - 1]);
+
+	return 0;
+}
+
+static int spi_nor_parse_smpt(struct spi_nor *nor,
+			      const struct sfdp_parameter_header *smpt_header)
+{
+	const u32 *sector_map;
+	u32 *smpt;
+	size_t len;
+	u32 addr;
+	int i, ret;
+
+	/* Read the Sector Map Parameter Table. */
+	len = smpt_header->length * sizeof(*smpt);
+	smpt = kzalloc(len, GFP_KERNEL);
+	if (!smpt)
+		return -ENOMEM;
+
+	addr = SFDP_PARAM_HEADER_PTP(smpt_header);
+	ret = spi_nor_read_sfdp(nor, addr, len, smpt);
+	if (ret)
+		goto out;
+
+	/* Fix endianness of the SMPT DWORDs. */
+	for (i = 0; i < smpt_header->length; i++)
+		smpt[i] = le32_to_cpu(smpt[i]);
+
+	sector_map = spi_nor_get_map_in_use(nor, smpt);
+	if (!sector_map) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = spi_nor_init_non_uniform_erase_map(nor, sector_map);
+	if (ret)
+		goto out;
+
+	spi_nor_regions_sort_erase_types(&nor->erase_map);
+	/* fall through */
+out:
+	kfree(smpt);
+	return ret;
+}
+
 /**
  * spi_nor_parse_sfdp() - parse the Serial Flash Discoverable Parameters.
  * @nor:		pointer to a 'struct spi_nor'
@@ -2740,7 +2977,7 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 
 		switch (SFDP_PARAM_HEADER_ID(param_header)) {
 		case SFDP_SECTOR_MAP_ID:
-			dev_info(dev, "non-uniform erase sector maps are not supported yet.\n");
+			err = spi_nor_parse_smpt(nor, param_header);
 			break;
 
 		default:
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 5be9d20..5b2b0c8 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -421,6 +421,17 @@ static inline u64 spi_nor_region_end(const struct spi_nor_erase_region *region)
 	return (region->offset & ~SNOR_ERASE_FLAGS_MASK) + region->size;
 }
 
+static inline void spi_nor_region_mark_end(struct spi_nor_erase_region *region)
+{
+	region->offset |= SNOR_LAST_REGION;
+}
+
+static inline void
+spi_nor_region_mark_overlay(struct spi_nor_erase_region *region)
+{
+	region->offset |= SNOR_OVERLAID_REGION;
+}
+
 static inline bool spi_nor_has_uniform_erase(const struct spi_nor *nor)
 {
 	return !!nor->erase_map.uniform_erase_type;
-- 
2.9.4
