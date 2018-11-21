From: gengdongjiu@huawei.com (gengdongjiu)
Date: Wed, 21 Nov 2018 16:10:26 +0800
Subject: Resend: How to handle the SMMU RAS Error in the kernel
In-Reply-To: <c8a1d0e7-338b-05e1-2d52-f13223515f49@arm.com>
References: <CAMj-D2DY_1eZUsbnqurx8j3q04Y8JKiM2CtPv+NTsswydo0TJQ@mail.gmail.com>
 <c8a1d0e7-338b-05e1-2d52-f13223515f49@arm.com>
Message-ID: <7a93bf1b-7b7b-240e-bc74-68bf0ee18ac9@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,
   Thanks for the mail.

On 2018/11/20 2:05, James Morse wrote:
> Hi gengdongjiu,
> 
> On 17/11/2018 15:41, gengdongjiu wrote:
>> In the current kernel, it only handles three kinds of error, which is
>> memory error, PCIE device and ARM process. But now the SMMU already
>> support the RAS, how to handle the SMMU RAS error in the kernel?
> 
> What errors are being detected here?
> 
> I don't know much about the SMMU, but I think we should start with a list of
> errors that we want to handle.

In our platform, the SMMU RAS error mainly include below which flow the SMMU spec:
1. one bit ECC error, reported as CE.
2. two bits ECC error, reported as UEU.
3. fetch error in the SMMUv3 spec, reported as UER.

The 2 and 3 should be handled, but I do not know how do recovery to it.

> 
> 
> Is this a v8.2 fault handling interrupt from the SMMU taken to EL3?
> Or a cpu-access that was returned as external-abort? or a device access that was
> told external-abort?
it flows v8.2 RAS spec, it is a v8.2 fault handling interrupt from the SMMU taken to EL3.

> 
> What do we intend to do with this error information? Does the DMA layer have
> error handling we can hook this into?

we can get the DMA layer error from the RAS registers, such as DMA read errors.
may be the handle method is disabling this SMMU to avoid propagation.

> 
> Is this just another interface for memory-errors? (e.g the SMMU provides a
> device/address pair and the kernel works out the physical page to run
> memory_failure() on)
I need to check more.

> 
> 
>> I check the UEFI_SPEC_2.7, the ACPI's CPER have the IOMMU type, but it
>> seems the IOMMU type only are specific to AMD?s IOMMU specification,
> 
> ... and Intel VT-d. It looks like UEFI generalises all these as types of 'DMAr'.
yes, it is.

> 
> 
>> not have the ARM?s IOMMU section type, can we reuse this IOMMU section
>> type for the ARM SMMU?
> 
> The architecture specific records for AMD? No. Even if the information was the
> same, the presence of this record tells you its an AMD IOMMU, which its not.
> 
> The generic error section? Maybe.
> 
> Assuming the 'fault reason' list in Table 285 is sufficient to cover our list or
> errors, we can use the 'DMAr Generic Errors' section, (N.2.11.1), to describe
> the generic bits of the error ... but SMMU doesn't have an 'Architecture Type',
> so we at least need to get one allocated.
> 
> We will probably need an architecture specific 'DMAr Error Section'.
> 
> 
> I think adding the UEFI bits is probably the 'easy' bit. We should start with a
> list of errors, and the error handling code. This way we know what we need to
> add to the spec.

The list of SMMU RAS error is shown below, but I still do not know how to handle it.
1. one bit ECC error
2. two bits ECC error
3. fetch error in the SMMUv3 spec

> 
> 
> 
> Thanks,
> 
> James
> 
> .
> 
