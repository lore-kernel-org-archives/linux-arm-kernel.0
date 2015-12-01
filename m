From: sebastian_frias@sigmadesigns.com (Sebastian Frias)
Date: Tue, 1 Dec 2015 15:50:20 +0100
Subject: Virtual addresses, ioremap, vmalloc, etc
In-Reply-To: <565DB036.3010306@free.fr>
References: <565D8DA9.8040700@free.fr> <2755513.X6tENxzvXm@wuerfel>
 <565DB036.3010306@free.fr>
Message-ID: <565DB3AC.4010905@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/2015 03:35 PM, Mason wrote:
> On 01/12/2015 14:15, Arnd Bergmann wrote:
>> On Tuesday 01 December 2015 13:08:09 Mason wrote:
>>> Hello everyone,
>>>
>>> I was wondering if someone could help clear my confusion.
>>>
>>> In my company's legacy port (based on 3.4, dating back to 2.6) someone
>>> chose to map the first 16 MB of physical addresses using:
>>>
>>> static struct map_desc tango_map_desc[] __initdata = {
>>> 	{
>>> 		.virtual	= 0xf0000000,
>>> 		.pfn		=__phys_to_pfn(0),
>>> 		.length		= SZ_16M,
>>> 		.type 		= MT_DEVICE,
>>> 	},
>>> };
>>>
>>> static void __init tango_map_io(void)
>>> {
>>> 	iotable_init(tango_map_desc, ARRAY_SIZE(tango_map_desc));
>>> }
>>>
>>> Is the virtual address 0xf0000000 chosen arbitrary?
>>> Could I pick 0xf04200000 for example?
>>
>> It is arbitrary, but normally should be naturally aligned.
>>
>>> The same kernel, with no such boot-time mapping prints:
>>>
>>> [    0.000000] Memory: 641720K/655360K available (3135K kernel code, 109K rwdata, 1056K rodata, 3044K init, 218K bss, 13640K reserved, 0K cma-reserve)
>>> [    0.000000] Virtual kernel memory layout:
>>> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>>> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>>> [    0.000000]     vmalloc : 0xe8800000 - 0xff000000   ( 360 MB)
>>> [    0.000000]     lowmem  : 0xc0000000 - 0xe8000000   ( 640 MB)
>>>
>>> It looks like 0xf0000000 is in the middle of the vmalloc space.
>>> Is it a good idea to "statically" map something there?
>>
>> We deal with that on a lof of platforms that still use a static
>> mapping. I normally advocate not using that kind of mapping unless
>> you can show a measurable performance difference on your platform.
>>
>>> If I were to call ioremap(0, SZ_16M); at run-time, I would imagine
>>> the virtual address could be anywhere in the vmalloc space?
>>> There's no reason it would be 0xf0000000, right?
>>>
>>> In short, is virtual address 0xf0000000 special in any way?
>>> (Other than being in the vmalloc space perhaps.)
>>>
>>> For my own reference:
>>> https://www.kernel.org/doc/Documentation/arm/memory.txt
>>
>> I think 0xf0000000 is a common choice because that made an easy
>> computation back in the days when most platforms used an
>> io_p2v() to get a hardcoded virtual address, rather than calling
>> ioremap as we do today.
>
> Thanks for the detailed answer.
>
> One more thing: when I configure earlyprintk, I'm supposed to provide
> physical AND virtual address of the UART.
>
> If I'm not using a hard-coded P2V mapping, and instead rely on ioremap,
> how am I supposed to know the virtual address of the UART?
>
> Regards.
>

I think you can use anything as long as it is correctly aligned (w.r.t 
MMU specification)
There is a specific mapping setup in arch/arm/kernel/head.S by the 
addruart macro
