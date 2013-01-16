From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Wed, 16 Jan 2013 15:50:18 +0000
Subject: ARM DMA: Fix in dma_cache_maint_page
In-Reply-To: <20130116130838.GS23505@n2100.arm.linux.org.uk>
References: <50F69F72.4030807@codeaurora.org> <50F6A14C.6040206@codeaurora.org>
 <1358340715.2384.23.camel@dabdike.int.hansenpartnership.com>
 <20130116130838.GS23505@n2100.arm.linux.org.uk>
Message-ID: <1358351418.2384.37.camel@dabdike.int.hansenpartnership.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-01-16 at 13:08 +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 16, 2013 at 12:51:55PM +0000, James Bottomley wrote:
> > On Wed, 2013-01-16 at 18:17 +0530, Subhash Jadavani wrote:
> > > Is it possible to pick up James patch below? Thread here: 
> > > http://comments.gmane.org/gmane.linux.kernel.mmc/18670, have the details 
> > > on the motivation behind this fix.
> > 
> > Someone should also audit the arm kernel code for more of these linear
> > page array assumptions.  I'm guessing that when sparsemem was added to
> > arm over a year ago, whoever did it either didn't audit or missed a few.
> 
> No, that's a bad assumption.  We've had discontigmem for years - maybe
> something like 12 years.

Discontigmem doesn't suffer from this particular problem: The breaks in
the page arrays in a discontigmem environment represent real breaks in
the physical memory map, so there can never arise a situation where
page++ wouldn't get you the next valid page, provided there's still a
real contiguous page of physical memory present in the system, of
course.

Sparsemem tried to be cleverer and it broke that assumption.  I'm
starting to wonder if there are other places in the kernel which make it
and get broken by sparsemem.

I have patches for parisc to switch it over to sparsemem from
discontigmem ... I haven't pushed them yet, fortunately, and I certainly
didn't check our underlying assumptions for this problem.

>   I switched everything over to sparsemem, and
> sparsemem has been used on ARM for years too:
> 
> 	commit 05944d74bc28fffbcce159cb915d0acff82f30a1
> 	Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
> 	Date:   Thu Nov 30 20:43:51 2006 +0000
> 
> 	    [ARM] Add initial sparsemem support
> 
> 	    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> However, there's a big problem with this: very few of the lead people
> have machines which suffer from this disability, so there's very little
> testing of it - and there's very little testing of new code with it.

Anyone can test this just by enabling sparsemem with an artificially
small SECTION_SIZE_BITS (that makes it much more likely you'll hit a
boundary).

> The patch which originally introduced this code which your patch
> touches was part of adding highmem support to ARM:
> 
> 	commit 43377453af83b8ff8c1c731da1508bd6b84ebfea
> 	Author: Nicolas Pitre <nico@cam.org>
> 	Date:   Thu Mar 12 22:52:09 2009 -0400
> 
> 	    [ARM] introduce dma_cache_maint_page()
> 
> 	    This is a helper to be used by the DMA mapping API to handle cache
> 	    maintenance for memory identified by a page structure instead of a
> 	    virtual address.  Those pages may or may not be highmem pages, and
> 	    when they're highmem pages, they may or may not be virtually mapped.
> 	    When they're not mapped then there is no L1 cache to worry about. But
> 	    even in that case the L2 cache must be processed since unmapped highmem
> 	    pages can still be L2 cached.
> 
> 	    Signed-off-by: Nicolas Pitre <nico@marvell.com>
> 
> some three years later, and has been through a number of revisions since.
> 
> I'd really like to get rid of sparsemem so it's one less failure case, but
> alas there's a relatively small bunch of folk who rely upon it.  That
> means it's always going to be more buggy.

Heh, I'd like to do that too on parisc; the problem is that the memory
holes in our platform are just to big to use a linear array on.  And now
that the slub people want DISCONTIGMEM deprecated, there's not much
choice.

James
