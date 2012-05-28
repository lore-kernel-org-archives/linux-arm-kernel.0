From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 28 May 2012 09:59:09 +0200
Subject: [RFC/PATCH 1/1] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20120528062057.GA10380@mbp>
References: <1338160318-20712-1-git-send-email-gmbnomis@gmail.com>
 <1338160318-20712-2-git-send-email-gmbnomis@gmail.com>
 <20120528043241.GA2803@mbp.cambridge.arm.com>
 <20120528053559.GA25047@schnuecks.de> <20120528062057.GA10380@mbp>
Message-ID: <20120528075908.GA28286@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Mon, May 28, 2012 at 02:21:00PM +0800, Catalin Marinas wrote:
> On Mon, May 28, 2012 at 06:35:59AM +0100, Simon Baatz wrote:
> > On Mon, May 28, 2012 at 12:32:44PM +0800, Catalin Marinas wrote:
> > > On Mon, May 28, 2012 at 12:11:58AM +0100, Simon Baatz wrote:
> > > ...
> > > > +void __flush_kernel_dcache_page(struct page *page)
> > > > +{
> > > > +	struct address_space *mapping;
> > > > +
> > > > +	mapping = page_mapping(page);
> > > > +
> > > > +	if (!mapping || mapping_mapped(mapping))
> > > > +		__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
> > > > +}
> > > > +EXPORT_SYMBOL(__flush_kernel_dcache_page);
> > > 
> > > I wonder whether the above condition isn't always true after
> > > get_user_pages().
> > 
> > Not sure about corner cases, but I would assume that yes, this is the
> > case.  However, the block layer sees the pages from get_user_pages()
> > directly only in the O_DIRECT case.  Usually (read fault for page
> > cache), flush_kernel_dcache_page() gets pages with mapping != NULL
> > and mapping_mapped() == NULL (i.e. no user space mapping (yet)).
> 
> And we can probably assume that this is only for new pages with the
> PG_dcache_clean bit already cleared (i.e. no need to set it again in
> flush_kernel_dcache_page for the lazy case).

At least this is what the implementation assumed before and what the
proposed change continues to assume.  Since this assumption has been
in mainline since beginning of 2011 or so and since it applies to the
likely case, I think that the assumption should be safe.

- Simon
