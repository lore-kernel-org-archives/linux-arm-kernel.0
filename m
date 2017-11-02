From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 2 Nov 2017 12:00:51 +0000
Subject: [PATCH 06/17] coresight: tmc: Make ETR SG table circular
In-Reply-To: <20171101234717.GA16611@xps15>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
 <20171019171553.24056-7-suzuki.poulose@arm.com>
 <20171101234717.GA16611@xps15>
Message-ID: <db0a9a62-e2b5-6895-f7b9-42989d3d56e2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/17 23:47, Mathieu Poirier wrote:
> On Thu, Oct 19, 2017 at 06:15:42PM +0100, Suzuki K Poulose wrote:
>> Make the ETR SG table Circular buffer so that we could start
>> at any of the SG pages and use the entire buffer for tracing.
>> This can be achieved by :
>>
>> 1) Keeping an additional LINK pointer at the very end of the
>> SG table, i.e, after the LAST buffer entry, to point back to
>> the beginning of the first table. This will allow us to use
>> the buffer normally when we start the trace at offset 0 of
>> the buffer, as the LAST buffer entry hints the TMC-ETR and
>> it automatically wraps to the offset 0.
>>
>> 2) If we want to start at any other ETR SG page aligned offset,
>> we could :
>>   a) Make the preceding page entry as LAST entry.
>>   b) Make the original LAST entry a normal entry.
>>   c) Use the table pointer to the "new" start offset as the
>>      base of the table address.
>> This works as the TMC doesn't mandate that the page table
>> base address should be 4K page aligned.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---

>> +static int __maybe_unused
>> +tmc_etr_sg_table_rotate(struct etr_sg_table *etr_table, u64 base_offset)
>> +{
>> +	u32 last_entry, first_entry;
>> +	u64 last_offset;
>> +	struct tmc_sg_table *sg_table = etr_table->sg_table;
>> +	sgte_t *table_ptr = sg_table->table_vaddr;
>> +	ssize_t buf_size = tmc_sg_table_buf_size(sg_table);
>> +
>> +	/* Offset should always be SG PAGE_SIZE aligned */
>> +	if (base_offset & (ETR_SG_PAGE_SIZE - 1)) {
>> +		pr_debug("unaligned base offset %llx\n", base_offset);
>> +		return -EINVAL;
>> +	}
>> +	/* Make sure the offset is within the range */
>> +	if (base_offset < 0 || base_offset > buf_size) {
>> +		base_offset = (base_offset + buf_size) % buf_size;
>> +		pr_debug("Resetting offset to %llx\n", base_offset);
>> +	}
>> +	first_entry = tmc_etr_sg_offset_to_table_index(base_offset);
>> +	if (first_entry == etr_table->first_entry) {
>> +		pr_debug("Head is already at %llx, skipping\n", base_offset);
>> +		return 0;
>> +	}
>> +
>> +	/* Last entry should be the previous one to the new "base" */
>> +	last_offset = ((base_offset - ETR_SG_PAGE_SIZE) + buf_size) % buf_size;
>> +	last_entry = tmc_etr_sg_offset_to_table_index(last_offset);
>> +
>> +	/* Reset the current Last page to Normal and new Last page to NORMAL */
>> +	tmc_etr_sg_update_type(&table_ptr[etr_table->last_entry],
>> +				 ETR_SG_ET_NORMAL);
>> +	tmc_etr_sg_update_type(&table_ptr[last_entry], ETR_SG_ET_LAST);
>> +	etr_table->hwaddr = tmc_etr_sg_table_index_to_daddr(sg_table,
>> +							    first_entry);
>> +	etr_table->first_entry = first_entry;
>> +	etr_table->last_entry = last_entry;
>> +	pr_debug("table rotated to offset %llx-%llx, entries (%d - %d), dba: %llx\n",
>> +			base_offset, last_offset, first_entry, last_entry,
>> +			etr_table->hwaddr);
> 
> The above line generates a warning when compiling for ARMv7.

Where you running with LPAE off ? That could probably be the case,
where hwaddr could be 32bit or 64bit depending on whether LPAE
is enabled. I will fix it.

I have fixed some other warnings with ARMv7 with LPAE.

Suzuki
