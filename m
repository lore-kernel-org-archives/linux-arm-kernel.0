From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 Jul 2015 12:13:42 +0100
Subject: [PATCH 3/3] arm64, mm: Use IPIs for TLB invalidation.
In-Reply-To: <55A40A50.8080902@caviumnetworks.com>
References: <1436646323-10527-1-git-send-email-ddaney.cavm@gmail.com>
 <1436646323-10527-4-git-send-email-ddaney.cavm@gmail.com>
 <20150713181755.GP2632@arm.com>
 <55A40A50.8080902@caviumnetworks.com>
Message-ID: <20150714111342.GD13555@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 11:58:24AM -0700, David Daney wrote:
> On 07/13/2015 11:17 AM, Will Deacon wrote:
> >On Sat, Jul 11, 2015 at 09:25:23PM +0100, David Daney wrote:
> >>From: David Daney <david.daney@cavium.com>
> >>
> >>Most broadcast TLB invalidations are unnecessary.  So when
> >>invalidating for a given mm/vma target the only the needed CPUs via
> >>and IPI.
> >>
> >>For global TLB invalidations, also use IPI.
> >>
> >>Tested on Cavium ThunderX.
> >>
> >>This change reduces 'time make -j48' on kernel from 139s to 116s (83%
> >>as long).
> >
> >Any idea *why* you're seeing such an improvement? Some older kernels had
> >a bug where we'd try to flush a negative (i.e. huge) range by page, so it
> >would be nice to rule that out. I assume these measurements are using
> >mainline?
> 
> I have an untested multi-part theory:
> 
> 1) Most of the invalidations in the kernel build will be for a mm that was
> only used on a single CPU (the current CPU), so IPIs are for the most part
> not needed.  We win by not having to synchronize across all CPUs waiting for
> the DSB to complete.  I think most of it occurs at process exit.  Q: why do
> anything at process exit?  The use of ASIDs should make TLB invalidations at
> process death unnecessary.

I think for the process exit, something like below may work (but it
needs proper review and a lot of testing to make sure I haven't missed
anything; note that it's only valid for the current ASID allocation
algorithm on arm64 which does not allow ASID reusing until roll-over):

------------8<---------------------------
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 3a0242c7eb8d..0176cda688cb 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -38,7 +38,8 @@ static inline void __tlb_remove_table(void *_table)
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 	if (tlb->fullmm) {
-		flush_tlb_mm(tlb->mm);
+		/* Deferred until ASID roll-over */
+		WARN_ON(atomic_read(&tlb->mm->mm_users));
 	} else {
 		struct vm_area_struct vma = { .vm_mm = tlb->mm, };
 		flush_tlb_range(&vma, tlb->start, tlb->end);
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 934815d45eda..2e595933864a 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -150,6 +150,13 @@ static inline void __flush_tlb_pgtable(struct mm_struct *mm,
 {
 	unsigned long addr = uaddr >> 12 | ((unsigned long)ASID(mm) << 48);
 
+	/*
+	 * Check for concurrent users of this mm. If there are no users with
+	 * user space, we do not have any (speculative) page table walkers.
+	 */
+	if (!atomic_read(&mm->mm_users))
+		return;
+
 	dsb(ishst);
 	asm("tlbi	vae1is, %0" : : "r" (addr));
 	dsb(ish);
------------8<---------------------------

AFAICT, we have three main cases for full mm TLBI (and another when the
VA range is is too large):

1. fork - dup_mmap() needs to flush the parent after changing the pages
   to read-only for CoW. Here we can't really do anything
2. sys_exit - exit_mmap() clearing the page tables, the above TLBI
   deferring would help
3. sys_execve - by the time we call exit_mmap(old_mm), we already
   activated the new mm via exec_mmap(), so deferring TLBI should work

BTW, if we do the TLBI deferring to the ASID roll-over event, your
flush_context() patch to use local TLBI would no longer work. It is
called from __new_context() when allocating a new ASID, so it needs to
be broadcast to all the CPUs.

> 2) By simplifying the VA range invalidations to just a single ASID based
> invalidation, we are issuing many fewer TLBI broadcasts.  The overhead of
> refilling the local TLB with still needed mappings may be lower than the
> overhead of all those TLBI operations.

That the munmap case usually. In our tests, we haven't seen large
ranges, mostly 1-2 4KB pages (especially with kernbench when median file
size fits in 4KB). Maybe the new batching code for x86 could help ARM as
well if we implement it. We would still issue TLBIs but it allows us to
issue a single DSB at the end.

Once we manage to optimise the current implementation, maybe it would
still be faster on a large machine (48 cores) with IPIs but it is highly
dependent on the type of workload (single-threaded tasks would benefit).
Also note that under KVM the cost of the IPI is much higher.

-- 
Catalin
