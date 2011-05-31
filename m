From: dave@linux.vnet.ibm.com (Dave Hansen)
Date: Tue, 31 May 2011 10:34:20 -0700
Subject: [PATCH 01/10] mm: Introduce the memory regions data structure
In-Reply-To: <20110529081618.GC8333@in.ibm.com>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
	<1306499498-14263-2-git-send-email-ankita@in.ibm.com>
	<1306510203.22505.69.camel@nimitz>
	<20110527182041.GM5654@dirshya.in.ibm.com>
	<1306531912.22505.84.camel@nimitz> <20110529081618.GC8333@in.ibm.com>
Message-ID: <1306863260.15490.35.camel@nimitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-05-29 at 13:46 +0530, Ankita Garg wrote:
> > It's worth noting that we already do targeted reclaim on boundaries
> > other than zones.  The lumpy reclaim and memory compaction logically do
> > the same thing.  So, it's at least possible to do this without having
> > the global LRU designed around the way you want to reclaim.
> >
> My understanding maybe incorrect, but doesn't both lumpy reclaim and
> memory compaction still work under zone boundary ? While trying to free
> up higher order pages, lumpy reclaim checks to ensure that pages that
> are selected do not cross zone boundary. Further, compaction walks
> through the pages in a zone and tries to re-arrange them.

I'm asserting that we don't need memory regions in the

	pgdat->regions[]->zones[]

layout to do what you're asking for.

Lumpy reclaim is limited to a zone because it's trying to satisfy and
allocation request that came in for *THAT* *ZONE*.  It's useless to go
clear out other zones.  In your case, you don't care about zone
boundaries: you want to reclaim things regardless.

There was a "cma: Contiguous Memory Allocator added" patch posted a bit
ago to linux-mm at .  You might want to take a look at it for some
inspiration.

I think you also need to clearly establish here why any memory that
you're going to want to power off can't use (or shouldn't use)
ZONE_MOVABLE.  It seems a bit silly to have it there, and ignore it for
such a similar use case.  Memory hot-remove and power-down are not
horrifically different beasts.

BTW, that's probably something else to add to your list: make sure
mem_map[]s for memory in a region get allocated *in* that region. 

-- Dave
