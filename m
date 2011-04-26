From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2011 16:26:19 +0200
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <20110421130930.4be9e9e1@jbarnes-desktop>
References: <201104212129.17013.arnd@arndb.de>
	<20110421130930.4be9e9e1@jbarnes-desktop>
Message-ID: <201104261626.20152.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 April 2011, Jesse Barnes wrote:
> On Thu, 21 Apr 2011 21:29:16 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > I think the recent discussions on linaro-mm-sig and the BoF last week
> > at ELC have been quite productive, and at least my understanding
> > of the missing pieces has improved quite a bit. This is a list of
> > things that I think need to be done in the kernel. Please complain
> > if any of these still seem controversial:
> > 
> > 1. Fix the arm version of dma_alloc_coherent. It's in use today and
> >    is broken on modern CPUs because it results in both cached and
> >    uncached mappings. Rebecca suggested different approaches how to
> >    get there.
> > 
> > 2. Implement dma_alloc_noncoherent on ARM. Marek pointed out
> >    that this is needed, and it currently is not implemented, with
> >    an outdated comment explaining why it used to not be possible
> >    to do it.
> > 
> > 3. Convert ARM to use asm-generic/dma-mapping-common.h. We need
> >    both IOMMU and direct mapped DMA on some machines.
> 
> I don't think the DMA mapping and allocation APIs are sufficient for
> high performance graphics at least.  It's fairly common to allocate a
> bunch of buffers necessary to render a scene, build up a command buffer
> that references them, then hand the whole thing off to the kernel to
> execute at once on the GPU.  That allows for a lot of extra efficiency,
> since it allows you to batch the MMU binding until execution occurs (or
> even put it off entirely until the page is referenced by the GPU in the
> case of faulting support).  It's also necessary to avoid livelocks
> between two clients trying to render; if mapping is incremental on both
> sides, it's possible that neither will be able to make forward
> progress due to IOMMU space exhaustion.
> 
> So that argues for separating allocation from mapping both on the user
> side (which I think everyone agrees on) as well as on the kernel side,
> both for CPU access (which some drivers won't need) and for GPU access.

I don't thing that this argument has anything to do with what the
underlying API should be, right? I can see this built on top of either
the dma-mapping headers with extensions to map potentially uncached
pages, and with the iommu API. Neither way would however save us from
implementing the three items listed above.

It's certainly a good point to note that we should have a way to
allocate pages for a device without mapping them into any address
space right away. My feeling is still that the dma mapping API is
the right place for this, because it is the only part of the kernel
that has knowledge about whether a device needs uncached memory for
coherent access, under what constraints it can map noncontiguous
memory into its own address space, and what its addressing capabilities
are (dma mask).

	Arnd
