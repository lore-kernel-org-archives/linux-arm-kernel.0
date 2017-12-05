From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Tue, 5 Dec 2017 23:02:35 +0800
Subject: [PATCH RESEND] arm64: fault: avoid send SIGBUS two times
Message-ID: <20171205150235.46325-1-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If APEI handling the memory error is failed, the do_mem_abort()
and do_sea() will all deliver SIGBUS. In fact, sending one time
can be enough, so correct it.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 arch/arm64/mm/fault.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index fcf2ede3..9e3f7ca 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -570,7 +570,6 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 {
 	struct siginfo info;
 	const struct fault_info *inf;
-	int ret = 0;
 
 	inf = esr_to_fault_info(esr);
 	pr_err("Synchronous External Abort: %s (0x%08x) at 0x%016lx\n",
@@ -585,7 +584,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 		if (interrupts_enabled(regs))
 			nmi_enter();
 
-		ret = ghes_notify_sea();
+		ghes_notify_sea();
 
 		if (interrupts_enabled(regs))
 			nmi_exit();
@@ -600,7 +599,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 		info.si_addr  = (void __user *)addr;
 	arm64_notify_die("", regs, &info, esr);
 
-	return ret;
+	return 0;
 }
 
 static const struct fault_info fault_info[] = {
-- 
2.10.1
