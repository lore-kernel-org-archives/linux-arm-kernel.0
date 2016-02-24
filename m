From: schwidefsky@de.ibm.com (Martin Schwidefsky)
Date: Wed, 24 Feb 2016 09:22:08 +0100
Subject: [BUG] random kernel crashes after THP rework on s390 (maybe
 also on PowerPC and ARM)
In-Reply-To: <20160223191907.25719a4d@thinkpad>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name>
 <56BE00E7.1010303@de.ibm.com> <20160212181640.4eabb85f@thinkpad>
 <20160223103221.GA1418@node.shutemov.name>
 <20160223191907.25719a4d@thinkpad>
Message-ID: <20160224092208.49e013ff@mschwide>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Feb 2016 19:19:07 +0100
Gerald Schaefer <gerald.schaefer@de.ibm.com> wrote:

> On Tue, 23 Feb 2016 13:32:21 +0300
> "Kirill A. Shutemov" <kirill@shutemov.name> wrote:
> 
> > On Fri, Feb 12, 2016 at 06:16:40PM +0100, Gerald Schaefer wrote:
> > > On Fri, 12 Feb 2016 16:57:27 +0100
> > > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> > > 
> > > > > I'm also confused by pmd_none() is equal to !pmd_present() on s390. Hm?
> > > > 
> > > > Don't know, Gerald or Martin?
> > > 
> > > The implementation frequently changes depending on how many new bits Martin
> > > needs to squeeze out :-)
> > > We don't have a _PAGE_PRESENT bit for pmds, so pmd_present() just checks if the
> > > entry is not empty. pmd_none() of course does the opposite, it checks if it is
> > > empty.
> > 
> > I still worry about pmd_present(). It looks wrong to me. I wounder if
> > patch below makes a difference.
> > 
> > The theory is that the splitting bit effetely masked bogus pmd_present():
> > we had pmd_trans_splitting() in all code path and that prevented mm from
> > touching the pmd. Once pmd_trans_splitting() has gone, mm proceed with the
> > pmd where it shouldn't and here's a boom.
> 
> Well, I don't think pmd_present() == true is bogus for a trans_huge pmd under
> splitting, after all there is a page behind the the pmd. Also, if it was
> bogus, and it would need to be false, why should it be marked !pmd_present()
> only at the pmdp_invalidate() step before the pmd_populate()? It clearly
> is pmd_present() before that, on all architectures, and if there was any
> problem/race with that, setting it to !pmd_present() at this stage would
> only (marginally) reduce the race window.
> 
> BTW, PowerPC and Sparc seem to do the same thing in pmdp_invalidate(),
> i.e. they do not set pmd_present() == false, only mark it so that it would
> not generate a new TLB entry, just like on s390. After all, the function
> is called pmdp_invalidate(), and I think the comment in mm/huge_memory.c
> before that call is just a little ambiguous in its wording. When it says
> "mark the pmd notpresent" it probably means "mark it so that it will not
> generate a new TLB entry", which is also what the comment is really about:
> prevent huge and small entries in the TLB for the same page at the same
> time.

If I am not mistaken this is true for x86 as well. The generic implementation
for pmdp_invalidate sets a new pmd that has been modified with
pmd_mknotpresent. For x86 this function removes the _PAGE_PRESENT and
_PAGE_PROTNONE bits from the entry. The _PAGE_PSE bit stays set and that
makes pmd_present return true.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
