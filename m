From: monstr@monstr.eu (Michal Simek)
Date: Tue, 26 Mar 2013 11:45:23 +0100
Subject: [PATCH 04/10] arm: zynq: Load scu baseaddress at run time
In-Reply-To: <5150D0E7.90101@gmail.com>
References: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
 <1364219596-4954-4-git-send-email-michal.simek@xilinx.com>
 <515059D4.5070903@gmail.com>
 <CAHTX3dJfvFNNuyJC54fS=NCpRxovVsxHTss8wJd_QOB2PaxL7g@mail.gmail.com>
 <51506F31.2080709@gmail.com>
 <CAHTX3d+1auKVLko+LKAA+a4rh4Rfw19ggzmS7DhvYuuCAWUwHA@mail.gmail.com>
 <5150D0E7.90101@gmail.com>
Message-ID: <51517C43.20303@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 11:34 PM, Rob Herring wrote:
> On 03/25/2013 11:07 AM, Michal Simek wrote:
>> 2013/3/25 Rob Herring <robherring2@gmail.com>:
>>> On 03/25/2013 09:51 AM, Michal Simek wrote:
>>>> Hi Rob,
>>>>
>>>> 2013/3/25 Rob Herring <robherring2@gmail.com>:
>>>>> On 03/25/2013 08:53 AM, Michal Simek wrote:
>>>>>> Use Cortex a9 cp15 to read scu baseaddress.
>>>
>>> [...]
>>>
>>>>>> +static void __init scu_init(void)
>>>>>> +{
>>>>>> +     unsigned long base;
>>>>>> +
>>>>>> +     base = scu_a9_get_base();
>>>>>> +     zynq_cortex_a9_scu_map.pfn = __phys_to_pfn(base);
>>>>>> +     zynq_cortex_a9_scu_map.virtual = base;
>>>>>
>>>>> You are setting the virtual address to the physical base?
>>>>>
>>>>>> +     iotable_init(&zynq_cortex_a9_scu_map, 1);
>>>>>
>>>>> Then creating a static mapping...
>>>>>
>>>>>> +     scu_base = ioremap(base, zynq_cortex_a9_scu_map.length);
>>>>>
>>>>> And also a dynamic mapping?
>>>>
>>>> Yes - exactly.
>>>
>>> You are simply getting lucky that it works. If the physical address did
>>> not happen to be in the vmalloc address region, it would not work. You
>>> should not do this because you have an implicit requirement and the code
>>> will look broken to anyone that reads it.
>>
>> yeah correct. I will add there a comment to mentioned that.
>
> I think leaving the define would be better, but either way is fine.

ok. From my point of view is better to keep scu where it is and any early vmalloc
allocator will be really helpful. Because there is also early map
for early console where virtual addresses are hardcoded.
It will be just easier to ask generic code to return base if if you request
for size.

static unsigned long iomapstart = VMALLOC_END;

unsigned long get_iomap_virtbase(unsigned long size)
{
	iomapstart -= size;
	return iomapstart;
}

Something like this will be helpful and then instead of setup virtual
addresses for every static io mapping just to call this function
and you will get mapping correct all the time.


>>>> I was talking to Olof about this code at ELC and he mentioned that someone
>>>> else might know better way how to do it.
>>>>
>>>> It is quite a long time I played with this code.
>>>> I found this solution in vexpress platform (mach-vexpress/platsmp.c)
>>>>
>>>> IRC: Static mapping is necessary to be able to access device so early.
>>>
>>> Only to read the number of cores. That's not really worth an early
>>> mapping. I would move to using DT to count the number of cores. Support
>>> for that is already in place.
>>
>> What's the functions for that?
>>  From my point of view is better to read it directly on SoC and not to read
>> dts. It should be also faster.
>
> Actually, I think you just remove all the code related to
> set_cpu_possible().
>
> The relevant function is arm_dt_init_cpu_maps.

Ok. Thanks.

I will look at it but currently I prefer to cound number of cores
via scu because we are using too many dtses.

Thanks,
Michal



-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
