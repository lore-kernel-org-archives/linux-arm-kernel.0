From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 3 Sep 2018 19:37:15 +0200
Subject: [RESEND PATCH v2 1/3] mtd: spi-nor: add support to non-uniform
 SFDP SPI NOR flash memories
In-Reply-To: <20180827102644.7323-2-tudor.ambarus@microchip.com>
References: <20180827102644.7323-1-tudor.ambarus@microchip.com>
 <20180827102644.7323-2-tudor.ambarus@microchip.com>
Message-ID: <8f25975d-e0d8-dd11-76ce-857e99df9c2c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2018 12:26 PM, Tudor Ambarus wrote:
[...]

> +/* JEDEC JESD216B Standard imposes erase sizes to be power of 2. */
> +static inline u64
> +spi_nor_div_by_erase_size(const struct spi_nor_erase_type *erase,
> +			  u64 dividend, u32 *remainder)
> +{
> +	*remainder = (u32)dividend & erase->size_mask;

Is the cast really needed ? btw I think there might be a macro doing
just this, div_by_ or something in include/ .

> +	return dividend >> erase->size_shift;
> +}
> +
> +static const struct spi_nor_erase_type *
> +spi_nor_find_best_erase_type(const struct spi_nor_erase_map *map,
> +			     const struct spi_nor_erase_region *region,
> +			     u64 addr, u32 len)
> +{
> +	const struct spi_nor_erase_type *erase;
> +	u32 rem;
> +	int i;
> +	u8 erase_mask = region->offset & SNOR_ERASE_TYPE_MASK;
> +
> +	/*
> +	 * Erase types are ordered by size, with the biggest erase type at
> +	 * index 0.
> +	 */
> +	for (i = SNOR_ERASE_TYPE_MAX - 1; i >= 0; i--) {
> +		/* Does the erase region support the tested erase type? */
> +		if (!(erase_mask & BIT(i)))
> +			continue;
> +
> +		erase = &map->erase_type[i];
> +
> +		/* Don't erase more than what the user has asked for. */
> +		if (erase->size > len)
> +			continue;
> +
> +		/* Alignment is not mandatory for overlaid regions */
> +		if (region->offset & SNOR_OVERLAID_REGION)
> +			return erase;
> +
> +		spi_nor_div_by_erase_size(erase, addr, &rem);
> +		if (rem)
> +			continue;
> +		else
> +			return erase;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct spi_nor_erase_region *
> +spi_nor_region_next(struct spi_nor_erase_region *region)
> +{
> +	if (spi_nor_region_is_last(region))
> +		return NULL;
> +	return ++region;

region++ ...

[...]

> +static int spi_nor_cmp_erase_type(const void *a, const void *b)
> +{
> +	const struct spi_nor_erase_type *erase1 = a;
> +	const struct spi_nor_erase_type *erase2 = b;
> +
> +	return erase1->size - erase2->size;

What does this function do again ?

> +}
> +
> +static void spi_nor_regions_sort_erase_types(struct spi_nor_erase_map *map)
> +{
> +	struct spi_nor_erase_region *region = map->regions;
> +	struct spi_nor_erase_type *erase_type = map->erase_type;
> +	int i;
> +	u8 region_erase_mask, ordered_erase_mask;
> +
> +	/*
> +	 * Sort each region's Erase Types in ascending order with the smallest
> +	 * Erase Type size starting at BIT(0).
> +	 */
> +	while (region) {
> +		region_erase_mask = region->offset & SNOR_ERASE_TYPE_MASK;
> +
> +		/*
> +		 * The region's erase mask indicates which erase types are
> +		 * supported from the erase types defined in the map.
> +		 */
> +		ordered_erase_mask = 0;
> +		for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++)
> +			if (erase_type[i].size &&
> +			    region_erase_mask & BIT(erase_type[i].idx))
> +				ordered_erase_mask |= BIT(i);
> +
> +		/* Overwrite erase mask. */
> +		region->offset = (region->offset & ~SNOR_ERASE_TYPE_MASK) |
> +				 ordered_erase_mask;
> +
> +		region = spi_nor_region_next(region);
> +	}
> +}
> +
> +static inline void

Drop the inline

> +spi_nor_init_uniform_erase_map(struct spi_nor_erase_map *map,
> +			       u8 erase_mask, u64 flash_size)
> +{
> +	map->uniform_region.offset = SNOR_ERASE_FLAGS_OFFSET(erase_mask, 1, 0,
> +							     0);
> +	map->uniform_region.size = flash_size;
> +	map->regions = &map->uniform_region;
> +	map->uniform_erase_type = erase_mask;
> +}
> +

[...]

> +#define spi_nor_region_is_last(region)  (region->offset & SNOR_LAST_REGION)
> +
> +static inline u64 spi_nor_region_end(const struct spi_nor_erase_region *region)

Get rid of the inlines, really.

> +{
> +	return (region->offset & ~SNOR_ERASE_FLAGS_MASK) + region->size;
> +}
> +
> +static inline bool spi_nor_has_uniform_erase(const struct spi_nor *nor)
> +{
> +	return !!nor->erase_map.uniform_erase_type;
> +}
> +
>  static inline void spi_nor_set_flash_node(struct spi_nor *nor,
>  					  struct device_node *np)
>  {
> 

General question, what happens if the multi-block erase fails mid-way ,
is that handled or reported somehow to the user ?

-- 
Best regards,
Marek Vasut
