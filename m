From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 13 May 2010 10:18:10 +1000
Subject: Rampant ext3/4 corruption on 2.6.34-rc7 with VIVT ARM (Marvell
	88f5182)
In-Reply-To: <1273707708.15428.4.camel@mulgrave.site>
References: <1273569821.21352.19.camel@pasglop>
	<1273575478.21352.29.camel@pasglop>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C545537F@dbde02.ent.ti.com>
	<20100512222154.GA6841@shareable.org>
	<1273704431.21352.136.camel@pasglop>
	<1273707708.15428.4.camel@mulgrave.site>
Message-ID: <1273709890.21352.141.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-05-12 at 18:41 -0500, James Bottomley wrote:
> > Which means that for coherent architectures that do not implement
> > the ops->sync_* hooks, we are probably missing a barrier here... 
> > 
> > Thus if the above is expected to be a memory barrier, it's broken on
> > cache coherent powerpc for example. On non-coherent powerpc, we do
> cache
> > flushes and those are implicit barriers.
> 
> Can you explain this a little more.  On a cache coherent machine, the
> sync is a nop ... why would you want a nop to be any type of barrier?

Well if the driver can peek at the data after the sync, and have any
kind of ordering guarantee that it doesn't get stale data (the load
isn't prefetched or speculated early), that would require an mb() or at
least rmb().

It would seem sensible for drivers to assume that something like
dma_cache_sync_for_cpu() thus has the semantics of an rmb() at least,
no ?

Cheers,
Ben.
