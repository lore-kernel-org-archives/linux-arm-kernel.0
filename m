From: nfortino@nvidia.com (Nickolas Fortino)
Date: Mon, 15 Jul 2013 11:19:23 -0700
Subject: preempted dup_mm misses TLB invalidate
Message-ID: <51E43D2B.9090709@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I?ve noticed an issue in simulation where the Linux kernel is executing 
a user process when the page tables and TLBs have gotten out of sync. 
The page tables have a page marked as user read only, but the TLB has 
the page marked as user read/write.

I?ve traced the issue back to the handling of copy on write pages 
generated from the ?do_fork?, ?copy_process?, ?dup_mm?, ?dup_mmap? call 
stack. If run without interruption, ?dup_mmap? calls 
?flush_tlb_mm(oldmm)? on completion, avoiding any issues. In this case, 
however, about 4 million instructions after ?dup_mm? is called, 
?copy_pte_range? yields to another thread via __cond_resched. About 20 
million instructions later, a user process with the ASID of the source 
mm is scheduled. This process performs a store to a page modified from 
read/write to read only in the copy on write logic of ?copy_one_pte?. 
Because the TLB was not invalidated, the store hits on a TLB entry with 
read/write permissions and succeeds without a fault.

What invariant in the Linux kernel is supposed to prevent this from 
happening? Note I have not observed user visible corruption, but it 
seems very unlikely a successful store to a page marked as read only in 
the kernel is safe.

For reference, this issue was found with the Linux 3.7 kernel coming 
from the Linaro 12.12 release available at 
http://releases.linaro.org/12.12/android/vexpress
