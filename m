From: toshi.kani@hpe.com (Kani, Toshi)
Date: Tue, 29 May 2018 16:10:24 +0000
Subject: [PATCH v3 3/3] x86/mm: add TLB purge to free pmd/pte page
 interfaces
In-Reply-To: <20180529144438.GM18595@8bytes.org>
References: <20180516233207.1580-1-toshi.kani@hpe.com>
 <20180516233207.1580-4-toshi.kani@hpe.com>
 <20180529144438.GM18595@8bytes.org>
Message-ID: <1527610139.14039.58.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-05-29 at 16:44 +0200, Joerg Roedel wrote:
> On Wed, May 16, 2018 at 05:32:07PM -0600, Toshi Kani wrote:
> >  	pmd = (pmd_t *)pud_page_vaddr(*pud);
> > +	pmd_sv = (pmd_t *)__get_free_page(GFP_KERNEL);
> > +	if (!pmd_sv)
> > +		return 0;
> 
> So your code still needs to allocate a full page where a simple
> list_head on the stack would do the same job.

Can you explain why you think allocating a page here is a major problem?
 
As I explained before, pud_free_pmd_page() covers an extremely rare case
 which I could not even hit with a huge number of ioremap() calls until
I instrumented alloc_vmap_area() to force this case to happen.  I do not
think pages should be listed for such a rare case.

> Ingo, Thomas, can you please just revert the original broken patch for
> now until there is proper fix?

If we just revert, please apply patch 1/3 first.  This patch address the
BUG_ON issue on PAE.  This is a real issue that needs a fix ASAP.

The page-directory cache issue on x64, which is addressed by patch 3/3,
is a theoretical issue that I could not hit by putting ioremap() calls
into a loop for a whole day.  Nobody hit this issue, either.

The simple revert patch Joerg posted a while ago causes
pmd_free_pte_page() to fail on x64.  This causes multiple pmd mappings
to fall into pte mappings on my test systems.  This can be seen as a
degradation, and I am afraid that it is more harmful than good.

Thanks,
-Toshi
