From: houpengyang@huawei.com (Hou Pengyang)
Date: Tue, 28 Apr 2015 13:20:48 +0000
Subject: [PATCH] arm64: perf: Fix callchain parse error with kernel tracepoint
 events
Message-ID: <1430227248-19657-1-git-send-email-houpengyang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For ARM64, when tracing with tracepoint events, the IP and cpsr are set
to 0, preventing the perf code parsing the callchain and resolving the
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

For tracepoint event, stack parsing also doesn't work well for ARM. Jean Pihet
comed up a patch:
http://thread.gmane.org/gmane.linux.kernel/1734283/focus=1734280

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 arch/arm64/include/asm/perf_event.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index d26d1d5..16a074f 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -24,4 +24,20 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
 #define perf_misc_flags(regs)	perf_misc_flags(regs)
 #endif
 
+#define perf_arch_fetch_caller_regs(regs, __ip) { \
+   unsigned long sp;   \
+   __asm__ ("mov %[sp], sp\n" : [sp] "=r" (sp)); \
+       (regs)->pc = (__ip);    \
+       __asm__ (      \
+               "str %[sp],  %[_arm64_sp]  \n\t"    \
+               "str x29, %[_arm64_fp]  \n\t"    \
+               "mrs %[_arm64_cpsr], spsr_el1 \n\t"     \
+               : [_arm64_sp] "=m" (regs->sp),      \
+                 [_arm64_fp] "=m" (regs->regs[29]),  \
+                 [_arm64_cpsr] "=r" (regs->pstate) \
+       : [sp] "r" (sp)     \
+       );      \
+}
+
+
 #endif
-- 
1.8.3.4
