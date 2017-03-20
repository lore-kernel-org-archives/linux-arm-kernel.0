From: john.garry@huawei.com (John Garry)
Date: Mon, 20 Mar 2017 10:22:59 +0000
Subject: [PATCH 03/20] asm-generic/io.h: add PCI config space remap
 interface
In-Reply-To: <20170317000803.GA28800@wotan.suse.de>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-4-lorenzo.pieralisi@arm.com>
 <20170316211243.GE9739@bhelgaas-glaptop.roam.corp.google.com>
 <20170317000803.GA28800@wotan.suse.de>
Message-ID: <f7a4083d-373d-c93b-1aa4-89a967aa97fe@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/2017 00:08, Luis R. Rodriguez wrote:
> On Thu, Mar 16, 2017 at 04:12:43PM -0500, Bjorn Helgaas wrote:
>> [+cc Luis]
>>
>> On Mon, Feb 27, 2017 at 03:14:14PM +0000, Lorenzo Pieralisi wrote:
>>> The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
>>> Posting") mandate non-posted configuration transactions. As further
>>> highlighted in the PCIe specifications (4.0 - Rev0.3, "Ordering
>>> Considerations for the Enhanced Configuration Access Mechanism"),
>>> through ECAM and ECAM-derivative configuration mechanism, the memory
>>> mapped transactions from the host CPU into Configuration Requests on the
>>> PCI express fabric may create ordering problems for software because
>>> writes to memory address are typically posted transactions (unless the
>>> architecture can enforce through virtual address mapping non-posted
>>> write transactions behaviour) but writes to Configuration Space are not
>>> posted on the PCI express fabric.
>>>
>>> Current DT and ACPI host bridge controllers map PCI configuration space
>>> (ECAM and ECAM-derivative) into the virtual address space through
>>> ioremap() calls, that are non-cacheable device accesses on most
>>> architectures, but may provide "bufferable" or "posted" write semantics
>>> in architecture like eg ARM/ARM64 that allow ioremap'ed regions writes
>>> to be buffered in the bus connecting the host CPU to the PCI fabric;
>>> this behaviour, as underlined in the PCIe specifications, may trigger
>>> transactions ordering rules and must be prevented.
>>>
>>> Introduce a new generic and explicit API to create a memory
>>> mapping for ECAM and ECAM-derivative config space area that
>>> defaults to ioremap_nocache() (which should provide a sane default
>>> behaviour) but still allowing architectures on which ioremap_nocache()
>>> results in posted write transactions to override the function
>>> call with an arch specific implementation that complies with
>>> the PCI specifications for configuration transactions.
>
> So... I take it this is actually fixing a series of odd issues also,
> do we at least have some reports or actual issues ?
>

We (Huawei) originally raised the concern [1], but have not actually 
experienced any related issue.

Thanks,
John

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/477353.html

>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: Russell King <linux@armlinux.org.uk>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> ---
>>>  include/asm-generic/io.h | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
>>> index 7ef015e..52dda81 100644
>>> --- a/include/asm-generic/io.h
>>> +++ b/include/asm-generic/io.h
>>> @@ -915,6 +915,15 @@ extern void ioport_unmap(void __iomem *p);
>>>  #endif /* CONFIG_GENERIC_IOMAP */
>>>  #endif /* CONFIG_HAS_IOPORT_MAP */
>>>
>>> +#ifndef pci_remap_cfgspace
>>> +#define pci_remap_cfgspace pci_remap_cfgspace
>>> +static inline void __iomem *pci_remap_cfgspace(phys_addr_t offset,
>>> +					       size_t size)
>>> +{
>>> +	return ioremap_nocache(offset, size);
>>> +}
>>
>> I'm fine with this conceptually, but I think it would make more sense
>> if the name weren't specific to PCI or config space, e.g.,
>> ioremap_nopost() or something.
>
> Seems reasonable to me -- but are there other buses that could use this already
> as well ? Wouldn't these other buses also run into similar issues ? Can someone
> also bounce me a copy of the patches that use this ?
>
> While at it, please add some documentation too, the above commit log is huge,
> and yet for the person eyeballing the code they won't have any clue why this
> was added exactly. Since this is about helping with picking the right
> ioremap due to certain semantics / requirements on the PCI config space,
> we should clarify then what exactly are the expectations here. The clearer
> you are the less in trouble we can get later.
>
>   Luis
>
> .
>
