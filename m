From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:25:04 +0800
Subject: [RFC PATCH v4 26/34] early kprobes on ftrace: x86: arch code for
 retrieving kprobed instruction.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-27-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch_kprobe_on_ftrace_get_old_insn() is for retriving kprobed
instrution, which is for ftrace used. When ftrace trying to make call,
it compares original instruction against exoected instruction (usually
nop), and deny to work if they are different. This newly introduced
function returns the bytes pattern of kprobe probed instruction. It
doesn't re-read the bytes and returns it to ftrace. Instead, it
regenerates the probed instruction for comparing.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/kernel/kprobes/core.c | 22 ++++++++++++++++++++++
 arch/x86/kernel/kprobes/opt.c  | 19 ++++++++++++++-----
 include/linux/kprobes.h        |  6 ++++++
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index ead5b51..87beb64 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1159,4 +1159,26 @@ void arch_fix_ftrace_early_kprobe(struct kprobe *kp,
 	}
 }
 
+const unsigned char *arch_kprobe_on_ftrace_get_old_insn(struct kprobe *kp,
+		const unsigned char *ftrace_nop,
+		unsigned char *dest, size_t insn_size)
+{
+	u8 brkp[] = {BREAKPOINT_INSTRUCTION};
+	struct optimized_kprobe *op;
+
+	if (kp->flags & KPROBE_FLAG_OPTIMIZED) {
+#ifndef CONFIG_OPTPROBES
+		BUG_ON(1);
+#else
+		op = container_of(kp, struct optimized_kprobe, kp);
+		arch_optimize_kprobes_genbranch(op, dest, insn_size);
+		return dest;
+#endif
+	}
+
+	memcpy(dest, brkp, INT3_SIZE);
+	memcpy(dest + INT3_SIZE, ftrace_nop + INT3_SIZE,
+			insn_size - INT3_SIZE);
+	return dest;
+}
 #endif
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index ef3c0be..9b54148 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -392,6 +392,19 @@ static int optimize_kprobe_stop_machine(void *data)
 	return 0;
 }
 
+const unsigned char *arch_optimize_kprobes_genbranch(struct optimized_kprobe *op,
+		unsigned char *insn_buf, size_t buf_length)
+{
+	s32 rel = (s32)((long)op->optinsn.insn -
+			((long)op->kp.addr + RELATIVEJUMP_SIZE));
+
+	BUG_ON(buf_length < RELATIVEJUMP_SIZE);
+
+	insn_buf[0] = RELATIVEJUMP_OPCODE;
+	*(s32 *)(&insn_buf[1]) = rel;
+	return insn_buf;
+}
+
 /*
  * Replace breakpoints (int3) with relative jumps.
  * Caller must call with locking kprobe_mutex and text_mutex.
@@ -402,8 +415,7 @@ void arch_optimize_kprobes(struct list_head *oplist)
 	u8 insn_buf[RELATIVEJUMP_SIZE];
 
 	list_for_each_entry_safe(op, tmp, oplist, list) {
-		s32 rel = (s32)((long)op->optinsn.insn -
-			((long)op->kp.addr + RELATIVEJUMP_SIZE));
+		arch_optimize_kprobes_genbranch(op, insn_buf, RELATIVEJUMP_SIZE);
 
 		WARN_ON(kprobe_disabled(&op->kp));
 
@@ -411,9 +423,6 @@ void arch_optimize_kprobes(struct list_head *oplist)
 		memcpy(op->optinsn.copied_insn, op->kp.addr + INT3_SIZE,
 		       RELATIVE_ADDR_SIZE);
 
-		insn_buf[0] = RELATIVEJUMP_OPCODE;
-		*(s32 *)(&insn_buf[1]) = rel;
-
 		if (unlikely(kprobes_is_early())) {
 			struct optimize_kprobe_early_param p = {
 				.op = op,
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index ab1a330..5a5290f 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -276,10 +276,16 @@ extern bool arch_within_kprobe_blacklist(unsigned long addr);
  * its pointer in function decl list.
  */
 struct optimized_kprobe;
+#ifdef CONFIG_OPTPROBES
+extern const unsigned char *arch_optimize_kprobes_genbranch(struct optimized_kprobe *op,
+		unsigned char *insn_buf, size_t buf_length);
+#endif
 
 #if defined(CONFIG_EARLY_KPROBES) && defined(CONFIG_KPROBES_ON_FTRACE)
 extern void arch_fix_ftrace_early_kprobe(struct kprobe *kp,
 		struct optimized_kprobe *op, int optimized);
+extern const unsigned char *arch_kprobe_on_ftrace_get_old_insn(struct kprobe *kp,
+		const unsigned char *ftrace_nop, unsigned char *dest, size_t insn_size);
 
 extern void init_kprobes_on_ftrace(void);
 extern bool kprobe_fix_ftrace_make_nop(struct dyn_ftrace *rec);
-- 
1.8.4
