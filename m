From: julien.grall@arm.com (Julien Grall)
Date: Wed, 18 Jan 2017 19:13:23 +0000
Subject: [Xen-devel] [RFC] Device memory mappings for Dom0 on ARM64 ACPI
 systems
In-Reply-To: <alpine.DEB.2.10.1701181058110.10192@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1701171309040.2347@sstabellini-ThinkPad-X260>
 <20170118110243.ctqpperggim5k7dw@dhcp-3-221.uk.xensource.com>
 <alpine.DEB.2.10.1701181058110.10192@sstabellini-ThinkPad-X260>
Message-ID: <20c89f12-cb0c-1145-99d0-320b2080b503@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 18/01/17 19:05, Stefano Stabellini wrote:
> On Wed, 18 Jan 2017, Roger Pau Monn? wrote:
>> On Tue, Jan 17, 2017 at 02:20:54PM -0800, Stefano Stabellini wrote:
>>> a) One option is to provide a Xen specific implementation of
>>> acpi_os_ioremap in Linux. I think this is the cleanest approach, but
>>> unfortunately, it doesn't cover cases where ioremap is used directly. (2)
>>> is one of such cases, see
>>> arch/arm64/kernel/pci.c:pci_acpi_setup_ecam_mapping and
>>> drivers/pci/ecam.c:pci_ecam_create. (3) is another one of these cases,
>>> see drivers/acpi/apei/bert.c:bert_init.
>>
>> This is basically the same as b) from Xen's PoV, the only difference is where
>> you would call the hypercall from Dom0 to establish stage-2 mappings.
>
> Right, but it is important from the Linux point of view, this is why I
> am asking the Linux maintainers.
>
>
>>> b) Otherwise, we could write an alternative implementation of ioremap
>>> on arm64. The Xen specific ioremap would request a stage-2 mapping
>>> first, then create the stage-1 mapping as usual. However, this means
>>> issuing an hypercall for every ioremap call.
>>
>> This seems fine to me, and at present is the only way to get something working.
>> As you said not being able to discover OperationRegions from Xen means that
>> there's a chance some MMIO might not be added to the stage-2 mappings.
>>
>> Then what's the initial memory map state when Dom0 is booted? There are no MMIO
>> mappings at all, and Dom0 must request mappings for everything?
>
> Yes

To give more context here, the UEFI memory map does not report all the 
MMIO regions. So there is no possibility to map MMIO at boot.

>
>
>> What happens to ACPI tables crafted for Dom0 that reside in RAM? That would
>> apply to the STAO and to the other tables that are crafted for Dom0 at build
>> time. Should Dom0 also request stage-2 mappings for them, and Xen simply ignore
>> those calls?
>
> The ACPI (and UEFI) tables are mapped by Xen

I think Royger's point is DOM0 cannot tell whether a region has been 
mapped by Xen or not.

The function ioremap will be used to map anything (it is the leaf of all 
mapping functions), and will call Xen no matter the address passed. It 
could be a RAM region, HW device region, emulated device region.

For the RAM and emulated device region we don't want Xen to modify the 
mapping. Note that the current hypercall does not report an error back 
(see [1]) but I think it is a different error.

Also, I think we would need some work in Xen because, from my 
understanding of acpi_iomem_deny_access, DOM0 would be able to map the 
RAM through this hypercall. So it would mess-up with the page table even 
if it should not.

Cheers,

-- 
Julien Grall
