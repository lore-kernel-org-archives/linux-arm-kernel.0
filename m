From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 31 Oct 2018 10:33:08 -0700
Subject: [PATCH v2 4/6] arm64: Utilize phys_initrd_start/phys_initrd_size
In-Reply-To: <20181031070350.GA12503@rapoport-lnx>
References: <20181030230721.28429-1-f.fainelli@gmail.com>
 <20181030230721.28429-5-f.fainelli@gmail.com>
 <20181031070350.GA12503@rapoport-lnx>
Message-ID: <ae4cfe6b-8df8-7737-e7e0-9471bd131a67@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/18 12:03 AM, Mike Rapoport wrote:
> On Tue, Oct 30, 2018 at 04:07:19PM -0700, Florian Fainelli wrote:
>> ARM64 is the only architecture that re-defines
>> __early_init_dt_declare_initrd() in order for that function to populate
>> initrd_start/initrd_end with physical addresses instead of virtual
>> addresses. Instead of having an override we can leverage
>> drivers/of/fdt.c populating phys_initrd_start/phys_initrd_size to
>> populate those variables for us.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  arch/arm64/mm/init.c | 21 +++++++++------------
>>  1 file changed, 9 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 3cf87341859f..e95cee656a55 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -72,8 +72,8 @@ static int __init early_initrd(char *p)
>>  	if (*endp == ',') {
>>  		size = memparse(endp + 1, NULL);
>>  
>> -		initrd_start = start;
>> -		initrd_end = start + size;
>> +		phys_initrd_start = start;
>> +		phys_initrd_size = size;
>>  	}
>>  	return 0;
>>  }
>> @@ -408,14 +408,14 @@ void __init arm64_memblock_init(void)
>>  		memblock_add(__pa_symbol(_text), (u64)(_end - _text));
>>  	}
>>  
>> -	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
>> +	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
>>  		/*
>>  		 * Add back the memory we just removed if it results in the
>>  		 * initrd to become inaccessible via the linear mapping.
>>  		 * Otherwise, this is a no-op
>>  		 */
>> -		u64 base = initrd_start & PAGE_MASK;
>> -		u64 size = PAGE_ALIGN(initrd_end) - base;
>> +		u64 base = phys_initrd_start & PAGE_MASK;
>> +		u64 size = PAGE_ALIGN(phys_initrd_size);
>>  
>>  		/*
>>  		 * We can only add back the initrd memory if we don't end up
>> @@ -460,13 +460,10 @@ void __init arm64_memblock_init(void)
>>  	 */
>>  	memblock_reserve(__pa_symbol(_text), _end - _text);
>>  #ifdef CONFIG_BLK_DEV_INITRD
>> -	if (initrd_start) {
> 
> There may be no initrd at all, so the condition here would rather become
> 
> 	if (phys_initrd_start)

Or use phys_initrd_size, which would be consistent with how other
architectures typically test for this.

> 
>> -		memblock_reserve(initrd_start, initrd_end - initrd_start);
>> -
>> -		/* the generic initrd code expects virtual addresses */
>> -		initrd_start = __phys_to_virt(initrd_start);
>> -		initrd_end = __phys_to_virt(initrd_end);
>> -	}
>> +	/* the generic initrd code expects virtual addresses */
>> +	initrd_start = __phys_to_virt(phys_initrd_start);
>> +	initrd_end = initrd_start + phys_initrd_size;
>> +	initrd_below_start_ok = 0;
>>  #endif
> 
> I also wonder what is the reason to keep memstart_addr randomization and
> initrd setup interleaved?
> 
> What we have now is roughly:
> 
> 1) set memstart_addr
> 2) enforce memory_limit
> 3) reserve initrd
> 4) randomize memstart_addr
> 5) reserve text + data
> 6) reserve initrd again and set virtual addresses of initrd_{start,end}
> 
> Maybe it's possible to merge (3) into (6) ?

That's kind of orthogonal to this patch series, but it's a valid
question, not sure I would want to tackle that just now though :)
-- 
Florian
