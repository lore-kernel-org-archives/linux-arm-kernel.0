From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Jun 2015 12:30:15 +0100
Subject: [RFC PATCH v3] arm DMA: Fix allocation from CMA for coherent DMA
In-Reply-To: <20150629110532.GD29907@e104818-lin.cambridge.arm.com>
References: <1434663862-17858-1-git-send-email-lorenx4@gmail.com>
 <20150626162549.GK3078@e104818-lin.cambridge.arm.com>
 <CAE=W-e3YUjT=KbYTizBwg+3huvFLDqHvhzZN-oPqEnOKUXAtoQ@mail.gmail.com>
 <20150629103737.GC29907@e104818-lin.cambridge.arm.com>
 <20150629104604.GB7557@n2100.arm.linux.org.uk>
 <20150629110532.GD29907@e104818-lin.cambridge.arm.com>
Message-ID: <20150629113014.GC7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 29, 2015 at 12:05:33PM +0100, Catalin Marinas wrote:
> On Mon, Jun 29, 2015 at 11:46:04AM +0100, Russell King - ARM Linux wrote:
> > The reason we always clear the buffer is that we can't be sure that a
> > driver will not map a buffer allocated by dma_alloc_coherent() into
> > userspace without it first being initialised.  There have been drivers
> > which do this (ALSA in particular.)  I haven't checked whether this
> > instance still does this, but it used to - and the problem is once
> > one instance exists, it gets copied...
> 
> You are right, the memset'ing is probably still necessary to patch
> potential security holes. The cache flushing is not for coherent buffers
> (sometimes this may be more expensive than the memset itself, though
> lost in the noise if only done once).

Well, CMA itself is _not_ a fast allocator.  The code is highly inefficient
- multiple loops within loops within loops.

cma_alloc() walks over the range by the alignment size, trying to allocate
each block in sequence.

The worst case is: CMA region size nMB, you're trying to allocate with a
4k alignment, CMA memory is all pinned.  It will attempt to allocate the
first 4k page, calling alloc_contig_range() on the range.  That tries to
reclaim the pages, and while it may be able to reclaim some, it will try
five times to do so before failing.  We'll then increment the starting
address by 4k and repeat, until we get to the end of CMA.  So, the outer
loop tries nMB/4kB times to do the allocation - for a 256MB CMA region,
that's 64k calls to alloc_contig_range(), and 327680 calls to the page
reclaim functions.

I've recently seen a single allocation call for 8MB (1080p frame) from
256MB of CMA with scattered pinned pages taking about two seconds to
complete.

One of the problems is that CMA has no knowledge of other users of the
pages, and has no feedback from alloc_contig_range() about which pages
are pinned, so cma_alloc() can't make a sensible guess at the next block
to try.

zeroing and cache flushing is the _least_ of the problems in that code
path.

(Pages can be pinned by ext4fs - see the LWN articles on the subject of
pinned pages and CMA - and also by drivers that hold on to GFP_MOVABLE
pages.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
