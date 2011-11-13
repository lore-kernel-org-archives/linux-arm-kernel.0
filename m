From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 13 Nov 2011 10:32:02 +0000
Subject: [PATCH 1/1 v3] arch/arm/mm/fault.c: Porting OOM changes into
 __do_page_fault
In-Reply-To: <1321147946-3639-1-git-send-email-consul.kautuk@gmail.com>
References: <1321147946-3639-1-git-send-email-consul.kautuk@gmail.com>
Message-ID: <20111113103202.GG27746@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 12, 2011 at 08:32:26PM -0500, Kautuk Consul wrote:
> Commits d065bd810b6deb67d4897a14bfe21f8eb526ba99 and
> 37b23e0525d393d48a7d59f870b3bc061a30ccdb introduced changes into
> the x86 pagefault handler for making the page fault handler
> retryable as well as killable.

Please include the summary of those commit IDs in the description.

> These changes reduce the mmap_sem hold time(for x86), which is crucial
> during OOM killer invocation.

We don't need (for x86) because that's not really relevant, and also
implied by the above paragraph.

> Porting these changes to ARM.

"Port" not "Porting" - it's not something that happens continuously
(or even something that happens each time the commit text is read!)

> 
> Without these changes, my ARM board encounters many hang and livelock
> scenarios.
> After applying this patch, OOM feature performance improves according to
> my testing.
> 
> Motivation for porting these changes:
> ------------------------------------
> Embedded devices such as SMART TVs and SMART phones have the capability
> to download and run apps from the internet.
> Due to this, the device user might run some malignant app that
> allocates too much memory.
> In that case, OOM killer performance is very important so that the
> device can free up memory for other apps as well as the kernel.
> 
> Signed-off-by: Kautuk Consul <consul.kautuk@gmail.com>

This now looks better, thanks.

I don't think we need the "motivation" section in here - it should be
below the '---'.

> ---
>  arch/arm/mm/fault.c |   50 ++++++++++++++++++++++++++++++++++++++------------
>  1 files changed, 38 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index aa33949..9aeba03 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -231,7 +231,7 @@ static inline bool access_error(unsigned int fsr, struct vm_area_struct *vma)
>  
>  static int __kprobes
>  __do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
> -		struct task_struct *tsk)
> +		unsigned int flags, struct task_struct *tsk)
>  {
>  	struct vm_area_struct *vma;
>  	int fault;
> @@ -257,13 +257,9 @@ good_area:
>  	 * If for any reason at all we couldn't handle the fault, make
>  	 * sure we exit gracefully rather than endlessly redo the fault.
>  	 */
> -	fault = handle_mm_fault(mm, vma, addr & PAGE_MASK, (fsr & FSR_WRITE) ? FAULT_FLAG_WRITE : 0);
> +	fault = handle_mm_fault(mm, vma, addr & PAGE_MASK, flags);
>  	if (unlikely(fault & VM_FAULT_ERROR))
>  		return fault;
> -	if (fault & VM_FAULT_MAJOR)
> -		tsk->maj_flt++;
> -	else
> -		tsk->min_flt++;
>  	return fault;
>  
>  check_stack:
> @@ -279,6 +275,9 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  	struct task_struct *tsk;
>  	struct mm_struct *mm;
>  	int fault, sig, code;
> +	int write = fsr & FSR_WRITE;
> +	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE |
> +					(write ? FAULT_FLAG_WRITE : 0);
>  
>  	if (notify_page_fault(regs, fsr))
>  		return 0;
> @@ -305,6 +304,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  	if (!down_read_trylock(&mm->mmap_sem)) {
>  		if (!user_mode(regs) && !search_exception_tables(regs->ARM_pc))
>  			goto no_context;
> +retry:
>  		down_read(&mm->mmap_sem);
>  	} else {
>  		/*
> @@ -320,14 +320,40 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  #endif
>  	}
>  
> -	fault = __do_page_fault(mm, addr, fsr, tsk);
> -	up_read(&mm->mmap_sem);
> +	fault = __do_page_fault(mm, addr, fsr, flags, tsk);
> +
> +	/* If we need to retry but a fatal signal is pending, handle the
> +	 * signal first. We do not need to release the mmap_sem because
> +	 * it would already be released in __lock_page_or_retry in
> +	 * mm/filemap.c. */
> +	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +		return 0;
>  
> +	/*
> +	 * Major/minor page fault accounting is only done on the
> +	 * initial attempt. If we go through a retry, it is extremely
> +	 * likely that the page will be found in page cache at that point.
> +	 */
>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
> -	if (fault & VM_FAULT_MAJOR)
> -		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs, addr);
> -	else if (fault & VM_FAULT_MINOR)
> -		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, addr);
> +	if (flags & FAULT_FLAG_ALLOW_RETRY) {
> +		if (fault & VM_FAULT_MAJOR) {
> +			tsk->maj_flt++;
> +			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
> +				      regs, addr);
> +		} else {
> +			tsk->min_flt++;
> +			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
> +				      regs, addr);
> +		}
> +		if (fault & VM_FAULT_RETRY) {
> +			/* Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk
> +			 * of starvation. */
> +			flags &= ~FAULT_FLAG_ALLOW_RETRY;
> +			goto retry;
> +		}
> +	}
> +
> +	up_read(&mm->mmap_sem);
>  
>  	/*
>  	 * Handle the "normal" case first - VM_FAULT_MAJOR / VM_FAULT_MINOR
> -- 
> 1.7.5.4
> 
