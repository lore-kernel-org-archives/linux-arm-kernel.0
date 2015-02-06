From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 6 Feb 2015 18:30:55 +0800
Subject: [RFC PATCH] x86: kprobes: enable optmize relative call insn
In-Reply-To: <54B540A8.1020804@hitachi.com>
References: <54B540A8.1020804@hitachi.com>
Message-ID: <1423218655-30394-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In reply to Masami Hiramatsu's question on my previous early kprobe
patch series at:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315771.html

that on x86, early kprobe's applications range is limited by the type of
optimizable instructions, I made this patch, which enables optimizing
relative call instructions by introducing specific template for them.
Such instructions make up about 7% of the kernel. In addition, when
ftrace is enabled, funtion entry will be it, so early kprobe will be
much useful than before.

The relationship between ftrace and kprobe is interesting. Under normal
circumstances, kprobe utilizes ftrace. However, under early case,
there's no way to tell whether the probing instruction is an ftrace
entry. Another possible method on that is to move part of ftrace init
ahead. However, to allow optimize more instructions should also be
good for performance.

Masami, I'd like to hear your reply on it. Do you think this patch is
also useful for the normal cases?

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/include/asm/kprobes.h | 17 +++++++--
 arch/x86/kernel/kprobes/opt.c  | 82 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 94 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 017f4bb..3627694 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -31,6 +31,7 @@
 #define RELATIVEJUMP_OPCODE 0xe9
 #define RELATIVEJUMP_SIZE 5
 #define RELATIVECALL_OPCODE 0xe8
+#define RELATIVECALL_SIZE 5
 #define RELATIVE_ADDR_SIZE 4
 #define MAX_STACK_SIZE 64
 #define MAX_OPTIMIZED_LENGTH (MAX_INSN_SIZE + RELATIVE_ADDR_SIZE)
@@ -38,8 +39,10 @@
 #ifdef __ASSEMBLY__
 
 #define KPROBE_OPCODE_SIZE     1
+#define OPT_CALL_TEMPLATE_SIZE (optprobe_call_template_end - \
+		optprobe_call_template_entry)
 #define MAX_OPTINSN_SIZE ((optprobe_template_end - optprobe_template_entry) + \
-	MAX_OPTIMIZED_LENGTH + RELATIVEJUMP_SIZE)
+	MAX_OPTIMIZED_LENGTH + RELATIVEJUMP_SIZE + OPT_CALL_TEMPLATE_SIZE)
 
 #ifdef CONFIG_EARLY_KPROBES
 # define EARLY_KPROBES_CODES_AREA					\
@@ -81,10 +84,20 @@ extern __visible kprobe_opcode_t optprobe_template_entry;
 extern __visible kprobe_opcode_t optprobe_template_val;
 extern __visible kprobe_opcode_t optprobe_template_call;
 extern __visible kprobe_opcode_t optprobe_template_end;
+
+extern __visible kprobe_opcode_t optprobe_call_template_entry;
+extern __visible kprobe_opcode_t optprobe_call_template_val_destaddr;
+extern __visible kprobe_opcode_t optprobe_call_template_val_retaddr;
+extern __visible kprobe_opcode_t optprobe_call_template_end;
+
+#define OPT_CALL_TEMPLATE_SIZE				\
+	((unsigned long)&optprobe_call_template_end -	\
+	 (unsigned long)&optprobe_call_template_entry)
 #define MAX_OPTINSN_SIZE 				\
 	(((unsigned long)&optprobe_template_end -	\
 	  (unsigned long)&optprobe_template_entry) +	\
-	 MAX_OPTIMIZED_LENGTH + RELATIVEJUMP_SIZE)
+	 MAX_OPTIMIZED_LENGTH + RELATIVEJUMP_SIZE +	\
+	 OPT_CALL_TEMPLATE_SIZE)
 
 extern const int kretprobe_blacklist_size;
 
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index dc5fccb..05dd06f 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -39,6 +39,23 @@
 
 #include "common.h"
 
+static inline bool
+is_relcall(u8 *addr)
+{
+	return (*(u8 *)(addr) == RELATIVECALL_OPCODE);
+}
+
+static inline void *
+get_relcall_target(u8 *addr)
+{
+	struct __arch_relative_insn {
+		u8 op;
+		s32 raddr;
+	} __packed *insn;
+	insn = (struct __arch_relative_insn *)addr;
+	return (void *)((unsigned long)addr + RELATIVECALL_SIZE + insn->raddr);
+}
+
 unsigned long __recover_optprobed_insn(kprobe_opcode_t *buf, unsigned long addr)
 {
 	struct optimized_kprobe *op;
@@ -89,6 +106,48 @@ static void synthesize_set_arg1(kprobe_opcode_t *addr, unsigned long val)
 }
 
 asm (
+#ifdef CONFIG_X86_64
+			".global optprobe_call_template_entry\n"
+			"optprobe_call_template_entry:"
+			"pushq %rdi\n"
+			".global optprobe_call_template_val_destaddr\n"
+			"optprobe_call_template_val_destaddr:"
+			ASM_NOP5
+			ASM_NOP5
+			"pushq %rdi\n"
+			".global optprobe_call_template_val_retaddr\n"
+			"optprobe_call_template_val_retaddr:"
+			ASM_NOP5
+			ASM_NOP5
+			"xchgq %rdi, 8(%rsp)\n"
+			"retq\n"
+#else /* CONFIG_X86_32 */
+			".global optprobe_call_template_entry\n"
+			"optprobe_call_template_entry:"
+			"push %edi\n"
+			".global optprobe_call_template_val_destaddr\n"
+			"optprobe_call_template_val_destaddr:"
+			ASM_NOP5
+			"push %edi\n"
+			".global optprobe_call_template_val_retaddr\n"
+			"optprobe_call_template_val_retaddr:"
+			ASM_NOP5
+			"xchg %edi, 4(%esp)\n"
+			"ret\n"
+#endif
+			".global optprobe_call_template_end\n"
+			"optprobe_call_template_end:\n"
+);
+
+#define __OPTCALL_TMPL_MOVE_DESTADDR_IDX \
+	((long)&optprobe_call_template_val_destaddr - (long)&optprobe_call_template_entry)
+#define __OPTCALL_TMPL_MOVE_RETADDR_IDX \
+	((long)&optprobe_call_template_val_retaddr - (long)&optprobe_call_template_entry)
+#define __OPTCALL_TMPL_END_IDX \
+	((long)&optprobe_call_template_end - (long)&optprobe_call_template_entry)
+#define OPTCALL_TMPL_SIZE	__OPTCALL_TMPL_END_IDX
+
+asm (
 			".global optprobe_template_entry\n"
 			"optprobe_template_entry:\n"
 #ifdef CONFIG_X86_64
@@ -135,6 +194,10 @@ asm (
 #define TMPL_END_IDX \
 	((long)&optprobe_template_end - (long)&optprobe_template_entry)
 
+#define TMPL_OPTCALL_MOVE_DESTADDR_IDX	(TMPL_END_IDX + __OPTCALL_TMPL_MOVE_DESTADDR_IDX)
+#define TMPL_OPTCALL_MOVE_RETADDR_IDX	(TMPL_END_IDX + __OPTCALL_TMPL_MOVE_RETADDR_IDX)
+#define TMPL_OPTCALL_END_IDX	(TMPL_END_IDX + __OPTCALL_TMPL_END_IDX)
+
 #define INT3_SIZE sizeof(kprobe_opcode_t)
 
 /* Optimized kprobe call back function: called from optinsn */
@@ -175,6 +238,12 @@ static int copy_optimized_instructions(u8 *dest, u8 *src)
 {
 	int len = 0, ret;
 
+	if (is_relcall(src)) {
+		memcpy(dest, &optprobe_call_template_entry,
+				OPTCALL_TMPL_SIZE);
+		return OPTCALL_TMPL_SIZE;
+	}
+
 	while (len < RELATIVEJUMP_SIZE) {
 		ret = __copy_instruction(dest + len, src + len);
 		if (!ret || !can_boost(dest + len))
@@ -365,9 +434,16 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
 	/* Set probe function call */
 	synthesize_relcall(buf + TMPL_CALL_IDX, optimized_callback);
 
-	/* Set returning jmp instruction@the tail of out-of-line buffer */
-	synthesize_reljump(buf + TMPL_END_IDX + op->optinsn.size,
-			   (u8 *)op->kp.addr + op->optinsn.size);
+	if (!is_relcall(op->kp.addr)) {
+		/* Set returning jmp instruction at the tail of out-of-line buffer */
+		synthesize_reljump(buf + TMPL_END_IDX + op->optinsn.size,
+				(u8 *)op->kp.addr + op->optinsn.size);
+	} else {
+		synthesize_set_arg1(buf + TMPL_OPTCALL_MOVE_DESTADDR_IDX,
+				(unsigned long)(get_relcall_target(op->kp.addr)));
+		synthesize_set_arg1(buf + TMPL_OPTCALL_MOVE_RETADDR_IDX,
+				(unsigned long)(op->kp.addr + RELATIVECALL_SIZE));
+	}
 
 	flush_icache_range((unsigned long) buf,
 			   (unsigned long) buf + TMPL_END_IDX +
-- 
1.8.4
