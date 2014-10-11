From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 10 Oct 2014 20:04:57 -0400
Subject: [PATCH] ARM: keystone: add bus notifier to set dma_pfn_offset
 for pci devices
In-Reply-To: <54385187.6030002@ti.com>
References: <1412954137-4567-1-git-send-email-m-karicheri2@ti.com>
 <7733803.LRHUrkheId@wuerfel> <54385187.6030002@ti.com>
Message-ID: <54387429.2030605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/10/14 5:37 PM, Murali Karicheri wrote:
> On 10/10/2014 02:22 PM, Arnd Bergmann wrote:
>> On Friday 10 October 2014 11:15:37 Murali Karicheri wrote:
>>> @@ -54,6 +55,8 @@ static void __init keystone_init(void)
>>>          keystone_pm_runtime_init();
>>>          if (platform_nb.notifier_call)
>>>                  bus_register_notifier(&platform_bus_type,&platform_nb);
>>> +       if (platform_nb.notifier_call)
>>> +               bus_register_notifier(&pci_bus_type,&platform_nb);
>>>          of_platform_populate(NULL, of_default_bus_match_table, NULL,
>>> NULL);
>>>
>>
>> No, this looks very wrong. Santosh spent an enormous effort on obsoleting
>> the platform notifier block by adding the range parser to the platform
>> device probe path.
>>
>> You should really remove platform_nb and all associated code rather than
>> adding more code to it.
>>
>> NAK
>>
>>     Arnd
> Arnd,
>
> I took a look at the recent work from Santosh where he has introduced
> dma-range property to set the dma_pfn_offset for platform devices. Are
> you referring to this commit below?
>
Its the correct commit.

> commit 591c1ee465ce5372385dbc41e7d3e36cbb477bd8
> Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date:   Thu Apr 24 11:30:04 2014 -0400
>
>      of: configure the platform device dma parameters
>
>      Retrieve DMA configuration from DT and setup platform device's DMA
>      parameters. The DMA configuration in DT has to be specified using
>      "dma-ranges" and "dma-coherent" properties if supported.
>
>      We setup dma_pfn_offset using "dma-ranges" and dma_coherent_ops
>      using "dma-coherent" device tree properties.
>
>      The set_arch_dma_coherent_ops macro has to be defined by arch if
>      it supports coherent dma_ops. Otherwise,
> set_arch_dma_coherent_ops() is
>      declared as nop.
>
> Based on this, dma configuration parameters get set for the device which
> is probed through DT.
>
> As PCI devices are attached to the PCI bus during scan, and we don't
> have DT nodes, we could use similar mechanism to pass the dma-range info
> from parent host platform device to the PCI devices by adding an
> of_pci_dma_configure() API and hook it to the PCI probe path some where?
> Please comment on this so that I can work on the right solution to
> address this issue for Keystone.
>
Adding the DT node parsing code in PCI bus probe path is the right way
to go about it. You could re-use some of the helpers from dma parsing
code.

I let Arnd comment if he disagrees, otherwise I suggest to create an
RFC patch and post it on the list. We can take it from there.

That also reminded me xhci host code issue with dma-ranges since the
devices are manually created there. I will review that thread as
well after this merge window.

Regards,
Santosh
