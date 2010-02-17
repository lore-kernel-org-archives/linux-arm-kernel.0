From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 17 Feb 2010 21:05:49 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <20100217095553.GA30033@n2100.arm.linux.org.uk>
References: <20100208065519.GE1290@ucw.cz>
	<1265628483.4020.63.camel@pc1117.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C3CF7D50@dbde02.ent.ti.com>
	<201002160922.47072.oliver@neukum.org>
	<1266397543.16346.264.camel@pasglop>
	<20100217095553.GA30033@n2100.arm.linux.org.uk>
Message-ID: <1266401149.16346.276.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-02-17 at 09:55 +0000, Russell King - ARM Linux wrote:
> Nope.  It's to do with mapping a buffer for DMA, and then doing PIO
> reads/writes to it.
> 
> With speculative prefetches, you have to deal with cache coherency with
> hardware DMA on DMA unmap.  If you've written to the buffer in violation
> of the DMA API buffer ownership rules, then your writes get thrown away
> resulting in immediate data corruption. 

Right, and this exact same problem will bite some embedded powerpc
too I suppose :-)

Hrm... actually not :-) We don't do the invalidate at unmap time
today because we know 44x have such a broken prefetcher that we disable
it ... interesting considering that there are machines around that
do non-coherent DMA with 750's style chips who -do- have a prefetcher...
damn, we have a bug :-)

In any case, same problem here.

See my reply to Oliver. Basically, the problem boils down to the
dma_map/unmap being done at the wrong layer. The driver should
simply not do these if it's going to do PIO over that range.

Cheers,
Ben.
