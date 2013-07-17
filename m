From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Jul 2013 20:27:46 +0100
Subject: preempted dup_mm misses TLB invalidate
In-Reply-To: <51E43D2B.9090709@nvidia.com>
References: <51E43D2B.9090709@nvidia.com>
Message-ID: <20130717192746.GE16496@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 07:19:23PM +0100, Nickolas Fortino wrote:
> I?ve noticed an issue in simulation where the Linux kernel is executing 
> a user process when the page tables and TLBs have gotten out of sync. 
> The page tables have a page marked as user read only, but the TLB has 
> the page marked as user read/write.

This happens during fork() for the current process. I think mprotect()
as well. The caller is supposed not to have threads that write its
memory while another thread does a fork().

> I?ve traced the issue back to the handling of copy on write pages 
> generated from the ?do_fork?, ?copy_process?, ?dup_mm?, ?dup_mmap? call 
> stack. If run without interruption, ?dup_mmap? calls 
> ?flush_tlb_mm(oldmm)? on completion, avoiding any issues. In this case, 
> however, about 4 million instructions after ?dup_mm? is called, 
> ?copy_pte_range? yields to another thread via __cond_resched. About 20 
> million instructions later, a user process with the ASID of the source 
> mm is scheduled.

Why would it have the same ASID? We should not reuse an ASID unless
there was a TLB invalidation for that ASID. If it's a thread of the same
process, I think it's just a user programming bug.

> This process performs a store to a page modified from 
> read/write to read only in the copy on write logic of ?copy_one_pte?. 
> Because the TLB was not invalidated, the store hits on a TLB entry with 
> read/write permissions and succeeds without a fault.
> 
> What invariant in the Linux kernel is supposed to prevent this from 
> happening? Note I have not observed user visible corruption, but it 
> seems very unlikely a successful store to a page marked as read only in 
> the kernel is safe.

See above. The only workaround would be to stop all the threads of a
process while calling fork(). Threads and fork() are not nice to
each-other.

-- 
Catalin
