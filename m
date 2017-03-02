From: punit.agrawal@arm.com (Punit Agrawal)
Date: Thu, 02 Mar 2017 18:28:47 +0000
Subject: [PATCH V2] arm64: hwpoison: add VM_FAULT_HWPOISON[_LARGE] handling
In-Reply-To: <1487720205-14594-1-git-send-email-tbaicar@codeaurora.org> (Tyler
 Baicar's message of "Tue, 21 Feb 2017 16:36:45 -0700")
References: <1487720205-14594-1-git-send-email-tbaicar@codeaurora.org>
Message-ID: <87wpc7o7mo.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

Tyler Baicar <tbaicar@codeaurora.org> writes:

> From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>
>
> Add VM_FAULT_HWPOISON[_LARGE] handling to the arm64 page fault
> handler. Handling of VM_FAULT_HWPOISON[_LARGE] is very similar
> to VM_FAULT_OOM, the only difference is that a different si_code
> (BUS_MCEERR_AR) is passed to user space and si_addr_lsb field is
> initialized.
>
> Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  arch/arm64/mm/fault.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 156169c..ceaa82f 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -30,6 +30,7 @@
>  #include <linux/highmem.h>
>  #include <linux/perf_event.h>
>  #include <linux/preempt.h>
> +#include <linux/hugetlb.h>
>  
>  #include <asm/bug.h>
>  #include <asm/cpufeature.h>
> @@ -193,9 +194,10 @@ static void __do_kernel_fault(struct mm_struct *mm, unsigned long addr,
>   */
>  static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
>  			    unsigned int esr, unsigned int sig, int code,
> -			    struct pt_regs *regs)
> +			    struct pt_regs *regs, int fault)
>  {
>  	struct siginfo si;
> +	unsigned int lsb = 0;
>  
>  	if (unhandled_signal(tsk, sig) && show_unhandled_signals_ratelimited()) {
>  		pr_info("%s[%d]: unhandled %s (%d) at 0x%08lx, esr 0x%03x\n",
> @@ -211,6 +213,17 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
>  	si.si_errno = 0;
>  	si.si_code = code;
>  	si.si_addr = (void __user *)addr;
> +	/*
> +	 * Either small page or large page may be poisoned.
> +	 * In other words, VM_FAULT_HWPOISON_LARGE and
> +	 * VM_FAULT_HWPOISON are mutually exclusive.
> +	 */
> +	if (fault & VM_FAULT_HWPOISON_LARGE)
> +		lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
> +	else if (fault & VM_FAULT_HWPOISON)
> +		lsb = PAGE_SHIFT;
> +	si.si_addr_lsb = lsb;
> +
>  	force_sig_info(sig, &si, tsk);
>  }
>  
> @@ -224,7 +237,7 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
>  	 * handle this fault with.
>  	 */
>  	if (user_mode(regs))
> -		__do_user_fault(tsk, addr, esr, SIGSEGV, SEGV_MAPERR, regs);
> +		__do_user_fault(tsk, addr, esr, SIGSEGV, SEGV_MAPERR, regs, 0);
>  	else
>  		__do_kernel_fault(mm, addr, esr, regs);
>  }
> @@ -426,6 +439,9 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  		 */
>  		sig = SIGBUS;
>  		code = BUS_ADRERR;
> +	} else if (fault & (VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE)) {
> +		sig = SIGBUS;
> +		code = BUS_MCEERR_AR;
>  	} else {
>  		/*
>  		 * Something tried to access memory that isn't in our memory
> @@ -436,7 +452,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  			SEGV_ACCERR : SEGV_MAPERR;
>  	}
>  
> -	__do_user_fault(tsk, addr, esr, sig, code, regs);
> +	__do_user_fault(tsk, addr, esr, sig, code, regs, fault);
>  	return 0;
>  
>  no_context:

The code looks good but I ran into some failures while running the
hugepages hwpoison tests from mce-tests suite[0]. I get a bad pmd error
in dmesg -

[  344.165544] mm/pgtable-generic.c:33: bad pmd 000000083af00074.

I suspect that this is due to the huge pte accessors not correctly
dealing with poisoned entries (which are represented as swap entries).

I am investigating the failure but could you try running the tests at
your end as well.

To run the tests, I cloned the repository[0]. It test needs a simple fix
at the end of this mail to run correctly. With that applied and running
as root -

# cd mce-test/cases/function/hwpoison
# ./run_hugepage.sh


[0] https://git.kernel.org/cgit/utils/cpu/mce/mce-test.git/

--------->8--------------
commit cb5c61f18dd86baf01b90404d4ecf51dd3d176c7
Author: Punit Agrawal <punit.agrawal@arm.com>
Date:   Thu Mar 2 18:24:40 2017 +0000

    Use correct return type for getopt_long

    getopt_long returns an int. Fix the return type to avoid issues when
    checking for negative error codes on architectures with unsigned char,
    e.g., arm.

    Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>

diff --git a/cases/function/hwpoison/thugetlb.c b/cases/function/hwpoison/thugetlb.c
index 92dc7d2..fbcf426 100644
--- a/cases/function/hwpoison/thugetlb.c
+++ b/cases/function/hwpoison/thugetlb.c
@@ -125,7 +125,7 @@ int main(int argc, char *argv[])
        int forkflag = 0;
        int privateflag = 0;
        int cowflag = 0;
-   char c;
+ int c;
        pid_t pid = 0;
        void *expected_addr = NULL;
        struct sembuf sembuffer;
