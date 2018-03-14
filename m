From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 14 Mar 2018 18:45:06 +0000
Subject: [RFC 2/5] dt-bindings: brcm: Add reserved-dma-region for iPROC
In-Reply-To: <CAOA9gs32BqGiXD7R2v7=Xkv-PVLTzuU3VmG1dAm6HNd4=w-qQg@mail.gmail.com>
References: <1520312368-7068-1-git-send-email-jitendra.bhivare@broadcom.com>
 <1520312368-7068-3-git-send-email-jitendra.bhivare@broadcom.com>
 <c2f30c0c-ff5e-2904-11f4-5351749381a9@arm.com>
 <CAOA9gs32BqGiXD7R2v7=Xkv-PVLTzuU3VmG1dAm6HNd4=w-qQg@mail.gmail.com>
Message-ID: <a4a27e3c-4e7b-4850-ebf7-bd2b8f6f0d97@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/18 07:03, Jitendra Bhivare wrote:
> On Tue, Mar 6, 2018 at 5:12 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 06/03/18 04:59, Jitendra Bhivare wrote:
>>>
>>> With SoC wide DMA mask of 40-bit, the mappings for entire IOVA space can't
>>> be specified in the PAXBv2 PCIe RC of SoC. The holes in IOVA space needs
>>> to
>>> be reserved to prevent any IOVA allocations in those spaces.
>>
>>
>> Can you clarify why? If this is the PCI inbound window thing again, let me
>> say once again that "dma-ranges" is the appropriate way for DT to describe
>> the hardware.
>>
>> Robin.
> dma-ranges = < \
> 0x43000000 0x00 0x00000000 0x00 0x80000000 0x00 0x80000000 \
> 0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
> 0x43000000 0x80 0x00000000 0x80 0x00000000 0x80 0x00000000>
> 
> Yes, its for PCI inbound windows. In our HW, they are limited by sizes
> specified in
> ARM memory maps which was done for non-IOMMU cases to catch any transfer
> outside the ranges.
> dma-ranges are already being used to program these inbound windows and SoC
> wide DMA mask is already specified but IOMMU code can still allocate IOVAs
> in the gaps for which translation will fail in PCIe RC.

Right, so make iommu-dma reserve the gaps. No need to clutter up the DT 
with redundant information which gets handled pretty much identically 
anyway.

Robin.

>>
>>
>>> reserved-dma-region property is added to specify the ranges which should
>>> never be mapped and given to devices sitting behind.
>>>
>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>> Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>> Signed-off-by: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
>>> ---
>>>    Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>> b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>> index b8e48b4..3be0fe3 100644
>>> --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>> +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>> @@ -30,6 +30,9 @@ Optional properties:
>>>    - dma-ranges: Some PAXB-based root complexes do not have inbound mapping
>>> done
>>>      by the ASIC after power on reset.  In this case, SW is required to
>>> configure
>>>    the mapping, based on inbound memory regions specified by this property.
>>> +- reserved-dma-region: PAXBv2 with IOMMU enabled cannot provide mappings
>>> for
>>> +  entire IOVA space specified by DMA mask. Hence this is used to reserve
>>> the
>>> +  gaps in dma-ranges.
>>>      - brcm,pcie-ob: Some iProc SoCs do not have the outbound address
>>> mapping done
>>>    by the ASIC after power on reset. In this case, SW needs to configure it
>>>
>>
