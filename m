From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 18 Mar 2010 19:00:06 +0530
Subject: Highmem issues with MMC filesystem
In-Reply-To: <alpine.LFD.2.00.1003180904440.31128@xanadu.home>
References: <037201cac5d7$6c5b8c60$LocalHost@wipblrx0099946>
	<alpine.LFD.2.00.1003170946250.31128@xanadu.home>
	<043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946>
	<alpine.LFD.2.00.1003171050160.31128@xanadu.home>
	<20100318092352.GD8267@n2100.arm.linux.org.uk>
	<c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com>
	<20100318112453.GA19544@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1003180904440.31128@xanadu.home>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C489CB4A@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Nicolas Pitre
> Sent: Thursday, March 18, 2010 6:50 PM
> To: Russell King - ARM Linux
> Cc: linux-mmc at vger.kernel.org; V, Hemanth; saeed bishara; pierre at ossman.eu; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: Highmem issues with MMC filesystem
> 
> On Thu, 18 Mar 2010, Russell King - ARM Linux wrote:
> 
> > On Thu, Mar 18, 2010 at 01:15:58PM +0200, saeed bishara wrote:
> > > >> The only conclusion I came to so far is that ARMv5 where highmem works
> > > >> just fine in all cases has VIVT cache whereas ARMv6 has VIPT cache.
> > > >> And the problem with VIPT caches occurs when direct DMA is involved,
> > > >> otherwise there is no problem if PIO or NFS is used. ?Sprinkling some
> > > >> flush_cache_all() in a few places makes things work, but this is not a
> > > >> satisfactory solution.
> > > >
> > > > This sounds like the problem we had with the DMA API. ?Since that's now
> > > > fixed, there shouldn't be a problem with the latest (-rc) kernels, or
> > > > a kernel with my old streaming DMA patches applied.
> > > The failure happens also on 2.6.34.rc1,  as Nico said, it looks like
> > > that buffers that are subject to DMA remain dirty, as I understand it,
> > > for vipt nonaliasing cpu's, the kernel doesn't clean user space cache
> > > lines. if I force kmap_atomic/kunmap_atomic to highmem pages that are
> > > not mapped by the kernel (kmap_high_get returns null), then the issue
> > > disappears.
> >
> > In no case does the kernel ever clean user space cache lines for DMA;
> > that's not the responsibility of the DMA API.
> 
> Let's forget about user space.  Even some kernel space memory is
> affected too.
> 
> The issue as I see it is that highmem pages being DMA'd to may be cached
> even when they're unmapped on VIPT machines.  And the DMA code performs
> L1 cache maintenance only on pages which are virtually mapped.
> 
> Contrary to VIVT caches which have to be flushed all the time, VIPT
> caches may avoid cache flushing in some cases, which may lead to some
> highmem pages not being mapped but still cached somehow.  But so far I
> just can't find how that could happen.
> 
> The only way a highmem page can be unmapped is through kunmap_atomic()
> where an explicit __cpuc_flush_dcache_area() is performed, or through
> flush_all_zero_pkmaps() where flush_cache_kmaps() translates into
> flush_cache_all().
> 
> So something allows for some highmem pages to escape cache flushing when
> unmapped.  But I can't find it.
> 
Or could it be that there is appropriate cacheflush happening but data gets
stuck in CPU writebuffers instead of reaching to main memory. In this case
too DMA won't see the contents and a barrier (dsb) is necessary to ensure
that write buffer is drained before DMA takes over the buffer.

Regards,
Santosh
