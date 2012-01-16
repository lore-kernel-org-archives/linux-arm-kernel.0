From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 16 Jan 2012 18:02:16 +0000
Subject: [PATCH] ARM: alignment: Enable verbose fault messages for user
 BUS_ADRALN signals
Message-ID: <1326736936-27443-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A UDBG_BUS flag (1 << 4) is recognised for the user_debug= command
line option to the kernel, but currently this does not cause
anything to be printed for unhandled alignment faults delivered to
userspace.

This patch reports such faults to the kernel log when the UDBG_BUS
flag it set, in a similar way to the way other faults are already
reported.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/alignment.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index c335c76..3e1c616 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -922,6 +922,17 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		si.si_code = BUS_ADRALN;
 		si.si_addr = (void __user *)addr;
 
+#ifdef CONFIG_DEBUG_USER
+		if (user_debug & UDBG_BUS) {
+			printk(KERN_DEBUG "%s: alignment fault (%d) at 0x%08lx, code 0x%03x\n",
+			       current->comm, si.si_signo,
+			       (unsigned long)si.si_addr, fsr);
+
+			show_pte(current->mm, addr);
+			show_regs(regs);
+		}
+#endif
+
 		force_sig_info(si.si_signo, &si, current);
 	} else {
 		/*
-- 
1.7.4.1
