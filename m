From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 15 Mar 2018 19:58:51 +0000
Subject: [RFC 2/5] dt-bindings: brcm: Add reserved-dma-region for iPROC
In-Reply-To: <CAOA9gs1XE1RkumEkYafO5f+b1YjGCFTYzxSSB-U4JcsR6=QdQg@mail.gmail.com>
References: <1520312368-7068-1-git-send-email-jitendra.bhivare@broadcom.com>
 <1520312368-7068-3-git-send-email-jitendra.bhivare@broadcom.com>
 <c2f30c0c-ff5e-2904-11f4-5351749381a9@arm.com>
 <CAOA9gs32BqGiXD7R2v7=Xkv-PVLTzuU3VmG1dAm6HNd4=w-qQg@mail.gmail.com>
 <a4a27e3c-4e7b-4850-ebf7-bd2b8f6f0d97@arm.com>
 <CAOA9gs1XE1RkumEkYafO5f+b1YjGCFTYzxSSB-U4JcsR6=QdQg@mail.gmail.com>
Message-ID: <ffc9e4c2-709d-707f-06eb-2cc14bea883b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/03/18 12:03, Jitendra Bhivare wrote:
> On Thu, Mar 15, 2018 at 12:15 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 12/03/18 07:03, Jitendra Bhivare wrote:
>>>
>>> On Tue, Mar 6, 2018 at 5:12 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>>>>
>>>> On 06/03/18 04:59, Jitendra Bhivare wrote:
>>>>>
>>>>>
>>>>> With SoC wide DMA mask of 40-bit, the mappings for entire IOVA space
>>>>> can't
>>>>> be specified in the PAXBv2 PCIe RC of SoC. The holes in IOVA space needs
>>>>> to
>>>>> be reserved to prevent any IOVA allocations in those spaces.
>>>>
>>>>
>>>>
>>>> Can you clarify why? If this is the PCI inbound window thing again, let
>>>> me
>>>> say once again that "dma-ranges" is the appropriate way for DT to
>>>> describe
>>>> the hardware.
>>>>
>>>> Robin.
>>>
>>> dma-ranges = < \
>>> 0x43000000 0x00 0x00000000 0x00 0x80000000 0x00 0x80000000 \
>>> 0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
>>> 0x43000000 0x80 0x00000000 0x80 0x00000000 0x80 0x00000000>
>>>
>>> Yes, its for PCI inbound windows. In our HW, they are limited by sizes
>>> specified in
>>> ARM memory maps which was done for non-IOMMU cases to catch any transfer
>>> outside the ranges.
>>> dma-ranges are already being used to program these inbound windows and SoC
>>> wide DMA mask is already specified but IOMMU code can still allocate IOVAs
>>> in the gaps for which translation will fail in PCIe RC.
>>
>>
>> Right, so make iommu-dma reserve the gaps. No need to clutter up the DT with
>> redundant information which gets handled pretty much identically anyway.
>>
>> Robin.
> There was a mistake in pasting dma-ranges mentioned. This is what we use it in
> IOMMU case.
> #define PCIE_DMA_RANGES dma-ranges = < \
> 0x43000000 0x00 0x00000000 0x00 0x00000000 0x04 0x00000000 \
> 0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
> 0x43000000 0x80 0x00000000 0x80 0x00000000 0x80 0x00000000>
> 
> #define PCIE_RESERVED_DMA_REGION reserved-dma-region = < \
> 0x0 0x0 0x04 0x0 0x04 0x0 \
> 0x0 0x0 0x10 0x0 0x70 0x0>
> 
> This is non-iommu case which is per ARM memory map.
> #define PCIE_DMA_RANGES dma-ranges = < \
> 0x43000000 0x00 0x80000000 0x00 0x80000000 0x00 0x80000000 \
> 0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
> 0x43000000 0x80 0x00000000 0x80 0x00000000 0x40 0x00000000>
> 
> In IOMMU case, we had to increase first in-bound window i.e.
> dma-ranges first entry
> from 2GB-4GB (in non-iommu case) to 0-16GB because out-bound window specified
> from 2GB-4GB implicitly gets reserved by the PCI iommu code. This allowed IOVA
> allocations from 0-2GB and 4-16GB mapped through in-bound windows.
> 
> Basically, my point is that dma-ranges specified is being used to
> program our in-bound
> windows and defines PCI space to CPU address space supported mappings of HW.
> In the same way, it would be better to explicitly specify
> reserved-dma-region to clarify
> this as HW hole than implicity reserving the regions.

Why? If DMA traffic can only pass through inbound windows, and you 
program the inbound windows based on dma-ranges, then by definition 
dma-ranges tells you exactly the set of addresses that are usable for 
DMA, and by extension, IOMMU remapping. I fail to see how it's then 
"better" to add a second slightly different description of the exact 
same information with the bonus maintenance burden of then having to 
ensure the two actually match.

Robin.

> We can at least have single property 'reserved-dma-window' for MSI
> region and DMA regions
> to help describe the holes in the HW than let SW compute it.
> 
>>>>
>>>>
>>>>> reserved-dma-region property is added to specify the ranges which should
>>>>> never be mapped and given to devices sitting behind.
>>>>>
>>>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>>>> Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
>>>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>>>> Signed-off-by: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
>>>>> ---
>>>>>     Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt | 3 +++
>>>>>     1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>>>> b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>>>> index b8e48b4..3be0fe3 100644
>>>>> --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>>>> +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>>>> @@ -30,6 +30,9 @@ Optional properties:
>>>>>     - dma-ranges: Some PAXB-based root complexes do not have inbound
>>>>> mapping
>>>>> done
>>>>>       by the ASIC after power on reset.  In this case, SW is required to
>>>>> configure
>>>>>     the mapping, based on inbound memory regions specified by this
>>>>> property.
>>>>> +- reserved-dma-region: PAXBv2 with IOMMU enabled cannot provide
>>>>> mappings
>>>>> for
>>>>> +  entire IOVA space specified by DMA mask. Hence this is used to
>>>>> reserve
>>>>> the
>>>>> +  gaps in dma-ranges.
>>>>>       - brcm,pcie-ob: Some iProc SoCs do not have the outbound address
>>>>> mapping done
>>>>>     by the ASIC after power on reset. In this case, SW needs to configure
>>>>> it
>>>>>
>>>>
>>
