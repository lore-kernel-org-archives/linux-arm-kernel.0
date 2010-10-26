From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Oct 2010 20:30:16 +0100
Subject: [PATCH] ARM: memblock: set allocation limit for
	MEMBLOCK_ALLOC_ANYWHERE
In-Reply-To: <1288116524.5506.1.camel@jazztop>
References: <20101025104800.6961.70715.stgit@e102109-lin.cambridge.arm.com>
	<20101025151513.GB21105@n2100.arm.linux.org.uk>
	<1288047336.6035.12.camel@jazztop>
	<20101026105638.GA2092@n2100.arm.linux.org.uk>
	<1288116524.5506.1.camel@jazztop>
Message-ID: <20101026193016.GA9354@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 26, 2010 at 07:08:43PM +0100, Will Deacon wrote:
> Russell,
> 
> On Tue, 2010-10-26 at 11:56 +0100, Russell King - ARM Linux wrote:
> > On Mon, Oct 25, 2010 at 11:55:36PM +0100, Will Deacon wrote:
> > > Right. I could also move this call out of sanity_check_meminfo
> > > and into arm_memblock_init now that we don't need lowmem_end_addr
> > > to be initialised. If you're happy with me making that change then
> > > I'll post a revised version to the patch system.
> > 
> > It looks like we're doing a few things out of order.  Yes, it makes
> > sense to move that initialization to arm_memblock_init(), but as we're
> > not running sanity_check_meminfo(), it could mean there's problems
> > with out of order membanks and similar.
> > 
> We could move the arm_memblock_init() call into paging_init, immediately
> after the call to sanity_check_meminfo. I think everything should be
> safe then.

Well, there's actually some things which the mmu-ful stuff does (such as
sorting) which the nommu stuff should also do for safety sake, so I
think a little bit of a cleanup in this area would be no bad thing,
rather than trying to move arm_memblock_init() into both the MMU and
noMMU code.
