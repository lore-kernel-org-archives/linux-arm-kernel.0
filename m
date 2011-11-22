From: consul.kautuk@gmail.com (kautuk.c @samsung.com)
Date: Tue, 22 Nov 2011 13:33:42 -0500
Subject: [PATCH 1/1 v5] arm: fault.c: Port OOM changes into do_page_fault
In-Reply-To: <1321985779-5810-1-git-send-email-consul.kautuk@gmail.com>
References: <1321985779-5810-1-git-send-email-consul.kautuk@gmail.com>
Message-ID: <CAFPAmTQ3su_tuwHEBKPwn4YFX8sWs0x1agYfyzTnOdBaVRL21Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please disregard this one due to the following line :
From: Kautuk <kautuk@ubuntu.(none)>

There was something wrong in my git configuration.

On Tue, Nov 22, 2011 at 1:16 PM, Kautuk Consul <consul.kautuk@gmail.com> wrote:
> From: Kautuk <kautuk@ubuntu.(none)>
>
> Commit d065bd810b6deb67d4897a14bfe21f8eb526ba99
> (mm: retry page fault when blocking on disk transfer) and
> commit 37b23e0525d393d48a7d59f870b3bc061a30ccdb
> (x86,mm: make pagefault killable)
>
> The above commits introduced changes into the x86 pagefault handler
> for making the page fault handler retryable as well as killable.
>
> These changes reduce the mmap_sem hold time, which is crucial
> during OOM killer invocation.
>
> Port these changes to ARM.
>
> Without these changes, my ARM board encounters many hang and livelock
> scenarios.
> After applying this patch, OOM feature performance improves according to
> my testing.
>
> Signed-off-by: Kautuk <kautuk@ubuntu.(none)>
> ---
> ?arch/arm/mm/fault.c | ? 58 ++++++++++++++++++++++++++++++++++----------------
> ?1 files changed, 39 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index aa33949..4aabeae 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -231,7 +231,7 @@ static inline bool access_error(unsigned int fsr, struct vm_area_struct *vma)
>
> ?static int __kprobes
> ?__do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
> - ? ? ? ? ? ? ? struct task_struct *tsk)
> + ? ? ? ? ? ? ? unsigned int flags, struct task_struct *tsk)
> ?{
> ? ? ? ?struct vm_area_struct *vma;
> ? ? ? ?int fault;
> @@ -253,18 +253,7 @@ good_area:
> ? ? ? ? ? ? ? ?goto out;
> ? ? ? ?}
>
> - ? ? ? /*
> - ? ? ? ?* If for any reason at all we couldn't handle the fault, make
> - ? ? ? ?* sure we exit gracefully rather than endlessly redo the fault.
> - ? ? ? ?*/
> - ? ? ? fault = handle_mm_fault(mm, vma, addr & PAGE_MASK, (fsr & FSR_WRITE) ? FAULT_FLAG_WRITE : 0);
> - ? ? ? if (unlikely(fault & VM_FAULT_ERROR))
> - ? ? ? ? ? ? ? return fault;
> - ? ? ? if (fault & VM_FAULT_MAJOR)
> - ? ? ? ? ? ? ? tsk->maj_flt++;
> - ? ? ? else
> - ? ? ? ? ? ? ? tsk->min_flt++;
> - ? ? ? return fault;
> + ? ? ? return handle_mm_fault(mm, vma, addr & PAGE_MASK, flags);
>
> ?check_stack:
> ? ? ? ?if (vma->vm_flags & VM_GROWSDOWN && !expand_stack(vma, addr))
> @@ -279,6 +268,9 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
> ? ? ? ?struct task_struct *tsk;
> ? ? ? ?struct mm_struct *mm;
> ? ? ? ?int fault, sig, code;
> + ? ? ? int write = fsr & FSR_WRITE;
> + ? ? ? unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE |
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (write ? FAULT_FLAG_WRITE : 0);
>
> ? ? ? ?if (notify_page_fault(regs, fsr))
> ? ? ? ? ? ? ? ?return 0;
> @@ -305,6 +297,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
> ? ? ? ?if (!down_read_trylock(&mm->mmap_sem)) {
> ? ? ? ? ? ? ? ?if (!user_mode(regs) && !search_exception_tables(regs->ARM_pc))
> ? ? ? ? ? ? ? ? ? ? ? ?goto no_context;
> +retry:
> ? ? ? ? ? ? ? ?down_read(&mm->mmap_sem);
> ? ? ? ?} else {
> ? ? ? ? ? ? ? ?/*
> @@ -320,14 +313,41 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
> ?#endif
> ? ? ? ?}
>
> - ? ? ? fault = __do_page_fault(mm, addr, fsr, tsk);
> - ? ? ? up_read(&mm->mmap_sem);
> + ? ? ? fault = __do_page_fault(mm, addr, fsr, flags, tsk);
> +
> + ? ? ? /* If we need to retry but a fatal signal is pending, handle the
> + ? ? ? ?* signal first. We do not need to release the mmap_sem because
> + ? ? ? ?* it would already be released in __lock_page_or_retry in
> + ? ? ? ?* mm/filemap.c. */
> + ? ? ? if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> + ? ? ? ? ? ? ? return 0;
> +
> + ? ? ? /*
> + ? ? ? ?* Major/minor page fault accounting is only done on the
> + ? ? ? ?* initial attempt. If we go through a retry, it is extremely
> + ? ? ? ?* likely that the page will be found in page cache at that point.
> + ? ? ? ?*/
>
> ? ? ? ?perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
> - ? ? ? if (fault & VM_FAULT_MAJOR)
> - ? ? ? ? ? ? ? perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs, addr);
> - ? ? ? else if (fault & VM_FAULT_MINOR)
> - ? ? ? ? ? ? ? perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, addr);
> + ? ? ? if (flags & FAULT_FLAG_ALLOW_RETRY) {
> + ? ? ? ? ? ? ? if (fault & VM_FAULT_MAJOR) {
> + ? ? ? ? ? ? ? ? ? ? ? tsk->maj_flt++;
> + ? ? ? ? ? ? ? ? ? ? ? perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? regs, addr);
> + ? ? ? ? ? ? ? } else {
> + ? ? ? ? ? ? ? ? ? ? ? tsk->min_flt++;
> + ? ? ? ? ? ? ? ? ? ? ? perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? regs, addr);
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? if (fault & VM_FAULT_RETRY) {
> + ? ? ? ? ? ? ? ? ? ? ? /* Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk
> + ? ? ? ? ? ? ? ? ? ? ? * of starvation. */
> + ? ? ? ? ? ? ? ? ? ? ? flags &= ~FAULT_FLAG_ALLOW_RETRY;
> + ? ? ? ? ? ? ? ? ? ? ? goto retry;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> +
> + ? ? ? up_read(&mm->mmap_sem);
>
> ? ? ? ?/*
> ? ? ? ? * Handle the "normal" case first - VM_FAULT_MAJOR / VM_FAULT_MINOR
> --
> 1.7.5.4
>
>
