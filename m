From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 26 Jul 2011 15:14:46 +0100
Subject: [PATCH 1/2] ARM: alignment: Make SIGBUS sent to userspace POSIXly
	correct
Message-ID: <1311689686-7451-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the UM_SIGNAL alignment fault mode, no siginfo structure is
passed to userspace.

POSIX specifies how siginfo_t should be populated for alignment
faults, so this patch does just that:

  * si_signo = SIGBUS
  * si_code = BUS_ADRALN
  * si_addr = address of the faulted instruction

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/alignment.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 724ba3b..9a65aaf 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -22,6 +22,7 @@
 #include <linux/sched.h>
 #include <linux/uaccess.h>
 
+#include <asm/system.h>
 #include <asm/unaligned.h>
 
 #include "fault.h"
@@ -883,9 +884,16 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (ai_usermode & UM_FIXUP)
 		goto fixup;
 
-	if (ai_usermode & UM_SIGNAL)
-		force_sig(SIGBUS, current);
-	else {
+	if (ai_usermode & UM_SIGNAL) {
+		siginfo_t si;
+
+		si.si_signo = SIGBUS;
+		si.si_errno = 0;
+		si.si_code = BUS_ADRALN;
+		si.si_addr = (void __user *)instruction_pointer(regs);
+
+		force_sig_info(si.si_signo, &si, current);
+	} else {
 		/*
 		 * We're about to disable the alignment trap and return to
 		 * user space.  But if an interrupt occurs before actually
-- 
1.7.4.1
