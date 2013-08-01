From: dave.long@linaro.org (David Long)
Date: Thu,  1 Aug 2013 19:45:50 -0400
Subject: [PATCH 6/9] ARM: move shared uprobe/kprobe definitions into new
 include file
In-Reply-To: <1375400753-3454-1-git-send-email-dave.long@linaro.org>
References: <1375400753-3454-1-git-send-email-dave.long@linaro.org>
Message-ID: <1375400753-3454-7-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "David A. Long" <dave.long@linaro.org>

Separate the kprobe-only definitions from the definitions needed by
both kprobes and uprobes.

Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/include/asm/kprobes.h | 17 +----------------
 arch/arm/include/asm/probes.h  | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/include/asm/probes.h

diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
index f82ec22..53b1a80 100644
--- a/arch/arm/include/asm/kprobes.h
+++ b/arch/arm/include/asm/kprobes.h
@@ -27,22 +27,7 @@
 #define flush_insn_slot(p)		do { } while (0)
 #define kretprobe_blacklist_size	0
 
-typedef u32 kprobe_opcode_t;
-
-struct kprobe;
-typedef void (kprobe_insn_handler_t)(struct kprobe *, struct pt_regs *);
-typedef unsigned long (kprobe_check_cc)(unsigned long);
-typedef void (kprobe_insn_singlestep_t)(struct kprobe *, struct pt_regs *);
-typedef void (kprobe_insn_fn_t)(void);
-
-/* Architecture specific copy of original instruction. */
-struct arch_specific_insn {
-	kprobe_opcode_t			*insn;
-	kprobe_insn_handler_t		*insn_handler;
-	kprobe_check_cc			*insn_check_cc;
-	kprobe_insn_singlestep_t	*insn_singlestep;
-	kprobe_insn_fn_t		*insn_fn;
-};
+#include <asm/probes.h>
 
 struct prev_kprobe {
 	struct kprobe *kp;
diff --git a/arch/arm/include/asm/probes.h b/arch/arm/include/asm/probes.h
new file mode 100644
index 0000000..df46994
--- /dev/null
+++ b/arch/arm/include/asm/probes.h
@@ -0,0 +1,23 @@
+#ifndef _ASM_PROBES_H
+#define _ASM_PROBES_H
+
+#ifdef CONFIG_KPROBES
+typedef u32 kprobe_opcode_t;
+
+struct kprobe;
+typedef void (kprobe_insn_handler_t)(struct kprobe *, struct pt_regs *);
+typedef unsigned long (kprobe_check_cc)(unsigned long);
+typedef void (kprobe_insn_singlestep_t)(struct kprobe *, struct pt_regs *);
+typedef void (kprobe_insn_fn_t)(void);
+
+/* Architecture specific copy of original instruction. */
+struct arch_specific_insn {
+	kprobe_opcode_t			*insn;
+	kprobe_insn_handler_t		*insn_handler;
+	kprobe_check_cc			*insn_check_cc;
+	kprobe_insn_singlestep_t	*insn_singlestep;
+	kprobe_insn_fn_t		*insn_fn;
+};
+#endif
+
+#endif
-- 
1.8.1.2
