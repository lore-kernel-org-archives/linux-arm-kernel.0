From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 3 Jun 2013 10:33:10 +0100
Subject: [PATCH V4] ARM: handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <CACVXFVMU+pHrtezStKRNzhhJWg7L1NTBQKwhwLe+-9Yh5JhgiA@mail.gmail.com>
References: <1368336956-6693-1-git-send-email-gmbnomis@gmail.com>
 <CACVXFVOo6HNXeZ95QqAXU64aAmXXrTVsHJ9TvgirWKOWmwnSfA@mail.gmail.com>
 <20130531185414.GA19061@schnuecks.de>
 <CACVXFVMU+pHrtezStKRNzhhJWg7L1NTBQKwhwLe+-9Yh5JhgiA@mail.gmail.com>
Message-ID: <20130603093309.GA32295@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 01, 2013 at 11:27:38AM +0100, Ming Lei wrote:
> On Sat, Jun 1, 2013 at 2:54 AM, Simon Baatz <gmbnomis@gmail.com> wrote:
> > On Fri, May 31, 2013 at 05:07:22PM +0800, Ming Lei wrote:
> >> On Sun, May 12, 2013 at 1:35 PM, Simon Baatz <gmbnomis@gmail.com> wrote:
> >> > +                       __flush_kernel_dcache_page(page);
> >>
> >> I am wondering if I-cache should be flushed here since the user mapping
> >> on the page may be executable and I/D coherency should be maintained.
> >
> > Me too. In fact, I wondered so much that I proposed it myself in a
> > previous version of the patch (see [1]) :-) However, this has never
> > been part of flush_kernel_dcache_page() and it is not clear whether
> > the flush for I/D-cache coherency is really needed here (or in
> > flush_dcache_page() for that matter) or whether it is sufficient to
> > do it when mapping the page into user space.
> 
> After reading cachetlb.txt again, looks your patch is correct, because
> this kernel API is called in the situations:
> 
>         It is assumed here that the user has no incoherent cached copies
>        (i.e. the original page was obtained from a mechanism like
> get_user_pages()).
> 
> So only flushing kernel mapping for the page is correct if callers of the API
> obey the rule.

I think we should stick with just the D-cache flushing here. We can
revisit when we see a clear scenario where I-cache maintenance is
needed.

Regarding the 'user has no incoherent cached copies', this would work on
ARMv5 but not on ARMv7 unless you unmap the page from user space
(because of speculative loads into both I and D caches). Since we only
target the D-cache, we just leave flush_kernel_dcache_page() as no-op on
ARMv7 (non-aliasing VIPT).

-- 
Catalin
