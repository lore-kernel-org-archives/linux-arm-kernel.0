From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Tue, 12 Dec 2017 00:05:36 +0800
Subject: [RESEND PATCH V2] arm64: fault: avoid send SIGBUS two times
Message-ID: <20171211160536.11600-1-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

do_sea() calls arm64_notify_die() which will always signal
user-space. It also returns whether APEI claimed the external
abort as a RAS notification. If it returns failure do_mem_abort()
will signal user-space too.

do_mem_abort() wants to know if we handled the error, we always
call arm64_notify_die() so can always return success.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
1. Address James's comments to update the commit messages
2. Address James's comments to not change the si_code for SIGBUS
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
@@ -640,7 +639,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 		info.si_addr  = (void __user *)addr;
 	arm64_notify_die("", regs, &info, esr);
 
-	return ret;
+	return 0;
 }
 
 static const struct fault_info fault_info[] = {
--
2.10.1
