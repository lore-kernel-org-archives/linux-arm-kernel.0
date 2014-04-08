From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 8 Apr 2014 12:40:33 -0600
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140408201547.7bf37e2a@skate>
References: <20140405193435.50d8dd81@skate>
 <54BB31A2B04145E8908E0183FAB6B61B@fatboyfat.co.uk>
 <alpine.DEB.2.10.1404061631130.4683@vroombuntu>
 <20140408171309.09bbf968@skate> <20140408174034.79df403e@skate>
 <20140408175545.1b4d55a5@skate>
 <20140408171417.GB27776@obsidianresearch.com>
 <20140408175324.GH11052@1wt.eu>
 <20140408180828.GC32490@obsidianresearch.com>
 <20140408201547.7bf37e2a@skate>
Message-ID: <20140408184033.GG32490@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 08:15:47PM +0200, Thomas Petazzoni wrote:

> The problem I have with this approach is the consumption of windows. We
> have a limited number of them, and this approach could easily consume
> quite a few windows for one single bridge BAR, depending on its size.
> Like a bridge BAR of 120 MB would consume four windows (one 64 MB, one
> 32 MB, one 16 MB and one 8 MB).

I agree, but on the other hand, the three people hitting this problem
have lots and lots of free windows. This won't work for someone using
a large number of PEX ports, but it does work right now, and it is
small enough to go into -stable..
 
> Instead, I would really like to see the PCI core being told about this
> constraint, so that it can oversize the bridge BAR (to 128 MB in the
> above example of a 120 MB bridge BAR). Of course, it would be better if
> the PCI core would not blindly apply this logic: if there is a 129 MB
> bridge BAR, we'd prefer to have two windows (one 128 MB and one 1 MB),
> so as to not loose too much physical address space.

Right, it would be great if the alignment function could alter the
size as well - but as you say, once we get there you will still want
to allocate more than 1 mbus window per bridge window, so the code
will still be required ..

Also, as you pointed out, the base alignment is also important to
consider, so this needs fixing too: 

	if (res->flags & IORESOURCE_IO)
		return round_up(start, max_t(resource_size_t, SZ_64K, size));
	else if (res->flags & IORESOURCE_MEM)
		return round_up(start, max_t(resource_size_t, SZ_1M, size));

What does round_up do when size is not a power of 2? Not the right
thing, I think. Size should be rounded first..

And the rough loop should consider the base alignment when
constraining the size as well...

Jason
