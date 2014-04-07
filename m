From: julien.grall@linaro.org (Julien Grall)
Date: Mon, 07 Apr 2014 18:28:12 +0100
Subject: [RFC] Extend zImage format to support notes
In-Reply-To: <20140407160452.GB14062@e106331-lin.cambridge.arm.com>
References: <5342AF59.3030405@linaro.org>
 <20140407160452.GB14062@e106331-lin.cambridge.arm.com>
Message-ID: <5342E02C.4010004@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2014 05:04 PM, Mark Rutland wrote:
> On Mon, Apr 07, 2014 at 02:59:53PM +0100, Julien Grall wrote:
> Hi Julien,

Hello Mark,

>> Currently ELF is supporting notes (see include/linux/elfnote.h) which
>> is used by Xen to know the feature supported by the kernel.
> 
> What kind of features do you intend for Xen discover through this
> mechanism on ARM?

tl;dr: To know if DOM0 Linux will correctly work when IOMMU is enabled
by Xen.

Actually Xen doesn't support IOMMU. To allow DMA-capable devices
correctly work, we use an hybrid approach:
   - 1:1 mapping for DOM0 memory
   - Use swiotlb for DMA on a foreign page (i.e. page which belongs to
another domain).

For the latter, the swiotlb will return a physical address rather than
an IPA.

I'm actually working to add SMMU support in Xen for ARM. Once Xen will
enable the IOMMU, Linux will have to program DMA with IPA.

As the swiotlb is returning physical address, Linux will have to know
whether the device is protected by IOMMU or not. For the former case,
Linux shouldn't use swiotlb for this device (see
https://lkml.org/lkml/2014/2/20/351).

Since the Xen ABI is stable for ARM (since Linux 3.13 and Xen 4.4), we
want to be able to boot Linux 3.13 on newer version of Xen. For this
version and onward (i.e. as long as swiotlb is used by default in DOM0),
Xen has to boot with IOMMU disabled.

With the zImage format extension, we will be able to add a note saying:
"I don't use swiotlb by default, you can turn on the IOMMU" once it's case.

> Can support for these not be negotiated at run-time (how does this work
> with other OSs under Xen)?

We though about runtime approach (see the whole discussion here
https://patches.linaro.org/26034/), but it's not as extensible as notes.
In fact, we might need more notes in the future when new feature will be
added and requires a DOM0/guest side support.

On x86 world, the dom0/guest features is discovered via ELF notes.
I think we should use the same way on ARM when zImage is used to boot DOM0.

> On arm64 we seem to have a notes section but no pointer to it in the
> Image header. I assume you'd consider a notes section useful for 64-bit
> too?

Yes, we will need to same section on arm64.

> I have some patches extending the header for arm64 which I intend to
> post shortly; if we're going to clash there and this is needed, perhaps
> I can fold in a similar update.

I didn't start to work on arm64 format extension. I wanted to wait for
feedback on the zImage format extension for arm32.

I plan to use one (may two) field from the reserved ones.

Sincerely yours,

-- 
Julien Grall
