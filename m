From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 20 Oct 2017 18:11:30 +0100
Subject: [PATCH 06/17] coresight: tmc: Make ETR SG table circular
In-Reply-To: <20171019171553.24056-7-suzuki.poulose@arm.com>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
 <20171019171553.24056-7-suzuki.poulose@arm.com>
Message-ID: <28695e86-ad56-847b-dd45-bf5502bd5b01@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On 19/10/17 18:15, Suzuki K Poulose wrote:
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
>   a) Make the preceding page entry as LAST entry.
>   b) Make the original LAST entry a normal entry.
>   c) Use the table pointer to the "new" start offset as the
>      base of the table address.
> This works as the TMC doesn't mandate that the page table
> base address should be 4K page aligned.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 159 +++++++++++++++++++++---
>   1 file changed, 139 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 4424eb67a54c..c171b244e12a 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c

[...]

> @@ -519,6 +534,107 @@ static void tmc_etr_sg_table_populate(struct etr_sg_table *etr_table)
>   	/* Set up the last entry, which is always a data pointer */
>   	paddr = data_daddrs[dpidx] + spidx * ETR_SG_PAGE_SIZE;
>   	*ptr++ = ETR_SG_ENTRY(paddr, ETR_SG_ET_LAST);
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

base_offset is unsigned, so the left operand of the '||' is useless 
(would've expected the compiler to emit a warning for this).

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

Current Last page to NORMAL and new Last page to LAST?

Cheers,

-- 
Julien Thierry
