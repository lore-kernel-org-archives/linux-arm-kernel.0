From: yalin.wang2010@gmail.com (yalin wang)
Date: Mon, 18 May 2015 10:46:23 +0800
Subject: [RFC] arm:consider THUMB and BE endian kernel build
Message-ID: <5559527F.9090300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch fix the function in kernel_thread(),
when kernel is build as THUMB2 or BE8 endian, we should
also set the correct bit in CPSR, so that kernel can return to
the correct state to execute.
---
  arch/arm/kernel/process.c | 6 ++++++
  1 file changed, 6 insertions(+)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index f192a2a..9a7ab32 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -220,6 +220,12 @@ copy_thread(unsigned long clone_flags, unsigned 
long stack_start,
  		thread->cpu_context.r4 = stk_sz;
  		thread->cpu_context.r5 = stack_start;
  		childregs->ARM_cpsr = SVC_MODE;
+#ifdef CONFIG_THUMB2_KERNEL
+		childregs->ARM_cpsr |= PSR_T_BIT;
+#endif
+#ifdef CONFIG_CPU_ENDIAN_BE8
+		childregs->ARM_cpsr |= PSR_E_BIT;
+#endif
  	}
  	thread->cpu_context.pc = (unsigned long)ret_from_fork;
  	thread->cpu_context.sp = (unsigned long)childregs;
-- 
1.9.1
