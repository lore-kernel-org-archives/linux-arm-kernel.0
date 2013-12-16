From: steve.capper@linaro.org (Steve Capper)
Date: Mon, 16 Dec 2013 15:07:41 +0000
Subject: [PATCH 1/2] arm: mm: fix dcache flush logic for compound high
 pages
In-Reply-To: <20131213163821.GL19177@mudshark.cambridge.arm.com>
References: <1386936391-30493-1-git-send-email-steve.capper@linaro.org>
 <1386936391-30493-2-git-send-email-steve.capper@linaro.org>
 <20131213163821.GL19177@mudshark.cambridge.arm.com>
Message-ID: <20131216150740.GA1721@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 04:38:21PM +0000, Will Deacon wrote:
> On Fri, Dec 13, 2013 at 12:06:30PM +0000, Steve Capper wrote:
> > When given a compound high page, __flush_dcache_page will only flush
> > the first page of the compound page repeatedly rather than the entire
> > set of constituent pages.
> > 
> > This patch corrects the logic such that all constituent pages are now
> > flushed.
> 
> Ha -- well spotted!
> 
/me looks around innocently
> > Signed-off-by: Steve Capper <steve.capper@linaro.org>
> > ---
> >  arch/arm/mm/flush.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> > index 6d5ba9a..4962302 100644
> > --- a/arch/arm/mm/flush.c
> > +++ b/arch/arm/mm/flush.c
> > @@ -173,18 +173,19 @@ void __flush_dcache_page(struct address_space *mapping, struct page *page)
> >  		__cpuc_flush_dcache_area(page_address(page), page_size);
> >  	} else {
> >  		unsigned long i;
> > +		struct page *cpage = page;
> >  		if (cache_is_vipt_nonaliasing()) {
> > -			for (i = 0; i < (1 << compound_order(page)); i++) {
> > -				void *addr = kmap_atomic(page);
> > +			for (i = 0; i < (1 << compound_order(page)); cpage++, i++) {
> > +				void *addr = kmap_atomic(cpage);
> 
> Any reason not to use page + i?
> 

Thanks, that does look better with a page + i. I have sent a V2 patch
that includes this change:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/219571.html

If this looks okay should it go in the patch system? And I can add a
stable tag too?

Cheers,
-- 
Steve

> Will
