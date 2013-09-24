From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 24 Sep 2013 09:40:53 +0100
Subject: [RESEND RFC V2] ARM: mm: make UACCESS_WITH_MEMCPY huge page aware
In-Reply-To: <alpine.LFD.2.03.1309231143110.312@syhkavp.arg>
References: <1379945742-9457-1-git-send-email-steve.capper@linaro.org>
 <alpine.LFD.2.03.1309231143110.312@syhkavp.arg>
Message-ID: <20130924084052.GA6973@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 12:26:32PM -0400, Nicolas Pitre wrote:
> On Mon, 23 Sep 2013, Steve Capper wrote:
> 
> > Resending, as I ommitted a few important CC's.
> > 
> > ---
> > 
> > The memory pinning code in uaccess_with_memcpy.c does not check
> > for HugeTLB or THP pmds, and will enter an infinite loop should
> > a __copy_to_user or __clear_user occur against a huge page.
> > 
> > This patch adds detection code for huge pages to pin_page_for_write.
> > As this code can be executed in a fast path it refers to the actual
> > pmds rather than the vma. If a HugeTLB or THP is found (they have
> > the same pmd representation on ARM), the page table spinlock is
> > taken to prevent modification whilst the page is pinned.
> > 
> > On ARM, huge pages are only represented as pmds, thus no huge pud
> > checks are performed. (For huge puds one would lock the page table
> > in a similar manner as in the pmd case).
> > 
> > Two helper functions are introduced; pmd_thp_or_huge will check
> > whether or not a page is huge or transparent huge (which have the
> > same pmd layout on ARM), and pmd_hugewillfault will detect whether
> > or not a page fault will occur on write to the page.
> > 
> > Changes since first RFC:
> >    * The page mask is widened for hugepages to reduce the number
> >      of potential locks/unlocks.
> >      (A knobbled /dev/zero with its latency reduction chunks
> >       removed shows a 2x data rate boost with hugepages backing:
> >       dd if=/dev/zero of=/dev/null bs=10M count=1024 )
> 
> Are you saying that the 2x boost is due to this page mask widening?
> 
> A non negligeable drawback with this large mask is the fact that you're 
> holding a spinlock for a much longer period.
> 
> What kind of performance do you get by leaving the lock period to a 
> small page boundary?
> 
> 

Hi Nicolas,
Here are the performance numbers I get on a dev board:
$ dd if=/dev/zero of=/dev/null bs=10M count=1024
1024+0 records in
1024+0 records out
10737418240 bytes (11 GB) copied, 4.74566 s, 2.3 GB/s

With page_mask==PAGE_MASK:
$ hugectl --heap dd if=/dev/zero of=/dev/null bs=10M count=1024
1024+0 records in
1024+0 records out
10737418240 bytes (11 GB) copied, 3.64141 s, 2.9 GB/s

With page_mask==HPAGE_MASK for huge pages:
$ hugectl --heap dd if=/dev/zero of=/dev/null bs=10M count=1024
1024+0 records in
1024+0 records out
10737418240 bytes (11 GB) copied, 2.11376 s, 5.1 GB/s

So with a standard page mask we still get a modest performance boost to
this microbenchmark when the memory is backed by huge pages.

I've been thinking about the potential latency costs of locking the
process address space for a prolonged period of time and this has got
me spooked. So I am going to post this as a patch without the variable
page_mask. Thanks for your comment on this :-).

There is some work being carried out on split huge page table locks,
that may make HPAGE_MASK practical some day (we would need to be running
split page table locks too), but I think it's better to stick with
PAGE_MASK for now.

Cheers,
--
Steve
