From: james.morse@arm.com (James Morse)
Date: Thu, 17 Nov 2016 18:00:58 +0000
Subject: [PATCH v27 1/9] memblock: add memblock_cap_memory_range()
In-Reply-To: <20161117111917.GA22855@arm.com>
References: <20161102044959.11954-1-takahiro.akashi@linaro.org>
 <20161102045153.12008-1-takahiro.akashi@linaro.org>
 <20161110172720.GB17134@arm.com> <20161111025049.GG381@linaro.org>
 <20161111031903.GB15997@arm.com> <20161114055515.GH381@linaro.org>
 <20161116163015.GM7928@arm.com> <20161117022023.GA5704@linaro.org>
 <20161117111917.GA22855@arm.com>
Message-ID: <582DF05A.9050601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will, Akashi,

On 17/11/16 11:19, Will Deacon wrote:
> It looks much better, thanks! Just one question below.
> 

> On Thu, Nov 17, 2016 at 02:34:24PM +0900, AKASHI Takahiro wrote:
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 7608bc3..fea1688 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1514,11 +1514,37 @@ void __init memblock_enforce_memory_limit(phys_addr_t limit)
>>  			      (phys_addr_t)ULLONG_MAX);
>>  }
>>  
>> +void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
>> +{
>> +	int start_rgn, end_rgn;
>> +	int i, ret;
>> +
>> +	if (!size)
>> +		return;
>> +
>> +	ret = memblock_isolate_range(&memblock.memory, base, size,
>> +						&start_rgn, &end_rgn);
>> +	if (ret)
>> +		return;
>> +
>> +	/* remove all the MAP regions */
>> +	for (i = memblock.memory.cnt - 1; i >= end_rgn; i--)
>> +		if (!memblock_is_nomap(&memblock.memory.regions[i]))
>> +			memblock_remove_region(&memblock.memory, i);
> 
> In the case that we have only one, giant memblock that covers base all
> of base + size, can't we end up with start_rgn = end_rgn = 0? In which

Can this happen? If we only have one memblock that exactly spans
base:(base+size), memblock_isolate_range() will hit the '@rgn is fully
contained, record it' code and set start_rgn=0,end_rgn=1. (rbase==base,
rend==end). We only go round the loop once.

If we only have one memblock that is bigger than base:(base+size) we end up with
three regions, start_rgn=1,end_rgn=2. The trickery here is the '@rgn intersects
from above' code decreases the loop counter so we process the same entry twice,
hitting '@rgn is fully contained, record it' the second time round... so we go
round the loop four times.

I can't see how we hit the:
> 	if (rbase >= end)
> 		break;
> 	if (rend <= base)
> 		continue;

code in either case...



Thanks,

James


> case, we'd end up accidentally removing the map regions here.
> 
> The existing code:
> 
>> -	/* remove all the MAP regions above the limit */
>> -	for (i = end_rgn - 1; i >= start_rgn; i--) {
>> -		if (!memblock_is_nomap(&type->regions[i]))
>> -			memblock_remove_region(type, i);
>> -	}
> 
> seems to handle this.
