From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 21 Oct 2014 11:32:46 -0700
Subject: ARM: issue with memory reservation from DT
In-Reply-To: <54469161.50709@ti.com>
References: <543EAC5A.6050209@ti.com>
 <20141015175025.GJ27405@n2100.arm.linux.org.uk> <54400123.7040806@ti.com>
 <5440DD02.9020103@codeaurora.org> <5440EDC6.70300@ti.com>
 <544149CF.5080809@codeaurora.org> <54457534.5050607@codeaurora.org>
 <54469161.50709@ti.com>
Message-ID: <5446A6CE.7030506@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2014 10:01 AM, Grygorii Strashko wrote:
> Hi Laura,
>
> On 10/20/2014 11:48 PM, Laura Abbott wrote:
>> On 10/17/2014 9:54 AM, Laura Abbott wrote:
>>> On 10/17/2014 3:21 AM, Grygorii Strashko wrote:
>>>> Hi Laura,
>>>>
>>>> As I mentioned in first e-mail I've 1G Mem node initially:
>>>>     reg = <0x8 0x00000000 0x0 0x40000000>;
>>>>
>>>> and have memory reservation of 512M in the upper part of memory:
>>>>     reserved-memory {
>>>>      reg = <0x8 0x20000000 0x0 0x20000000>;
>>>>
>>>> then in sanity_check_meminfo() initial mem configuration calculated as
>>>> following:
>>>>
>>>> [    0.000000] ======= memblock_limit=0x000000082f800000
>>>> arm_lowmem_limit=0x000000082f800000 vmalloc_limit=ef800000
>>>> high_memory=0x000000082f800000
>>>> and memblock.current_limit == arm_lowmem_limit=0x000000082f800000
>>>>
>>>> then in arm_memblock_init()->early_init_fdt_scan_reserved_mem() 512M
>>>> of memory removed
>>>> (not reserved!, because "no-map;" is defined).
>>>>
>>>> After that Kernel will have only 512M of accessible memory
>>>>    memory[0x0]    [0x00000800000000-0x0000081fffffff]
>>>>
>>>> I've checked of_reserved_mem.c and saw no issues there :(
>>>>
>>>
>>> Yes, I suspect the issue is not with of_reserved_mem.c and instead with
>>> sanity_check_meminfo in mmu.c . I'm still traveling so I'll probably
>>> take a look on Monday unless I find some time sooner.
>>>
>>
>> I was able to reproduce a crash on my device by removing all highmem
>> as well. It looks like the logic assumes that lowmem limit will only
>> ever increase and not need to decrease. This seems like a limitation
>> of running with CONFIG_HIGHMEM on a system which doesn't actually
>> need highmem. This seems to have been the case even before the meminfo
>> removal as well. The following worked for me:
>>
>> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
>> index 9f98cec..6696016 100644
>> --- a/arch/arm/mm/mmu.c
>> +++ b/arch/arm/mm/mmu.c
>> @@ -1140,6 +1140,9 @@ void __init sanity_check_meminfo(void)
>>                   }
>>           }
>>
>> +       if (arm_lowmem_limit > memblock_end_of_DRAM())
>> +               arm_lowmem_limit = memblock_end_of_DRAM();
>> +
>>           high_memory = __va(arm_lowmem_limit - 1) + 1;
>>
>>           /*
>>
>>
>> I'll turn this into an official patch for review if it fixes your
>> problem as well.
>
> thanks you for your comments.
>
> No. It doesn't help :( because you've fixed sanity_check_meminfo()
> while I've the case when memory is removed (stolen) from arm_memblock_init()
> which, in turn, called after sanity_check_meminfo() - see setup_arch().
>

Okay, yes you are absolutely correct. I didn't read Russell's last
e-mail closely enough and was testing off of a different baseline
where the sanity_check_meminfo did actually fix.

> Below is last things I've found - It seems related to memZones configuration
> and in my case CONFIG_ZONE_DMA=y:
> == bad case:
> [    0.000000] ======= memblock_limit=0x000000082f800000 arm_lowmem_limit=0x000000082f800000 vmalloc_limit=ef800000 high_memory=0x000000082f800000
> [    0.000000] ======= min_low_pfn=800000 max_low_pfn=82F800 max_pfn=820000
> [    0.000000] ======= zone0 size2F800 holeF800
> [    0.000000] ======= zone1 size0 hole0
> [    0.000000] ======= zone2 sizeFFFF0800 holeFFFF0800
> [    0.000000] ======= zone3 size0 hole0
>
> == good case - can boot (with below fix applied):
> [    0.000000] ======= memblock_limit=0x000000082f800000 arm_lowmem_limit=0x000000082f800000 vmalloc_limit=ef800000 high_memory=0x000000082f800000
> [    0.000000] ======= min_low_pfn=800000 max_low_pfn=820000 max_pfn=820000
> [    0.000000] ======= zone0 size20000 hole0
> [    0.000000] ======= zone1 size0 hole0
> [    0.000000] ======= zone2 size0 hole0
> [    0.000000] ======= zone3 size0 hole0
>
> Also I've found, that before commit "ARM: 8025/1: Get rid of meminfo"
> the 'max_low_pfn' was calculated as below:
>
> -       struct meminfo *mi = &meminfo;
> -       int i;
> -
> -       /* This assumes the meminfo array is properly sorted */
> -       *min = bank_pfn_start(&mi->bank[0]);
> -       for_each_bank (i, mi)
> -               if (mi->bank[i].highmem)
> -                               break;
> -       *max_low = bank_pfn_end(&mi->bank[i - 1]);
>
> So, I've tried to roll back above functionality and I was able to boot with below change:
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -137,7 +137,19 @@ void show_mem(unsigned int filter)
>   static void __init find_limits(unsigned long *min, unsigned long *max_low,
>                                 unsigned long *max_high)
>   {
> -       *max_low = PFN_DOWN(memblock_get_current_limit());
> +       struct memblock_region *reg;
> +
> +       for_each_memblock(memory, reg) {
> +               if (reg->base >= memblock_get_current_limit())
> +                       break;
> +
> +               if ((reg->base + reg->size) > memblock_get_current_limit()) {
> +                       *max_low = PFN_DOWN(memblock_get_current_limit());
> +                       break;
> +               }
> +
> +               *max_low = PFN_DOWN(reg->base + reg->size);
> +       }
>          *min = PFN_UP(memblock_start_of_DRAM());
>          *max_high = PFN_DOWN(memblock_end_of_DRAM());
>   }
>

Yes, I think you've narrowed down the problem well. It seems like this
could be simplified though to

*max_low = min(PFN_DOWN(memblock_get_current_limit()),
			memblock_end_of_DRAM())

I haven't tested that though.

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
