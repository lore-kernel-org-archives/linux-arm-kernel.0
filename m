From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Oct 2010 18:53:08 +0100
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101007192245.GC26435@n2100.arm.linux.org.uk>
	<AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
Message-ID: <20101008175308.GA10975@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 08, 2010 at 12:32:35PM +0300, Felipe Contreras wrote:
> I think when _you_ remove functionality from the architecture, you
> should provide a mechanism that drivers can migrate to. Since there's
> nothing like that, not even a guideline, you are breaking the drivers
> willingly, and expecting other people to fix a difficult problem that
> you yourself have no idea how to fix properly.

We can either wait for people to complain about silent data corruption
or we can be compliant with the architecture specification.  Which is
better - to avoid data corruption and be correct, or allow a system to
become flakey and corrupt people's data.

What I care about is system correctness and people's data - having
multiple mappings with different attributes is documented in very clear
terms as being 'unpredictable' and therefore it isn't permissible to
allow the practice that worked with previous processors (inherently
due to their cache architecture) to continue forward onto processors
with a different cache architecture.

As already discussed, it's nigh on impossible to unmap the existing
direct mapped region (read the previous discussions about why this is)
- which is precisely why there is no direct alternative solution.

The only possible solution is to exclude some memory at boot time from
the system direct map so that it never appears in the direct map, and
use ioremap on _that_.  Another possible alternative is to use highmem,
obtain highmem pages (making sure that it doesn't fall back to lowmem)
and remap them using interfaces such as vmap.

So there are solutions to the problem, but it seems that _no one_ is
willing to discuss it other than "we want our old way back".

If you want the old way back, apply pressure to silicon vendors and
ARM Ltd to change the architecture to lift this restriction - which
will probably mean doing away with aggressive speculative prefetching
so that it's possible to predict what will be in the cache at any
point in time.
