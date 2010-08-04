From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Aug 2010 09:49:30 +0100
Subject: memblock glitch
In-Reply-To: <1280882307.1902.124.camel@pasglop>
References: <1280882307.1902.124.camel@pasglop>
Message-ID: <20100804084930.GA4927@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 04, 2010 at 10:38:27AM +1000, Benjamin Herrenschmidt wrote:
> Hi Russell !
> 
> While looking at updating ARM memblock to some of my changes, I found
> this bit in arch/arm/mm/init.c:
> 
> int pfn_valid(unsigned long pfn)
> {
> 	struct memblock_region *mem = &memblock.memory;
> 	unsigned int left = 0, right = mem->cnt;
> 
> 	do {
> 		unsigned int mid = (right + left) / 2;
> 
> 		if (pfn < memblock_start_pfn(mem, mid))
> 			right = mid;
> 		else if (pfn >= memblock_end_pfn(mem, mid))
> 			left = mid + 1;
> 		else
> 			return 1;
> 	} while (left < right);
> 	return 0;
> }
> EXPORT_SYMBOL(pfn_valid);
> 
> So you're trying to do a dichotomy to be faster.

Correct.  The normal size of this thing tends to typically be one or
maybe two entries, although we normally support up to 8 ranges, or 16
in one case.  It works well because of the tight cache locality of the
data, which occupies maybe up to three cache lines.

> However, that doesn't
> quite work with my new code as I'm trying to take away access to
> the internals of memblock from arch code so we can re-implement the core
> in a slightly saner way if we wish to.
> 
> Since I understand why you don't want a linear search there, any
> objection if I move the logic to the core memblock and expose it via a
> memblock_search() kind of facility ?

No objection.
