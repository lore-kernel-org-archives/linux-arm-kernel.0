From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 24 Sep 2018 11:10:09 +0200
Subject: [REVIEW][PATCH 09/15] signal/arm64: Only call set_thread_esr once in
 do_page_fault
In-Reply-To: <871s9j462u.fsf@xmission.com>
References: <871s9j462u.fsf@xmission.com>
Message-ID: <20180924091015.4458-9-ebiederm@xmission.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This code is truly common between the signal sending cases so share it.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/arm64/mm/fault.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index ab85533e2255..959c4a565c8e 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -564,6 +564,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	}
 
 	inf = esr_to_fault_info(esr);
+	set_thread_esr(addr, esr);
 	if (fault & VM_FAULT_SIGBUS) {
 		/*
 		 * We had some memory, but were unable to successfully fix up
@@ -573,7 +574,6 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		si.si_signo	= SIGBUS;
 		si.si_code	= BUS_ADRERR;
 		si.si_addr = (void __user *)addr;
-		set_thread_esr(addr, esr);
 		arm64_force_sig_info(&si, inf->name);
 	} else if (fault & (VM_FAULT_HWPOISON_LARGE | VM_FAULT_HWPOISON)) {
 		unsigned int lsb;
@@ -587,7 +587,6 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		si.si_code	= BUS_MCEERR_AR;
 		si.si_addr = (void __user *)addr;
 		si.si_addr_lsb	= lsb;
-		set_thread_esr(addr, esr);
 		arm64_force_sig_info(&si, inf->name);
 	} else {
 		/*
@@ -599,7 +598,6 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		si.si_code	= fault == VM_FAULT_BADACCESS ?
 				  SEGV_ACCERR : SEGV_MAPERR;
 		si.si_addr = (void __user *)addr;
-		set_thread_esr(addr, esr);
 		arm64_force_sig_info(&si, inf->name);
 	}
 
-- 
2.17.1
