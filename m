From: jbarnes@virtuousgeek.org (Jesse Barnes)
Date: Tue, 26 Apr 2011 08:39:22 -0700
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <201104261626.20152.arnd@arndb.de>
References: <201104212129.17013.arnd@arndb.de>
	<20110421130930.4be9e9e1@jbarnes-desktop>
	<201104261626.20152.arnd@arndb.de>
Message-ID: <20110426083922.344bd8d6@jbarnes-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Apr 2011 16:26:19 +0200
Arnd Bergmann <arnd@arndb.de> wrote:
> I don't thing that this argument has anything to do with what the
> underlying API should be, right? I can see this built on top of either
> the dma-mapping headers with extensions to map potentially uncached
> pages, and with the iommu API. Neither way would however save us from
> implementing the three items listed above.

Or simply extending the DMA mapping API to allow for allocations
without mapping.  I was just worried you had a more traditional driver
model in mind (e.g. coherent alloc on the ring buffer, single mappings
for data buffers, all mapped in the kernel driver at allocation time).

The DMA API does have some advantages, in that arches already support
it, there's some infrastructure for handling per-bus mapping, etc., so
building on top of it is probably a good idea.

> It's certainly a good point to note that we should have a way to
> allocate pages for a device without mapping them into any address
> space right away. My feeling is still that the dma mapping API is
> the right place for this, because it is the only part of the kernel
> that has knowledge about whether a device needs uncached memory for
> coherent access, under what constraints it can map noncontiguous
> memory into its own address space, and what its addressing capabilities
> are (dma mask).

Right.  Sometimes a device or platform can handle either cached or
uncached though, and we need userspace to decide on the best type for
performance reasons.

-- 
Jesse Barnes, Intel Open Source Technology Center
