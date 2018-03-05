From: dianders@chromium.org (Douglas Anderson)
Date: Mon,  5 Mar 2018 15:43:09 -0800
Subject: [PATCH v2] arm64/debug: Fix registers on sleeping tasks
Message-ID: <20180305234309.233226-1-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the equivalent of commit 001bf455d206 ("ARM: 8428/1: kgdb: Fix
registers on sleeping tasks") but for arm64.  Nuff said.

...well, perhaps I could also add that task_pt_regs are userspace
registers and that's not what kgdb is supposed to be reporting.  We're
supposed to be reporting kernel registers.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Init cpu_context in one line
- Explain that task_pt_regs are userspace

 arch/arm64/kernel/kgdb.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 2122cd187f19..a20de58061a8 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -138,14 +138,25 @@ int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
 void
 sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *task)
 {
-	struct pt_regs *thread_regs;
+	struct cpu_context *cpu_context = &task->thread.cpu_context;
 
 	/* Initialize to zero */
 	memset((char *)gdb_regs, 0, NUMREGBYTES);
-	thread_regs = task_pt_regs(task);
-	memcpy((void *)gdb_regs, (void *)thread_regs->regs, GP_REG_BYTES);
-	/* Special case for PSTATE (check comments in asm/kgdb.h for details) */
-	dbg_get_reg(33, gdb_regs + GP_REG_BYTES, thread_regs);
+
+	gdb_regs[19] = cpu_context->x19;
+	gdb_regs[20] = cpu_context->x20;
+	gdb_regs[21] = cpu_context->x21;
+	gdb_regs[22] = cpu_context->x22;
+	gdb_regs[23] = cpu_context->x23;
+	gdb_regs[24] = cpu_context->x24;
+	gdb_regs[25] = cpu_context->x25;
+	gdb_regs[26] = cpu_context->x26;
+	gdb_regs[27] = cpu_context->x27;
+	gdb_regs[28] = cpu_context->x28;
+	gdb_regs[29] = cpu_context->fp;
+
+	gdb_regs[31] = cpu_context->sp;
+	gdb_regs[32] = cpu_context->pc;
 }
 
 void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
-- 
2.16.2.395.g2e18187dfd-goog
