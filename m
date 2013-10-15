From: dave.long@linaro.org (David Long)
Date: Tue, 15 Oct 2013 17:04:21 -0400
Subject: [PATCH v2 06/13] ARM: move shared uprobe/kprobe definitions into new
 include file
In-Reply-To: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
Message-ID: <1381871068-27660-7-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "David A. Long" <dave.long@linaro.org>

Separate the kprobe-only definitions from the definitions needed by
both kprobes and uprobes.

Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/include/asm/kprobes.h | 15 +--------------
 arch/arm/include/asm/probes.h  | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/include/asm/probes.h

diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
index f82ec22..30fc11b 100644
--- a/arch/arm/include/asm/kprobes.h
+++ b/arch/arm/include/asm/kprobes.h
@@ -28,21 +28,8 @@
 #define kretprobe_blacklist_size	0
 
 typedef u32 kprobe_opcode_t;
-
 struct kprobe;
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
index 0000000..21da148
--- /dev/null
+++ b/arch/arm/include/asm/probes.h
@@ -0,0 +1,18 @@
+#ifndef _ASM_PROBES_H
+#define _ASM_PROBES_H
+
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
+
+#endif
-- 
1.8.1.2
