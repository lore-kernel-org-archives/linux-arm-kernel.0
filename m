From: james.morse@arm.com (James Morse)
Date: Thu, 11 Oct 2018 09:28:33 +0100
Subject: [PATCH] arm64: Fix /proc/iomem for reserved but not memory regions
In-Reply-To: <20181009152610.GA9259@arm.com>
References: <20181009110830.13331-1-james.morse@arm.com>
 <20181009152610.GA9259@arm.com>
Message-ID: <b9cf5aea-d055-d8fe-25fa-6648644b0ff9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 09/10/2018 16:26, Will Deacon wrote:
> On Tue, Oct 09, 2018 at 12:08:30PM +0100, James Morse wrote:

>> @@ -244,8 +252,11 @@ static void __init request_standard_resources(void)
>>  static int __init reserve_memblock_reserved_regions(void)
>>  {
>>  	phys_addr_t start, end, roundup_end = 0;
>> -	struct resource *mem, *res;
>> -	u64 i;
>> +	struct resource *mem;
>> +	u64 i, mem_idx = 0;
>> +
>> +	if (!standard_resources)
>> +		return 0;
>>  
>>  	for_each_reserved_mem_region(i, &start, &end) {
>>  		if (end <= roundup_end)
>> @@ -255,24 +266,25 @@ static int __init reserve_memblock_reserved_regions(void)
>>  		end = __pfn_to_phys(PFN_UP(end)) - 1;
>>  		roundup_end = end;
>>  
>> -		res = kzalloc(sizeof(*res), GFP_ATOMIC);
>> -		if (WARN_ON(!res))
>> -			return -ENOMEM;
>> -		res->start = start;
>> -		res->end = end;
>> -		res->name  = "reserved";
>> -		res->flags = IORESOURCE_MEM;
>> +		while (start > standard_resources[mem_idx].end) {
>> +			mem_idx++;
>> +			if (mem_idx >= num_standard_resources)
>> +				return 0; /* no more 'System RAM' */
> 
> It might just be me, but I find the control flow here pretty hard to reason
> about. In fact, the way I managed to understand it was by writing my own
> implementation and gradually figuring out why you need all of the checks
> that you have here :)

That doesn't sound fun...


> The version I came up with is below, which I think I prefer, but I would
> say that wouldn't I?
> What do you think? Is there something I've missed?

Fine by me. There was an "if (!standard_resources)" which is never going to
fire, its just paranoia.

Holding on to the roundup_end has gone. This means if you get multiple
memblock_reserved() entries that lie in the same page of memory, you will try to
reserve_region_with_split() of PAGE_SIZE for each one, rounded up to page size.
pcpu does this sort of thing.
Turns out, this is fine. The WARN_ON() I was avoiding with this (/* conflict
covered whole area */) is for next_res, not res. This looks like
resource.c:paranoia, it doesn't happen in this case.


> It's fairly "dumb" compared to your code (i.e. it always looks at all the
> reserved regions) but this is __init code, so I don't think it matters.

(and memblock_is_region_reserved() walks the list again), but I agree
readability matters more. Looks like I was still in shock at walking two lists,
I was over-zealous in making it only do it once!

> --->8
> 
> @@ -243,36 +251,26 @@ static void __init request_standard_resources(void)
>  
>  static int __init reserve_memblock_reserved_regions(void)
>  {
> +	u64 i, j;
> +
> +	for (i = 0; i < num_standard_resources; ++i) {
> +		struct resource *mem = &standard_resources[i];
> +		phys_addr_t r_start, r_end, mem_size = mem->end - mem->start;
> +
> +		if (!memblock_is_region_reserved(mem->start, mem_size))
>  			continue;

> +		for_each_reserved_mem_region(j, &r_start, &r_end) {

The 'ends' that come out of memblock all end in 0xfff for the page-offset bits ...

> +			resource_size_t start, end;
> +
> +			start = max(PFN_PHYS(PFN_DOWN(r_start)), mem->start);
> +			end = min(PFN_PHYS(PFN_UP(r_end)), mem->end);

Here we implicitly round it up to a page boundary, meaning the entry in
/proc/iomem looks like:
| 80030e0000-80032b6fff : Kernel data
| 80b9c00000-80bfc00000 : reserved
| 80bfe00000-80ffdfffff : Crash kernel

instead of what we had before:
| 80030e0000-80032b6fff : Kernel data
| 80b9c00000-80bfbfffff : reserved
| 80bfe00000-80ffdfffff : Crash kernel


The end values in request_standard_resources() are already rounded then fixed,
so that is what shows up for the 'top level' 'System RAM' entries. Having the
second level entries behave differently looks weird, and isn't what we had for
the existing 'Kernel data' and friends entries.


I think your:
| end = min(PFN_PHYS(PFN_UP(r_end)), mem->end);

Needs to be:
| end = min(PFN_PHYS(PFN_UP(r_end)) - 1, mem->end);


> +
> +			if (start > mem->end || end < mem->start)
> +				continue;
> +
> +			reserve_region_with_split(mem, start, end, "reserved");
> +		}
>  	}
>  
>  	return 0;

You've rewritten most of this, for your patch I can offer:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
