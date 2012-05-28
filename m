From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 28 May 2012 07:35:59 +0200
Subject: [RFC/PATCH 1/1] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20120528043241.GA2803@mbp.cambridge.arm.com>
References: <1338160318-20712-1-git-send-email-gmbnomis@gmail.com>
 <1338160318-20712-2-git-send-email-gmbnomis@gmail.com>
 <20120528043241.GA2803@mbp.cambridge.arm.com>
Message-ID: <20120528053559.GA25047@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Mon, May 28, 2012 at 12:32:44PM +0800, Catalin Marinas wrote:
> On Mon, May 28, 2012 at 12:11:58AM +0100, Simon Baatz wrote:
> ...
> > +void __flush_kernel_dcache_page(struct page *page)
> > +{
> > +	struct address_space *mapping;
> > +
> > +	mapping = page_mapping(page);
> > +
> > +	if (!mapping || mapping_mapped(mapping))
> > +		__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
> > +}
> > +EXPORT_SYMBOL(__flush_kernel_dcache_page);
> 
> I wonder whether the above condition isn't always true after
> get_user_pages().
> 

Not sure about corner cases, but I would assume that yes, this is the
case.  However, the block layer sees the pages from get_user_pages()
directly only in the O_DIRECT case.  Usually (read fault for page
cache), flush_kernel_dcache_page() gets pages with mapping != NULL
and mapping_mapped() == NULL (i.e. no user space mapping (yet)).

- Simon
