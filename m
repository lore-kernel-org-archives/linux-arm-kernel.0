From: lauraa@codeaurora.org (Laura Abbott)
Date: Sun, 29 Jun 2014 12:33:51 -0700
Subject: [PATCHv3 1/5] lib/genalloc.c: Add power aligned algorithm
In-Reply-To: <20140620093340.GL25104@arm.com>
References: <1402969165-7526-1-git-send-email-lauraa@codeaurora.org>
 <1402969165-7526-2-git-send-email-lauraa@codeaurora.org>
 <20140620093340.GL25104@arm.com>
Message-ID: <53B06A1F.9010105@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/20/2014 2:33 AM, Will Deacon wrote:
> Hi Laura,
> 
> On Tue, Jun 17, 2014 at 02:39:21AM +0100, Laura Abbott wrote:
>> One of the more common algorithms used for allocation
>> is to align the start address of the allocation to
>> the order of size requested. Add this as an algorithm
>> option for genalloc.
> 
> Good idea, I didn't know this even existed!
> 
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>> ---
>>  include/linux/genalloc.h |  4 ++++
>>  lib/genalloc.c           | 21 +++++++++++++++++++++
>>  2 files changed, 25 insertions(+)
>>
>> diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
>> index 1c2fdaa..3cd0934 100644
>> --- a/include/linux/genalloc.h
>> +++ b/include/linux/genalloc.h
>> @@ -110,6 +110,10 @@ extern void gen_pool_set_algo(struct gen_pool *pool, genpool_algo_t algo,
>>  extern unsigned long gen_pool_first_fit(unsigned long *map, unsigned long size,
>>  		unsigned long start, unsigned int nr, void *data);
>>  
>> +extern unsigned long gen_pool_first_fit_order_align(unsigned long *map,
>> +		unsigned long size, unsigned long start, unsigned int nr,
>> +		void *data);
>> +
>>  extern unsigned long gen_pool_best_fit(unsigned long *map, unsigned long size,
>>  		unsigned long start, unsigned int nr, void *data);
>>  
>> diff --git a/lib/genalloc.c b/lib/genalloc.c
>> index bdb9a45..9758529 100644
>> --- a/lib/genalloc.c
>> +++ b/lib/genalloc.c
>> @@ -481,6 +481,27 @@ unsigned long gen_pool_first_fit(unsigned long *map, unsigned long size,
>>  EXPORT_SYMBOL(gen_pool_first_fit);
>>  
>>  /**
>> + * gen_pool_first_fit_order_align - find the first available region
>> + * of memory matching the size requirement. The region will be aligned
>> + * to the order of the size specified.
>> + * @map: The address to base the search on
>> + * @size: The bitmap size in bits
>> + * @start: The bitnumber to start searching at
>> + * @nr: The number of zeroed bits we're looking for
>> + * @data: additional data - unused
> 
> It doesn't look unused to me.
> 
>> + */
>> +unsigned long gen_pool_first_fit_order_align(unsigned long *map,
>> +		unsigned long size, unsigned long start,
>> +		unsigned int nr, void *data)
>> +{
>> +	unsigned long order = (unsigned long) data;
>> +	unsigned long align_mask = (1 << get_order(nr << order)) - 1;
> 
> Why isn't the order just order?
> 

I did some bad math somewhere. All we really need is 

unsigned long align_mask = roundup_pow_of_two(nr) - 1;

Which means the data would actually be unused. I'll fix it in the next
version.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
