From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Feb 2010 09:55:53 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1266397543.16346.264.camel@pasglop>
References: <20100208065519.GE1290@ucw.cz>
	<1265628483.4020.63.camel@pc1117.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C3CF7D50@dbde02.ent.ti.com>
	<201002160922.47072.oliver@neukum.org>
	<1266397543.16346.264.camel@pasglop>
Message-ID: <20100217095553.GA30033@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2010 at 08:05:43PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2010-02-16 at 09:22 +0100, Oliver Neukum wrote:
> > This seems wrong to me. Buffers for control transfers may be
> > transfered
> > by DMA, so the caches must be flushed on architectures whose caches
> > are not coherent with respect to DMA.
> > 
> > Would you care to elaborate on the exact nature of the bug you are
> > fixing?
> 
> I missed part of this thread, so forgive me if I'm a bit off here, but
> if the problem is indeed I$/D$ cache coherency vs. PIO transfers, then
> this is a long solved issue on other archs such as ppc (and I _think_
> sparc).

Nope.  It's to do with mapping a buffer for DMA, and then doing PIO
reads/writes to it.

With speculative prefetches, you have to deal with cache coherency with
hardware DMA on DMA unmap.  If you've written to the buffer in violation
of the DMA API buffer ownership rules, then your writes get thrown away
resulting in immediate data corruption.
