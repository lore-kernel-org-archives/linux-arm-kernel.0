From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 8 Oct 2012 22:02:16 +0200
Subject: [PATCH V3 2/2] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20121008174428.GB3204@arm.com>
References: <1349609352-6408-1-git-send-email-gmbnomis@gmail.com>
 <1349609352-6408-3-git-send-email-gmbnomis@gmail.com>
 <20121008174428.GB3204@arm.com>
Message-ID: <20121008200216.GA14167@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Mon, Oct 08, 2012 at 06:44:28PM +0100, Catalin Marinas wrote:
> On Sun, Oct 07, 2012 at 12:29:12PM +0100, Simon Baatz wrote:
> > Commit f8b63c1 made flush_kernel_dcache_page() a no-op assuming that
> > the pages it needs to handle are kernel mapped only.  However, for
> > example when doing direct I/O, pages with user space mappings may
> > occur.
> > 
> > Thus, do lazy flushing like in flush_dcache_page() if there are no user
> > space mappings.  Otherwise, flush the kernel cache lines directly.
> 
> Do you need to fix the VIPT non-aliasing case as well? Does
> flush_kernel_dcache_page() need to handle I-cache?

Good question. My previous version of the patch did not handle it,
but after our discussion on the arm64 case, I came to the conclusion
that we probably need to handle it.

flush_dcache_page() and flush_kernel_dcache_page() are both used when
a page was modified via its kernel mapping.  For example,
crypto/scatterwalk.c uses flush_dcache_page() whereas
lib/scatterlist.c uses flush_kernel_dcache_page().  

Thus, the reasoning is that if flush_dcache_page() needs to handle
I-cache in the case there is no hook later (already user-mapped page
cache page) then flush_kernel_dcache_page() needs to do the same. 

With respect to clearing the flag in the VIPT non-aliasing case with
anon pages: Declaring the pages dirty by default may already be
sufficient in this case, at least that is what the current
implementation assumes.  On the other hand, if we clear the
PG_dcache_clean flag in a function that is not even supposed to
handle anon pages, then why shouldn't we do it in a function that is? 
I wanted to play safe here and apply the same logic in both
functions.


- Simon

 
