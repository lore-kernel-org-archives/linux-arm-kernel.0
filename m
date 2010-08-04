From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 04 Aug 2010 10:38:27 +1000
Subject: memblock glitch
Message-ID: <1280882307.1902.124.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell !

While looking at updating ARM memblock to some of my changes, I found
this bit in arch/arm/mm/init.c:

int pfn_valid(unsigned long pfn)
{
	struct memblock_region *mem = &memblock.memory;
	unsigned int left = 0, right = mem->cnt;

	do {
		unsigned int mid = (right + left) / 2;

		if (pfn < memblock_start_pfn(mem, mid))
			right = mid;
		else if (pfn >= memblock_end_pfn(mem, mid))
			left = mid + 1;
		else
			return 1;
	} while (left < right);
	return 0;
}
EXPORT_SYMBOL(pfn_valid);

So you're trying to do a dichotomy to be faster. However, that doesn't
quite work with my new code as I'm trying to take away access to
the internals of memblock from arch code so we can re-implement the core
in a slightly saner way if we wish to.

Since I understand why you don't want a linear search there, any
objection if I move the logic to the core memblock and expose it via a
memblock_search() kind of facility ?

Cheers,
Ben.
