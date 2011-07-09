From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:56:59 +0100
Subject: [PATCH 12/51] ARM: kprobes: Add Thumb breakpoint support
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-13-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Extend the breakpoint insertion and catching functions to support Thumb
code.

As breakpoints are no longer of a fixed size, the flush_insns macro
is modified to take a size argument instead of an instruction count.

Note, we need both 16- and 32-bit Thumb breakpoints, because if we
were to use a 16-bit breakpoint to replace a 32-bit instruction which
was in an IT block, and the condition check failed, then the breakpoint
may not fire (it's unpredictable behaviour) and the CPU could then try
and execute the second half of the 32-bit Thumb instruction.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes.h |    7 ++-
 arch/arm/kernel/kprobes.c |  122 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 115 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kernel/kprobes.h b/arch/arm/kernel/kprobes.h
index 86abfab..a84b14d 100644
--- a/arch/arm/kernel/kprobes.h
+++ b/arch/arm/kernel/kprobes.h
@@ -18,10 +18,13 @@
 #define _ARM_KERNEL_KPROBES_H
 
 /*
- * This undefined instruction must be unique and
+ * These undefined instructions must be unique and
  * reserved solely for kprobes' use.
  */
-#define KPROBE_BREAKPOINT_INSTRUCTION	0xe7f001f8
+#define KPROBE_ARM_BREAKPOINT_INSTRUCTION	0xe7f001f8
+#define KPROBE_THUMB16_BREAKPOINT_INSTRUCTION	0xde18
+#define KPROBE_THUMB32_BREAKPOINT_INSTRUCTION	0xf7f0a018
+
 
 enum kprobe_insn {
 	INSN_REJECTED,
diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
index 0df2d6d..b8f5b3b 100644
--- a/arch/arm/kernel/kprobes.c
+++ b/arch/arm/kernel/kprobes.c
@@ -34,10 +34,10 @@
 	min((unsigned long)MAX_STACK_SIZE,		\
 	    (unsigned long)current_thread_info() + THREAD_START_SP - (addr))
 
-#define flush_insns(addr, cnt) 				\
+#define flush_insns(addr, size)				\
 	flush_icache_range((unsigned long)(addr),	\
 			   (unsigned long)(addr) +	\
-			   sizeof(kprobe_opcode_t) * (cnt))
+			   (size))
 
 /* Used as a marker in ARM_pc to note when we're in a jprobe. */
 #define JPROBE_MAGIC_ADDR		0xffffffff
@@ -86,7 +86,8 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 			return -ENOMEM;
 		for (is = 0; is < MAX_INSN_SIZE; ++is)
 			p->ainsn.insn[is] = tmp_insn[is];
-		flush_insns(p->ainsn.insn, MAX_INSN_SIZE);
+		flush_insns(p->ainsn.insn,
+				sizeof(p->ainsn.insn[0]) * MAX_INSN_SIZE);
 		break;
 
 	case INSN_GOOD_NO_SLOT:	/* instruction doesn't need insn slot */
@@ -97,24 +98,82 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	return 0;
 }
 
+#ifdef CONFIG_THUMB2_KERNEL
+
+/*
+ * For a 32-bit Thumb breakpoint spanning two memory words we need to take
+ * special precautions to insert the breakpoint atomically, especially on SMP
+ * systems. This is achieved by calling this arming function using stop_machine.
+ */
+int __kprobes set_t32_breakpoint(void *addr)
+{
+	((u16 *)addr)[0] = KPROBE_THUMB32_BREAKPOINT_INSTRUCTION >> 16;
+	((u16 *)addr)[1] = KPROBE_THUMB32_BREAKPOINT_INSTRUCTION & 0xffff;
+	flush_insns(addr, 2*sizeof(u16));
+	return 0;
+}
+
 void __kprobes arch_arm_kprobe(struct kprobe *p)
 {
-	*p->addr = KPROBE_BREAKPOINT_INSTRUCTION;
-	flush_insns(p->addr, 1);
+	uintptr_t addr = (uintptr_t)p->addr & ~1; /* Remove any Thumb flag */
+
+	if (!is_wide_instruction(p->opcode)) {
+		*(u16 *)addr = KPROBE_THUMB16_BREAKPOINT_INSTRUCTION;
+		flush_insns(addr, sizeof(u16));
+	} else if (addr & 2) {
+		/* A 32-bit instruction spanning two words needs special care */
+		stop_machine(set_t32_breakpoint, (void *)addr, &cpu_online_map);
+	} else {
+		/* Word aligned 32-bit instruction can be written atomically */
+		u32 bkp = KPROBE_THUMB32_BREAKPOINT_INSTRUCTION;
+#ifndef __ARMEB__ /* Swap halfwords for little-endian */
+		bkp = (bkp >> 16) | (bkp << 16);
+#endif
+		*(u32 *)addr = bkp;
+		flush_insns(addr, sizeof(u32));
+	}
 }
 
+#else /* !CONFIG_THUMB2_KERNEL */
+
+void __kprobes arch_arm_kprobe(struct kprobe *p)
+{
+	*p->addr = KPROBE_ARM_BREAKPOINT_INSTRUCTION;
+	flush_insns(p->addr, sizeof(p->addr[0]));
+}
+
+#endif /* !CONFIG_THUMB2_KERNEL */
+
 /*
  * The actual disarming is done here on each CPU and synchronized using
  * stop_machine. This synchronization is necessary on SMP to avoid removing
  * a probe between the moment the 'Undefined Instruction' exception is raised
  * and the moment the exception handler reads the faulting instruction from
- * memory.
+ * memory. It is also needed to atomically set the two half-words of a 32-bit
+ * Thumb breakpoint.
  */
 int __kprobes __arch_disarm_kprobe(void *p)
 {
 	struct kprobe *kp = p;
+#ifdef CONFIG_THUMB2_KERNEL
+	u16 *addr = (u16 *)((uintptr_t)kp->addr & ~1);
+	kprobe_opcode_t insn = kp->opcode;
+	unsigned int len;
+
+	if (is_wide_instruction(insn)) {
+		((u16 *)addr)[0] = insn>>16;
+		((u16 *)addr)[1] = insn;
+		len = 2*sizeof(u16);
+	} else {
+		((u16 *)addr)[0] = insn;
+		len = sizeof(u16);
+	}
+	flush_insns(addr, len);
+
+#else /* !CONFIG_THUMB2_KERNEL */
 	*kp->addr = kp->opcode;
-	flush_insns(kp->addr, 1);
+	flush_insns(kp->addr, sizeof(kp->addr[0]));
+#endif
 	return 0;
 }
 
@@ -167,11 +226,23 @@ void __kprobes kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p, *cur;
 	struct kprobe_ctlblk *kcb;
-	kprobe_opcode_t	*addr = (kprobe_opcode_t *)regs->ARM_pc;
 
 	kcb = get_kprobe_ctlblk();
 	cur = kprobe_running();
-	p = get_kprobe(addr);
+
+#ifdef CONFIG_THUMB2_KERNEL
+	/*
+	 * First look for a probe which was registered using an address with
+	 * bit 0 set, this is the usual situation for pointers to Thumb code.
+	 * If not found, fallback to looking for one with bit 0 clear.
+	 */
+	p = get_kprobe((kprobe_opcode_t *)(regs->ARM_pc | 1));
+	if (!p)
+		p = get_kprobe((kprobe_opcode_t *)regs->ARM_pc);
+
+#else /* ! CONFIG_THUMB2_KERNEL */
+	p = get_kprobe((kprobe_opcode_t *)regs->ARM_pc);
+#endif
 
 	if (p) {
 		if (cur) {
@@ -511,17 +582,44 @@ int __kprobes arch_trampoline_kprobe(struct kprobe *p)
 	return 0;
 }
 
-static struct undef_hook kprobes_break_hook = {
+#ifdef CONFIG_THUMB2_KERNEL
+
+static struct undef_hook kprobes_thumb16_break_hook = {
+	.instr_mask	= 0xffff,
+	.instr_val	= KPROBE_THUMB16_BREAKPOINT_INSTRUCTION,
+	.cpsr_mask	= MODE_MASK,
+	.cpsr_val	= SVC_MODE,
+	.fn		= kprobe_trap_handler,
+};
+
+static struct undef_hook kprobes_thumb32_break_hook = {
+	.instr_mask	= 0xffffffff,
+	.instr_val	= KPROBE_THUMB32_BREAKPOINT_INSTRUCTION,
+	.cpsr_mask	= MODE_MASK,
+	.cpsr_val	= SVC_MODE,
+	.fn		= kprobe_trap_handler,
+};
+
+#else  /* !CONFIG_THUMB2_KERNEL */
+
+static struct undef_hook kprobes_arm_break_hook = {
 	.instr_mask	= 0xffffffff,
-	.instr_val	= KPROBE_BREAKPOINT_INSTRUCTION,
+	.instr_val	= KPROBE_ARM_BREAKPOINT_INSTRUCTION,
 	.cpsr_mask	= MODE_MASK,
 	.cpsr_val	= SVC_MODE,
 	.fn		= kprobe_trap_handler,
 };
 
+#endif /* !CONFIG_THUMB2_KERNEL */
+
 int __init arch_init_kprobes()
 {
 	arm_kprobe_decode_init();
-	register_undef_hook(&kprobes_break_hook);
+#ifdef CONFIG_THUMB2_KERNEL
+	register_undef_hook(&kprobes_thumb16_break_hook);
+	register_undef_hook(&kprobes_thumb32_break_hook);
+#else
+	register_undef_hook(&kprobes_arm_break_hook);
+#endif
 	return 0;
 }
-- 
1.7.2.5
