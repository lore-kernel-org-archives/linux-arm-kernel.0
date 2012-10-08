From: gmbnomis@gmail.com (Simon Baatz)
Date: Tue, 9 Oct 2012 01:07:34 +0200
Subject: [PATCH V3 2/2] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20121008202040.GC4625@n2100.arm.linux.org.uk>
References: <1349609352-6408-1-git-send-email-gmbnomis@gmail.com>
 <1349609352-6408-3-git-send-email-gmbnomis@gmail.com>
 <20121008174428.GB3204@arm.com>
 <20121008200216.GA14167@schnuecks.de>
 <20121008202040.GC4625@n2100.arm.linux.org.uk>
Message-ID: <20121008230733.GA17819@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Oct 08, 2012 at 09:20:40PM +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 08, 2012 at 10:02:16PM +0200, Simon Baatz wrote:
> > Hi Catalin,
> > 
> > On Mon, Oct 08, 2012 at 06:44:28PM +0100, Catalin Marinas wrote:
> > > On Sun, Oct 07, 2012 at 12:29:12PM +0100, Simon Baatz wrote:
> > > > Commit f8b63c1 made flush_kernel_dcache_page() a no-op assuming that
> > > > the pages it needs to handle are kernel mapped only.  However, for
> > > > example when doing direct I/O, pages with user space mappings may
> > > > occur.
> > > > 
> > > > Thus, do lazy flushing like in flush_dcache_page() if there are no user
> > > > space mappings.  Otherwise, flush the kernel cache lines directly.
> > > 
> > > Do you need to fix the VIPT non-aliasing case as well? Does
> > > flush_kernel_dcache_page() need to handle I-cache?
> > 
> > Good question. My previous version of the patch did not handle it,
> > but after our discussion on the arm64 case, I came to the conclusion
> > that we probably need to handle it.
> > 
> > flush_dcache_page() and flush_kernel_dcache_page() are both used when
> > a page was modified via its kernel mapping.  For example,
> > crypto/scatterwalk.c uses flush_dcache_page() whereas
> > lib/scatterlist.c uses flush_kernel_dcache_page().  
> 
> It's likely that this stuff is incredibly buggy - and where we suspect
> there's problems (like using the wrong flush_dcache_page() vs
> flush_kernel_dcache_page() call) that needs to be fixed.
> 
> I suspect crypto/scatterwalk.c was created long before
> flush_kernel_dcache_page() came into existence, and it probably needs
> to be fixed.
>
> > Thus, the reasoning is that if flush_dcache_page() needs to handle
> > I-cache in the case there is no hook later (already user-mapped page
> > cache page) then flush_kernel_dcache_page() needs to do the same. 
> 
> This sounds like we're heading in the direction that flush_kernel_dcache_page()
> and flush_dcache_page() end up being virtually identical.  This isn't
> supposed to be - they _are_ supposed to be different.  Again, maybe
> that's because the users have chosen the wrong function.
> ...

Yes, it is a mess and may be incredibly buggy. 

According to documentation flush_kernel_dcache_page() is supposed to
handle user pages.  It can assume that potential user mappings have
been flushed.  However, the documentation does not mention the case
of page cache pages with no user mappings explicitly.

flush_dcache_page() is supposed to deal with the user and kernel
mappings. However, the documentation does explicitly state that it is
not supposed to handle anon pages (but the arm implementation does
flush the kernel mapping).

Now, what should crypto/scatterwalk.c do? In the write to page path,
it can see page cache pages with and without user mappings and anon
pages.  If there are user mappings, it can assume that they have been
flushed.  I would argue it should use flush_kernel_dcache_page(). 
But if so, our current implementation does not handle two of these
three cases at all.

And the proposed flush_kernel_dcache_page() is different. It only
flushes the kernel mapping in the relevant cases whereas
flush_dcache_page() needs to care about user mappings as well. 
According to documentation we could remove the anon page case in
flush_dcache_page(), but uses like in crypto/scatterwalk.c currently
prevent that.

> > With respect to clearing the flag in the VIPT non-aliasing case with
> > anon pages: Declaring the pages dirty by default may already be
> > sufficient in this case, at least that is what the current
> > implementation assumes.
> 
> PG_arch_1 has no meaning what so ever for anon pages.  Don't even try
> to make it have meaning there, it will cause lots of pain if you do.
> The reason is that anon pages have no mapping, and so trying to do the
> PG_arch_1 trick will result in most places deciding "there is no
> userspace mapping we can skip that".

Hmm, now that you say it, it's quite obvious. There is the following
in __sync_icache_dcache():

        if (cache_is_vipt_aliasing())
                mapping = page_mapping(page);
        else
                mapping = NULL;

        if (!test_and_set_bit(PG_dcache_clean, &page->flags))
                __flush_dcache_page(mapping, page);

        if (pte_exec(pteval))
                __flush_icache_all();

At least this looks strange to me given that PG_dcache_clean has no
meaning for anon pages.  Is this correct?

- Simon
