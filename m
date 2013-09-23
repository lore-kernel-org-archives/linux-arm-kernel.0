From: steve.capper@linaro.org (Steve Capper)
Date: Mon, 23 Sep 2013 14:19:24 +0100
Subject: [RFC V2] ARM: mm: make UACCESS_WITH_MEMCPY huge page aware
In-Reply-To: <1379410429-3372-1-git-send-email-steve.capper@linaro.org>
References: <1379410429-3372-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20130923131923.GA7233@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 10:33:49AM +0100, Steve Capper wrote:
> The memory pinning code in uaccess_with_memcpy.c does not check
> for HugeTLB or THP pmds, and will enter an infinite loop should
> a __copy_to_user or __clear_user occur against a huge page.
> 
> This patch adds detection code for huge pages to pin_page_for_write.
> As this code can be executed in a fast path it refers to the actual
> pmds rather than the vma. If a HugeTLB or THP is found (they have
> the same pmd representation on ARM), the page table spinlock is
> taken to prevent modification whilst the page is pinned.
> 
> On ARM, huge pages are only represented as pmds, thus no huge pud
> checks are performed. (For huge puds one would lock the page table
> in a similar manner as in the pmd case).
> 
> Two helper functions are introduced; pmd_thp_or_huge will check
> whether or not a page is huge or transparent huge (which have the
> same pmd layout on ARM), and pmd_hugewillfault will detect whether
> or not a page fault will occur on write to the page.
> 
> Changes since first RFC:
>    * The page mask is widened for hugepages to reduce the number
>      of potential locks/unlocks.
>      (A knobbled /dev/zero with its latency reduction chunks
>       removed shows a 2x data rate boost with hugepages backing:
>       dd if=/dev/zero of=/dev/null bs=10M count=1024 )
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> ---

A ping to see if anyone had any questions/comments/flames :-)?

Should it go into the patch system?

Thanks,
-- 
Steve 
