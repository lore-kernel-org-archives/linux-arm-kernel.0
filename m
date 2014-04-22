From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 22 Apr 2014 15:50:07 -0700
Subject: [RFC][PATCH] arm64: Add atomic pool for dma mapping
In-Reply-To: <20140422100201.GB7484@arm.com>
References: <1397764941-1351-1-git-send-email-lauraa@codeaurora.org>
 <20140422100201.GB7484@arm.com>
Message-ID: <5356F21F.1060001@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/22/2014 3:02 AM, Will Deacon wrote:
> Hi Laura,
> 
> On Thu, Apr 17, 2014 at 09:02:21PM +0100, Laura Abbott wrote:
>> Neither CMA nor noncoherent allocations support atomic allocations.
>> Add a dedicated atomic pool to support this.
>>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>> ---
>>  arch/arm64/mm/dma-mapping.c | 186 +++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 184 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>> index 0ba347e..c67a3ff 100644
>> --- a/arch/arm64/mm/dma-mapping.c
>> +++ b/arch/arm64/mm/dma-mapping.c
>> @@ -38,6 +38,110 @@ static pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot,
>>  	return prot;
>>  }
>>  
>> +#define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
>> +
>> +struct dma_pool {
>> +	size_t size;
>> +	spinlock_t lock;
>> +	void *coherent_vaddr;
>> +	void *noncoherent_vaddr;
>> +	unsigned long *bitmap;
>> +	unsigned long nr_pages;
>> +	struct page **pages;
>> +};
>> +
>> +static struct dma_pool atomic_pool = {
>> +	.size = DEFAULT_DMA_COHERENT_POOL_SIZE,
>> +};
>> +
>> +static int __init early_coherent_pool(char *p)
>> +{
>> +	atomic_pool.size = memparse(p, &p);
>> +	return 0;
>> +}
>> +early_param("coherent_pool", early_coherent_pool);
> 
> What happened to the device-tree bindings we discussed in Edinburgh with
> Grant and Ben? This looks like a good opportunity to make use of those,
> rather than use the command-line as we do for arch/arm.
> 

The current point of the coherent command line option is to override the
default size. Going with DT would mean that if the node is specified in
DT, the memory is allocated via that framework. If there is no node, then
fallback to allocating the memory as normal. This asymmetry seems a bit
odd to me.

> Will
> 

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
