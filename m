From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 25 Nov 2016 10:49:08 +0000
Subject: [RFC PATCH 04/11] PCI: tegra: limit to MMU build only
In-Reply-To: <20161122112619.GA22862@ulmo.ba.sec>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <11637152.Dd0IBkEQ8q@wuerfel> <58341297.9090303@arm.com>
 <28079479.jInxCWkYlm@wuerfel> <20161122112619.GA22862@ulmo.ba.sec>
Message-ID: <58381724.5090802@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/11/16 11:26, Thierry Reding wrote:
> On Tue, Nov 22, 2016 at 10:54:01AM +0100, Arnd Bergmann wrote:
>> On Tuesday, November 22, 2016 9:40:39 AM CET Vladimir Murzin wrote:
>>> On 22/11/16 09:31, Arnd Bergmann wrote:
>>>> On Tuesday, November 22, 2016 9:26:01 AM CET Vladimir Murzin wrote:
>>>>> This driver uses functionality which available for MMU build only,
>>>>> thus add dependency on MMU.
>>>>>
>>>>> Cc: Thierry Reding <thierry.reding@gmail.com>
>>>>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>>>>>
>>>>
>>>> Can you be more specific about what requires the MMU here?
>>>>
>>>> Is it the I/O space remapping or something else?
>>>
>>> Yes it comes from I/O space remapping.
>>>
>>> The fill error log:
>>>
>>>   CC      drivers/pci/host/pci-tegra.o
>>> In file included from ./arch/arm/include/asm/page.h:22:0,
>>>                  from ./arch/arm/include/asm/thread_info.h:17,
>>>                  from ./include/linux/thread_info.h:58,
>>>                  from ./include/asm-generic/current.h:4,
>>>                  from ./arch/arm/include/generated/asm/current.h:1,
>>>                  from ./include/linux/mutex.h:13,
>>>                  from ./include/linux/notifier.h:13,
>>>                  from ./include/linux/clk.h:17,
>>>                  from drivers/pci/host/pci-tegra.c:29:
>>> drivers/pci/host/pci-tegra.c: In function 'tegra_pcie_bus_alloc':
>>> drivers/pci/host/pci-tegra.c:388:27: error: 'L_PTE_PRESENT' undeclared (first use in this function)
>>>   pgprot_t prot = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
>>
>>
>> That is not the I/O space, that is the config space.
>>
>> Not sure what a better alternative would be, but the manual selection
>> of page flags makes the driver non-portable and dependent on architecture
>> specifics that it really shouldn't have to worry about.
>>
>> In common PCI code, we use pgprot_device(PAGE_KERNEL)) at some point,
>> and that sounds like the right thing to do, but ARM doesn't provide
>> an override for it and the fallback is pgprot_noncached(), which is
>> probably wrong here.
> 
> Actually I think pgprot_noncached() is correct. Very early on we used to
> map this using ioremap() and I remember that working. I also just tested
> the pci-tegra driver with pgprot_device(PAGE_KERNEL) instead of the ARM-
> specific flags and it seems to work well.
> 

I did try that, but tegra_pcie_bus_alloc() calls get_vm_area() so

drivers/built-in.o: In function `tegra_pcie_add_bus':
:(.text+0x7763c): undefined reference to `get_vm_area'
make: *** [vmlinux] Error 1

Cheers
Vladimir

> Thierry
> 
