From: kdinh@apm.com (Khuong Dinh)
Date: Thu, 27 Apr 2017 09:42:16 -0700
Subject: [PATCH v4 00/21] PCI: fix config space memory mappings
In-Reply-To: <745824fc-016a-38b2-01a3-398399d4c80a@huawei.com>
References: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
 <2e24e205-d761-9172-9463-4a53e1a0de4d@jonmasters.org>
 <361fde15-5ba3-d33b-f946-003e89ba071f@huawei.com>
 <000501d2beb2$023b9100$06b2b300$@gmail.com>
 <745824fc-016a-38b2-01a3-398399d4c80a@huawei.com>
Message-ID: <CAAsHzqtOR-Sv0ocU86fUoJEJSFkMKXPXrGPa9JV-G_5tPTFXBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
  They're same before and after applying the patch.
  It was tested with X-Gene 1 and X-Gene 2 with DT (Device Tree) and ACPI boot.

  X-Gene 1 - DT :
[root@(none) ~]# lspci -s 01:00.0 -v
01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
        Subsystem: Intel Corporation Gigabit CT Desktop Adapter
        Flags: bus master, fast devsel, latency 0, IRQ 68
        Memory at e1800c0000 (32-bit, non-prefetchable) [size=128K]
        Memory at e180000000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at 1000 [disabled] [size=32]
        Memory at e1800e0000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at e180080000 [disabled] [size=256K]
        Capabilities: [c8] Power Management version 2
        Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [e0] Express Endpoint, MSI 00
        Capabilities: [a0] MSI-X: Enable+ Count=5 Masked-
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 00-1b-21-ff-ff-4f-68-3d
        Kernel driver in use: e1000e

  X-Gene 1 - ACPI :
[root@(none) ~]# lspci -s 01:00.0 -v
01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
        Subsystem: Intel Corporation Gigabit CT Desktop Adapter
        Flags: bus master, fast devsel, latency 0, IRQ 117
        Memory at e0400c0000 (32-bit, non-prefetchable) [size=128K]
        Memory at e040000000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at 1000 [disabled] [size=32]
        Memory at e0400e0000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at e040080000 [disabled] [size=256K]
        Capabilities: [c8] Power Management version 2
        Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [e0] Express Endpoint, MSI 00
        Capabilities: [a0] MSI-X: Enable- Count=5 Masked-
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 00-1b-21-ff-ff-4f-68-3d
        Kernel driver in use: e1000e

 X-Gene 2 - DT :
[root@(none) ~]# lspci -s 0000:01:00.0 -v
0000:01:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit
Ethernet Controller (Copper) (rev 06)
        Subsystem: Intel Corporation PRO/1000 PT Desktop Adapter
        Flags: bus master, fast devsel, latency 0, IRQ 49
        Memory at c120000000 (32-bit, non-prefetchable) [size=128K]
        Memory at c120020000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at 1000 [disabled] [size=32]
        Expansion ROM at c120040000 [disabled] [size=128K]
        Capabilities: [c8] Power Management version 2
        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [e0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 00-1b-21-ff-ff-1e-84-4e
        Kernel driver in use: e1000e

 X-Gene 2 - ACPI :
[root@(none) ~]# lspci -s 0000:01:00.0 -v
0000:01:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit
Ethernet Controller (Copper) (rev 06)
        Subsystem: Intel Corporation PRO/1000 PT Desktop Adapter
        Flags: bus master, fast devsel, latency 0, IRQ 93
        Memory at c040000000 (32-bit, non-prefetchable) [size=128K]
        Memory at c040020000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at 1000 [disabled] [size=32]
        Expansion ROM at c040040000 [disabled] [size=128K]
        Capabilities: [c8] Power Management version 2
        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [e0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 00-1b-21-ff-ff-1e-84-4e
        Kernel driver in use: e1000e

Best regards,
Khuong Dinh

On Wed, Apr 26, 2017 at 6:46 PM, Dongdong Liu <liudongdong3@huawei.com> wrote:
>
>
> ? 2017/4/27 1:24, Jingoo Han ??:
>>
>> On Wednesday, April 26, 2017 6:54 AM, Dongdong Liu wrote;
>>>
>>>
>>> Tested-by: Dongdong Liu <liudongdong3@huawei.com>
>>>
>>> I tested the patchset on HiSilicon ARM64 D05 board.It works ok with 82599
>>> netcard.
>>
>>
>> Thank you for testing these patches. HiSilicon PCIe may use
>> Designware-based
>> PCIe controller. In my opinion, other Designware-based PCIe controller
>> will
>> work properly.
>>
>> To Dongdong Liu, Khuong Dinh, and other people,
>> If possible, can you check the output of 'lspci -v'?
>> If you find something different, please share it with us.
>> Good luck.
>
>
> root@(none)$ ./lspci -v
> 0002:80:00.0 Class 0604: Device 19e5:1610 (rev 01)
>         Flags: bus master, fast devsel, latency 0
>         Memory at a9e00000 (32-bit, non-prefetchable) [size=64K]
>         Bus: primary=80, secondary=81, subordinate=82, sec-latency=0
>         I/O behind bridge: 00000000-00001fff
>         Memory behind bridge: a8800000-a8ffffff
>         Prefetchable memory behind bridge: 00000000a9000000-00000000a9dfffff
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable- Count=1/32 Maskable+ 64bit+
>         Capabilities: [70] Express Root Port (Slot-), MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [158] #19
>         Capabilities: [178] #17
>         Kernel driver in use: pcieport
>
> 0002:81:00.0 Class 0200: Device 8086:10fb (rev 01)
>         Flags: bus master, fast devsel, latency 0, IRQ 255
>         Memory at a9000000 (64-bit, prefetchable) [size=4M]
>         I/O ports at 1000 [disabled] [size=32]
>         Memory at a9800000 (64-bit, prefetchable) [size=16K]
>         Expansion ROM at a8800000 [disabled] [size=4M]
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
>         Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
>         Capabilities: [a0] Express Endpoint, MSI 00
>         Capabilities: [e0] Vital Product Data
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [140] Device Serial Number 9c-37-f4-ff-ff-7b-5b-a0
>         Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
>         Capabilities: [160] Single Root I/O Virtualization (SR-IOV)
>         Kernel driver in use: ixgbe
>
> 0002:81:00.1 Class 0200: Device 8086:10fb (rev 01)
>         Flags: bus master, fast devsel, latency 0, IRQ 255
>         Memory at a9400000 (64-bit, prefetchable) [size=4M]
>         I/O ports at 1020 [disabled] [size=32]
>         Memory at a9a04000 (64-bit, prefetchable) [size=16K]
>         Expansion ROM at a8c00000 [disabled] [size=4M]
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
>         Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
>         Capabilities: [a0] Express Endpoint, MSI 00
>         Capabilities: [e0] Vital Product Data
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [140] Device Serial Number 9c-37-f4-ff-ff-7b-5b-a0
>         Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
>         Capabilities: [160] Single Root I/O Virtualization (SR-IOV)
>         Kernel driver in use: ixgbe
>
> 0004:88:00.0 Class 0604: Device 19e5:1610 (rev 01)
>         Flags: bus master, fast devsel, latency 0
>         Memory at 8a9000000 (32-bit, non-prefetchable) [size=64K]
>         Bus: primary=88, secondary=89, subordinate=89, sec-latency=0
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable- Count=1/32 Maskable+ 64bit+
>         Capabilities: [70] Express Root Port (Slot-), MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [158] #19
>         Capabilities: [178] #17
>         Kernel driver in use: pcieport
>
> Thanks,
> Dongdong
>>
>>
>> Best regards,
>> Jingoo Han
>>
>>>
>>> Thanks,
>>> Dongdong
>>> ? 2017/4/25 14:40, Jon Masters ??:
>>>>
>>>> On 04/19/2017 12:48 PM, Lorenzo Pieralisi wrote:
>>>>
>>>>> On some platforms (ie ARM/ARM64) ioremap fails to comply with the PCI
>>>>> configuration non-posted write transactions requirement, because it
>>>>> provides a memory mapping that issues "bufferable" or, in PCI terms
>>>>> "posted" write transactions. Likewise, the current pci_remap_iospace()
>>>>> implementation maps the physical address range that the PCI translates
>>>>> to I/O space cycles to virtual address space through pgprot_device()
>>>>> attributes that on eg ARM64 provides a memory mapping issuing
>>>>> posted writes transactions, which is not PCI specifications compliant.
>>>>
>>>>
>>>> Side note that I've pinged all of the ARM server vendors and asked them
>>>> to verify this patch series on their platforms.
>>>>
>>>> Jon.
>>>>
>>>> .
>>>>
>>
>> .
>>
>

-- 
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and contains information that 
is confidential and proprietary to Applied Micro Circuits Corporation or 
its subsidiaries. It is to be used solely for the purpose of furthering the 
parties' business relationship. All unauthorized review, use, disclosure or 
distribution is prohibited. If you are not the intended recipient, please 
contact the sender by reply e-mail and destroy all copies of the original 
message.
