From: will.deacon@arm.com (Will Deacon)
Date: Wed, 5 Aug 2015 17:24:52 +0100
Subject: [PATCH 05/13] iommu/io-pgtable-arm: Allow appropriate DMA API use
In-Reply-To: <1987558.GfG8OCqzMM@avalon>
References: <1438608355-7335-1-git-send-email-will.deacon@arm.com>
 <55C0D071.1040104@arm.com>
 <20150804145642.GQ7557@n2100.arm.linux.org.uk>
 <1987558.GfG8OCqzMM@avalon>
Message-ID: <20150805162452.GH6092@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Tue, Aug 04, 2015 at 09:54:27PM +0100, Laurent Pinchart wrote:
> On Tuesday 04 August 2015 15:56:42 Russell King - ARM Linux wrote:
> > On Tue, Aug 04, 2015 at 03:47:13PM +0100, Robin Murphy wrote:
> > > On 04/08/15 14:16, Laurent Pinchart wrote:
> > >> This is what I believe to be an API abuse. The
> > >> dma_sync_single_for_device()
> > >> API is meant to pass ownership of a buffer to the device. Unless I'm
> > >> mistaken, once that's done the CPU isn't allowed to touch the buffer
> > >> anymore until dma_sync_single_for_cpu() is called to get ownership of
> > >> the buffer back.
> >
> > That's what I thought up until recently, but it's not strictly true - see
> > Documentation/DMA-API.txt which Robin quoted.
> 
> I find the documentation slightly unclear on this topic. I have nothing 
> against updating it to state that the sync functions ensure visibility of the 
> data to the device or CPU instead of transferring ownership if that's the 
> general understanding of how the API work (or should work). This would of 
> course need to be carefully reviewed to ensure that the current implementation 
> really works that way across all architectures, or at least that it can be 
> made to work that way.

I was hoping to send this lot off to Joerg tomorrow morning, since it's
removing a hack from the io-pgtable users before it has chance to spread
further. This use of the API is certainly ok on arm and arm64 (where
these drivers currently run) and I don't see why it wouldn't work for
any IOMMU that treats the page tables as read-only. Once we start getting
into hardware access/dirty bits, then the streaming-DMA API is a lost
cause but I would expect those systems to be using SVM with the CPU page
tables anyway and therefore be cache-coherent.

I agree that the Documentation isn't brilliant, but that could be addressed
in a separate patch (especially since I don't think it would be merged
via the iommu tree).

Is that alright?

Will
