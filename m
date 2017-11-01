From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 1 Nov 2017 17:47:17 -0600
Subject: [PATCH 06/17] coresight: tmc: Make ETR SG table circular
In-Reply-To: <20171019171553.24056-7-suzuki.poulose@arm.com>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
 <20171019171553.24056-7-suzuki.poulose@arm.com>
Message-ID: <20171101234717.GA16611@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 06:15:42PM +0100, Suzuki K Poulose wrote:
> Make the ETR SG table Circular buffer so that we could start
> at any of the SG pages and use the entire buffer for tracing.
> This can be achieved by :
> 
> 1) Keeping an additional LINK pointer at the very end of the
> SG table, i.e, after the LAST buffer entry, to point back to
> the beginning of the first table. This will allow us to use
> the buffer normally when we start the trace at offset 0 of
> the buffer, as the LAST buffer entry hints the TMC-ETR and
> it automatically wraps to the offset 0.
> 
> 2) If we want to start at any other ETR SG page aligned offset,
> we could :
>  a) Make the preceding page entry as LAST entry.
>  b) Make the original LAST entry a normal entry.
>  c) Use the table pointer to the "new" start offset as the
>     base of the table address.
> This works as the TMC doesn't mandate that the page table
> base address should be 4K page aligned.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 159 +++++++++++++++++++++---
>  1 file changed, 139 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 4424eb67a54c..c171b244e12a 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -71,36 +71,41 @@ typedef u32 sgte_t;
>   * @sg_table:		Generic SG Table holding the data/table pages.
>   * @hwaddr:		hwaddress used by the TMC, which is the base
>   *			address of the table.
> + * @nr_entries:		Total number of pointers in the table.
> + * @first_entry:	Index to the current "start" of the buffer.
> + * @last_entry:		Index to the last entry of the buffer.
>   */
>  struct etr_sg_table {
>  	struct tmc_sg_table	*sg_table;
>  	dma_addr_t		hwaddr;
> +	u32			nr_entries;
> +	u32			first_entry;
> +	u32			last_entry;
>  };
>  
>  /*
>   * tmc_etr_sg_table_entries: Total number of table entries required to map
>   * @nr_pages system pages.
>   *
> - * We need to map @nr_pages * ETR_SG_PAGES_PER_SYSPAGE data pages.
> + * We need to map @nr_pages * ETR_SG_PAGES_PER_SYSPAGE data pages and
> + * an additional Link pointer for making it a Circular buffer.
>   * Each TMC page can map (ETR_SG_PTRS_PER_PAGE - 1) buffer pointers,
>   * with the last entry pointing to the page containing the table
> - * entries. If we spill over to a new page for mapping 1 entry,
> - * we could as well replace the link entry of the previous page
> - * with the last entry.
> + * entries. If we fill the last table in full with the pointers, (i.e,
> + * nr_sgpages % (ETR_SG_PTRS_PER_PAGE - 1) == 0, we don't have to allocate
> + * another table and hence skip the Link pointer. Also we could use the
> + * link entry of the last page to make it circular.
>   */
>  static inline unsigned long __attribute_const__
>  tmc_etr_sg_table_entries(int nr_pages)
>  {
>  	unsigned long nr_sgpages = nr_pages * ETR_SG_PAGES_PER_SYSPAGE;
>  	unsigned long nr_sglinks = nr_sgpages / (ETR_SG_PTRS_PER_PAGE - 1);
> -	/*
> -	 * If we spill over to a new page for 1 entry, we could as well
> -	 * make it the LAST entry in the previous page, skipping the Link
> -	 * address.
> -	 */
> -	if (nr_sglinks && (nr_sgpages % (ETR_SG_PTRS_PER_PAGE - 1) < 2))
> +
> +	if (nr_sglinks && !(nr_sgpages % (ETR_SG_PTRS_PER_PAGE - 1)))
>  		nr_sglinks--;
> -	return nr_sgpages + nr_sglinks;
> +	/* Add an entry for the circular link */
> +	return nr_sgpages + nr_sglinks + 1;
>  }
>  
>  /*
> @@ -417,14 +422,21 @@ tmc_sg_daddr_to_vaddr(struct tmc_sg_table *sg_table,
>  /* Dump the given sg_table */
>  static void tmc_etr_sg_table_dump(struct etr_sg_table *etr_table)
>  {
> -	sgte_t *ptr;
> +	sgte_t *ptr, *start;
>  	int i = 0;
>  	dma_addr_t addr;
>  	struct tmc_sg_table *sg_table = etr_table->sg_table;
>  
> -	ptr = (sgte_t *)tmc_sg_daddr_to_vaddr(sg_table,
> +	start = (sgte_t *)tmc_sg_daddr_to_vaddr(sg_table,
>  					      etr_table->hwaddr, true);
> -	while (ptr) {
> +	if (!start) {
> +		pr_debug("ERROR: Failed to translate table base: 0x%llx\n",
> +					 etr_table->hwaddr);
> +		return;
> +	}
> +
> +	ptr = start;
> +	do {
>  		addr = ETR_SG_ADDR(*ptr);
>  		switch (ETR_SG_ET(*ptr)) {
>  		case ETR_SG_ET_NORMAL:
> @@ -436,14 +448,17 @@ static void tmc_etr_sg_table_dump(struct etr_sg_table *etr_table)
>  				 i, ptr, addr);
>  			ptr = (sgte_t *)tmc_sg_daddr_to_vaddr(sg_table,
>  							      addr, true);
> +			if (!ptr)
> +				pr_debug("ERROR: Bad Link 0x%llx\n", addr);
>  			break;
>  		case ETR_SG_ET_LAST:
>  			pr_debug("%05d: ### %p\t:[L] 0x%llx ###\n",
>  				 i, ptr, addr);
> -			return;
> +			ptr++;
> +			break;
>  		}
>  		i++;
> -	}
> +	} while (ptr && ptr != start);
>  	pr_debug("******* End of Table *****\n");
>  }
>  #endif
> @@ -458,7 +473,7 @@ static void tmc_etr_sg_table_dump(struct etr_sg_table *etr_table)
>  static void tmc_etr_sg_table_populate(struct etr_sg_table *etr_table)
>  {
>  	dma_addr_t paddr;
> -	int i, type, nr_entries;
> +	int i, type;
>  	int tpidx = 0; /* index to the current system table_page */
>  	int sgtidx = 0;	/* index to the sg_table within the current syspage */
>  	int sgtoffset = 0; /* offset to the next entry within the sg_table */
> @@ -469,16 +484,16 @@ static void tmc_etr_sg_table_populate(struct etr_sg_table *etr_table)
>  	dma_addr_t *table_daddrs = sg_table->table_pages.daddrs;
>  	dma_addr_t *data_daddrs = sg_table->data_pages.daddrs;
>  
> -	nr_entries = tmc_etr_sg_table_entries(sg_table->data_pages.nr_pages);
>  	/*
>  	 * Use the contiguous virtual address of the table to update entries.
>  	 */
>  	ptr = sg_table->table_vaddr;
>  	/*
> -	 * Fill all the entries, except the last entry to avoid special
> +	 * Fill all the entries, except the last two entries (i.e, the last
> +	 * buffer and the circular link back to the base) to avoid special
>  	 * checks within the loop.
>  	 */
> -	for (i = 0; i < nr_entries - 1; i++) {
> +	for (i = 0; i < etr_table->nr_entries - 2; i++) {
>  		if (sgtoffset == ETR_SG_PTRS_PER_PAGE - 1) {
>  			/*
>  			 * Last entry in a sg_table page is a link address to
> @@ -519,6 +534,107 @@ static void tmc_etr_sg_table_populate(struct etr_sg_table *etr_table)
>  	/* Set up the last entry, which is always a data pointer */
>  	paddr = data_daddrs[dpidx] + spidx * ETR_SG_PAGE_SIZE;
>  	*ptr++ = ETR_SG_ENTRY(paddr, ETR_SG_ET_LAST);
> +	/* followed by a circular link, back to the start of the table */
> +	*ptr++ = ETR_SG_ENTRY(sg_table->table_daddr, ETR_SG_ET_LINK);
> +}
> +
> +/*
> + * tmc_etr_sg_offset_to_table_index : Translate a given data @offset
> + * to the index of the page table "entry". Data pointers always have
> + * a fixed location, with ETR_SG_PTRS_PER_PAGE - 1 entries in an
> + * ETR_SG_PAGE and 1 link entry per (ETR_SG_PTRS_PER_PAGE -1) entries.
> + */
> +static inline u32
> +tmc_etr_sg_offset_to_table_index(u64 offset)
> +{
> +	u64 sgpage_idx = offset >> ETR_SG_PAGE_SHIFT;
> +
> +	return sgpage_idx + sgpage_idx / (ETR_SG_PTRS_PER_PAGE - 1);
> +}
> +
> +/*
> + * tmc_etr_sg_update_type: Update the type of a given entry in the
> + * table to the requested entry. This is only used for data buffers
> + * to toggle the "NORMAL" vs "LAST" buffer entries.
> + */
> +static inline void tmc_etr_sg_update_type(sgte_t *entry, u32 type)
> +{
> +	WARN_ON(ETR_SG_ET(*entry) == ETR_SG_ET_LINK);
> +	WARN_ON(!ETR_SG_ET(*entry));
> +	*entry &= ~ETR_SG_ET_MASK;
> +	*entry |= type;
> +}
> +
> +/*
> + * tmc_etr_sg_table_index_to_daddr: Return the hardware address to the table
> + * entry @index. Use this address to let the table begin @index.
> + */
> +static inline dma_addr_t
> +tmc_etr_sg_table_index_to_daddr(struct tmc_sg_table *sg_table, u32 index)
> +{
> +	u32 sys_page_idx = index / ETR_SG_PTRS_PER_SYSPAGE;
> +	u32 sys_page_offset = index % ETR_SG_PTRS_PER_SYSPAGE;
> +	sgte_t *ptr;
> +
> +	ptr = (sgte_t *)sg_table->table_pages.daddrs[sys_page_idx];
> +	return (dma_addr_t)&ptr[sys_page_offset];
> +}
> +
> +/*
> + * tmc_etr_sg_table_rotate : Rotate the SG circular buffer, moving
> + * the "base" to a requested offset. We do so by :
> + *
> + * 1) Reset the current LAST buffer.
> + * 2) Mark the "previous" buffer in the table to the "base" as LAST.
> + * 3) Update the hwaddr to point to the table pointer for the buffer
> + *    which starts at "base".
> + */
> +static int __maybe_unused
> +tmc_etr_sg_table_rotate(struct etr_sg_table *etr_table, u64 base_offset)
> +{
> +	u32 last_entry, first_entry;
> +	u64 last_offset;
> +	struct tmc_sg_table *sg_table = etr_table->sg_table;
> +	sgte_t *table_ptr = sg_table->table_vaddr;
> +	ssize_t buf_size = tmc_sg_table_buf_size(sg_table);
> +
> +	/* Offset should always be SG PAGE_SIZE aligned */
> +	if (base_offset & (ETR_SG_PAGE_SIZE - 1)) {
> +		pr_debug("unaligned base offset %llx\n", base_offset);
> +		return -EINVAL;
> +	}
> +	/* Make sure the offset is within the range */
> +	if (base_offset < 0 || base_offset > buf_size) {
> +		base_offset = (base_offset + buf_size) % buf_size;
> +		pr_debug("Resetting offset to %llx\n", base_offset);
> +	}
> +	first_entry = tmc_etr_sg_offset_to_table_index(base_offset);
> +	if (first_entry == etr_table->first_entry) {
> +		pr_debug("Head is already at %llx, skipping\n", base_offset);
> +		return 0;
> +	}
> +
> +	/* Last entry should be the previous one to the new "base" */
> +	last_offset = ((base_offset - ETR_SG_PAGE_SIZE) + buf_size) % buf_size;
> +	last_entry = tmc_etr_sg_offset_to_table_index(last_offset);
> +
> +	/* Reset the current Last page to Normal and new Last page to NORMAL */
> +	tmc_etr_sg_update_type(&table_ptr[etr_table->last_entry],
> +				 ETR_SG_ET_NORMAL);
> +	tmc_etr_sg_update_type(&table_ptr[last_entry], ETR_SG_ET_LAST);
> +	etr_table->hwaddr = tmc_etr_sg_table_index_to_daddr(sg_table,
> +							    first_entry);
> +	etr_table->first_entry = first_entry;
> +	etr_table->last_entry = last_entry;
> +	pr_debug("table rotated to offset %llx-%llx, entries (%d - %d), dba: %llx\n",
> +			base_offset, last_offset, first_entry, last_entry,
> +			etr_table->hwaddr);

The above line generates a warning when compiling for ARMv7.

> +	/* Sync the table for device */
> +	tmc_sg_table_sync_table(sg_table);
> +#ifdef ETR_SG_DEBUG
> +	tmc_etr_sg_table_dump(etr_table);
> +#endif
> +	return 0;
>  }
>  
>  /*
> @@ -552,6 +668,9 @@ tmc_init_etr_sg_table(struct device *dev, int node,
>  	}
>  
>  	etr_table->sg_table = sg_table;
> +	etr_table->nr_entries = nr_entries;
> +	etr_table->first_entry = 0;
> +	etr_table->last_entry = nr_entries - 2;
>  	/* TMC should use table base address for DBA */
>  	etr_table->hwaddr = sg_table->table_daddr;
>  	tmc_etr_sg_table_populate(etr_table);
> -- 
> 2.13.6
> 
