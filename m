From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 24 Feb 2010 13:47:12 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1266601011.32546.48.camel@e102109-lin.cambridge.arm.com>
References: <1266445892.16346.306.camel@pasglop>
	<1266599755.32546.38.camel@e102109-lin.cambridge.arm.com>
	<1266601011.32546.48.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1266979632.23523.1668.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-02-19 at 17:36 +0000, Catalin Marinas wrote:
> 
> If a page is already mapped in user space, flush_dcache_page() on ARM
> does the flushing rather than deferring it to update_mmu_cache(). 

This is for D-cache aliases on VIVT right ? Or are you still talking
about I/D coherency on PIPT ARMs ? Because the later should not matter
for already mapped userspace pages in the sense that if user space
explicitely read() onto a page, it's up to userspace to cache clean that
page before executing from it in my book :-)

> The PIO HCD drivers, however, don't call flush_dcache_page(). Is it possible
> that the HCD could transfer data into a page cache page already mapped
> in user space? My understanding is that the scenario above is possible.

It is but I'm not confident the responsibility for doing that cleanup
is at the HCD level. That would impact a lot of HCD activities that
don't need such flushing since the use of the page is purely in-kernel.

Though I suppose that could be optimized out in most case using the page
use count.

But I still wonder whether it should be pushed down to the actual
interface drivers, that's always been the case I believe. In fact, in
the case of block ops, it's generally done at the BIO or even file
system layer right ?

Cheers,
Ben.
