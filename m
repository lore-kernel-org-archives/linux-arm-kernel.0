From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 10 Sep 2015 16:21:59 +0100
Subject: [PATCH] arm64: Add support for hardware updates of the access
 and dirty pte bits
In-Reply-To: <55F19D57.70209@citrix.com>
References: <1436545468-1549-1-git-send-email-catalin.marinas@arm.com>
 <55F06A87.3000204@citrix.com> <20150910100753.GE12294@localhost>
 <55F19785.4090106@citrix.com> <55F199AE.2020003@arm.com>
 <55F19D57.70209@citrix.com>
Message-ID: <55F1A017.1020906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/15 16:10, Julien Grall wrote:
> On 10/09/15 15:54, Marc Zyngier wrote:
>> On 10/09/15 15:45, Julien Grall wrote:
>>> Hi,
>>>
>>> On 10/09/15 11:07, Catalin Marinas wrote:
>>>> On Wed, Sep 09, 2015 at 06:21:11PM +0100, Julien Grall wrote:
>>>>> I've tried to boot the latest linus/master (a794b4f) which include this
>>>>> patch as DOM0 on xgene. This is failing late in the boot with
>>>>> a BUG (see trace below).
>>>>>
>>>>> The bisector pointed me to this patch. When I disable
>>>>> CONFIG_ARM64_HW_AFDBM, I'm able to boot the kernel and use it
>>>>> without any issue.
>>>>>
>>>>> Although, I'm not sure to understand how this patch could
>>>>> possibly break the filesystem subsystem.
>>>>
>>>> I don't understand either. It seems that the kernel raises a BUG on
>>>> !PagePrivate but this patch never touches the page structure, only ptes.
>>>>
>>>> I recall to have tested it on XGene but I can try it again (bare metal).
>>>> Is the bare metal error for you the same?
>>>
>>> Same on bare-metal. I'm using Debian Jessie for the userspace and boot
>>> using U-boot:
>>>
>>> U-Boot 2013.04-mustang_sw_1.15.12 (May 20 2015 - 10:03:33)
>>>
>>> CPU0: APM ARM 64-bit Potenza Rev A3 2400MHz PCP 2400MHz
>>>      32 KB ICACHE, 32 KB DCACHE
>>>      SOC 2000MHz IOBAXI 400MHz AXI 250MHz AHB 200MHz GFC 125MHz
>>> Boot from SPI-NOR
>>> Slimpro FW:
>>>         Ver: 2.1
>>> Board: Mustang - AppliedMicro APM883208-xNA24SPT Reference Board
>>> I2C:   ready
>>> DRAM:  ECC 16 GiB @ 1600MHz
>>> SF: Detected N25Q256 with page size 256 Bytes, total 32 MiB
>>
>> Here's mine:
>>
>> U-Boot 2013.04-mustang_sw_1.13.28-beta (Aug 25 2014 - 14:16:10)
>>
>> CPU0: APM ARM 64-bit Potenza Rev A3 2400MHz PCP 2400MHz
>>      32 KB ICACHE, 32 KB DCACHE
>>      SOC 2000MHz IOBAXI 400MHz AXI 250MHz AHB 200MHz GFC 125MHz
>> Boot from SPI-NOR
>> SLIMpro FW 2.2
>> Board: Mustang - AppliedMicro APM887408 Reference Board
>> I2C:   ready
>> DRAM:  ECC 16 GiB @ 1600MHz
>> SF: Detected N25Q256 with page size 256 Bytes, total 32 MiB
>>
>> Same core, different board apparently. And of course an ancient U-Boot.
> 
> IIRC we had to update our firmware in order to get the correct GICD
> region [1].
> 
> Regards,
> 
> [1] http://lists.xen.org/archives/html/xen-devel/2015-04/msg02816.html

Quality stuff!!!

	M.
-- 
Jazz is not dead. It just smells funny...
