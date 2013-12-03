From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 3 Dec 2013 13:46:24 +0000
Subject: [PATCH 0/3] Simplify set_huge_pte_at, pte_same for LPAE
In-Reply-To: <1384882529-28104-1-git-send-email-steve.capper@linaro.org>
References: <1384882529-28104-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20131203134623.GA24994@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 05:35:26PM +0000, Steve Capper wrote:
> Hello,
> The following patch series is my attempt at fixing a rather nasty bug
> which became visible in 3.12-rc1 when running the libhugetlbfs test
> suite. (This problem only just came to my attention yesterday).
> 
> For LPAE, set_huge_pte_at calls set_pte_at which then calls
> set_pte_ext, which in turn is wired up to call cpu_v7_set_pte_ext,
> which is defined in proc-v7-3level.S.
> 
> For huge pages, given newprot a pgprot_t value for a shared writable
> VMA, and ptep a pointer to a pte belonging to this VMA; the following
> behaviour is assumed by core code:
>    hugetlb_change_protection(vma, address, end, newprot);
>    ...
> 
>    huge_pte_write(huge_ptep_get(ptep)); /* should be true! */
> 
> Unfortunately, cpu_v7_set_pte_ext will change the bit layout of the
> resultant pte, and will set the read only bit if the dirty bit is not
> also enabled.
> 
> If one were to allocate a read only shared huge page, then fault it in,
> and then mprotect it to be writeable. A subsequent write to that huge
> page will result in a spurious call to hugetlb_cow, which causes
> corruption. This call is optimised away prior to:
>  37a2140 mm, hugetlb: do not use a page in page cache for cow
>          optimization
> 
> If one runs the libhugetlbfs test suite on v3.12-rc1 upwards, then the
> mprotect test will cause the afformentioned corruption and before the
> set of tests completes, the system will be left in an unresponsive
> state. (calls to fork fail with -ENOMEM).
> 
> This was an absolute pig to debug and, as this is the second time I've
> ran into issues caused by ptes being modified in transit, I've opted to
> re-implement set_huge_pte_at such that it just dereferences the pte.
> (in a similar manner as arm64). This has also allowed me to revert the
> pte_same logic change (that removed the NG bit from comparison), by
> also setting the NG bit for all new huge ptes.
> 
> These patches are against 3.12, and I have tested this series on an
> Arndale board with LPAE running libhugetlbfs.
> 
> I would really value any comments/critique/flames on this series.
> Especially as I've ommitted the DCCMVAC at the end of set_huge_pte_at
> as I couldn't see why it was needed, please yell at me if it is needed!
> :-)
> 
> Cheers,
> -- 
> Steve

Hi,
A question has been raised for the arm64 analogue of this series as to
whether or not this is the best approach:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/215155.html

I am having a think about this, and will send out a V2 once my brain
has caught up. :-)

Cheers,
-- 
Steve
