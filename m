From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Apr 2017 09:44:41 +0100
Subject: [PATCH] arm64: mm: unaligned access by user-land should be
 received as SIGBUS
In-Reply-To: <alpine.LRH.2.00.1704052252320.45451@sjc-ads-6991.cisco.com>
References: <1491198314-17025-1-git-send-email-kamensky@cisco.com>
 <1491198314-17025-2-git-send-email-kamensky@cisco.com>
 <20170403092430.GA5706@arm.com>
 <alpine.LRH.2.00.1704052252320.45451@sjc-ads-6991.cisco.com>
Message-ID: <20170406084440.GA18204@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Victor,

On Wed, Apr 05, 2017 at 11:01:45PM -0700, Victor Kamensky wrote:
> On Mon, 3 Apr 2017, Will Deacon wrote:
> >On Sun, Apr 02, 2017 at 10:45:14PM -0700, Victor Kamensky wrote:
> >>After 52d7523 (arm64: mm: allow the kernel to handle alignment faults on
> >>user accesses) commit user-land accesses that produce unaligned exceptions
> >>like in case of aarch32 ldm/stm/ldrd/strd instructions operating on
> >>unaligned memory received by user-land as SIGSEGV. It is wrong, it should
> >>be reported as SIGBUS as it was before 52d7523 commit.
> >>
> >>Changed do_bad_area function to take signal and code parameters, so caller
> >>can pass them down properly depending on fault type, as SIGSEGV in case of
> >>do_translation_fault and SIGBUS in case of do_alignment_fault.
> >>
> >>Signed-off-by: Victor Kamensky <kamensky@cisco.com>
> >>Cc: xe-linux-external at cisco.com
> >>Fixes: 52d7523 (arm64: mm: allow the kernel to handle alignment faults on user accesses)
> >>---
> >> arch/arm64/mm/fault.c | 9 +++++----
> >> 1 file changed, 5 insertions(+), 4 deletions(-)
> >>
> >>diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> >>index 4bf899f..204eb58 100644
> >>--- a/arch/arm64/mm/fault.c
> >>+++ b/arch/arm64/mm/fault.c
> >>@@ -215,7 +215,8 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
> >> 	force_sig_info(sig, &si, tsk);
> >> }
> >>
> >>-static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *regs)
> >>+static void do_bad_area(unsigned long addr, unsigned int esr,
> >>+			struct pt_regs *regs, int sig, int code)
> >> {
> >> 	struct task_struct *tsk = current;
> >> 	struct mm_struct *mm = tsk->active_mm;
> >>@@ -225,7 +226,7 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
> >> 	 * handle this fault with.
> >> 	 */
> >> 	if (user_mode(regs))
> >>-		__do_user_fault(tsk, addr, esr, SIGSEGV, SEGV_MAPERR, regs);
> >>+		__do_user_fault(tsk, addr, esr, sig, code, regs);
> >> 	else
> >> 		__do_kernel_fault(mm, addr, esr, regs);
> >> }
> >>@@ -469,14 +470,14 @@ static int __kprobes do_translation_fault(unsigned long addr,
> >> 	if (addr < TASK_SIZE)
> >> 		return do_page_fault(addr, esr, regs);
> >>
> >>-	do_bad_area(addr, esr, regs);
> >>+	do_bad_area(addr, esr, regs, SIGSEGV, SEGV_MAPERR);
> >> 	return 0;
> >> }
> >>
> >> static int do_alignment_fault(unsigned long addr, unsigned int esr,
> >> 			      struct pt_regs *regs)
> >> {
> >>-	do_bad_area(addr, esr, regs);
> >>+	do_bad_area(addr, esr, regs, SIGBUS,  BUS_ADRALN);
> >
> >Can we not just extract the signal number and code from the fault info
> >table?
> >
> >E.g. leave the type signature of do_bad_area like it is, but do:
> >
> >	const struct fault_info *inf = fault_info + (esr & 63);
> >	__do_user_fault(tsk, addr, esr, inf->sig, inf->code, regs);
> >
> >The '& 63' is ugly as hell, so maybe wrap that up in a esr_to_fault_info
> >function and kill the fault_name thing we have at the moment.
> 
> Could you please take a look at [1]. I've tried to reimplement the
> fix following your suggestion.

Yup, I picked this up here already:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=fixes/core

Thanks,

Will
