From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Sat, 9 Dec 2017 09:15:32 +0800
Subject: [PATCH V2] arm64: fault: avoid send SIGBUS two times
Message-ID: <20171209011532.7300-1-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

do_sea() calls arm64_notify_die() which will always signal
user-space. It also returns whether APEI claimed the external
abort as a RAS notification. If it returns failure do_mem_abort()
will signal user-space too.

do_mem_abort() wants to know if we handled the error, we always
call arm64_notify_die() so can always return success.

The si_code BUS_MCEERR_AR can tell user-space there is a hardware
error that needs to be dealt with immediately

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 arch/arm64/mm/fault.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index b64958b..38b9f3e 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -610,7 +610,6 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 {
 	struct siginfo info;
 	const struct fault_info *inf;
-	int ret = 0;
 
 	inf = esr_to_fault_info(esr);
 	pr_err("Synchronous External Abort: %s (0x%08x) at 0x%016lx\n",
@@ -625,7 +624,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 		if (interrupts_enabled(regs))
 			nmi_enter();
 
-		ret = ghes_notify_sea();
+		ghes_notify_sea();
 
 		if (interrupts_enabled(regs))
 			nmi_exit();
@@ -633,14 +632,14 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 
 	info.si_signo = SIGBUS;
 	info.si_errno = 0;
-	info.si_code  = 0;
+	info.si_code  = BUS_MCEERR_AR;
 	if (esr & ESR_ELx_FnV)
 		info.si_addr = NULL;
 	else
 		info.si_addr  = (void __user *)addr;
 	arm64_notify_die("", regs, &info, esr);
 
-	return ret;
+	return 0;
 }
 
 static const struct fault_info fault_info[] = {
-- 
2.10.1
