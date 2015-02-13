From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 13 Feb 2015 13:41:13 +0800
Subject: [RFC PATCH v3 23/26] early kprobes: x86:
 arch_restore_optimized_kprobe().
In-Reply-To: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
References: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423806073-62441-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch_restore_optimized_kprobe() can be used to temporarily restore
probed instruction. It will actually disable optimized kprobe, but keep
the relatived data structure. It uses stop_machine() to enforce
atimicity.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/kernel/kprobes/opt.c | 26 ++++++++++++++++++++++++++
 include/linux/kprobes.h       |  1 +
 2 files changed, 27 insertions(+)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index f3ea954..12332c2 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -28,6 +28,7 @@
 #include <linux/kdebug.h>
 #include <linux/kallsyms.h>
 #include <linux/ftrace.h>
+#include <linux/stop_machine.h>
 
 #include <asm/cacheflush.h>
 #include <asm/desc.h>
@@ -486,4 +487,29 @@ void arch_fix_ftrace_early_kprobe(struct optimized_kprobe *op)
 		memcpy(&list_p->opcode, correct_nop5, sizeof(kprobe_opcode_t));
 
 }
+
+static int do_restore_kprobe(void *p)
+{
+	struct optimized_kprobe *op = p;
+	u8 insn_buf[RELATIVEJUMP_SIZE];
+
+	memcpy(insn_buf, &op->kp.opcode, sizeof(kprobe_opcode_t));
+	memcpy(insn_buf + INT3_SIZE,
+			op->optinsn.copied_insn,
+			RELATIVE_ADDR_SIZE);
+	text_poke(op->kp.addr, insn_buf, RELATIVEJUMP_SIZE);
+	return 0;
+}
+
+void arch_restore_optimized_kprobe(struct optimized_kprobe *op)
+{
+	u32 mask = KPROBE_FLAG_EARLY |
+		KPROBE_FLAG_OPTIMIZED |
+		KPROBE_FLAG_FTRACE;
+
+	if ((op->kp.flags & mask) != mask)
+		return;
+
+	stop_machine(do_restore_kprobe, op, NULL);
+}
 #endif
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e483f1b..e615402 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -462,6 +462,7 @@ extern int arch_prepare_kprobe_ftrace(struct kprobe *p);
 
 #ifdef CONFIG_EARLY_KPROBES
 extern void arch_fix_ftrace_early_kprobe(struct optimized_kprobe *p);
+extern void arch_restore_optimized_kprobe(struct optimized_kprobe *p);
 #endif
 
 #endif
-- 
1.8.4
