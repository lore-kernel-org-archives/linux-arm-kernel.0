From: toshi.kani@hpe.com (Kani, Toshi)
Date: Fri, 27 Apr 2018 14:31:51 +0000
Subject: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
In-Reply-To: <20180427073719.GT15462@8bytes.org>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
 <20180314180155.19492-3-toshi.kani@hpe.com>
 <20180426141926.GN15462@8bytes.org> <1524759629.2693.465.camel@hpe.com>
 <20180426172327.GQ15462@8bytes.org> <1524764948.2693.478.camel@hpe.com>
 <20180426200737.GS15462@8bytes.org> <1524781764.2693.503.camel@hpe.com>
 <20180427073719.GT15462@8bytes.org>
Message-ID: <1524839460.2693.531.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-04-27 at 09:37 +0200, joro at 8bytes.org wrote:
> On Thu, Apr 26, 2018 at 10:30:14PM +0000, Kani, Toshi wrote:
> > Thanks for the clarification. After reading through SDM one more time, I
> > agree that we need a TLB purge here. Here is my current understanding. 
> > 
> >  - INVLPG purges both TLB and paging-structure caches. So, PMD cache was
> > purged once.
> >  - However, processor may cache this PMD entry later in speculation
> > since it has p-bit set. (This is where my misunderstanding was.
> > Speculation is not allowed to access a target address, but it may still
> > cache this PMD entry.)
> >  - A single INVLPG on each processor purges this PMD cache. It does not
> > need a range purge (which was already done).
> > 
> > Does it sound right to you?
> 
> The right fix is to first synchronize the changes when the PMD/PUD is
> cleared and then flush the TLB system-wide. After that is done you can
> free the page.

Agreed. This can be done on top of this patch.

> But doing all that in the pud/pmd_free_pmd/pte_page() functions is too
> expensive, as the TLB flush requires to send IPIs to all cores in the
> system, and that every time the function is called.
>
> So what needs to be done is to fix this from high-level ioremap code to
> first unmap all required PTE/PMD pages and collect them in a list. When
> that is done you can synchronize the changes with the other page-tables
> in the system and do one system-wide TLB flush. When that is complete
> you can free the pages on the list that were collected while unmapping.
>
> Then the new mappings can be established and again synchronized with the
> other page-tables in the system.

Yes, and this patch was designed to work in such way.  Please note that
this patch added pud_free_pmd_page() and pmd_free_pte_page() to the
ioremap() path when and only when it creates a pud or pmd map.  This
assures the following preconditions are met without overhead.
 - All pte entries for a target pud/pmd address range have been cleared.
 - System-wide TLB purges have been done for a target pud/pmd address
range.

So, we can add the step 2 on top of this patch.
 1. Clear pud/pmd entry.
 2. System wide TLB flush <-- TO BE ADDED BY NEW PATCH
 3. Free its underlining pmd/pte page.

> > As for the BUG_ON issue, are you able to reproduce this issue?  If so,
> > would you be able to test the fix?
> 
> Yes, I can reproduce the BUG_ON with my PTI patches and a fedora-i386
> VM.

Great!

> I already ran into the issue before your patches were merged upstream,
> but my "fix" is different because it just prevents huge-mappings when
> there were smaller mappings before. See
> 
> 	e3e288121408 x86/pgtable: Don't set huge PUD/PMD on non-leaf entries
> 
> for details. This patch does not fix the base-problem, but hides it
> again, as the real fix needs some more work across architectures.

Right.  Patch 1/2 of this series made the same fix as well.  See:

b6bdb7517c3d  mm/vmalloc: add interfaces to free unmapped page table

> Your patch actually makes the problem worse, without it the PTE/PMD pages
> were just leaked, so that they could not be reused. But with your patch
> the pages can be used again and the page-walker might establish TLB
> entries based on random content the new owner writes to it. This can
> lead to all kinds of random and very hard to debug data corruption
> issues.
> 
> So until we make the generic ioremap code in lib/ioremap.c smarter about
> unmapping/remapping ranges the best solution is making my fix work again
> by reverting your patch.

We do not need to revert this patch.  We can make the above change I
mentioned.

Thanks,
-Toshi
