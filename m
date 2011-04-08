From: bill_carson@126.com (bill)
Date: Fri, 8 Apr 2011 16:04:52 +0800 (CST)
Subject: Query about __unmap_hugepage_range
Message-ID: <676cc2d1.17772.12f34246b06.Coremail.bill_carson@126.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey, MM developers:)

I don't know if this posting is proper at here, so sorry for disturbing if it does.

for normal 4K page: in unmap_page_range
1: tlb_start_vma(tlb, vma); <------ call  flush_cache_range to invalidate icache if vma is VM_EXEC
2: clear pagetable mapping
3: tlb_end_vma(tlb, vma); <-------- call flush_tlb_range to invalidate unmapped vma tlb entry

for hugepage: in __unmap_hugepage_range
1: clear pagetable mapping
2: call flush_tlb_range(vma, start, end); to invalidate unmapped vma tlb entry

I really don't understand about two things:
A: why there is no flush_cache_range for hugepage when we do the unmapping?
B: How does kernel take care of such case for both normal 4K page and hugepage:
    a: mmap a page with PROT_EXEC at location p;
    b: copy bunch instruction into p ,call cacheflush to make ICACHE see the new instruction;
    c: run instruction at location p, then unmap it;
    d: mmap a new page with MAP_FIXED/PROT_EXEC at location p, and run unexpected instruction at p;
        there is a great chance we got the same page@step_a;
        user space should see a clean icache, not a stale one;
    
I am really puzzled for a long time.
I am porting hugepage for ARM ,and one testcase in libhugetlbfs called icache-hygiene failed, test rationale is described  in above B.

Any tips/advice would be truly appreciated.
Thanks

 







-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110408/05cff2bf/attachment-0001.html>
