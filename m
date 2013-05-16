From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 May 2013 15:36:38 +0100
Subject: [PATCH] ARM: remove the .vm_mm value from gate_vma.
In-Reply-To: <1368702394-1737-1-git-send-email-steve.capper@linaro.org>
References: <1368702394-1737-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20130516143638.GR18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 12:06:34PM +0100, Steve Capper wrote:
> If one reads /proc/$PID/smaps, the mmap_sem belonging to the
> address space of the task being examined is locked for reading.
> All the pages of the vmas belonging to the task's address space
> are then walked with this lock held.
> 
> If a gate_vma is present in the architecture, it too is examined
> by the fs/proc/task_mmu.c code. As gate_vma doesn't belong to the
> address space of the task though, its pages are not walked.
> 
> A recent cleanup (commit f6604efe) of the gate_vma initialisation
> code set the vm_mm value to &init_mm. Unfortunately a non-NULL
> vm_mm value in the gate_vma will cause the task_mmu code to attempt
> to walk the pages of the gate_vma (with no mmap-sem lock held). If
> one enables Transparent Huge Page support and vm debugging, this
> will then cause OOPses as pmd_trans_huge_lock is called without
> mmap_sem being locked.
> 
> This patch removes the .vm_mm value from gate_vma, restoring the
> original behaviour of the task_mmu code.

This looks fine - x86 also sets .vm_mm to NULL here.  So please put
it in my patch system.  Does this need to be applied to stable
kernels as well?  If so, please mark it with Cc: <stable@vger.kernel.org>
(but do not send it to that address).  Also, it'd be worth checking
which stable kernels it needs to be applied to.

Thanks.
