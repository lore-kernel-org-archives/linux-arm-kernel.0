From: external.Peter.Waechtler@de.bosch.com (EXTERNAL Waechtler Peter (Fa. TCP, CM-AI/PJ-CF31))
Date: Thu, 22 Mar 2012 13:24:47 +0100
Subject: ARM11MPcore: tlb_ops_need_broadcast causes deadlock
Message-ID: <274124B9C6907D4B8CE985903EAA19E91B2D579066@SI-MBX06.de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we are again with another issue on ARM11mpcore (2 cores for Linux):

In relatively rare circumstances the system soft-locks up:


cpuA                                                                cpuB

kswapd searches for pages to reclaim
via shrink_zone
page_referenced
page_referenced_one
    page_check_address(&ptl)   <- ptl gets locked!
    ptep_clear_flush_young_notify                                   jump to the "innocent" page
                                                                        IRQS OFF
                                                                        do_DataAbort-> handle_mm_fault
                                                                            handle_pte_fault (inlined)
                                                                            ptl = pte_lockptr(mm, pmd);
                                                                            spin_lock(ptl);

        flush_tlb_page
            tlb_ops_need_broadcast
            on_each_cpu_mask(ipi_flush_tlb_page, with WAIT)
                csd_lock_wait()
                                          DEADLOCK, IPI on cpuB does not finish because IRQs are OFF
    pte_unmap_unlock(pte, ptl);



And here is some explanation:

Every then and now pages are marked inaccessible in the hardware PTE
(page table entry) so that the VM subsystem can check if the page is
accessed at all. If it's frequently accessed it will become a "young" page.
On memory pressure "old" pages will be the first to get evicted.

The kswapd kernel thread goes through a list of pages to check if they
were accessed in a given interval and mark our target page as young.

The cpuB executes some user code hitting that page and because the PTE
is marked "inaccessible", so that the attempt can be stored, it results
in a page fault.

Unluckily the kswapd calls tlb_flush and that is configured to inform all
cpus about that change via IPIs. cpuB is in an user abort handler (__dabt_usr)
and the disaster takes its course:

For checking if it's a thumb instruction that caused the fault the abort handler
accesses the page resulting into another fault - but now entering svc abort handler
(__dabt_svc) and that turns off interrupts!

That leads to cpuA waiting in csd_lock_wait for the IPI to signal its end of execution
(via csd->flags) but that does not happen because IRQs are off on cpuB that
is stuck in the page fault handler spinning to get the lock for the mm->page_table_lock
but this is still held on cpuA waiting for the IPIs to finish.

possible solutions:

a) do not wait for that particular IPI since the mapping does not change
 (just the access bits)

b) open code the ptep_set_access_flags() and change the sequence that the IPI
 is called without holding the page_table_lock anymore

This shows up on CPUs where tlb_ops_need_broadcast() returns true.


Input welcome how to resolve this issue.

regards

        Peter
