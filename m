From: lauraa@codeaurora.org (Laura Abbott)
Date: Fri, 08 Aug 2014 15:41:51 -0700
Subject: [PATCHv6 1/5] lib/genalloc.c: Add power aligned algorithm
In-Reply-To: <20140808153635.36f27a4fbfbd8f715e51d15e@linux-foundation.org>
References: <1407529397-6642-1-git-send-email-lauraa@codeaurora.org>
 <20140808153635.36f27a4fbfbd8f715e51d15e@linux-foundation.org>
Message-ID: <53E5522F.10603@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/8/2014 3:36 PM, Andrew Morton wrote:
> On Fri,  8 Aug 2014 13:23:13 -0700 Laura Abbott <lauraa@codeaurora.org> wrote:
> 
>>
>> One of the more common algorithms used for allocation
>> is to align the start address of the allocation to
>> the order of size requested. Add this as an algorithm
>> option for genalloc.
>>
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
> `data' is used.
> 
>> + */
>> +unsigned long gen_pool_first_fit_order_align(unsigned long *map,
>> +		unsigned long size, unsigned long start,
>> +		unsigned int nr, void *data)
>> +{
>> +	unsigned long order = (unsigned long) data;
> 
> Why pass a void*?  Why not pass "unsigned order;"?
> 
>> +	unsigned long align_mask = (1 << get_order(nr << order)) - 1;
>> +
>> +	return bitmap_find_next_zero_area(map, size, start, nr, align_mask);
>> +}
>> +EXPORT_SYMBOL(gen_pool_first_fit_order_align);
>> +
>> +/**
>>   * gen_pool_best_fit - find the best fitting region of memory
>>   * macthing the size requirement (no alignment constraint)
>>   * @map: The address to base the search on
> 

Ugh, I sent out the wrong version of this one which updated the function to
not need the parameter. I'll update with the correct version in v7.

Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
