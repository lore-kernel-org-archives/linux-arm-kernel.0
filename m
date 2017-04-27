From: liudongdong3@huawei.com (Dongdong Liu)
Date: Thu, 27 Apr 2017 09:46:15 +0800
Subject: [PATCH v4 00/21] PCI: fix config space memory mappings
In-Reply-To: <000501d2beb2$023b9100$06b2b300$@gmail.com>
References: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
 <2e24e205-d761-9172-9463-4a53e1a0de4d@jonmasters.org>
 <361fde15-5ba3-d33b-f946-003e89ba071f@huawei.com>
 <000501d2beb2$023b9100$06b2b300$@gmail.com>
Message-ID: <745824fc-016a-38b2-01a3-398399d4c80a@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017/4/27 1:24, Jingoo Han ??:
> On Wednesday, April 26, 2017 6:54 AM, Dongdong Liu wrote;
>>
>> Tested-by: Dongdong Liu <liudongdong3@huawei.com>
>>
>> I tested the patchset on HiSilicon ARM64 D05 board.It works ok with 82599
>> netcard.
>
> Thank you for testing these patches. HiSilicon PCIe may use Designware-based
> PCIe controller. In my opinion, other Designware-based PCIe controller will
> work properly.
>
> To Dongdong Liu, Khuong Dinh, and other people,
> If possible, can you check the output of 'lspci -v'?
> If you find something different, please share it with us.
> Good luck.

root@(none)$ ./lspci -v
0002:80:00.0 Class 0604: Device 19e5:1610 (rev 01)
         Flags: bus master, fast devsel, latency 0
         Memory at a9e00000 (32-bit, non-prefetchable) [size=64K]
         Bus: primary=80, secondary=81, subordinate=82, sec-latency=0
         I/O behind bridge: 00000000-00001fff
         Memory behind bridge: a8800000-a8ffffff
         Prefetchable memory behind bridge: 00000000a9000000-00000000a9dfffff
         Capabilities: [40] Power Management version 3
         Capabilities: [50] MSI: Enable- Count=1/32 Maskable+ 64bit+
         Capabilities: [70] Express Root Port (Slot-), MSI 00
         Capabilities: [100] Advanced Error Reporting
         Capabilities: [158] #19
         Capabilities: [178] #17
         Kernel driver in use: pcieport

0002:81:00.0 Class 0200: Device 8086:10fb (rev 01)
         Flags: bus master, fast devsel, latency 0, IRQ 255
         Memory at a9000000 (64-bit, prefetchable) [size=4M]
         I/O ports at 1000 [disabled] [size=32]
         Memory at a9800000 (64-bit, prefetchable) [size=16K]
         Expansion ROM at a8800000 [disabled] [size=4M]
         Capabilities: [40] Power Management version 3
         Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
         Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
         Capabilities: [a0] Express Endpoint, MSI 00
         Capabilities: [e0] Vital Product Data
         Capabilities: [100] Advanced Error Reporting
         Capabilities: [140] Device Serial Number 9c-37-f4-ff-ff-7b-5b-a0
         Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
         Capabilities: [160] Single Root I/O Virtualization (SR-IOV)
         Kernel driver in use: ixgbe

0002:81:00.1 Class 0200: Device 8086:10fb (rev 01)
         Flags: bus master, fast devsel, latency 0, IRQ 255
         Memory at a9400000 (64-bit, prefetchable) [size=4M]
         I/O ports at 1020 [disabled] [size=32]
         Memory at a9a04000 (64-bit, prefetchable) [size=16K]
         Expansion ROM at a8c00000 [disabled] [size=4M]
         Capabilities: [40] Power Management version 3
         Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
         Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
         Capabilities: [a0] Express Endpoint, MSI 00
         Capabilities: [e0] Vital Product Data
         Capabilities: [100] Advanced Error Reporting
         Capabilities: [140] Device Serial Number 9c-37-f4-ff-ff-7b-5b-a0
         Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
         Capabilities: [160] Single Root I/O Virtualization (SR-IOV)
         Kernel driver in use: ixgbe

0004:88:00.0 Class 0604: Device 19e5:1610 (rev 01)
         Flags: bus master, fast devsel, latency 0
         Memory at 8a9000000 (32-bit, non-prefetchable) [size=64K]
         Bus: primary=88, secondary=89, subordinate=89, sec-latency=0
         Capabilities: [40] Power Management version 3
         Capabilities: [50] MSI: Enable- Count=1/32 Maskable+ 64bit+
         Capabilities: [70] Express Root Port (Slot-), MSI 00
         Capabilities: [100] Advanced Error Reporting
         Capabilities: [158] #19
         Capabilities: [178] #17
         Kernel driver in use: pcieport

Thanks,
Dongdong
>
> Best regards,
> Jingoo Han
>
>>
>> Thanks,
>> Dongdong
>> ? 2017/4/25 14:40, Jon Masters ??:
>>> On 04/19/2017 12:48 PM, Lorenzo Pieralisi wrote:
>>>
>>>> On some platforms (ie ARM/ARM64) ioremap fails to comply with the PCI
>>>> configuration non-posted write transactions requirement, because it
>>>> provides a memory mapping that issues "bufferable" or, in PCI terms
>>>> "posted" write transactions. Likewise, the current pci_remap_iospace()
>>>> implementation maps the physical address range that the PCI translates
>>>> to I/O space cycles to virtual address space through pgprot_device()
>>>> attributes that on eg ARM64 provides a memory mapping issuing
>>>> posted writes transactions, which is not PCI specifications compliant.
>>>
>>> Side note that I've pinged all of the ARM server vendors and asked them
>>> to verify this patch series on their platforms.
>>>
>>> Jon.
>>>
>>> .
>>>
>
> .
>
