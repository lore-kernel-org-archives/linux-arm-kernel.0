From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 13 Feb 2015 13:40:53 +0800
Subject: [RFC PATCH v3 15/26] early kprobes: x86: directly modify code.
In-Reply-To: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
References: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423806053-62111-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When registering early kprobes, SMP should has not been enabled, so
doesn't require synchronization in text_poke_bp(). Simply memcpy is
enough.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/kernel/kprobes/opt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 0dd8d08..21847ab 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -36,6 +36,7 @@
 #include <asm/alternative.h>
 #include <asm/insn.h>
 #include <asm/debugreg.h>
+#include <asm/tlbflush.h>
 
 #include "common.h"
 
@@ -397,8 +398,15 @@ void arch_optimize_kprobes(struct list_head *oplist)
 		insn_buf[0] = RELATIVEJUMP_OPCODE;
 		*(s32 *)(&insn_buf[1]) = rel;
 
-		text_poke_bp(op->kp.addr, insn_buf, RELATIVEJUMP_SIZE,
-			     op->optinsn.insn);
+		if (unlikely(kprobes_is_early())) {
+			BUG_ON(!(op->kp.flags & KPROBE_FLAG_EARLY));
+			memcpy(op->kp.addr, insn_buf, RELATIVEJUMP_SIZE);
+			local_flush_tlb();
+			sync_core();
+		} else {
+			text_poke_bp(op->kp.addr, insn_buf, RELATIVEJUMP_SIZE,
+				     op->optinsn.insn);
+		}
 
 		list_del_init(&op->list);
 	}
-- 
1.8.4
