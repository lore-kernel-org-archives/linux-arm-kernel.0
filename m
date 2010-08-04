From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 04 Aug 2010 11:38:10 +1000
Subject: memblock glitch
In-Reply-To: <1280882307.1902.124.camel@pasglop>
References: <1280882307.1902.124.camel@pasglop>
Message-ID: <1280885890.1902.134.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-08-04 at 10:38 +1000, Benjamin Herrenschmidt wrote:
> Hi Russell !
> 
> While looking at updating ARM memblock to some of my changes, I found
> this bit in arch/arm/mm/init.c:

And another question...

In arch/arm/plat-omap/fb.c:

static int valid_sdram(unsigned long addr, unsigned long size)
{
	struct memblock_region res;

	res.base = addr;
	res.size = size;
	return !memblock_find(&res) && res.base == addr && res.size == size;
}

So if I understand things correctly, you are working around the weird
behaviour of memblock_find(), which returns the intersection of the
region passed and the first memblock that partially overlaps it.

Since you are now the only user of that function (I was about to remove it),
would you be happy if I replaced the above and the !SPARSEMEM pfn_valid()
with a single function: memblock_is_mem(addr, size) ?

It can do a fast search (binary search or whatever) on addr, and then
dbl check size (which would be PAGE_SIZE for pfn_valid).

Ben.
