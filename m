From: mgorman@techsingularity.net (Mel Gorman)
Date: Mon, 19 Oct 2015 14:26:49 +0100
Subject: [PATCH 2/2] arm64: Use gfpflags_allow_blocking()
In-Reply-To: <5624E561.6010107@arm.com>
References: <ecbbf6550654071f13d1bdc04b86dc4d69ad09b4.1445008695.git.robin.murphy@arm.com>
 <adf855c7692b1512ab7216579468ad1eef2f25a8.1445008695.git.robin.murphy@arm.com>
 <20151016135900.bc1e10115a866a301dbb0cd8@linux-foundation.org>
 <5624E561.6010107@arm.com>
Message-ID: <20151019132649.GA2629@techsingularity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 01:43:13PM +0100, Robin Murphy wrote:
> Hi Andrew,
> 
> On 16/10/15 21:59, Andrew Morton wrote:
> >On Fri, 16 Oct 2015 16:33:42 +0100 Robin Murphy <robin.murphy@arm.com> wrote:
> >
> >>__GFP_WAIT is going away to live its life under a new identity; convert
> >>__iommu_alloc_attrs() to the new helper function instead.
> >>
> >>...
> >>
> >>--- a/arch/arm64/mm/dma-mapping.c
> >>+++ b/arch/arm64/mm/dma-mapping.c
> >>@@ -566,7 +566,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
> >>  	 */
> >>  	gfp |= __GFP_ZERO;
> >>
> >>-	if (gfp & __GFP_WAIT) {
> >>+	if (gfpflags_allow_blocking(gfp)) {
> >>  		struct page **pages;
> >>  		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
> >
> >Seems unnecessarily elaborate.  What's wrong with
> >
> >--- a/arch/arm64/mm/dma-mapping.c~mm-page_alloc-rename-__gfp_wait-to-__gfp_reclaim-arm-fix
> >+++ a/arch/arm64/mm/dma-mapping.c
> >@@ -562,7 +562,7 @@ static void *__iommu_alloc_attrs(struct
> >  	 */
> >  	gfp |= __GFP_ZERO;
> >
> >-	if (gfp & __GFP_WAIT) {
> >+	if (gfp & __GFP_RECLAIM) {
> >  		struct page **pages;
> >  		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
> >
> >
> >?
> 
> Well, in that case the charge of "unnecessarily elaborate" should have been
> directed at the original patch, and the 53 other locations where (flags &
> __GFP_WAIT) was changed as per the commit message:
> 
>   "Callers that are checking if they are non-blocking should use the
>    helper gfpflags_allow_blocking() where possible."
> 

The use of gfpflags_allows_blocking() like you originally had is actually
preferred by me. __GFP_RECLAIM can return true when the caller only allows
kswapd to wake which has nothing to do with blocking (currently). The
helper was added to avoid this type of confusion.

-- 
Mel Gorman
SUSE Labs
