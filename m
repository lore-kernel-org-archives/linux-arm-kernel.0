From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Sep 2009 19:33:11 +0100
Subject: ARM highmem stuff - 5687/1
In-Reply-To: <alpine.LFD.2.00.0909021009010.6044@xanadu.home>
References: <20090902135355.GB12595@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0909021009010.6044@xanadu.home>
Message-ID: <20090904183311.GA10316@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2009 at 11:52:33AM -0400, Nicolas Pitre wrote:
> On Wed, 2 Sep 2009, Russell King - ARM Linux wrote:
> 
> > Do we need a similar fix for flush_anon_page()?
> 
> Hmmmm... Maybe.  Especially since the only usage of flush_anon_page() is 
> in __get_user_pages() where the page passed to flush_anon_page() may or 
> may not be kmapped (it is not explicitly kmapped in that function, but 
> non atomic kmaps are lazily unmapped and would still require to be 
> flushed if their mapping is still there).  However, in 
> __get_user_pages(), there is a flush_dcache_page() right after the call 
> to flush_anon_page(), so the __cpuc_flush_dcache_page() in 
> __flush_anon_page() appears redundant to me and could simply be removed 
> entirely.

I'm not sure this is right.  It looks to me as if it is possible for
a page have both a mapping _and_ be an anonymous page - which can happen
if the page is an anonymous page which has been placed into the swapcache.

In this case, flush_dcache_page() may just set the PG_dcache_dirty bit
without flushing anything.

I do know that flush_anon_page() was required to stabilise the list server.
With the list server now effectively redundant, I've no way to test this
stuff, so I'm going to leave the duplicate flushing in place and won't
apply your patch.
