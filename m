From: zhang.lei@jp.fujitsu.com (Zhang, Lei)
Date: Tue, 18 Sep 2018 03:02:17 +0000
Subject: Huge page(contiguous bit) slow down
Message-ID: <8898674D84E3B24BA3A2D289B872026A69FE8F27@G01JPEXMBKW03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I found a slowdown problem when we uses a huge page on arm64 chip.
I think the cause of this problem is a bug of huge_ptep_set_access_flags() with contiguous pte.
Could you review and merge my patch?


Incident:
Multiple threaded process repeats page fault again and again, so the PC in EL0 doesn't move to the next operation.

Multiple threads occur page fault at the same time and the same VA. It may cause slowdown or hang of a process.
Because a race problem on updating pte maybe happened when the condition matched as below.
1. Multiple threads are running
2. All threads are ld/st-ing to the same huge page
3. The huge page is consist of contiguous ptes (2MiB page = 64KiB page x 32)
4. The huge page is mapped without MAP_POPULATE flag.

Mechanism:
The mechanism of this problem is as below.
Updating pte use 4 steps.

step1: create pte content
step2: zero-clear pte at ptep_get_and_clear
step3: flush tlb at flush_tlb_range
step4: set pte at set_pte_at(pte becomes non-zero)

When thread1 is doing between step2 and step4, thread2 accesses the same huge page at the same time.
It cause a new page fault at thread2.
After that, when thread2 is doing between step2 and step4, thread1 retries the access to the same page.
It cause a new page fault at thread1 again.
Multi-threads repeat this flow again and again.

On the other hand, if the pte is not a contiguous pte, slowdown or hang will not occur.
Because it check whether a correct pte has been already presented by other thread using pte_same before step2(0 clear pte).

Call tree information:
hugetlb_fault
  huge_ptep_set_access_flags
    ptep_set_access_flags  -> ( contiguous pte route not call this)
      pte_same
    ptep_get_and_clear
    flush_tlb_range
    set_pte_at

So our patch calls the same check function not only for non-contiguous pte but also for contiguous pte.

-----------------------------
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -332,6 +332,9 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
        if (!pte_cont(pte))
                return ptep_set_access_flags(vma, addr, ptep, pte, dirty);

+       if(pte_same(pte, READ_ONCE(*ptep)))
+               return 0;
+
        ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
        dpfn = pgsize >> PAGE_SHIFT;

Best Regards
Lei Zhang
Email: zhang.lei at jp.fujitsu.com
FUJTISU LIMITED.
