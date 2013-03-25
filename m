From: monstr@monstr.eu (Michal Simek)
Date: Mon, 25 Mar 2013 17:07:20 +0100
Subject: [PATCH 04/10] arm: zynq: Load scu baseaddress at run time
In-Reply-To: <51506F31.2080709@gmail.com>
References: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
 <1364219596-4954-4-git-send-email-michal.simek@xilinx.com>
 <515059D4.5070903@gmail.com>
 <CAHTX3dJfvFNNuyJC54fS=NCpRxovVsxHTss8wJd_QOB2PaxL7g@mail.gmail.com>
 <51506F31.2080709@gmail.com>
Message-ID: <CAHTX3d+1auKVLko+LKAA+a4rh4Rfw19ggzmS7DhvYuuCAWUwHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/25 Rob Herring <robherring2@gmail.com>:
> On 03/25/2013 09:51 AM, Michal Simek wrote:
>> Hi Rob,
>>
>> 2013/3/25 Rob Herring <robherring2@gmail.com>:
>>> On 03/25/2013 08:53 AM, Michal Simek wrote:
>>>> Use Cortex a9 cp15 to read scu baseaddress.
>
> [...]
>
>>>> +static void __init scu_init(void)
>>>> +{
>>>> +     unsigned long base;
>>>> +
>>>> +     base = scu_a9_get_base();
>>>> +     zynq_cortex_a9_scu_map.pfn = __phys_to_pfn(base);
>>>> +     zynq_cortex_a9_scu_map.virtual = base;
>>>
>>> You are setting the virtual address to the physical base?
>>>
>>>> +     iotable_init(&zynq_cortex_a9_scu_map, 1);
>>>
>>> Then creating a static mapping...
>>>
>>>> +     scu_base = ioremap(base, zynq_cortex_a9_scu_map.length);
>>>
>>> And also a dynamic mapping?
>>
>> Yes - exactly.
>
> You are simply getting lucky that it works. If the physical address did
> not happen to be in the vmalloc address region, it would not work. You
> should not do this because you have an implicit requirement and the code
> will look broken to anyone that reads it.

yeah correct. I will add there a comment to mentioned that.

>> I was talking to Olof about this code at ELC and he mentioned that someone
>> else might know better way how to do it.
>>
>> It is quite a long time I played with this code.
>> I found this solution in vexpress platform (mach-vexpress/platsmp.c)
>>
>> IRC: Static mapping is necessary to be able to access device so early.
>
> Only to read the number of cores. That's not really worth an early
> mapping. I would move to using DT to count the number of cores. Support
> for that is already in place.

What's the functions for that?
>From my point of view is better to read it directly on SoC and not to read
dts. It should be also faster.

>> On the other hand you can't use this static mapping when kernel runs
>> for that you need to use dynamic allocation.
>> Calling ioremap so early caused that the return address is the same
>> and you can just use it later. and it is also in the correct vmalloc area.
>>
>> We are using scu_base for power management code.
>> Let me check if dynamic mapping is also required.
>
> The should be no reason you need both.

I have done some tests and that ioremap could be probably removed.
Pawel: You are the author of this code in vexpress. Is there any
particular reason
to have there that ioremap?

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
