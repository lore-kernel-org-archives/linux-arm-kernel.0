From: toshi.kani@hpe.com (Kani, Toshi)
Date: Mon, 25 Jun 2018 21:15:03 +0000
Subject: [PATCH v3 0/3] fix free pmd/pte page handlings on x86
In-Reply-To: <20180625175225.GQ28965@dhcp22.suse.cz>
References: <20180516233207.1580-1-toshi.kani@hpe.com>
 <alpine.DEB.2.21.1806241516410.8650@nanos.tec.linutronix.de>
 <1529938470.14039.134.camel@hpe.com>
 <20180625175225.GQ28965@dhcp22.suse.cz>
Message-ID: <1529961187.14039.206.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-06-25 at 19:53 +0200, Michal Hocko wrote:
> On Mon 25-06-18 14:56:26, Kani Toshimitsu wrote:
> > On Sun, 2018-06-24 at 15:19 +0200, Thomas Gleixner wrote:
> > > On Wed, 16 May 2018, Toshi Kani wrote:
> > > 
> > > > This series fixes two issues in the x86 ioremap free page handlings
> > > > for pud/pmd mappings.
> > > > 
> > > > Patch 01 fixes BUG_ON on x86-PAE reported by Joerg.  It disables
> > > > the free page handling on x86-PAE.
> > > > 
> > > > Patch 02-03 fixes a possible issue with speculation which can cause
> > > > stale page-directory cache.
> > > >  - Patch 02 is from Chintan's v9 01/04 patch [1], which adds a new arg
> > > >    'addr', with my merge change to patch 01.
> > > >  - Patch 03 adds a TLB purge (INVLPG) to purge page-structure caches
> > > >    that may be cached by speculation.  See the patch descriptions for
> > > >    more detal.
> > > 
> > > Toshi, Joerg, Michal!
> > 
> > Hi Thomas,
> > 
> > Thanks for checking. I was about to ping as well.
> > 
> > > I'm failing to find a conclusion of this discussion. Can we finally make
> > > some progress with that?
> > 
> > I have not heard from Joerg since I last replied to his comments to
> > Patch 3/3 -- I did my best to explain that there was no issue in the
> > single page allocation in pud_free_pmd_page().  From my perspective, the
> >  v3 series is good to go.
> 
> Well, I admit that this not my area but I agree with Joerg that
> allocating memory inside afunction that is supposed to free page table
> is far from ideal. More so that the allocation is hardcoded GFP_KERNEL.
> We already have this antipattern in functions to allocate page tables
> and it has turned to be maintenance PITA longterm. So if there is a way
> around that then I would strongly suggest finding a different solution.
> 
> Whether that is sufficient to ditch the whole series is not my call
> though.

I'd agree if this code is in a memory free path.  However, this code is
in the ioremap() path, which is expected to allocate new page(s).

For example, setting a fresh PUD map allocates a new page to setup page
tables as follows:

  ioremap_pud_range()
    pud_alloc()
      __pud_alloc()
        pud_alloc_one()
          get_zeroed_page() with GFP_KERNEL
            __get_free_pages() with GFP_KERNEL | __GFP_ZERO

In a rare case, a PUD map is set to a previously-used-for-PMD range,
which leads to call pud_free_pmd_page() to free up the page consisting
of cleared PMD entries.  To manage this procedure, pud_free_pmd_page()
temporary allocates a page to save the cleared PMD entries as follows:

  ioremap_pud_range()
    pud_free_pmd_page()
      __get_free_page() with GFP_KERNEL

These details are all internal to the ioremap() callers, who should
always expect that ioremap() allocates pages for setting page tables.

As for possible performance implications associated with this page
allocation, pmd_free_pte_page() and pud_free_pmd_page() are very
different in terms of how likely they can be called.

pmd_free_pte_page(), which does not allocate a page, gets called
multiple times during normal boot on my test systems.  My ioremap tests
cause this function be called quite frequently.  This is because 4KB and
2MB vaddr allocation comes from similar vmalloc ranges. 

pud_free_pmd_page(), which allocates a page, seems to be never called
under normal circumstances, at least I was not able to with my ioremap
tests.  I found that 1GB vaddr allocation does not share with 4KB/2MB
ranges.  I had to hack the allocation code to force them shared to test
this function.  Hence, this memory allocation does not have any
implications in performance.

Lastly, for the code maintenance, I believe this memory allocation keeps
the code much simpler than it would otherwise need to manage a special
page list.

Thanks,
-Toshi
