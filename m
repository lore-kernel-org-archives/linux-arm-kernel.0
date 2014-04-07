From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 7 Apr 2014 19:25:53 +0100
Subject: [RFC] Extend zImage format to support notes
In-Reply-To: <5342E02C.4010004@linaro.org>
References: <5342AF59.3030405@linaro.org>
 <20140407160452.GB14062@e106331-lin.cambridge.arm.com>
 <5342E02C.4010004@linaro.org>
Message-ID: <20140407182553.GD14062@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 06:28:12PM +0100, Julien Grall wrote:
> On 04/07/2014 05:04 PM, Mark Rutland wrote:
> > On Mon, Apr 07, 2014 at 02:59:53PM +0100, Julien Grall wrote:
> > Hi Julien,
> 
> Hello Mark,
> 
> >> Currently ELF is supporting notes (see include/linux/elfnote.h) which
> >> is used by Xen to know the feature supported by the kernel.
> > 
> > What kind of features do you intend for Xen discover through this
> > mechanism on ARM?
> 
> tl;dr: To know if DOM0 Linux will correctly work when IOMMU is enabled
> by Xen.
> 
> Actually Xen doesn't support IOMMU. To allow DMA-capable devices
> correctly work, we use an hybrid approach:
>    - 1:1 mapping for DOM0 memory
>    - Use swiotlb for DMA on a foreign page (i.e. page which belongs to
> another domain).
> 
> For the latter, the swiotlb will return a physical address rather than
> an IPA.
> 
> I'm actually working to add SMMU support in Xen for ARM. Once Xen will
> enable the IOMMU, Linux will have to program DMA with IPA.

I'm probably being thick here, but is there anything preventing those
foreign pages from being idmapped into DOM0 (at least for the duration
of the DMA access) such that there is a 1-1 PA<->IPA mapping?

That would mean that from the point of view of Linux, there's nothing to
care about, as every address it knows it can deal with is a valid IPA.
Existing kernels would function with the IOMMU(s) on.

I assume I'm missing something fairly obvious :)

> As the swiotlb is returning physical address, Linux will have to know
> whether the device is protected by IOMMU or not. For the former case,
> Linux shouldn't use swiotlb for this device (see
> https://lkml.org/lkml/2014/2/20/351).

For some reason I can only see the cover letter and not the patches when
following that link.

> Since the Xen ABI is stable for ARM (since Linux 3.13 and Xen 4.4), we
> want to be able to boot Linux 3.13 on newer version of Xen. For this
> version and onward (i.e. as long as swiotlb is used by default in DOM0),
> Xen has to boot with IOMMU disabled.

A mentioned above, I think I'm missing some part of the reasoning as to
why Linux needs to know the difference.

> With the zImage format extension, we will be able to add a note saying:
> "I don't use swiotlb by default, you can turn on the IOMMU" once it's case.
> 
> > Can support for these not be negotiated at run-time (how does this work
> > with other OSs under Xen)?
> 
> We though about runtime approach (see the whole discussion here
> https://patches.linaro.org/26034/), but it's not as extensible as notes.
> In fact, we might need more notes in the future when new feature will be
> added and requires a DOM0/guest side support.

I can certainly see the usefulness of notes.

> 
> On x86 world, the dom0/guest features is discovered via ELF notes.
> I think we should use the same way on ARM when zImage is used to boot DOM0.
> 
> > On arm64 we seem to have a notes section but no pointer to it in the
> > Image header. I assume you'd consider a notes section useful for 64-bit
> > too?
> 
> Yes, we will need to same section on arm64.

If it makes sense for this case then I can see why we would want it on
arm64.

> > I have some patches extending the header for arm64 which I intend to
> > post shortly; if we're going to clash there and this is needed, perhaps
> > I can fold in a similar update.
> 
> I didn't start to work on arm64 format extension. I wanted to wait for
> feedback on the zImage format extension for arm32.

Certainly. I just wanted to make sure we weren't going to end up
stepping on each others' toes whenever we try to get our patches merged.

Cheers,
Mark.
