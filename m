From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 13 May 2010 08:47:11 +1000
Subject: Rampant ext3/4 corruption on 2.6.34-rc7 with VIVT ARM (Marvell
	88f5182)
In-Reply-To: <20100512222154.GA6841@shareable.org>
References: <1273569821.21352.19.camel@pasglop>
	<1273575478.21352.29.camel@pasglop>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C545537F@dbde02.ent.ti.com>
	<20100512222154.GA6841@shareable.org>
Message-ID: <1273704431.21352.136.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-05-12 at 23:21 +0100, Jamie Lokier wrote:
> Shilimkar, Santosh wrote:
> > There was a memory write barrier missing before the DMA descriptors 
> > are handed over to DMA controller.
> 
> On that note, are the cache flush functions implicit memory barriers?

(Adding Fujita on CC)

That's a very good question. The generic inline implementation of
dma_sync_* is:

static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
					   size_t size,
					   enum dma_data_direction dir)
{
	struct dma_map_ops *ops = get_dma_ops(dev);

	BUG_ON(!valid_dma_direction(dir));
	if (ops->sync_single_for_cpu)
		ops->sync_single_for_cpu(dev, addr, size, dir);
	debug_dma_sync_single_for_cpu(dev, addr, size, dir);
}

Which means that for coherent architectures that do not implement
the ops->sync_* hooks, we are probably missing a barrier here... 

Thus if the above is expected to be a memory barrier, it's broken on
cache coherent powerpc for example. On non-coherent powerpc, we do cache
flushes and those are implicit barriers.

Now, in the case at hand, which is my ARM based NAS, I believe this
is non cache-coherent and thus uses cache flush ops. I don't know ARM
well enough but I would expect these to be implicit barriers. Russell ?
Nico ?

IE. You may have found a bug here though I don't know whether it's the
bug we are hitting right now :-)

Cheers,
Ben.
