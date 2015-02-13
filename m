From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 13 Feb 2015 13:40:48 +0800
Subject: [RFC PATCH v3 13/26] early kprobes: ARM: directly modify code.
In-Reply-To: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
References: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423806048-62028-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For early kprobe, we can simply patch text because we are in a relative
simple environment.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/arm/probes/kprobes/opt-arm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
index bcdecc2..43446df 100644
--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -330,8 +330,18 @@ void __kprobes arch_optimize_kprobes(struct list_head *oplist)
 		 * Similar to __arch_disarm_kprobe, operations which
 		 * removing breakpoints must be wrapped by stop_machine
 		 * to avoid racing.
+		 *
+		 * If this function is called before kprobes initialized,
+		 * the kprobe should be an early kprobe, the instruction
+		 * is not armed with breakpoint. There should be only
+		 * one core now, so directly __patch_text is enough.
 		 */
-		kprobes_remove_breakpoint(op->kp.addr, insn);
+		if (unlikely(kprobes_is_early())) {
+			BUG_ON(!(op->kp.flags & KPROBE_FLAG_EARLY));
+			__patch_text(op->kp.addr, insn);
+		} else {
+			kprobes_remove_breakpoint(op->kp.addr, insn);
+		}
 
 		list_del_init(&op->list);
 	}
-- 
1.8.4
