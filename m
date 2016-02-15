From: gerald.schaefer@de.ibm.com (Gerald Schaefer)
Date: Mon, 15 Feb 2016 17:41:19 +0100
Subject: [BUG] random kernel crashes after THP rework on s390 (maybe
 also on PowerPC and ARM)
In-Reply-To: <20160212231510.GB15142@node.shutemov.name>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name>
 <56BE00E7.1010303@de.ibm.com> <20160212181640.4eabb85f@thinkpad>
 <20160212231510.GB15142@node.shutemov.name>
Message-ID: <20160215174119.53b56b86@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 13 Feb 2016 01:15:10 +0200
"Kirill A. Shutemov" <kirill@shutemov.name> wrote:

> 
> I'm trying to wrap my head around the issue and I don't think missing
> serialization with gup_fast is the cause -- we just don't need it
> anymore.
> 
> Previously, __split_huge_page_splitting() required serialization against
> gup_fast to make sure nobody can obtain new reference to the page after
> __split_huge_page_splitting() returns. This was a way to stabilize page
> references before starting to distribute them from head page to tail
> pages.
> 
> With new refcounting, we don't care about this. Splitting PMD is now
> decoupled from splitting underlying compound page. It's okay to get new
> pins after split_huge_pmd(). To stabilize page references during
> split_huge_page() we rely on setting up migration entries once all
> pmds are split into page table entries.
> 
> The theory that serialization against gup_fast is not a root cause of the
> crashes is consistent no crashes on arm64. Problem is somewhere else.

Hmm, ok, I just relied on the commit message of commit fecffad25458, which
talks about "pmdp_clear_flush() will do IPI as needed for fast_gup", as well
as the comments in mm/gup.c, which also still talk about IPIs and THP
splitting.

If IPI serialization with fast_gup is not needed anymore for THP splitting,
please fix at least the comments in mm/gup.c.

> 
> > > (It also does some some other magic to the attach_count, which might hold off
> > > finish_arch_post_lock_switch while some flushing is happening, but this should
> > > be unrelated here)
> > > 
> > > 
> > > > I'm also confused by pmd_none() is equal to !pmd_present() on s390. Hm?
> > > 
> > > Don't know, Gerald or Martin?
> > 
> > The implementation frequently changes depending on how many new bits Martin
> > needs to squeeze out :-)
> 
> One bit was freed up by the commit you've pointed to as a cause.
> I wounder If it's possible that screw up something while removing it? I
> don't see it, but who knows.
> 
> Could you check if revert of fecffad25458 helps?

I tried reverting fecffad25458, plus re-adding a call to pmdp_splitting_flush()
in __split_huge_pmd_locked(), and I could still reproduce the crashes, so I
guess it really isn't related to fast_gup vs. THP splitting.

> 
> And could you share how crashes looks like? I haven't seen backtraces yet.
> 
> > We don't have a _PAGE_PRESENT bit for pmds, so pmd_present() just checks if the
> > entry is not empty. pmd_none() of course does the opposite, it checks if it is
> > empty.
> 
