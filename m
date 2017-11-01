From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 1 Nov 2017 10:09:59 +0000
Subject: [PATCH 04/17] coresight: Add generic TMC sg table framework
In-Reply-To: <20171031221338.GA8487@xps15>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
 <20171019171553.24056-5-suzuki.poulose@arm.com> <20171031221338.GA8487@xps15>
Message-ID: <7543aa6a-3961-debc-3d6d-bd6899b310ad@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/10/17 22:13, Mathieu Poirier wrote:
> On Thu, Oct 19, 2017 at 06:15:40PM +0100, Suzuki K Poulose wrote:
>> This patch introduces a generic sg table data structure and
>> associated operations. An SG table can be used to map a set
>> of Data pages where the trace data could be stored by the TMC
>> ETR. The information about the data pages could be stored in
>> different formats, depending on the type of the underlying
>> SG mechanism (e.g, TMC ETR SG vs Coresight CATU). The generic
>> structure provides book keeping of the pages used for the data
>> as well as the table contents. The table should be filled by
>> the user of the infrastructure.
>>
>> A table can be created by specifying the number of data pages
>> as well as the number of table pages required to hold the
>> pointers, where the latter could be different for different
>> types of tables. The pages are mapped in the appropriate dma
>> data direction mode (i.e, DMA_TO_DEVICE for table pages
>> and DMA_FROM_DEVICE for data pages).  The framework can optionally
>> accept a set of allocated data pages (e.g, perf ring buffer) and
>> map them accordingly. The table and data pages are vmap'ed to allow
>> easier access by the drivers. The framework also provides helpers to
>> sync the data written to the pages with appropriate directions.
>>
>> This will be later used by the TMC ETR SG unit.
>>
>> Cc: Mathieu Poirier <matheiu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> ---
>>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 289 +++++++++++++++++++++++-
>>   drivers/hwtracing/coresight/coresight-tmc.h     |  44 ++++
>>   2 files changed, 332 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index 41535fa6b6cf..4b9e2b276122 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -16,10 +16,297 @@
>>    */
>>   
>>   #include <linux/coresight.h>
>> -#include <linux/dma-mapping.h>
>> +#include <linux/slab.h>
>>   #include "coresight-priv.h"
>>   #include "coresight-tmc.h"
>>   
>> +/*
>> + * tmc_pages_get_offset:  Go through all the pages in the tmc_pages
>> + * and map @phys_addr to an offset within the buffer.
> 
> Did you mean "... map @addr"?  It might also be worth it to explicitly mention
> that it maps a physical address to an offset in the contiguous range.

Yes, definitely. I will fix it.


...

>> +/*
>> + * Alloc pages for the table. Since this will be used by the device,
>> + * allocate the pages closer to the device (i.e, dev_to_node(dev)
>> + * rather than the CPU nod).
>> + */
>> +static int tmc_alloc_table_pages(struct tmc_sg_table *sg_table)
>> +{
>> +	int rc;
>> +	struct tmc_pages *table_pages = &sg_table->table_pages;
>> +
>> +	rc = tmc_pages_alloc(table_pages, sg_table->dev,
>> +			     dev_to_node(sg_table->dev),
>> +			     DMA_TO_DEVICE, NULL);
>> +	if (rc)
>> +		return rc;
>> +	sg_table->table_vaddr = vmap(table_pages->pages,
>> +				     table_pages->nr_pages,
>> +				     VM_MAP,
>> +				     PAGE_KERNEL);
>> +	if (!sg_table->table_vaddr)
>> +		rc = -ENOMEM;
>> +	else
>> +		sg_table->table_daddr = table_pages->daddrs[0];
>> +	return rc;
>> +}
>> +
>> +static int tmc_alloc_data_pages(struct tmc_sg_table *sg_table, void **pages)
>> +{
>> +	int rc;
>> +
>> +	rc = tmc_pages_alloc(&sg_table->data_pages,
>> +			     sg_table->dev, sg_table->node,
> 
> Am I missing something very subtle here or sg_table->node should be the same as
> dev_to_node(sg_table->dev)?  If the same both tmc_alloc_table_pages() and
> tmc_alloc_data_pages() should be using the same construct.  Otherwise please add
> a comment to justify the difference.

Yes, it was a last minute change to switch the table to use dev_to_node(), while the
data pages are allocated as requested by the user. Eventually the user would consume
the data pages (even though the device produces it). However, the table pages are solely
for the consumption of the device, hence the dev_to_node().

I will add a comment to make that explicit.

>>   	u32 axictl, sts;
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
>> index 6deb3afe9db8..5e49c035a1ac 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
>> @@ -19,6 +19,7 @@
>>   #define _CORESIGHT_TMC_H
>>   
>>   #include <linux/miscdevice.h>
>> +#include <linux/dma-mapping.h>
>>   
>>   #define TMC_RSZ			0x004
>>   #define TMC_STS			0x00c
>> @@ -171,6 +172,38 @@ struct tmc_drvdata {
>>   	u32			etr_caps;
>>   };
>>   
>> +/**
>> + * struct tmc_pages - Collection of pages used for SG.
>> + * @nr_pages:		Number of pages in the list.
>> + * @daddr:		DMA'able page address returned by dma_map_page().
>> + * @vaddr:		Virtual address returned by page_address().
> 
> This isn't accurate.
> 

Yes, I will clean that up. It kind of shows the number of revisions this
series has changed before reaching here ;-)

>> + */
>> +struct tmc_pages {
>> +	int nr_pages;
>> +	dma_addr_t	*daddrs;
>> +	struct page	**pages;
>> +};
>> +
>> +/*
>> + * struct tmc_sg_table : Generic SG table for TMC
> 
> Use a '-' as above or fix the above to be ':'.  I don't mind which is used as
> long as they are the same.
> 

Ok.


>> + * @dev:		Device for DMA allocations
>> + * @table_vaddr:	Contiguous Virtual address for PageTable
>> + * @data_vaddr:		Contiguous Virtual address for Data Buffer
>> + * @table_daddr:	DMA address of the PageTable base
>> + * @node:		Node for Page allocations
>> + * @table_pages:	List of pages & dma address for Table
>> + * @data_pages:		List of pages & dma address for Data
>> + */
>> +struct tmc_sg_table {
>> +	struct device *dev;
>> +	void *table_vaddr;
>> +	void *data_vaddr;
>> +	dma_addr_t table_daddr;
>> +	int node;
>> +	struct tmc_pages table_pages;
>> +	struct tmc_pages data_pages;
>> +};
>> +
>>   /* Generic functions */
>>   void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata);
>>   void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
>> @@ -226,4 +259,15 @@ static inline bool tmc_etr_has_cap(struct tmc_drvdata *drvdata, u32 cap)
>>   	return !!(drvdata->etr_caps & cap);
>>   }
>>   
>> +struct tmc_sg_table *tmc_alloc_sg_table(struct device *dev,
>> +					int node,
>> +					int nr_tpages,
>> +					int nr_dpages,
>> +					void **pages);
>> +void tmc_free_sg_table(struct tmc_sg_table *sg_table);
>> +void tmc_sg_table_sync_table(struct tmc_sg_table *sg_table);
>> +void tmc_sg_table_sync_data_range(struct tmc_sg_table *table,
>> +				  u64 offset, u64 size);
>> +ssize_t tmc_sg_table_get_data(struct tmc_sg_table *sg_table,
>> +			      u64 offset, size_t len, char **bufpp);
>>   #endif
> 
> I like this implementation, much cleaner than what I previously had.
> 

Thanks for the review !

Cheers
Suzuki
