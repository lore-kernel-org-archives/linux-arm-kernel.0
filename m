From: bsingharora@gmail.com (Balbir Singh)
Date: Fri, 15 Jul 2016 11:41:51 +1000
Subject: [PATCH v2 02/11] mm: Hardened usercopy
In-Reply-To: <1468544658.30053.26.camel@redhat.com>
References: <1468446964-22213-1-git-send-email-keescook@chromium.org>
 <1468446964-22213-3-git-send-email-keescook@chromium.org>
 <20160714232019.GA28254@350D>
 <1468544658.30053.26.camel@redhat.com>
Message-ID: <20160715014151.GA13944@balbir.ozlabs.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2016 at 09:04:18PM -0400, Rik van Riel wrote:
> On Fri, 2016-07-15 at 09:20 +1000, Balbir Singh wrote:
> 
> > > ==
> > > +		???((unsigned long)end & (unsigned
> > > long)PAGE_MASK)))
> > > +		return NULL;
> > > +
> > > +	/* Allow if start and end are inside the same compound
> > > page. */
> > > +	endpage = virt_to_head_page(end);
> > > +	if (likely(endpage == page))
> > > +		return NULL;
> > > +
> > > +	/* Allow special areas, device memory, and sometimes
> > > kernel data. */
> > > +	if (PageReserved(page) && PageReserved(endpage))
> > > +		return NULL;
> > 
> > If we came here, it's likely that endpage > page, do we need to check
> > that only the first and last pages are reserved? What about the ones
> > in
> > the middle?
> 
> I think this will be so rare, we can get away with just
> checking the beginning and the end.
>

But do we want to leave a hole where an aware user space
can try a longer copy_* to avoid this check? If it is unlikely
should we just bite the bullet and do the check for the entire
range?

Balbir Singh. 
