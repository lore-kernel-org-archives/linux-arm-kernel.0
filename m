From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Wed, 13 Dec 2017 18:36:47 +0800
Subject: [PATCH v3] arm64: fault: avoid send SIGBUS two times
Message-ID: <1513161407-42112-1-git-send-email-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

do_sea() calls arm64_notify_die() which will always signal
user-space. It also returns whether APEI claimed the external
abort as a RAS notification. If it returns failure do_mem_abort()
will signal user-space too.

do_mem_abort() wants to know if we handled the error, we always
call arm64_notify_die() so can always return success.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Reviewed-by: James Morse <james.morse@arm.com>
Reviewed-by: Xie XiuQi <xiexiuqi@huawei.com>
---
Change since V2:
1. Address James's comments to not change the si_code for SIGBUS

Change since V1:
1. Address James's comments to update the commit messages
---
 arch/arm64/mm/fault.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 22168cd..9b7f89d 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -574,7 +574,6 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 {
 	struct siginfo info;
 	const struct fault_info *inf;
-	int ret = 0;
 
 	inf = esr_to_fault_info(esr);
 	pr_err("Synchronous External Abort: %s (0x%08x) at 0x%016lx\n",
@@ -589,7 +588,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 		if (interrupts_enabled(regs))
 			nmi_enter();
 
-		ret = ghes_notify_sea();
+		ghes_notify_sea();
 
 		if (interrupts_enabled(regs))
 			nmi_exit();
@@ -604,7 +603,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 		info.si_addr  = (void __user *)addr;
 	arm64_notify_die("", regs, &info, esr);
 
-	return ret;
+	return 0;
 }
 
 static const struct fault_info fault_info[] = {
-- 
1.9.1
