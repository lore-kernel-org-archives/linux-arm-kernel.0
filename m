From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 31 Oct 2017 15:50:54 +0000
Subject: [PATCH v5 02/30] arm64: fpsimd: Correctly annotate exception helpers
 called from asm
In-Reply-To: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
References: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1509465082-30427-3-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple of FPSIMD exception handling functions that are called
from entry.S are currently not annotated as such.

This is not a big deal since asmlinkage does nothing on arm/arm64,
but fixing the annotations is more consistent and may help avoid
future surprises.

This patch adds appropriate asmlinkage annotations for
do_fpsimd_acc() and do_fpsimd_exc().

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 5d547de..e851faa19 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -21,6 +21,7 @@
 #include <linux/cpu.h>
 #include <linux/cpu_pm.h>
 #include <linux/kernel.h>
+#include <linux/linkage.h>
 #include <linux/init.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
@@ -102,7 +103,7 @@ static DEFINE_PER_CPU(struct fpsimd_state *, fpsimd_last_state);
 /*
  * Trapped FP/ASIMD access.
  */
-void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
+asmlinkage void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
 {
 	/* TODO: implement lazy context saving/restoring */
 	WARN_ON(1);
@@ -111,7 +112,7 @@ void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
 /*
  * Raise a SIGFPE for the current process.
  */
-void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
+asmlinkage void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
 {
 	siginfo_t info;
 	unsigned int si_code = 0;
-- 
2.1.4
