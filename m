From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 04 May 2010 17:28:56 +0100
Subject: [PATCH] ARM: Fix virtual kernel memory printing for sparsemem
In-Reply-To: <20100504161829.GE30601@n2100.arm.linux.org.uk>
References: <20100504161829.GE30601@n2100.arm.linux.org.uk>
Message-ID: <1272990536.15948.13.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-05-04 at 17:18 +0100, Russell King - ARM Linux wrote:
> On Tue, May 04, 2010 at 06:13:28PM +0200, Marek Vasut wrote:
> > Dne ?t 25. b?ezna 2010 17:01:26 Catalin Marinas napsal(a):
> > > On Thu, 2010-03-25 at 15:30 +0000, Russell King - ARM Linux wrote:
> > > > On Thu, Mar 25, 2010 at 03:24:29PM +0000, Catalin Marinas wrote:
> > > > > On Thu, 2010-03-25 at 15:10 +0000, Russell King - ARM Linux wrote:
> > > > > > While this looks fine, I'd like to see a lot of Tested-by's against
> > > > > > this before it's merged - we've had similar code in show_mem()
> > > > > > which has proven to be quite problematical to get right for all the
> > > > > > various different combinations we have.
> > > > > >
> > > > > > However, we also have the same method in show_mem() which we know
> > > > > > works fine, so I'd also like to see the problem with using it in
> > > > > > mem_init() fully analysed - rather than a "possibly because".
> > > > >
> > > > > I can remove the "possibly" part :). The page_count() is given a page
> > > > > with some random flags and it thinks it's a compound page. It than
> > > > > tries to access page->first which isn't set, hence the error.
> > > > >
> > > > > The original code assumes that for a given node the map is contiguous
> > > > > and it calculates the page as (map + pfn). This is only true for
> > > > > flatmem. With sparsemem the page calculation is a bit more complicated
> > > > > but handled by pfn_to_page().
> > > >
> > > > And show_mem() ?  It seems to suffer from the same problem.
> > >
> > > And that's a patch which fixes both (but as you said, it would be good
> > > if more people test it on various platforms).
> > >
> > >
> > > ARM: Fix kernel memory printing for sparsemem
> > >
> > > From: Catalin Marinas <catalin.marinas@arm.com>
> > >
> > > The show_mem() and mem_init() function are assuming that the page map is
> > > contiguous and calculates the start and end page of a bank using (map +
> > > pfn). This fails with SPARSEMEM where pfn_to_page() must be used.
> > >
> > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <Will.Deacon@arm.com>
> > > Cc: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
> >
> > Works perfectly on my machine. I have a PXA270 based device where I have to use
> > sparsemem. Thanks, you can add my:
> >
> > Tested-by: Marek Vasut <marek.vasut@gmail.com>
> >
> > Russell, the patch looks fine, please apply, the stuff is really broken.
> 
> It's great to see patches getting tested by others ;)
> 
> Catalin - mind submitting this with Marek's tested-by please?

Done (patch 6093/1).

-- 
Catalin
