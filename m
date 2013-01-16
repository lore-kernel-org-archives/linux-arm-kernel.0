From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Jan 2013 13:08:38 +0000
Subject: ARM DMA: Fix in dma_cache_maint_page
In-Reply-To: <1358340715.2384.23.camel@dabdike.int.hansenpartnership.com>
References: <50F69F72.4030807@codeaurora.org> <50F6A14C.6040206@codeaurora.org>
 <1358340715.2384.23.camel@dabdike.int.hansenpartnership.com>
Message-ID: <20130116130838.GS23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 12:51:55PM +0000, James Bottomley wrote:
> On Wed, 2013-01-16 at 18:17 +0530, Subhash Jadavani wrote:
> > Is it possible to pick up James patch below? Thread here: 
> > http://comments.gmane.org/gmane.linux.kernel.mmc/18670, have the details 
> > on the motivation behind this fix.
> 
> Someone should also audit the arm kernel code for more of these linear
> page array assumptions.  I'm guessing that when sparsemem was added to
> arm over a year ago, whoever did it either didn't audit or missed a few.

No, that's a bad assumption.  We've had discontigmem for years - maybe
something like 12 years.  I switched everything over to sparsemem, and
sparsemem has been used on ARM for years too:

	commit 05944d74bc28fffbcce159cb915d0acff82f30a1
	Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
	Date:   Thu Nov 30 20:43:51 2006 +0000

	    [ARM] Add initial sparsemem support

	    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

However, there's a big problem with this: very few of the lead people
have machines which suffer from this disability, so there's very little
testing of it - and there's very little testing of new code with it.

The patch which originally introduced this code which your patch
touches was part of adding highmem support to ARM:

	commit 43377453af83b8ff8c1c731da1508bd6b84ebfea
	Author: Nicolas Pitre <nico@cam.org>
	Date:   Thu Mar 12 22:52:09 2009 -0400

	    [ARM] introduce dma_cache_maint_page()

	    This is a helper to be used by the DMA mapping API to handle cache
	    maintenance for memory identified by a page structure instead of a
	    virtual address.  Those pages may or may not be highmem pages, and
	    when they're highmem pages, they may or may not be virtually mapped.
	    When they're not mapped then there is no L1 cache to worry about. But
	    even in that case the L2 cache must be processed since unmapped highmem
	    pages can still be L2 cached.

	    Signed-off-by: Nicolas Pitre <nico@marvell.com>

some three years later, and has been through a number of revisions since.

I'd really like to get rid of sparsemem so it's one less failure case, but
alas there's a relatively small bunch of folk who rely upon it.  That
means it's always going to be more buggy.
