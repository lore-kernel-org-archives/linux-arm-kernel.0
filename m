From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 09 Sep 2013 17:01:54 +0100
Subject: [PATCH v7 3/4] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <DAF223EB-C84C-4E82-A24A-ACD0A3A0559F@codeaurora.org>
References: <1377527959-5080-1-git-send-email-m.szyprowski@samsung.com>
 <1377527959-5080-4-git-send-email-m.szyprowski@samsung.com>
 <20130829224637.D09183E1222@localhost> <52209278.8040106@samsung.com>
 <DAF223EB-C84C-4E82-A24A-ACD0A3A0559F@codeaurora.org>
Message-ID: <20130909160154.8D7183E0F23@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Aug 2013 15:26:24 -0500, Kumar Gala <galak@codeaurora.org> wrote:
> On Aug 30, 2013, at 7:39 AM, Marek Szyprowski wrote:
> > On 8/30/2013 12:46 AM, Grant Likely wrote:
> >> On Mon, 26 Aug 2013 16:39:18 +0200, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> >> > +	- "reserved-memory-region" - compatibility is defined, given
> >> > +	  region is assigned for exclusive usage for by the respective
> >> > +	  devices.
> >> 
> >> BTW, just so you're aware there is already a binding for marking regions
> >> as reserved. It was recently added to arch/powerpc/kernel/prom.c.
> >> Unfortunately it doesn't look like it got documented. Search for
> >> "reserved-ranges". However, I don't think it blocks your work here. That
> >> binding doesn't provide any way for matching devices to reserved ranges.
> >> It is only for telling the kernel "hands of that memory".
> > 
> > ok, good to know.
> 
> So I think the most generic compatible should effectively be the same
> as 'reserved-ranges', ie this region shouldn't be touched by the
> kernel.
> 
> Than we can build on top of that with more specific compatibles.
> 
> I have examples from FSL networking SoCs where we would carve out
> memory for backing storage managed completely by the HW and Linux
> wouldn't need to touch it, however we might have a
> "fsl,qman-backing-store" compat encase we might want some debug code
> in linux to look at the region of memory.
> 
> I've got examples at qualcomm where we have shared data structures in
> specific memory regions between different processors that aren't cache
> coherent, so want the memory not to be marked as cacheable by Linux
> when it accesses it.  Again we'd have a "qcom,smem" prop on top of the
> "reserved-memory-region".

I think that is a reasonable approach, and works really well for regions
associated with specific hardware because the hardware driver can be
responsible for wiring it up to CMA or manage the region directly.
Whatever the driver desires to do.

It still remains what to do for generic regions that any device can use.
As I've previously said, I don't like calling out "CMA" specifically in
the compatible property because that happens to be a Linux
implementation specific details. Two years from now someone may propose
a new allocator that should take over what used to be handled by CMA
(kind of like how CMA may end up taking over from ION)....

Alright, I've thought about it some more and it probably does make sense
to use an additional compatible string. Marek originally suggested
"linux,contiguous-memory-region". I later suggested "shareable-memory-region",
but that's actually a worse name because it doesn't have any reference
to what the region is for (I was fixating on the kernel being able to
use unallocated pages; but that is also an implementation detail). I
exercise my right to change my mind and agree that contiguous is
appropriate here. But instead of calling out the contiguous allocator,
the binding should specifically lay out the usage model for these
regions. I would change the contiguous-memory binding to state the
following:
	Contiguous-memory is a region of general purpose memory from
	which large buffers of contiguous memory can be allocated.
	Contiguous buffers are often used for DMA buffers. The operating
	system may use the memory for any purpose, but must immediately
	release the pages if a contiguous buffer is required.

So the way I read things, the current proposal would be:

The generic form for do-not-touch memory:
	compatible = "reserved-memory";
 - I've dropped '-region' because I think it is redundant
 - The kernel will not make use of this memory except for when a driver picks it up

For contiguous memory:
	compatible = "contiguous-memory", "reserved-memory"

For contiguous memory that Linux will use by default if a specific
region isn't specified.
	compatible = "contiguous-memory", "reserved-memory"
	linux,default-contiguous-region;
 - I stuck with a linux, prefix here because I haven't come up with a
   non-linux way to describe this.

Memory that specific hardware can pick up:
	compatible = "qcom,smem", "reserved-memory"

Nodes with a 'size' property and without a 'reg' property need to have a
region allocated and reserved. The allocated region needs to be cached
somewhere. We could create a data structure for tracking the reserved
regions, or could write it in directly. While I shudder at the thought of
modifying the device tree at runtime by the kernel, it might just be the
sanest implementation at this time. I'd like to see what the
implementation looks like. (Since this is potentially controversial, I
would recommend implementing the exact regions in on patch, and add
dynamically allocated regions as a follow-up patch)

As far as proper implementation is concerned, I think it should be
explicit in the binding that the kernel should automatically exclude
anything under the reserved-memory node, regardless of the compatible
value. Merely being a child of the reserved-memory node immediately
means that it is a reserved memory region.

g.
