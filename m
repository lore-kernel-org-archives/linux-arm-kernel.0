From: toshi.kani@hpe.com (Kani, Toshi)
Date: Wed, 30 May 2018 15:39:20 +0000
Subject: [PATCH v3 3/3] x86/mm: add TLB purge to free pmd/pte page
 interfaces
In-Reply-To: <20180530045927.GP18595@8bytes.org>
References: <20180516233207.1580-1-toshi.kani@hpe.com>
 <20180516233207.1580-4-toshi.kani@hpe.com>
 <20180529144438.GM18595@8bytes.org> <1527610139.14039.58.camel@hpe.com>
 <20180530045927.GP18595@8bytes.org>
Message-ID: <1527694673.14039.106.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-05-30 at 06:59 +0200, joro at 8bytes.org wrote:
> On Tue, May 29, 2018 at 04:10:24PM +0000, Kani, Toshi wrote:
> > Can you explain why you think allocating a page here is a major problem?
> 
> Because a larger allocation is more likely to fail. And if you fail the
> allocation, you also fail to free more pages, which _is_ a problem. So
> better avoid any allocations in code paths that are about freeing
> memory.

It only allocates a single page.  If it fails to allocate a single page,
this pud mapping request simply falls to pmd mappings, which is only as
bad as your suggested plain revert always does for both pud and pmd
mappings.  Also, this func is called from ioremap() when a driver
initializes its mapping.  If the system does not have a single page to
allocate, the driver has a much bigger issue to deal with than its
request falling back to pmd mappings.  Please also note that this func
is not called from free-memory path.

> > If we just revert, please apply patch 1/3 first.  This patch address the
> > BUG_ON issue on PAE.  This is a real issue that needs a fix ASAP.
> 
> It does not address the problem of dirty page-walk caches on x86-64.

This patch 3/3 fixes it.  Hope my explanation above clarified.

> > The page-directory cache issue on x64, which is addressed by patch 3/3,
> > is a theoretical issue that I could not hit by putting ioremap() calls
> > into a loop for a whole day.  Nobody hit this issue, either.
> 
> How do you know you didn't hit that issue? It might cause silent data
> corruption, which might not be easily detected.

If the test hit that issue, it would have caused a kernel page fault
(freed & cleared pte page still unmapped, or this page reused and
attribute data invalid) or MCE (pte page reused and phys addr invalid)
when it accessed to ioremap'd address.

Causing silent data corruption requires that this freed & cleared pte
page to be reused and re-initialized with a valid pte entry data.  While
this case is possible, the chance of my test only hitting this case
without ever hitting much more likely cases of page fault or MCE is
basically zero.

> > The simple revert patch Joerg posted a while ago causes
> > pmd_free_pte_page() to fail on x64.  This causes multiple pmd mappings
> > to fall into pte mappings on my test systems.  This can be seen as a
> > degradation, and I am afraid that it is more harmful than good.
> 
> The plain revert just removes all the issues with the dirty TLB that the
> original patch introduced and prevents huge mappings from being
> established when there have been smaller mappings before. This is not
> ideal, but at least its is consistent and does not leak pages and leaves
> no dirty TLBs. So this is the easiest and most reliable fix for this
> stage in the release process.

If you think the page directory issue needs a fix ASAP, I believe taking
patch 3/3 is much better option than the plain revert, which will
introduce the fall-back issue I explained.

Thanks,
-Toshi
