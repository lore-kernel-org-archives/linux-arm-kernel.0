From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 1 Nov 2017 10:11:48 +0000
Subject: [PATCH 05/17] coresight: Add support for TMC ETR SG unit
In-Reply-To: <d365437e-3612-c3ef-59ad-f4048daf088e@arm.com>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
 <20171019171553.24056-6-suzuki.poulose@arm.com>
 <d365437e-3612-c3ef-59ad-f4048daf088e@arm.com>
Message-ID: <7b96683f-e1cf-b7d0-9bd9-956e3a33cdb6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index 4b9e2b276122..4424eb67a54c 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -21,6 +21,89 @@
>> ? #include "coresight-tmc.h"
>> ? /*
>> + * The TMC ETR SG has a page size of 4K. The SG table contains pointers
>> + * to 4KB buffers. However, the OS may be use PAGE_SIZE different from
> 
> nit:
> "the OS may use a PAGE_SIZE different from".
> 


>> +#define ETR_SG_PAGE_SHIFT??????? 12
>> +#define ETR_SG_PAGE_SIZE??????? (1UL << ETR_SG_PAGE_SHIFT)
>> +#define ETR_SG_PAGES_PER_SYSPAGE??? (1UL << \
>> +???????????????????? (PAGE_SHIFT - ETR_SG_PAGE_SHIFT))
> 
> I think this would be slightly easier to understand if defined as:
> "(PAGE_SIZE / ETR_SG_PAGE_SIZE)".
> 

>> +/* Dump the given sg_table */
>> +static void tmc_etr_sg_table_dump(struct etr_sg_table *etr_table)
>> +{
>> +??? sgte_t *ptr;
>> +??? int i = 0;
>> +??? dma_addr_t addr;
>> +??? struct tmc_sg_table *sg_table = etr_table->sg_table;
>> +
>> +??? ptr = (sgte_t *)tmc_sg_daddr_to_vaddr(sg_table,
>> +????????????????????????? etr_table->hwaddr, true);
>> +??? while (ptr) {
>> +??????? addr = ETR_SG_ADDR(*ptr);
>> +??????? switch (ETR_SG_ET(*ptr)) {
>> +??????? case ETR_SG_ET_NORMAL:
>> +??????????? pr_debug("%05d: %p\t:[N] 0x%llx\n", i, ptr, addr);
>> +??????????? ptr++;
>> +??????????? break;
>> +??????? case ETR_SG_ET_LINK:
>> +??????????? pr_debug("%05d: *** %p\t:{L} 0x%llx ***\n",
>> +???????????????? i, ptr, addr);
>> +??????????? ptr = (sgte_t *)tmc_sg_daddr_to_vaddr(sg_table,
>> +????????????????????????????????? addr, true);
>> +??????????? break;
>> +??????? case ETR_SG_ET_LAST:
>> +??????????? pr_debug("%05d: ### %p\t:[L] 0x%llx ###\n",
>> +???????????????? i, ptr, addr);
>> +??????????? return;
> 
> I get this is debug code, but it seems like if ETR_SG_ET(*ptr) is 0 we get stuck in an infinite loop. I guess it is something that supposedly doesn't happen, still I'd prefer having a default case saying the table might be corrupted and either incrementing ptr to try and get more info or breaking out of the loop.
> 

>> +??????? }
>> +??????? i++;
>> +??? }
>> +??? pr_debug("******* End of Table *****\n");
>> +}
>> +#endif
>> +
>> +/*
>> + * Populate the SG Table page table entries from table/data
>> + * pages allocated. Each Data page has ETR_SG_PAGES_PER_SYSPAGE SG pages.
>> + * So does a Table page. So we keep track of indices of the tables
>> + * in each system page and move the pointers accordingly.
>> + */
>> +#define INC_IDX_ROUND(idx, size) (idx = (idx + 1) % size)
> 
> Needs more parenthesis around idx and size.
> 

>> +static void tmc_etr_sg_table_populate(struct etr_sg_table *etr_table)
>> +{
>> +??? dma_addr_t paddr;
>> +??? int i, type, nr_entries;
>> +??? int tpidx = 0; /* index to the current system table_page */
>> +??? int sgtidx = 0;??? /* index to the sg_table within the current syspage */
>> +??? int sgtoffset = 0; /* offset to the next entry within the sg_table */
> 
> That's misleading, this seems to be the index of an entry within an ETR_SG_PAGE rather than an offset in bytes.
> 
> Maybe ptridx or entryidx would be a better name.

You're right, I have chosen sgtentry for now.

Thanks for the detailed look, I will fix all of them.

Cheers
Suzuki
