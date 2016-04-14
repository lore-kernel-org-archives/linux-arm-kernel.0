From: okaya@codeaurora.org (okaya at codeaurora.org)
Date: Thu, 14 Apr 2016 07:37:48 -0400
Subject: [PATCH V4 4/7] ARM64, ACPI, PCI: I/O Remapping Table (IORT)
 initial support.
In-Reply-To: <570F4886.70405@arm.com>
References: <1459759975-24097-1-git-send-email-tn@semihalf.com>
 <1459759975-24097-5-git-send-email-tn@semihalf.com>
 <570E645A.9010600@arm.com> <570E6794.4080409@semihalf.com>
 <570E6B2C.3060700@arm.com> <570EB78E.4060705@codeaurora.org>
 <570F44CD.7090605@semihalf.com> <570F4886.70405@arm.com>
Message-ID: <32c49fc25832b4cee05e5c9352c2f6cf@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-04-14 03:36, Marc Zyngier wrote:
> On 14/04/16 08:20, Tomasz Nowicki wrote:
>> On 13.04.2016 23:18, Sinan Kaya wrote:
>>> On 4/13/2016 11:52 AM, Marc Zyngier wrote:
>>>>>> Sure. Please see:
>>>>>> http://infocenter.arm.com/help/topic/com.arm.doc.den0049a/DEN0049A_IO_Remapping_Table.pdf
>>>>>> 3.1.1.5 PCI root complex node
>>>>>> PCI Segment number -> The PCI segment number, as in MCFG and as
>>>>>> returned by _SEG in the namespace.
>>>>>> 
>>>>>> So IORT spec states that pci_segment_number corresponds to the 
>>>>>> segment
>>>>>> number from MCFG table and _SEG method. Here is my patch which 
>>>>>> makes
>>>>>> sure pci_domain_nr(bus) is set properly:
>>>>>> https://lkml.org/lkml/2016/2/16/418
>>>> Lovely. So this series is actually dependent on the PCI one. I guess 
>>>> we
>>>> need to solve that one first, because IORT seems pretty pointless if 
>>>> we
>>>> don't have PCI support. What's the plan?
>>> 
>>> Would it be OK to split the PCI specific section of the patch and 
>>> continue
>>> review? PCI is a user of the IORT table. Not the other way around.
>> 
>> I need to disagree. What would be the use case for patches w/o "PCI 
>> part" ?
> 
> Quite. PCI (as a subsystem) doesn't need IORT at all, thank you very
> much. GIC (implementing MSI) and SMMU (implementing DMA) do, by virtue
> of RID/SID/DID being translated all over the place.
> 
> So by the look of it, the dependency chain is GIC+SMMU->IORT->PCI.
> 
> The GIC changes here are pretty mechanical, and not that interesting.
> The stuff that needs sorting quickly is PCI, because all this work is
> pointless if we don't have it.
> 
> At the risk of sounding like a stuck record: What's the plan?
> 
> Thanks,
> 
> 	M.

My answer is based on the spec definition. The spec defines named 
components for other peripherals that are behind iommu and can 
potentially implement msi.

You could have used a basic device like platform sata to take care of 
basic iort and smmu support.

You can then come back and implement PCIe support.
