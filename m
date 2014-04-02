From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 2 Apr 2014 12:13:26 +0100
Subject: Bug(?) in patch "arm64: Implement coherent DMA API based on
 swiotlb" (was Re: [GIT PULL] arm64 patches for 3.15)
In-Reply-To: <20140402094045.GH7528@n2100.arm.linux.org.uk>
References: <20140331175230.GA7480@arm.com>
 <1396368657.3681.17.camel@linaro1.home>
 <20140401172939.GG20061@arm.com>
 <1396428722.3554.20.camel@linaro1.home>
 <20140402092032.GB31892@arm.com>
 <20140402094045.GH7528@n2100.arm.linux.org.uk>
Message-ID: <20140402111326.GC31892@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 02, 2014 at 10:40:45AM +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 02, 2014 at 10:20:32AM +0100, Catalin Marinas wrote:
> > You are right. I think having unaligned DMA buffers for inbound
> > transfers is pointless. We can avoid losing data written by another CPU
> > in the same cache line but, depending on the stage of the DMA transfer,
> > it can corrupt the DMA data.
> > 
> > I wonder whether it's easier to define the cache_line_size() macro to
> > read CWG and assume that the DMA buffers are always aligned, ignoring
> > the invalidation of the unaligned boundaries. This wouldn't be much
> > different from your scenario where the shared cache line is written
> > (just less likely to trigger but still a bug, so I would rather notice
> > this early).
> > 
> > The ARMv7 code has a similar issue, it performs clean&invalidate on the
> > unaligned start but it doesn't move r0, so it goes into the main loop
> > invalidating the same cache line again. If it was written by something
> > else, the information would be lost.
> 
> You can't make that a requirement.  People have shared stuff across a
> cache line for years in Linux, and people have brought it up and tried
> to fix it, but there's much resistance against it.  In particular is
> SCSI, which submits the sense buffer as part of a larger structure (the
> host.)  SCSI sort-of guarantees that the surrounding struct members
> won't be touched, but their data has to be preserved.

Let's hope that CWG stays small enough on real hardware (as the
architecture specifies it to max 2K).

> In any case, remember that there are strict rules about ownership of the
> DMA memory vs calls to the DMA API.  It is invalid to call the DMA
> streaming API functions while a DMA transfer is active.

Yes, I was referring to non-DMA buffer area in the same cache line being
touched during a DMA transfer.

-- 
Catalin
