From: james.morse@arm.com (James Morse)
Date: Mon, 19 Nov 2018 18:05:29 +0000
Subject: Resend: How to handle the SMMU RAS Error in the kernel
In-Reply-To: <CAMj-D2DY_1eZUsbnqurx8j3q04Y8JKiM2CtPv+NTsswydo0TJQ@mail.gmail.com>
References: <CAMj-D2DY_1eZUsbnqurx8j3q04Y8JKiM2CtPv+NTsswydo0TJQ@mail.gmail.com>
Message-ID: <c8a1d0e7-338b-05e1-2d52-f13223515f49@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi gengdongjiu,

On 17/11/2018 15:41, gengdongjiu wrote:
> In the current kernel, it only handles three kinds of error, which is
> memory error, PCIE device and ARM process. But now the SMMU already
> support the RAS, how to handle the SMMU RAS error in the kernel?

What errors are being detected here?

I don't know much about the SMMU, but I think we should start with a list of
errors that we want to handle.


Is this a v8.2 fault handling interrupt from the SMMU taken to EL3?
Or a cpu-access that was returned as external-abort? or a device access that was
told external-abort?

What do we intend to do with this error information? Does the DMA layer have
error handling we can hook this into?

Is this just another interface for memory-errors? (e.g the SMMU provides a
device/address pair and the kernel works out the physical page to run
memory_failure() on)


> I check the UEFI_SPEC_2.7, the ACPI's CPER have the IOMMU type, but it
> seems the IOMMU type only are specific to AMD?s IOMMU specification,

... and Intel VT-d. It looks like UEFI generalises all these as types of 'DMAr'.


> not have the ARM?s IOMMU section type, can we reuse this IOMMU section
> type for the ARM SMMU?

The architecture specific records for AMD? No. Even if the information was the
same, the presence of this record tells you its an AMD IOMMU, which its not.

The generic error section? Maybe.

Assuming the 'fault reason' list in Table 285 is sufficient to cover our list or
errors, we can use the 'DMAr Generic Errors' section, (N.2.11.1), to describe
the generic bits of the error ... but SMMU doesn't have an 'Architecture Type',
so we at least need to get one allocated.

We will probably need an architecture specific 'DMAr Error Section'.


I think adding the UEFI bits is probably the 'easy' bit. We should start with a
list of errors, and the error handling code. This way we know what we need to
add to the spec.



Thanks,

James
