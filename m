From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 1 Nov 2017 10:12:41 +0000
Subject: [PATCH 06/17] coresight: tmc: Make ETR SG table circular
In-Reply-To: <28695e86-ad56-847b-dd45-bf5502bd5b01@arm.com>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
 <20171019171553.24056-7-suzuki.poulose@arm.com>
 <28695e86-ad56-847b-dd45-bf5502bd5b01@arm.com>
Message-ID: <93b0ae3a-4929-d417-19b2-4c512032a24a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/10/17 18:11, Julien Thierry wrote:

>> +static int __maybe_unused
>> +tmc_etr_sg_table_rotate(struct etr_sg_table *etr_table, u64 base_offset)
>> +{
>> +??? u32 last_entry, first_entry;
>> +??? u64 last_offset;
>> +??? struct tmc_sg_table *sg_table = etr_table->sg_table;
>> +??? sgte_t *table_ptr = sg_table->table_vaddr;
>> +??? ssize_t buf_size = tmc_sg_table_buf_size(sg_table);
>> +
>> +??? /* Offset should always be SG PAGE_SIZE aligned */
>> +??? if (base_offset & (ETR_SG_PAGE_SIZE - 1)) {
>> +??????? pr_debug("unaligned base offset %llx\n", base_offset);
>> +??????? return -EINVAL;
>> +??? }
>> +??? /* Make sure the offset is within the range */
>> +??? if (base_offset < 0 || base_offset > buf_size) {
> 
> base_offset is unsigned, so the left operand of the '||' is useless (would've expected the compiler to emit a warning for this).
> 
>> +??????? base_offset = (base_offset + buf_size) % buf_size;
>> +??????? pr_debug("Resetting offset to %llx\n", base_offset);
>> +??? }
>> +??? first_entry = tmc_etr_sg_offset_to_table_index(base_offset);
>> +??? if (first_entry == etr_table->first_entry) {
>> +??????? pr_debug("Head is already at %llx, skipping\n", base_offset);
>> +??????? return 0;
>> +??? }
>> +
>> +??? /* Last entry should be the previous one to the new "base" */
>> +??? last_offset = ((base_offset - ETR_SG_PAGE_SIZE) + buf_size) % buf_size;
>> +??? last_entry = tmc_etr_sg_offset_to_table_index(last_offset);
>> +
>> +??? /* Reset the current Last page to Normal and new Last page to NORMAL */
> 
> Current Last page to NORMAL and new Last page to LAST?

Thanks again, will fix them

Cheers
Suzuki
