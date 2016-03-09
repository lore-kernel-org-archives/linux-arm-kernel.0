From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Mar 2016 15:31:32 +0000
Subject: BUG in HugeTLBFS with Contiguous hint
In-Reply-To: <20160309021252.GA4573@linaro.org>
References: <20160309021252.GA4573@linaro.org>
Message-ID: <20160309153131.GF28496@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 02:12:56AM +0000, Steve Capper wrote:
> Hi,

Hi Steve,

> I am very sorry for the very late bug report. I have just come across
> this error.
> 
> Whilst testing something else, I found that 2MB HugeTLB pages formed
> from contiguous pte's cause BUGs to appear when running through the
> libhugetlbfs test suite.

Ouch. Any idea why this wasn't spotted earlier? Did something else
change?

> I have been digging into this and I think the problem is due to the
> huge pages not being unmapped properly (the nature of the bugs is that
> compound pages have a non-negative compound mapped count, thus appear
> as mapped in the hugetlbfs inode destruction logic); but I have not
> yet been able to convincingly isolate the problem.
> 
> I ran with 64KB PAGE_SIZE and CONFIG_DEBUG_VM. Failure mode at the
> bottom of this email for a 4.5-rc7 kernel.
> 
> Also, whilst reading through the code again, I think that
> find_num_contig can be better implemented by pulling through the vma
> (thus hstate) and avoid the need for a page table walk. This may make
> things slightly more reliable when DBM is enabled (as the current code
> depends on being able to pull out a matching pte), but would require
> some core changes.
> 
> I'll keep hacking, but, It may be better to temporarily disable (or
> revert) contiguous hint hugetlb pages for now as I don't think a quick
> fix can be found in time for the release.

A revert is certainly the easiest option, but it also seems unfortunate.

Maybe something like the patch below instead? It can be reverted as soon
as this is worked out. Can you confirm that this avoids the BUG?

Will

--->8

>From ff7925848b50050732ac0401e0acf27e8b241d7b Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Wed, 9 Mar 2016 15:22:55 +0000
Subject: [PATCH] arm64: hugetlb: partial revert of 66b3923a1a0f

Commit 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bit")
introduced support for huge pages using the contiguous bit in the PTE
as opposed to block mappings, which may be slightly unwieldy (512M) in
64k page configurations.

Unfortunately, this support has resulted in some late regressions when
running the libhugetlbfs test suite with 64k pages and CONFIG_DEBUG_VM
as a result of a BUG:

 | readback (2M: 64):	------------[ cut here ]------------
 | kernel BUG at fs/hugetlbfs/inode.c:446!
 | Internal error: Oops - BUG: 0 [#1] SMP
 | Modules linked in:
 | CPU: 7 PID: 1448 Comm: readback Not tainted 4.5.0-rc7 #148
 | Hardware name: linux,dummy-virt (DT)
 | task: fffffe0040964b00 ti: fffffe00c2668000 task.ti: fffffe00c2668000
 | PC is at remove_inode_hugepages+0x44c/0x480
 | LR is at remove_inode_hugepages+0x264/0x480

Rather than revert the entire patch, simply avoid advertising the
contiguous huge page sizes for now while people are actively working on
a fix. This patch can then be reverted once things have been sorted out.

Cc: David Woods <dwoods@ezchip.com>
Reported-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 82d607c3614e..da30529bb1f6 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -306,10 +306,6 @@ static __init int setup_hugepagesz(char *opt)
 		hugetlb_add_hstate(PMD_SHIFT - PAGE_SHIFT);
 	} else if (ps == PUD_SIZE) {
 		hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
-	} else if (ps == (PAGE_SIZE * CONT_PTES)) {
-		hugetlb_add_hstate(CONT_PTE_SHIFT);
-	} else if (ps == (PMD_SIZE * CONT_PMDS)) {
-		hugetlb_add_hstate((PMD_SHIFT + CONT_PMD_SHIFT) - PAGE_SHIFT);
 	} else {
 		pr_err("hugepagesz: Unsupported page size %lu K\n", ps >> 10);
 		return 0;
@@ -317,13 +313,3 @@ static __init int setup_hugepagesz(char *opt)
 	return 1;
 }
 __setup("hugepagesz=", setup_hugepagesz);
-
-#ifdef CONFIG_ARM64_64K_PAGES
-static __init int add_default_hugepagesz(void)
-{
-	if (size_to_hstate(CONT_PTES * PAGE_SIZE) == NULL)
-		hugetlb_add_hstate(CONT_PMD_SHIFT);
-	return 0;
-}
-arch_initcall(add_default_hugepagesz);
-#endif
-- 
2.1.4
