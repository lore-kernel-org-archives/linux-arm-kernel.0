From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 23 Sep 2016 16:33:27 +0900
Subject: [PATCH v2 3/3] arm64: kgdb: disable interrupts while a software step
 is enabled
In-Reply-To: <20160923073327.9657-1-takahiro.akashi@linaro.org>
References: <20160923073327.9657-1-takahiro.akashi@linaro.org>
Message-ID: <20160923073327.9657-4-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After entering kgdb mode, 'stepi' may unexpectedly breaks the execution
somewhere in el1_irq.

This happens because a debug exception is always enabled in el1_irq
due to the following commit merged in v3.16:
  commit 2a2830703a23 ("arm64: debug: avoid accessing mdscr_el1 on fault
			paths where possible")
A pending interrupt can be taken after kgdb has enabled a software step,
but before a debug exception is actually taken.

This patch enforces interrupts to be masked while single stepping.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: <stable@vger.kernel.org> # 3.16-
---
 arch/arm64/kernel/kgdb.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 59c4aec..6732a27 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -26,6 +26,7 @@
 #include <linux/kgdb.h>
 #include <linux/kprobes.h>
 #include <linux/percpu.h>
+#include <asm/ptrace.h>
 #include <asm/traps.h>
 
 struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
@@ -109,6 +110,7 @@ struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
 	{ "fpcr", 4, -1 },
 };
 
+static DEFINE_PER_CPU(unsigned int, kgdb_pstate);
 static DEFINE_PER_CPU(struct irq_work, kgdb_irq_work);
 
 char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
@@ -198,6 +200,10 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		err = 0;
 		break;
 	case 's':
+		/* mask interrupts while single stepping */
+		__this_cpu_write(kgdb_pstate, linux_regs->pstate);
+		linux_regs->pstate |= PSR_I_BIT;
+
 		/*
 		 * Update step address value with address passed
 		 * with step packet.
@@ -239,9 +245,18 @@ NOKPROBE_SYMBOL(kgdb_compiled_brk_fn);
 
 static int kgdb_step_brk_fn(struct pt_regs *regs, unsigned int esr)
 {
+	unsigned int pstate;
+
 	kernel_disable_single_step();
 	atomic_set(&kgdb_cpu_doing_single_step, -1);
 
+	/* restore interrupt mask status */
+	pstate = __this_cpu_read(kgdb_pstate);
+	if (pstate & PSR_I_BIT)
+		regs->pstate |= PSR_I_BIT;
+	else
+		regs->pstate &= ~PSR_I_BIT;
+
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
 	return 0;
 }
-- 
2.10.0
