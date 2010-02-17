From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 17 Feb 2010 20:05:43 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <201002160922.47072.oliver@neukum.org>
References: <20100208065519.GE1290@ucw.cz>
	<1265628483.4020.63.camel@pc1117.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C3CF7D50@dbde02.ent.ti.com>
	<201002160922.47072.oliver@neukum.org>
Message-ID: <1266397543.16346.264.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-02-16 at 09:22 +0100, Oliver Neukum wrote:
> This seems wrong to me. Buffers for control transfers may be
> transfered
> by DMA, so the caches must be flushed on architectures whose caches
> are not coherent with respect to DMA.
> 
> Would you care to elaborate on the exact nature of the bug you are
> fixing?

I missed part of this thread, so forgive me if I'm a bit off here, but
if the problem is indeed I$/D$ cache coherency vs. PIO transfers, then
this is a long solved issue on other archs such as ppc (and I _think_
sparc).

The way we do it, at least on powerpc which is PIPT, is to keep track on
a per-page basis, whether a given page is clean for execution using
PG_arch1 bit. This bit is cleared when a new page is popped into the
page cache, and we clear it from flush_dcache_page() iirc (you may want
to dbl check I don't have the code at hand right now, or rather, I do
but I'm to lazy to look right now :-)

Any page with that not set is mapped into userspace with execute
permission disabled. We do the flush and set PG_arch1 on the first exec
fault to that page.

Cheers,
Ben.
 
