From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 8 Mar 2017 16:31:13 -0800
Subject: pcie-iproc: broken 2nd (& 3rd?) controller support by
 c3245a566400 ("PCI: iproc: Request host bridge window resources")
In-Reply-To: <4acf85df-d5d0-6a01-b331-3158d0233a0e@gmail.com>
References: <faab6b85-58e8-3e62-8763-56a94b13fba1@gmail.com>
 <88dc6a0e-8989-d09f-1f93-6673a31664c1@broadcom.com>
 <4acf85df-d5d0-6a01-b331-3158d0233a0e@gmail.com>
Message-ID: <2e24d751-bca1-df51-cbd8-0eaa4a1c209f@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/8/2017 3:28 PM, Rafa? Mi?ecki wrote:
> On 03/08/2017 06:22 PM, Ray Jui wrote:
>> On 3/8/2017 4:56 AM, Rafa? Mi?ecki wrote:
>>> I just tried upgrading BCM5301X from 4.4 to 4.9 and noticed I don't see
>>> card
>>> connected to the 2nd controller.
>>>
>>> [    2.593534] pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
>>> [    2.599786] pci_bus 0000:00: root bus resource [mem
>>> 0x08000000-0x0fffffff]
>>> [    2.606663] pcie_iproc_bcma bcma0:7: link: UP
>>> [    2.611316] PCI: bus0: Fast back to back transfers disabled
>>> [    2.616899] pci 0000:00:00.0: bridge configuration invalid ([bus
>>> 00-00]), reconfiguring
>>> [    2.625395] PCI: bus1: Fast back to back transfers disabled
>>> [    2.631011] pci 0000:00:00.0: BAR 8: assigned [mem
>>> 0x08000000-0x080fffff]
>>> [    2.637795] pci 0000:01:00.0: BAR 0: assigned [mem
>>> 0x08000000-0x08007fff 64bit]
>>> [    2.645091] pci 0000:00:00.0: PCI bridge to [bus 01]
>>> [    2.650042] pci 0000:00:00.0:   bridge window [mem
>>> 0x08000000-0x080fffff]
>>>
>>> [    2.657199] pcie_iproc_bcma bcma0:8: resource collision: [mem
>>> 0x40000000-0x47ffffff] conflicts with PCIe MEM space [mem
>>> 0x40000000-0x47ffffff]
>>> [    2.669946] pcie_iproc_bcma bcma0:8: PCIe controller setup failed
>>> [    2.676032] pcie_iproc_bcma: probe of bcma0:8 failed with error -16
>>>
>>
>> Would you be able to add some debugging trace to see when the resource
>> was allocated the first time, and when the resource was allocated the
>> second time and therefore results in the conflict?
>>
>> In addition, I'm puzzled why this resource conflict issue for BCMA is
>> not seen with the first controller with outbound memory in the range of
>> 0x08000000 - 0x0fffffff? Maybe that provides a valuable data point here.
> 
> This is clearly a conflict between iproc on 1st controller and iproc on
> 2nd controller.
> 
> I added following code to the pcie-iproc-bcma.c:
> if (bdev->core_unit == 0) {
>     dev_info(dev, "[%s] aborting\n", __func__);
>     return -ENOTSUPP;
> }
> 
> And it resulted in 2nd controller (bcma0:8) working again:

This is what puzzled me. The first controller is using the following
outbound window: 0x8000000 - 0x0fffffff

The 2nd controller is using:
0x40000000 - 0x400fffff

They should not conflict with each other.

> [    2.472562] pcie_iproc_bcma bcma0:7: [iproc_pcie_bcma_probe] aborting
> [    2.479027] pcie_iproc_bcma: probe of bcma0:7 failed with error -524
> [    2.607425] pcie_iproc_bcma bcma0:8: PCI host bridge to bus 0000:00
> [    2.613678] pci_bus 0000:00: root bus resource [mem
> 0x40000000-0x47ffffff]
> [    2.620557] pcie_iproc_bcma bcma0:8: link: UP
> [    2.625206] PCI: bus0: Fast back to back transfers disabled
> [    2.630789] pci 0000:00:00.0: bridge configuration invalid ([bus
> 00-00]), reconfiguring
> [    2.639260] PCI: bus1: Fast back to back transfers disabled
> [    2.644871] pci 0000:00:00.0: BAR 8: assigned [mem
> 0x40000000-0x400fffff]
> [    2.651665] pci 0000:01:00.0: BAR 0: assigned [mem
> 0x40000000-0x40007fff 64bit]
> [    2.658962] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    2.663911] pci 0000:00:00.0:   bridge window [mem
> 0x40000000-0x400fffff]
> 
> I'm not exactly sure where this conflict is coming from. For debugging
> purposes I added:
> dev_info(dev, "[%s] res_mem:%pR\n", __func__, &res_mem);
> 
> Which resulted in:
> [    2.474558] pcie_iproc_bcma bcma0:7: [iproc_pcie_bcma_probe]
> res_mem:[mem 0x08000000-0x0fffffff]
> [    2.597246] pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
> [    2.603500] pci_bus 0000:00: root bus resource [mem
> 0x08000000-0x0fffffff]
> [    2.610382] pcie_iproc_bcma bcma0:7: link: UP
> [    2.615032] PCI: bus0: Fast back to back transfers disabled
> [    2.620619] pci 0000:00:00.0: bridge configuration invalid ([bus
> 00-00]), reconfiguring
> [    2.629131] PCI: bus1: Fast back to back transfers disabled
> [    2.634745] pci 0000:00:00.0: BAR 8: assigned [mem
> 0x08000000-0x080fffff]
> [    2.641537] pci 0000:01:00.0: BAR 0: assigned [mem
> 0x08000000-0x08007fff 64bit]
> [    2.648835] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    2.653783] pci 0000:00:00.0:   bridge window [mem
> 0x08000000-0x080fffff]
> [    2.660947] pcie_iproc_bcma bcma0:8: [iproc_pcie_bcma_probe]
> res_mem:[mem 0x40000000-0x47ffffff]
> [    2.669732] pcie_iproc_bcma bcma0:8: resource collision: [mem
> 0x40000000-0x47ffffff] conflicts with PCIe MEM space [mem
> 0x40000000-0x47ffffff]

Someone must have reserved 0x40000000-0x47ffffff silently somewhere, as
this is what the kernel complains about.

Btw, this code is from devm_request_resource in kernel/resource.c

> [    2.682470] pcie_iproc_bcma bcma0:8: PCIe controller setup failed
> [    2.688559] pcie_iproc_bcma: probe of bcma0:8 failed with error -16
> 
> There shouldn't be any conflict between 0x08000000-0x0fffffff and
> 0x40000000-0x47ffffff, right?

Correct. You need to figure out when 0x40000000-0x47ffffff was reserved
previously.

> 
> For bcma we do this:
> res_mem.start = bdev->addr_s[0];
> res_mem.end = bdev->addr_s[0] + SZ_128M - 1;
> 
> In case of BCM4708 there are following addresses:
> [    2.285430] bcma: bus0: Core 7 found: PCIe Gen 2 (manuf 0x4BF, id
> 0x501, rev 0x01, class 0x0)    addr:0x18012000 wrap:0x18101000
> addr_s[0]:0x08000000 addr_s[1]:0x00000000
> [    2.300384] bcma: bus0: Core 8 found: PCIe Gen 2 (manuf 0x4BF, id
> 0x501, rev 0x01, class 0x0)    addr:0x18013000 wrap:0x18102000
> addr_s[0]:0x40000000 addr_s[1]:0x00000000
> which matches what we see in the boot log.
