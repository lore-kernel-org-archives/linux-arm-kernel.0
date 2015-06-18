From: panand@redhat.com (Pratyush Anand)
Date: Thu, 18 Jun 2015 09:28:50 +0530
Subject: [RFC PATCH V2 03/10] arm64: include asm-generic/ptrace.h in
 asm/ptrace.h
In-Reply-To: <cover.1434598237.git.panand@redhat.com>
References: <cover.1434598237.git.panand@redhat.com>
Message-ID: <271aaf7a2e73220232c45c8790fdfcd7278ee387.1434598237.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

instruction_pointer_set is needed for uprobe implementation.
asm-generic/ptrace.h already defines it. So include it in asm/ptrace.h.

But inclusion of asm-generic/ptrace.h, needs definition of GET_USP,
SET_USP, GET_FP & SET_FP as they are different than the generic
definition. So, define them in asm/ptrace.h.

user_stack_pointer, instruction_pointer and profile_pc have already been
defined by asm-generic/ptrace.h now, therefore remove them from asm/ptrace.h.

To modify instruction pointer in kprobe, use
instruction_pointer_set(regs, val) instead of instruction_pointer(regs)
= val, otherwise lvalue error.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/include/asm/ptrace.h          | 32 +++++++++++++++++++++++++-------
 arch/arm64/kernel/kprobes.c              | 13 +++++++------
 arch/arm64/kernel/probes-simulate-insn.c | 16 ++++++++--------
 3 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index aadf61a334eb..3ea7f5a04bfc 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -144,10 +144,6 @@ struct pt_regs {
 
 #define fast_interrupts_enabled(regs) \
 	(!((regs)->pstate & PSR_F_BIT))
-
-#define user_stack_pointer(regs) \
-	(!compat_user_mode(regs) ? (regs)->sp : (regs)->compat_sp)
-
 /**
  * regs_get_register() - get register value from its offset
  * @regs:	   pt_regs from which register value is gotten
@@ -206,13 +202,35 @@ static inline int valid_user_regs(struct user_pt_regs *regs)
 	return 0;
 }
 
-#define instruction_pointer(regs)	((regs)->pc)
+#define GET_USP(regs) \
+	(!compat_user_mode(regs) ? (regs)->sp : (regs)->compat_sp)
+
+#define SET_USP(regs, val)				\
+	do {						\
+		if (compat_user_mode(regs))		\
+			(regs)->compat_sp = val;	\
+		else					\
+			(regs)->sp = val;		\
+	} while (0)
+
+#define GET_FP(regs) \
+	(!compat_user_mode(regs) ? (regs)->regs[29] : (regs)->compat_fp)
+
+#define SET_FP(regs, val)				\
+	do {						\
+		if (compat_user_mode(regs))		\
+			(regs)->compat_fp = val;	\
+		else					\
+			(regs)->regs[29] = val;		\
+	} while (0)
+
+#include <asm-generic/ptrace.h>
+
 #define stack_pointer(regs)		((regs)->sp)
 
 #ifdef CONFIG_SMP
+#undef profile_pc
 extern unsigned long profile_pc(struct pt_regs *regs);
-#else
-#define profile_pc(regs) instruction_pointer(regs)
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm64/kernel/kprobes.c b/arch/arm64/kernel/kprobes.c
index 740f71695b07..6c9f8b5f04ce 100644
--- a/arch/arm64/kernel/kprobes.c
+++ b/arch/arm64/kernel/kprobes.c
@@ -228,7 +228,8 @@ static void __kprobes
 skip_singlestep_missed(struct kprobe_ctlblk *kcb, struct pt_regs *regs)
 {
 	/* set return addr to next pc to continue */
-	instruction_pointer(regs) += sizeof(kprobe_opcode_t);
+	instruction_pointer_set(regs,
+			instruction_pointer(regs) + sizeof(kprobe_opcode_t));
 }
 
 static void __kprobes setup_singlestep(struct kprobe *p,
@@ -257,7 +258,7 @@ static void __kprobes setup_singlestep(struct kprobe *p,
 		/* IRQs and single stepping do not mix well. */
 		kprobes_save_local_irqflag(regs);
 		kernel_enable_single_step(regs);
-		instruction_pointer(regs) = slot;
+		instruction_pointer_set(regs, slot);
 	} else	{
 		/* insn simulation */
 		arch_simulate_insn(p, regs);
@@ -304,7 +305,7 @@ post_kprobe_handler(struct kprobe_ctlblk *kcb, struct pt_regs *regs)
 
 	/* return addr restore if non-branching insn */
 	if (cur->ainsn.restore.type == RESTORE_PC) {
-		instruction_pointer(regs) = cur->ainsn.restore.addr;
+		instruction_pointer_set(regs, cur->ainsn.restore.addr);
 		if (!instruction_pointer(regs))
 			BUG();
 	}
@@ -341,7 +342,7 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
 		 * and allow the page fault handler to continue as a
 		 * normal page fault.
 		 */
-		instruction_pointer(regs) = (unsigned long)cur->addr;
+		instruction_pointer_set(regs, (unsigned long)cur->addr);
 		if (!instruction_pointer(regs))
 			BUG();
 		if (kcb->kprobe_status == KPROBE_REENTER)
@@ -507,7 +508,7 @@ int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 	memcpy(kcb->jprobes_stack, (void *)stack_ptr,
 	       MIN_STACK_SIZE(stack_ptr));
 
-	instruction_pointer(regs) = (long)jp->entry;
+	instruction_pointer_set(regs, (long)jp->entry);
 	preempt_disable();
 	return 1;
 }
@@ -633,7 +634,7 @@ static void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
 
 	kretprobe_assert(ri, orig_ret_addr, trampoline_address);
 	/* restore the original return address */
-	instruction_pointer(regs) = orig_ret_addr;
+	instruction_pointer_set(regs, orig_ret_addr);
 	reset_current_kprobe();
 	kretprobe_hash_unlock(current, &flags);
 
diff --git a/arch/arm64/kernel/probes-simulate-insn.c b/arch/arm64/kernel/probes-simulate-insn.c
index a224c91001d9..098b434ab6fc 100644
--- a/arch/arm64/kernel/probes-simulate-insn.c
+++ b/arch/arm64/kernel/probes-simulate-insn.c
@@ -92,7 +92,7 @@ simulate_adr_adrp(u32 opcode, long addr, struct pt_regs *regs)
 
 	regs->regs[xn] = val;
 
-	instruction_pointer(regs) += 4;
+	instruction_pointer_set(regs, instruction_pointer(regs) + 4);
 }
 
 void __kprobes
@@ -104,7 +104,7 @@ simulate_b_bl(u32 opcode, long addr, struct pt_regs *regs)
 	if (opcode & (1 << 31))
 		regs->regs[30] = addr + 4;
 
-	instruction_pointer(regs) = addr + disp;
+	instruction_pointer_set(regs, addr + disp);
 }
 
 void __kprobes
@@ -112,7 +112,7 @@ simulate_b_cond(u32 opcode, long addr, struct pt_regs *regs)
 {
 	int disp = bcond_displacement(opcode);
 
-	instruction_pointer(regs) = addr + disp;
+	instruction_pointer_set(regs, addr + disp);
 }
 
 void __kprobes
@@ -124,7 +124,7 @@ simulate_br_blr_ret(u32 opcode, long addr, struct pt_regs *regs)
 	if (((opcode >> 21) & 0x3) == 1)
 		regs->regs[30] = addr + 4;
 
-	instruction_pointer(regs) = regs->regs[xn];
+	instruction_pointer_set(regs, regs->regs[xn]);
 }
 
 void __kprobes
@@ -132,7 +132,7 @@ simulate_cbz_cbnz(u32 opcode, long addr, struct pt_regs *regs)
 {
 	int disp = cbz_displacement(opcode);
 
-	instruction_pointer(regs) = addr + disp;
+	instruction_pointer_set(regs, addr + disp);
 }
 
 void __kprobes
@@ -140,7 +140,7 @@ simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs)
 {
 	int disp = tbz_displacement(opcode);
 
-	instruction_pointer(regs) = addr + disp;
+	instruction_pointer_set(regs, addr + disp);
 }
 
 void __kprobes
@@ -157,7 +157,7 @@ simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs)
 	else			/* w0-w31 */
 		*(u32 *) (&regs->regs[xn]) = (*(u32 *) (load_addr));
 
-	instruction_pointer(regs) += 4;
+	instruction_pointer_set(regs, instruction_pointer(regs) + 4);
 }
 
 void __kprobes
@@ -170,5 +170,5 @@ simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs)
 	load_addr = (s32 *) (addr + disp);
 	regs->regs[xn] = *load_addr;
 
-	instruction_pointer(regs) += 4;
+	instruction_pointer_set(regs, instruction_pointer(regs) + 4);
 }
-- 
2.1.0
