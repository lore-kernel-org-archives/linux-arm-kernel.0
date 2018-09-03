From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 3 Sep 2018 19:40:13 +0200
Subject: [RESEND PATCH v2 2/3] mtd: spi-nor: parse SFDP Sector Map
 Parameter Table
In-Reply-To: <20180827102644.7323-3-tudor.ambarus@microchip.com>
References: <20180827102644.7323-1-tudor.ambarus@microchip.com>
 <20180827102644.7323-3-tudor.ambarus@microchip.com>
Message-ID: <1bfbb5f7-39ee-08cb-8f7b-5c3f441f66a2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2018 12:26 PM, Tudor Ambarus wrote:
[...]
> +static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt)
> +{
> +	const u32 *ret = NULL;
> +	u32 i, addr;
> +	int err;
> +	u8 addr_width, read_opcode, read_dummy;
> +	u8 read_data_mask, data_byte, map_id;
> +
> +	addr_width = nor->addr_width;
> +	read_dummy = nor->read_dummy;
> +	read_opcode = nor->read_opcode;
> +
> +	map_id = 0;
> +	i = 0;
> +	/* Determine if there are any optional Detection Command Descriptors */
> +	while (!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
> +		read_data_mask = SMPT_CMD_READ_DATA(smpt[i]);
> +		nor->addr_width = spi_nor_smpt_addr_width(nor, smpt[i]);
> +		nor->read_dummy = spi_nor_smpt_read_dummy(nor, smpt[i]);
> +		nor->read_opcode = SMPT_CMD_OPCODE(smpt[i]);
> +		addr = smpt[i + 1];
> +
> +		err = spi_nor_read_raw(nor, addr, 1, &data_byte);
> +		if (err)
> +			goto out;
> +
> +		/*
> +		 * Build an index value that is used to select the Sector Map
> +		 * Configuration that is currently in use.
> +		 */
> +		map_id = map_id << 1 | (!(data_byte & read_data_mask) ? 0 : 1);

You can drop the ternary operator part completely ^

> +		i = i + 2;
> +	}
> +
> +	/* Find the matching configuration map */
> +	while (SMPT_MAP_ID(smpt[i]) != map_id) {
> +		if (smpt[i] & SMPT_DESC_END)
> +			goto out;
> +		/* increment the table index to the next map */
> +		i += SMPT_MAP_REGION_COUNT(smpt[i]) + 1;
> +	}
> +
> +	ret = smpt + i;
> +	/* fall through */
> +out:
> +	nor->addr_width = addr_width;
> +	nor->read_dummy = read_dummy;
> +	nor->read_opcode = read_opcode;
> +	return ret;
> +}
> +
> +static void
> +spi_nor_region_check_overlay(struct spi_nor_erase_region *region,
> +			     const struct spi_nor_erase_type *erase,
> +			     const u8 erase_type)
> +{
> +	int i;
> +
> +	for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++) {
> +		if (!(erase_type & BIT(i)))
> +			continue;
> +		if (region->size & erase[i].size_mask) {
> +			spi_nor_region_mark_overlay(region);
> +			return;
> +		}
> +	}
> +}
> +
> +static int spi_nor_init_non_uniform_erase_map(struct spi_nor *nor,
> +					      const u32 *smpt)
> +{
> +	struct spi_nor_erase_map *map = &nor->erase_map;
> +	const struct spi_nor_erase_type *erase = map->erase_type;
> +	struct spi_nor_erase_region *region;
> +	u64 offset;
> +	u32 region_count;
> +	int i, j;
> +	u8 erase_type;
> +
> +	region_count = SMPT_MAP_REGION_COUNT(*smpt);
> +	region = devm_kcalloc(nor->dev, region_count, sizeof(*region),
> +			      GFP_KERNEL);

Is this memory always correctly free'd ?

-- 
Best regards,
Marek Vasut
