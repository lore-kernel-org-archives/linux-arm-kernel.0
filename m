From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Aug 2010 09:54:47 +0100
Subject: memblock glitch
In-Reply-To: <1280885890.1902.134.camel@pasglop>
References: <1280882307.1902.124.camel@pasglop>
	<1280885890.1902.134.camel@pasglop>
Message-ID: <20100804085447.GB4927@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 04, 2010 at 11:38:10AM +1000, Benjamin Herrenschmidt wrote:
> In arch/arm/plat-omap/fb.c:
> 
> static int valid_sdram(unsigned long addr, unsigned long size)
> {
> 	struct memblock_region res;
> 
> 	res.base = addr;
> 	res.size = size;
> 	return !memblock_find(&res) && res.base == addr && res.size == size;
> }
> 
> So if I understand things correctly, you are working around the weird
> behaviour of memblock_find(), which returns the intersection of the
> region passed and the first memblock that partially overlaps it.

Correct - what it's trying to ascertain is whether the address range
is entirely contained within a valid region.

> Since you are now the only user of that function (I was about to remove it),
> would you be happy if I replaced the above and the !SPARSEMEM pfn_valid()
> with a single function: memblock_is_mem(addr, size) ?
> 
> It can do a fast search (binary search or whatever) on addr, and then
> dbl check size (which would be PAGE_SIZE for pfn_valid).

You could do, but do we want to introduce size checks for pfn_valid?
I'm slightly concerned because it can be a hot path.

If all entries in memblock are already page aligned, if addr falls
within a memblock, it must cover the entire page so checking the size
seems redundant for this case.
