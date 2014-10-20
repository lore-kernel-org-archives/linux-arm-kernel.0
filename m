From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 20 Oct 2014 13:48:52 -0700
Subject: ARM: issue with memory reservation from DT
In-Reply-To: <544149CF.5080809@codeaurora.org>
References: <543EAC5A.6050209@ti.com>
 <20141015175025.GJ27405@n2100.arm.linux.org.uk> <54400123.7040806@ti.com>
 <5440DD02.9020103@codeaurora.org> <5440EDC6.70300@ti.com>
 <544149CF.5080809@codeaurora.org>
Message-ID: <54457534.5050607@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2014 9:54 AM, Laura Abbott wrote:
> On 10/17/2014 3:21 AM, Grygorii Strashko wrote:
>> Hi Laura,
>>
>> As I mentioned in first e-mail I've 1G Mem node initially:
>>    reg = <0x8 0x00000000 0x0 0x40000000>;
>>
>> and have memory reservation of 512M in the upper part of memory:
>>    reserved-memory {
>>     reg = <0x8 0x20000000 0x0 0x20000000>;
>>
>> then in sanity_check_meminfo() initial mem configuration calculated as
>> following:
>>
>> [    0.000000] ======= memblock_limit=0x000000082f800000
>> arm_lowmem_limit=0x000000082f800000 vmalloc_limit=ef800000
>> high_memory=0x000000082f800000
>> and memblock.current_limit == arm_lowmem_limit=0x000000082f800000
>>
>> then in arm_memblock_init()->early_init_fdt_scan_reserved_mem() 512M
>> of memory removed
>> (not reserved!, because "no-map;" is defined).
>>
>> After that Kernel will have only 512M of accessible memory
>>   memory[0x0]    [0x00000800000000-0x0000081fffffff]
>>
>> I've checked of_reserved_mem.c and saw no issues there :(
>>
>
> Yes, I suspect the issue is not with of_reserved_mem.c and instead with
> sanity_check_meminfo in mmu.c . I'm still traveling so I'll probably
> take a look on Monday unless I find some time sooner.
>

I was able to reproduce a crash on my device by removing all highmem
as well. It looks like the logic assumes that lowmem limit will only
ever increase and not need to decrease. This seems like a limitation
of running with CONFIG_HIGHMEM on a system which doesn't actually
need highmem. This seems to have been the case even before the meminfo
removal as well. The following worked for me:

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 9f98cec..6696016 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1140,6 +1140,9 @@ void __init sanity_check_meminfo(void)
                 }
         }

+       if (arm_lowmem_limit > memblock_end_of_DRAM())
+               arm_lowmem_limit = memblock_end_of_DRAM();
+
         high_memory = __va(arm_lowmem_limit - 1) + 1;

         /*


I'll turn this into an official patch for review if it fixes your
problem as well.

Thanks,
Laura
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
