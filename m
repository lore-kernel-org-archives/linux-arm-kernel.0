From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 27 Feb 2010 08:40:29 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267201521.14703.50.camel@e102109-lin.cambridge.arm.com>
References: <1266979632.23523.1668.camel@pasglop>
	<1267201521.14703.50.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1267220429.23523.1811.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-02-26 at 16:25 +0000, Catalin Marinas wrote:
> 
> For mmap'ed pages (and present in the page cache), is it guaranteed that
> the HCD driver won't write to it once it has been mapped into user
> space? If that's the case, it may solve the problem by just reversing
> the meaning of PG_arch_1 on ARM and assume that a newly allocated page
> has dirty D-cache by default.

Well, I don't see why the HCD would write to it unless it's swapped out,
and thus unmapped or read() to or similar.

> The filesystem layer does it only if it needs to touch the data written
> by the block device (e.g. cramfs, jffs). Some block devices call
> flush_dcache_page (like mmci.c) while some others don't (and those that
> use DMA actually don't since the DMA API handles the flushing). 

Hrm, the DMA API certainly doesn't handle the I$/D$ coherency on
powerpc.. I'm afraid that whole cache handling stuff is totally
inconsistent since different archs have different expectations here.

Maybe we need to revisit things in that area, though it might require to
be done properly to have not one but two bits in struct page to
separately track the D$ and I$ state ...

Cheers,
Ben.
