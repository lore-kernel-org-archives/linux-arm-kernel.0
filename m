From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:24:52 +0800
Subject: [RFC PATCH v4 14/34] early kprobes: use stop_machine() based x86
 optimizer.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-15-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use stop_machine() to wrap code modification for x86 when optimizing
early kprobes. Since early kprobes are registered before smp inited,
text_poke_bp() is not ready at that time. This patch use stop_machine()
based code modification for early kprobes.

At very early stage, stop_machine() is simply irq operations. After
kprobes fully initianized, we will use text_poke_bp(). Only kprobes
registered after cpu_stop_init() before init_kprobes() will use real
stop_machine().

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/kernel/kprobes/opt.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 7b3b9d1..ef3c0be 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -28,6 +28,7 @@
 #include <linux/kdebug.h>
 #include <linux/kallsyms.h>
 #include <linux/ftrace.h>
+#include <linux/stop_machine.h>
 
 #include <asm/cacheflush.h>
 #include <asm/desc.h>
@@ -377,6 +378,20 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
 	return 0;
 }
 
+struct optimize_kprobe_early_param {
+	struct optimized_kprobe *op;
+	u8 *insn_buf;
+};
+
+static int optimize_kprobe_stop_machine(void *data)
+{
+	struct optimize_kprobe_early_param *param = data;
+
+	text_poke_early(param->op->kp.addr,
+			param->insn_buf, RELATIVEJUMP_SIZE);
+	return 0;
+}
+
 /*
  * Replace breakpoints (int3) with relative jumps.
  * Caller must call with locking kprobe_mutex and text_mutex.
@@ -399,8 +414,17 @@ void arch_optimize_kprobes(struct list_head *oplist)
 		insn_buf[0] = RELATIVEJUMP_OPCODE;
 		*(s32 *)(&insn_buf[1]) = rel;
 
-		text_poke_bp(op->kp.addr, insn_buf, RELATIVEJUMP_SIZE,
-			     op->optinsn.insn);
+		if (unlikely(kprobes_is_early())) {
+			struct optimize_kprobe_early_param p = {
+				.op = op,
+				.insn_buf = insn_buf,
+			};
+
+			stop_machine(optimize_kprobe_stop_machine, &p, NULL);
+		} else {
+			text_poke_bp(op->kp.addr, insn_buf, RELATIVEJUMP_SIZE,
+				     op->optinsn.insn);
+		}
 
 		list_del_init(&op->list);
 	}
-- 
1.8.4
