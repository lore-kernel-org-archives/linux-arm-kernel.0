From: houpengyang@huawei.com (Hou Pengyang)
Date: Thu, 30 Apr 2015 13:58:52 +0000
Subject: [PATCH v2] arm & arm64: perf: Fix callchain parse error with kernel
 tracepoint events
Message-ID: <1430402332-52750-1-git-send-email-houpengyang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For ARM & ARM64, when tracing with tracepoint events, the IP and cpsr are 
set to 0, preventing the perf code parsing the callchain and resolving the 
symbols correctly.

 ./perf record -e sched:sched_switch -g --call-graph dwarf ls
    [ perf record: Captured and wrote 0.146 MB perf.data ]
 ./perf report -f
    Samples: 194  of event 'sched:sched_switch', Event count (approx.): 194 
    Children      Self    Command  Shared Object     Symbol
    100.00%       100.00%  ls       [unknown]         [.] 0000000000000000

The fix is to implement perf_arch_fetch_caller_regs for ARM64, which fills
several necessary registers used for callchain unwinding, including pc,sp,
fp and psr .

With this patch, callchain can be parsed correctly as follows:

     ......
+    2.63%     0.00%  ls       [kernel.kallsyms]  [k] vfs_symlink
+    2.63%     0.00%  ls       [kernel.kallsyms]  [k] follow_down
+    2.63%     0.00%  ls       [kernel.kallsyms]  [k] pfkey_get
+    2.63%     0.00%  ls       [kernel.kallsyms]  [k] do_execveat_common.isra.33
-    2.63%     0.00%  ls       [kernel.kallsyms]  [k] pfkey_send_policy_notify
     pfkey_send_policy_notify
     pfkey_get
     v9fs_vfs_rename
     page_follow_link_light
     link_path_walk
     el0_svc_naked
    .......

Jean Pihet found this in ARM and come up with a patch:
http://thread.gmane.org/gmane.linux.kernel/1734283/focus=1734280

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 arch/arm/include/asm/perf_event.h   | 7 +++++++
 arch/arm64/include/asm/perf_event.h | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
index d9cf138..17705e2b 100644
--- a/arch/arm/include/asm/perf_event.h
+++ b/arch/arm/include/asm/perf_event.h
@@ -19,4 +19,11 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
 #define perf_misc_flags(regs)	perf_misc_flags(regs)
 #endif
 
+#define perf_arch_fetch_caller_regs(regs, __ip) { \
+    (regs)->ARM_pc = (__ip); \
+    (regs)->ARM_fp = (unsigned long) __builtin_frame_address(0); \
+    (regs)->ARM_sp = current_stack_pointer; \
+    (regs)->ARM_cpsr |= SYSTEM_MODE; \
+}
+
 #endif /* __ARM_PERF_EVENT_H__ */
diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index d26d1d5..e6911a4 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -24,4 +24,11 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
 #define perf_misc_flags(regs)	perf_misc_flags(regs)
 #endif
	 
+#define perf_arch_fetch_caller_regs(regs, __ip) { \
+    (regs)->ARM_pc = (__ip);    \
+    (regs)->ARM_fp = (unsigned long) __builtin_frame_address(0); \
+    (regs)->ARM_sp = current_stack_pointer; \
+    (regs)->ARM_cpsr |= PSR_MODE_EL1h;	\
+}
+
 #endif
-- 
1.8.5.2
