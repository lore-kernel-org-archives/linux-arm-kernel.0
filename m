From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 24 Sep 2018 11:10:07 +0200
Subject: [REVIEW][PATCH 07/15] signal/arm64: Expand __do_user_fault and remove
 it
In-Reply-To: <871s9j462u.fsf@xmission.com>
References: <871s9j462u.fsf@xmission.com>
Message-ID: <20180924091015.4458-7-ebiederm@xmission.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not all of the signals passed to __do_user_fault can be handled
the same way so expand the now tiny __do_user_fault in it's callers
and remove it.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/mm/fault.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 14d6ff895139..7df3d8b561c2 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -354,12 +354,6 @@ static void set_thread_esr(unsigned long address, unsigned int esr)
 	current->thread.fault_code = esr;
 }
 
-static void __do_user_fault(struct siginfo *info, unsigned int esr)
-{
-	set_thread_esr((unsigned long)info->si_addr, esr);
-	arm64_force_sig_info(info, esr_to_fault_info(esr)->name);
-}
-
 static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 {
 	/*
@@ -375,7 +369,8 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 		si.si_code	= inf->code;
 		si.si_addr	= (void __user *)addr;
 
-		__do_user_fault(&si, esr);
+		set_thread_esr(addr, esr);
+		arm64_force_sig_info(&si, inf->name);
 	} else {
 		__do_kernel_fault(addr, esr, regs);
 	}
@@ -576,7 +571,8 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		si.si_signo	= SIGBUS;
 		si.si_code	= BUS_ADRERR;
 		si.si_addr = (void __user *)addr;
-		__do_user_fault(&si, esr);
+		set_thread_esr(addr, esr);
+		arm64_force_sig_info(&si, esr_to_fault_info(esr)->name);
 	} else if (fault & (VM_FAULT_HWPOISON_LARGE | VM_FAULT_HWPOISON)) {
 		unsigned int lsb;
 
@@ -589,7 +585,8 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		si.si_code	= BUS_MCEERR_AR;
 		si.si_addr = (void __user *)addr;
 		si.si_addr_lsb	= lsb;
-		__do_user_fault(&si, esr);
+		set_thread_esr(addr, esr);
+		arm64_force_sig_info(&si, esr_to_fault_info(esr)->name);
 	} else {
 		/*
 		 * Something tried to access memory that isn't in our memory
@@ -600,7 +597,8 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		si.si_code	= fault == VM_FAULT_BADACCESS ?
 				  SEGV_ACCERR : SEGV_MAPERR;
 		si.si_addr = (void __user *)addr;
-		__do_user_fault(&si, esr);
+		set_thread_esr(addr, esr);
+		arm64_force_sig_info(&si, esr_to_fault_info(esr)->name);
 	}
 
 	return 0;
-- 
2.17.1
