From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Jul 2013 11:44:36 +0100
Subject: [PATCH V3] of: Set the DMA mask to 64 bits when dma_addr_t is
 64-bits
In-Reply-To: <CACVXFVNF0ZukAw5d1Uv_d0oE6arci7AyVtVEPRb0=hx+0dX6pA@mail.gmail.com>
References: <1367008266-1431-1-git-send-email-lauraa@codeaurora.org>
 <517AF270.8040106@gmail.com>
 <CACVXFVPfkqP+UyoGd-+QFRzndSam_DtU=utrBPYCPjQCGQ_F6g@mail.gmail.com>
 <51D71F81.5090503@codeaurora.org>
 <CACVXFVNT3j5o9a+N9FDA07Si+cngqAZkcqh6YYOf3rHsMvRgRg@mail.gmail.com>
 <20130706091511.GN24642@n2100.arm.linux.org.uk>
 <CACVXFVNF0ZukAw5d1Uv_d0oE6arci7AyVtVEPRb0=hx+0dX6pA@mail.gmail.com>
Message-ID: <20130708104436.GT24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 06:03:57PM +0800, Ming Lei wrote:
> On Sat, Jul 6, 2013 at 5:15 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Sat, Jul 06, 2013 at 10:21:05AM +0800, Ming Lei wrote:
> >> But please see below words in Documentation/DMA-API.txt:
> >>
> >>            Further, the physical address of the memory must be within the
> >>            dma_mask of the device (the dma_mask represents a bit mask of the
> >>            addressable region for the device.  I.e., if the physical address of
> >>            the memory anded with the dma_mask is still equal to the physical
> >>            address, then the device can perform DMA to the memory).
> >>
> >> You may argue that the description is about dev->dma_mask, but the
> >> usage should be same.
> >>
> >> In fact, most of devices in ARM SoC(even with LPAE enabled) doesn't
> >> support 64bit DMA, so I don't see the point that the default mask is set
> >> as 64bit.
> >
> > There's another couple of issues there:
> >
> > (a) Linux assumes that physical memory starts at location zero.  There
> >     are various places in the kernel that assume that this holds true:
> >
> >         max_dma_pfn = (dma_mask >> PAGE_SHIFT) + 1
> >
> >     One notable place is the block layer.  I've suggested to Santosh a
> >     way to fix this but I need to help him a little more with it.
> >
> > (b) Device DMA addresses are a *separate* address space to the physical
> >     address space.  Device DMA addresses are the addresses which need to
> >     be programmed into the device to perform DMA to the identified
> >     location.
> >
> > What (b) means is that if you are ending up with a 64-bit address to be
> > programmed into a 32-bit only register, there is something very very
> > wrong.  What this also means is that a 32-bit DMA mask should suffice,
> > because if the DMA address results in a 32-bit address _for the DMA
> > device_ then we are within its capabilities.
> >
> > In any case, the work around is not to set the DMA mask to be 64-bit.
> 
> So how about working around the problem by setting arm_dma_limit as
> (phys_addr_t)0xffffffff if CONFIG_ZONE_DMA is unset? Or other better
> solutions?
> 
> Otherwise enabling LPAE may cause system boot failure because
> mmc card may not work when arm_dma_limit becomes (u64)-1.

Well, working around it by bodging it means that the bodges will stay
and the problem will become even worse later, and we won't have the
weight of people saying it doesn't work to use as leverage to persuade
people that DMA masks need to change.  Sorry.
