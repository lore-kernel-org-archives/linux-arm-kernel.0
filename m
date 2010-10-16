From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 16 Oct 2010 13:36:28 +1100
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <20101008175308.GA10975@n2100.arm.linux.org.uk>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101007192245.GC26435@n2100.arm.linux.org.uk>
	<AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
	<20101008175308.GA10975@n2100.arm.linux.org.uk>
Message-ID: <1287196588.2370.1.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-10-08 at 18:53 +0100, Russell King - ARM Linux wrote:
> As already discussed, it's nigh on impossible to unmap the existing
> direct mapped region (read the previous discussions about why this is)
> - which is precisely why there is no direct alternative solution.
> 
> The only possible solution is to exclude some memory at boot time from
> the system direct map so that it never appears in the direct map, and
> use ioremap on _that_.  Another possible alternative is to use
> highmem,
> obtain highmem pages (making sure that it doesn't fall back to lowmem)
> and remap them using interfaces such as vmap.
> 
> So there are solutions to the problem, but it seems that _no one_ is
> willing to discuss it other than "we want our old way back".
> 
> If you want the old way back, apply pressure to silicon vendors and
> ARM Ltd to change the architecture to lift this restriction - which
> will probably mean doing away with aggressive speculative prefetching
> so that it's possible to predict what will be in the cache at any
> point in time. 

Note that we have the exact same problem on powerpc. The only sane
solution is that SoCs designed around such cores or versions of the
architecture should be fully DMA coherent to avoid the need for funky
mapping attributes. Anything else is garbage HW, but sadly, it looks
like way too many idiots still find jobs as HW designers.

Cheers,
Ben.
