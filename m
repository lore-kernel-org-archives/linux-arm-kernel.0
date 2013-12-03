From: sourav.poddar@ti.com (Sourav Poddar)
Date: Tue, 3 Dec 2013 19:20:37 +0530
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <201312031442.00141.marex@denx.de>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <201312030059.25628.marex@denx.de> <529DABF9.2030704@ti.com>
 <201312031442.00141.marex@denx.de>
Message-ID: <529DE1AD.8030101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marek Vasut,
On Tuesday 03 December 2013 07:12 PM, Marek Vasut wrote:
> Dear Sourav Poddar,
>
>> Dear Marek Vasut,
>>
>> On Tuesday 03 December 2013 05:29 AM, Marek Vasut wrote:
>>> Dear Sourav Poddar,
>>>
>>>> Dear Marek Vasut,
>>>>
>>>> On Wednesday 27 November 2013 03:36 PM, Marek Vasut wrote:
>>>>> Dear Sourav Poddar,
>>>>>
>>>>>> Dear Marek Vasut, Huang,
>>>>>>
>>>>>> On Wednesday 27 November 2013 02:57 PM, Marek Vasut wrote:
>>>>>>> Dear Huang Shijie,
>>>>>>>
>>>>>>>> 1.) Why add a new framework for SPI NOR?
>>>>>>>>
>>>>>>>>       The SPI-NOR controller such as Freescale's Quadspi controller
>>>>>>>>       is working in a different way from the SPI bus. It should
>>>>>>>>       knows the NOR commands to find the right LUT sequence.
>>>>>>>>       Unfortunately, the current code can not meet this requirement.
>>>>>>> Is there any kind of documentation for this controller available? I
>>>>>>> cannot quite understand how this controller works and why can it not
>>>>>>> be used with our current infrastructure.
>>>>>> I do have a similar requirement where my controller need to be
>>>>>> configured from slave info. I have submiited a series in the mtd list
>>>>>> adding that portion
>>>>>> of handling such cases. Here, is the patch which specific to m25p80
>>>>>> part. http://patchwork.ozlabs.org/patch/294285/
>>>>>>
>>>>>> The whole series can be found here:
>>>>>> https://www.mail-archive.com/linux-omap at vger.kernel.org/msg98691.html
>>>>> Is this TI QSPI the same thing as the Altera QSPI controller please ?
>>>> No, its differenet.
>>>>
>>>>> Otherwise, I seriously believe you and Huang should work on a common
>>>>> infrastructure. I would first like to understand how is the controller
>>>>> in DRA7xx different from regular SPI controller though. Is there any
>>>>> kind of documentation I could study please?
>>>> Sorry, we dont have a public document yet.
>>> Sorry for the delayed reply. I am processing the input on the QSPI and
>>> I'm finally starting to understand what's going on in here.
>> Thanks for the response.
>>
>>>> Though, this is what ti qspi contoller has
>>>>
>>>> It supports two modes of operation, one is SPI mode(normal), other is
>>>> the memory mapped read mode.
>>>>
>>>> For SPI mode, the state machine remains the same as it is with other spi
>>>> controller
>>>> available.
>>>>
>>>> For memory mapped, there is something more which we need to do around ..
>>>>
>>>> 1. There is a qspi "set up" register available, which needs to be filled
>>>> with
>>>>
>>>>         information like flash opcode, dummy bytes etc. In short, flash
>>>>
>>>> specific
>>>>
>>>>         details.
>>>>
>>>> 2   if the above register is configured with the required opcodes, then
>>>> whenever
>>>>
>>>>         we need to use memory mapped operations, we need to do is to
>>>>
>>>> switch our
>>>>
>>>>         qspi controller to memory mapped mode.
>>>>
>>>>        Switching of this mode to memory mapped needs
>>>>
>>>>         a )  write to a particular qspi register
>>>>         b)   write to control module(optional based on SOC).
>>>>
>>>> 3. Once the above steps are configured, then the flash data will be
>>>> mapped to a
>>>>
>>>>        particular memory address(SOC specific) from where the flash data
>>>>
>>>> can be read.
>>> OK, but is the memory mapped mode of any use (but for booting I suppose)
>>> ? How does it handle large SPI NOR flashes (we have spansion devices as
>>> big as 128MiB), does it really hog a _large_ amount of address space
>>> from the CPU address space ? Or is the operation somehow indexed ? Why
>>> is it better than using DMA?
>> Memory mapped will be of use whenever we try to read the flash content.
>> Instead of going through the entire SPI framework, and raising
>> interrupts, we can
>> memcpy the flash contents. I am using it for mounting a jffs2 filesystem.
>>
>> For me the memory mapped regions are like in the range 5c000000 -
>> 5fffffff, so
>> I can handle flash as large as 64MB.
>>
>> As far as its comparison with DMA is concerned, I cant comment much
>> about it.
>> My Qspi controller does not support DMA :(:(. So, memory mapped becomes the
>> best option option for me.
> OK, understood. So to sling large chunks of memory from SPI NOR to your DRAM,
> you need to issue these two steps in a loop:
>
> 1) write into the controller register the starting address of the SPI flash
> which you want to have available via the mmap interface
> 2) memcpy() from this mmaped area to DRAM
>
> correct? Won't the second step be pretty CPU-intensive

No, we dont need to write the starting address in any register.

1. we need to write opcodes(flash specific) in a qspi set up register.
2. Switch to mmap mode using qspi SWITCH register.

Memory mapped address need to be avilable though to m25p80_read api to
do memcpy, which is currently done by get_buf api.

We dont need to do the steps in a loop.
Point1 above is one time configurable.
point2 above need to be done whenever we want to use mmap operations.

memcpy(buf, base_addr + from, len) , where   len <= min(FLASH_SIZE, MMAP 
region)
