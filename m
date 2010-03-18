From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Mar 2010 11:24:54 +0000
Subject: Highmem issues with MMC filesystem
In-Reply-To: <c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com>
References: <037201cac5d7$6c5b8c60$LocalHost@wipblrx0099946>
	<alpine.LFD.2.00.1003170946250.31128@xanadu.home>
	<043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946>
	<alpine.LFD.2.00.1003171050160.31128@xanadu.home>
	<20100318092352.GD8267@n2100.arm.linux.org.uk>
	<c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com>
Message-ID: <20100318112453.GA19544@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 18, 2010 at 01:15:58PM +0200, saeed bishara wrote:
> >> The only conclusion I came to so far is that ARMv5 where highmem works
> >> just fine in all cases has VIVT cache whereas ARMv6 has VIPT cache.
> >> And the problem with VIPT caches occurs when direct DMA is involved,
> >> otherwise there is no problem if PIO or NFS is used. ?Sprinkling some
> >> flush_cache_all() in a few places makes things work, but this is not a
> >> satisfactory solution.
> >
> > This sounds like the problem we had with the DMA API. ?Since that's now
> > fixed, there shouldn't be a problem with the latest (-rc) kernels, or
> > a kernel with my old streaming DMA patches applied.
> The failure happens also on 2.6.34.rc1,  as Nico said, it looks like
> that buffers that are subject to DMA remain dirty, as I understand it,
> for vipt nonaliasing cpu's, the kernel doesn't clean user space cache
> lines. if I force kmap_atomic/kunmap_atomic to highmem pages that are
> not mapped by the kernel (kmap_high_get returns null), then the issue
> disappears.

In no case does the kernel ever clean user space cache lines for DMA;
that's not the responsibility of the DMA API.
