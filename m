From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 12 Nov 2018 16:37:44 -0800
Subject: [PATCH v4 6/6] arch: Move initrd= parsing into do_mounts_initrd.c
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075013A5929ED@us01wembx1.internal.synopsys.com>
References: <20181105225431.24485-1-f.fainelli@gmail.com>
 <20181105225431.24485-7-f.fainelli@gmail.com>
 <C2D7FE5348E1B147BCA15975FBA23075013A5929ED@us01wembx1.internal.synopsys.com>
Message-ID: <05f56763-1530-933d-2ce3-3653ad4c685f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/18 4:34 PM, Vineet Gupta wrote:
> On 11/5/18 2:58 PM, Florian Fainelli wrote:
>> ARC, ARM, ARM64 and Unicore32 are all capable of parsing the "initrd="
>> command line parameter to allow specifying the physical address and size
>> of an initrd. Move that parsing into init/do_mounts_initrd.c such that
>> we no longer duplicate that logic.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  arch/arc/mm/init.c       | 25 +++++--------------------
>>  arch/arm/mm/init.c       | 17 -----------------
>>  arch/arm64/mm/init.c     | 18 ------------------
>>  arch/unicore32/mm/init.c | 18 ------------------
>>  init/do_mounts_initrd.c  | 17 +++++++++++++++++
>>  5 files changed, 22 insertions(+), 73 deletions(-)
>>
>> diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
>> index f8fe5668b30f..43bf4c3a1290 100644
>> --- a/arch/arc/mm/init.c
>> +++ b/arch/arc/mm/init.c
>> @@ -78,24 +78,6 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
>>  		base, TO_MB(size), !in_use ? "Not used":"");
>>  }
>>  
>> -#ifdef CONFIG_BLK_DEV_INITRD
>> -static int __init early_initrd(char *p)
>> -{
>> -	unsigned long start, size;
>> -	char *endp;
>> -
>> -	start = memparse(p, &endp);
>> -	if (*endp == ',') {
>> -		size = memparse(endp + 1, NULL);
>> -
>> -		initrd_start = (unsigned long)__va(start);
>> -		initrd_end = (unsigned long)__va(start + size);
>> -	}
>> -	return 0;
>> -}
>> -early_param("initrd", early_initrd);
>> -#endif
>> -
>>  /*
>>   * First memory setup routine called from setup_arch()
>>   * 1. setup swapper's mm @init_mm
>> @@ -140,8 +122,11 @@ void __init setup_arch_memory(void)
>>  	memblock_reserve(low_mem_start, __pa(_end) - low_mem_start);
>>  
>>  #ifdef CONFIG_BLK_DEV_INITRD
>> -	if (initrd_start)
>> -		memblock_reserve(__pa(initrd_start), initrd_end - initrd_start);
>> +	if (phys_initrd_size) {
>> +		memblock_reserve(phys_initrd_start, phys_initrd_size);
>> +		initrd_start = (unsigned long)__va(phys_initrd_start);
>> +		initrd_end = initrd_start + phys_initrd_size;
>> +	}
>>  #endif
> 
> The common code now uses phys_initrd*, and you also use the same in ARC code, do
> we still need the initrd_* setting here ?
> ARC semantics was using them as PA anyways.

Yes, the generic initrd code expects initrd_start/end to be virtual
addresses, which we now directly derive from phys_initrd_start, that
should really be equivalent.
-- 
Florian
