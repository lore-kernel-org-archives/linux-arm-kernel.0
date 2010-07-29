From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jul 2010 10:12:05 +0200
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <20100728212156.GA6729@n2100.arm.linux.org.uk>
References: <1280270466-13503-1-git-send-email-stepanm@codeaurora.org>
	<201007281950.20847.arnd@arndb.de>
	<20100728212156.GA6729@n2100.arm.linux.org.uk>
Message-ID: <201007291012.05986.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 July 2010 23:21:56 Russell King - ARM Linux wrote:
> On Wed, Jul 28, 2010 at 07:50:20PM +0200, Arnd Bergmann wrote:
> > The DMA API is extremely flexible, it works just fine with all the
> > IOMMUs that I've seen so far. Please take a look at
> > include/asm-generic/dma-mapping-common.h and its users to see how
> > to use multiple IOMMUs depending on the device.
> 
> We don't yet use those DMA API interface extensions because we haven't
> had the need.  If someone who has the need wants to put the effort in
> though...

Right, it shouldn't be hard now that the groundwork for that is done.
Also, it's only really needed if you have IOMMUs of different types in the
same system. If msm doesn't have any swiotlb or dmabounce devices,
it could always use the same implementation for all devices.

> One of the problems with it though is the abstraction of the sync*
> operations is the wrong way around for stuff like dmabounce - we want
> to be passed the base address of the buffer (so we can look this up),
> plus offset and length.  We don't want to know just the region which
> is affected.

Yes, but that is an unrelated (dmabounce specific) problem that seems to
be fixed by an existing patch.

The driver posted by Stepan doesn't even support the dma_sync_single_*
style operations, and I don't think it can run into that specific problem.
Are there even (hardware) IOMMUs that are connected to noncoherent
buses? AFAICT, anything that needs to flush a dcache range in dma_sync_*
has a trivial mapping between bus and phys addresses.

	Arnd
