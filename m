From: mel@csn.ul.ie (Mel Gorman)
Date: Wed, 14 Jul 2010 14:14:15 +0100
Subject: About SECTION_SIZE_BITS for Sparsemem
In-Reply-To: <20100714085918.GB9115@n2100.arm.linux.org.uk>
References: <000601cb219c$c7830b60$56892220$%kim@samsung.com>
	<AANLkTinTrt7VKuKvleiJj4lv2tWqCcDYHVXAQIHLA7bh@mail.gmail.com>
	<001b01cb21aa$ef0e4d80$cd2ae880$%kim@samsung.com>
	<AANLkTinkujX3VbL0sXjjghovr8eX9Os0huw3OTBut2UP@mail.gmail.com>
	<20100713092658.GB29885@csn.ul.ie>
	<20100713093815.GD20590@n2100.arm.linux.org.uk>
	<20100713095035.GE29885@csn.ul.ie>
	<20100713173744.GB30142@n2100.arm.linux.org.uk>
	<20100713203250.GA21600@csn.ul.ie>
	<20100714085918.GB9115@n2100.arm.linux.org.uk>
Message-ID: <20100714131415.GC13117@csn.ul.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 14, 2010 at 09:59:18AM +0100, Russell King - ARM Linux wrote:
> On Tue, Jul 13, 2010 at 09:32:50PM +0100, Mel Gorman wrote:
> > On Tue, Jul 13, 2010 at 06:37:44PM +0100, Russell King - ARM Linux wrote:
> > > You're saying that MAX_PHYSMEM_BITS=29 SECTION_SIZE_BITS=26 is wrong.
> > > 
> > 
> > Not wrong. It's fine as long as you're ok with some unnecessary memmap
> > being allocated. There is wastage of memory but functionally it'll be
> > fine with existing sparsemem and the assumptions it makes.
> > 
> > Obviously you're not ok with this wastage or this discussion would not even
> > be happening and with SECTION_SIZE_BITS=26, there is quite a bit of wastage.
> 
> Absolutely I'm not ok with this wastage - it's 127 + 127 + 64 pages, or
> 1.2MB - that's 4% of system memory wasted in stuff which isn't going to
> be used.
> 
> Moreover, the mem_map array for each populated bank is 512K - which is
> the size of the RAM in the first two banks.  At that point, there's
> absolutely no point in populating them.  The overhead of populating
> those banks exactly equals the gain from populating them.
> 
> Sparsemem is absolutely absurd in this requirement - it can't handle
> sparse memory efficiently without wasting lots of memory in the
> process.
> 

I wasn't around when sparsemem was designed, but I strongly suspect it
wasn't considered that a bank would only be 512K. The requirement of a
section being fully populated to allow pfn_valid to be very cheap still
seems very reasonable to me in the majority of cases. It's just no ok in
ARMs case because of the size of banks.

> > I haven't researched this so apologies if it turns out to be stupid but
> > I think the bit SECTION_MAP_LAST_BIT is actually unused and should be
> > safe to use. Has the option being considered of using this bit to mean
> > "section has holes punched in it". If set, the architecture must provide
> > an additional arch_holey_section_pfn_valid() that does additional checking
> > based on information sparsemem doesn't have?  This would avoid the worst of
> > the performance issues of making pfn_valid() slower without increasing the
> > size of mem_section.
> 
> As I've already said, how about just allowing pfn_valid() to be overridden
> by architectures, even for the sparsemem case. 

If nothing else pans out, I won't resist that approach. It's not my No.1
perference because it results in SparseMem-on-ARM behaving one way and
SparseMem-on-everything-else behaving another with respect to pfn_valid().
I'd prefer that an architecture-specific pfn_valid() only be called for
the sections that are known to have holes punched in them.

> We have a perfectly good
> pfn_valid() implementation that'll work across the board, and will fix
> this issue.
> 

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
