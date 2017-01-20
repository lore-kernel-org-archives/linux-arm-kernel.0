From: julien.grall@arm.com (Julien Grall)
Date: Fri, 20 Jan 2017 14:10:33 +0100
Subject: [Xen-devel] [RFC] Device memory mappings for Dom0 on ARM64 ACPI
 systems
In-Reply-To: <20170120110114.2ajkmmhxhhbc6acl@dhcp-3-221.uk.xensource.com>
References: <alpine.DEB.2.10.1701171309040.2347@sstabellini-ThinkPad-X260>
 <20170118110243.ctqpperggim5k7dw@dhcp-3-221.uk.xensource.com>
 <alpine.DEB.2.10.1701181058110.10192@sstabellini-ThinkPad-X260>
 <20c89f12-cb0c-1145-99d0-320b2080b503@arm.com>
 <20170119154129.7dnjzvq23jop7oye@dhcp-3-221.uk.xensource.com>
 <alpine.DEB.2.10.1701191002330.10192@sstabellini-ThinkPad-X260>
 <94e89cb4-f40c-585e-b3e8-d9f8f58b53d9@arm.com>
 <20170120110114.2ajkmmhxhhbc6acl@dhcp-3-221.uk.xensource.com>
Message-ID: <a40dda2b-e6f3-3222-9b56-9208d96ce5d0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Royger,

On 20/01/2017 12:01, Roger Pau Monn? wrote:
> On Thu, Jan 19, 2017 at 09:14:03PM +0100, Julien Grall wrote:
>> On 19/01/2017 19:22, Stefano Stabellini wrote:
>>> On Thu, 19 Jan 2017, Roger Pau Monn? wrote:
>>>> On Wed, Jan 18, 2017 at 07:13:23PM +0000, Julien Grall wrote:
>>>>> Hi,
>>>>>
>>>>> On 18/01/17 19:05, Stefano Stabellini wrote:
>>>>>> On Wed, 18 Jan 2017, Roger Pau Monn? wrote:
>>>>>>> On Tue, Jan 17, 2017 at 02:20:54PM -0800, Stefano Stabellini wrote:
>>>>>>>> a) One option is to provide a Xen specific implementation of
>>>>>>>> acpi_os_ioremap in Linux. I think this is the cleanest approach, but
>>>>>>>> unfortunately, it doesn't cover cases where ioremap is used directly. (2)
>>>>>>>> is one of such cases, see
>>>>>>>> arch/arm64/kernel/pci.c:pci_acpi_setup_ecam_mapping and
>>>>>>>> drivers/pci/ecam.c:pci_ecam_create. (3) is another one of these cases,
>>>>>>>> see drivers/acpi/apei/bert.c:bert_init.
>>>>>>>
>>>>>>> This is basically the same as b) from Xen's PoV, the only difference is where
>>>>>>> you would call the hypercall from Dom0 to establish stage-2 mappings.
>>>>>>
>>>>>> Right, but it is important from the Linux point of view, this is why I
>>>>>> am asking the Linux maintainers.
>>>>>>
>>>>>>
>>>>>>>> b) Otherwise, we could write an alternative implementation of ioremap
>>>>>>>> on arm64. The Xen specific ioremap would request a stage-2 mapping
>>>>>>>> first, then create the stage-1 mapping as usual. However, this means
>>>>>>>> issuing an hypercall for every ioremap call.
>>>>>>>
>>>>>>> This seems fine to me, and at present is the only way to get something working.
>>>>>>> As you said not being able to discover OperationRegions from Xen means that
>>>>>>> there's a chance some MMIO might not be added to the stage-2 mappings.
>>>>>>>
>>>>>>> Then what's the initial memory map state when Dom0 is booted? There are no MMIO
>>>>>>> mappings at all, and Dom0 must request mappings for everything?
>>>>>>
>>>>>> Yes
>>>>>
>>>>> To give more context here, the UEFI memory map does not report all the MMIO
>>>>> regions. So there is no possibility to map MMIO at boot.
>>>>
>>>> I've been able to get a Dom0 booting on x86 by mapping all the regions marked
>>>> as ACPI in the memory map, plus the BARs of PCI devices and the MCFG areas.
>>
>> But how do you find the BAR? Is it by reading the BAR from the config space
>> when a PCI is added?
>
> Not really, part of this is already done at boot time, Xen does a brute-force
> scan of the segment 0 (see scan_pci_devices). For ECAM areas the hardware
> domain must issue an hypercall (PHYSDEVOP_pci_mmcfg_reserved) in order to
> notify Xen about their presence before attempting to access this region. This
> should cause Xen to scan the ECAM and add any devices (at least this was my
> idea).

In case of ARM, Xen does not use any PCI devices (no PCI UART) itself so 
scanning before hand is not necessary. If possible, I would prefer to 
have the scanning in one place rather than spreading in different place 
depending on the segments (we do have multiple segment on ARM).

>
>> Also, you are assuming that the MCFG will describe the host controller. This
>> is the case only when host controller available at boot. So you may miss
>> some here.
>
> Yes, I know, that's why we need the hypercall. The information in the MCFG
> table might be incomplete, and the hardware domain would have to fetch extra
> ECAM information from the _SEG method of host bridge devices in the ACPI
> namespace.
>
>> Furthermore, on ARM we have other static tables (such as GTDT) contain MMIO
>> region to map.
>>
>> Lastly, all devices are not PCI and you may have platform devices. The
>> platform devices will only be described in the ASL. Just in case, those
>> regions are not necessarily described in UEFI memory map.
>
> Will those devices work properly in such scenario? (ie: are they behind the
> SMMU?)

Platform devices might or might not be behind of the SMMU. It will 
depend if the device is DMA-capable and often whether the implementer 
decided to have an SMMU.

Today, there is no SMMU support (it is by-passed) for ACPI so we haven't 
yet encountered the problem. We have an item to investigate the work to 
be done here.

Some thoughts, each device will be associated to one of multiple 
StreamID (ID to configure the SMMU). I guess we could find this from the 
static table IORT, need to check.

Also, some of the platform device will have MSIs, I suspect the number 
of MSIs will be either hardcoded or found in the ASL. So we would need 
to have a new hypercall to advertise those.

>
>> So you need DOM0 to tell the list of regions.
>
> Yes, I agree that we need such hypercall ATM, although I think that we might be
> able to get rid of it in the long term if we are able to parse the AML tables
> from Xen.

Are you suggesting to bring a full AML parser in Xen? If so, it will be 
much bigger than Xen ARM itself. I would need a strong use case to 
accept a such thing.

Cheers,

-- 
Julien Grall
