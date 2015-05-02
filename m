From: houpengyang@huawei.com (Hou Pengyang)
Date: Sat, 2 May 2015 05:58:16 +0000
Subject: [PATCH v3 1/2] arm: perf: Fix callchain parse error with kernel
 tracepoint events
In-Reply-To: <1430546297-80481-1-git-send-email-houpengyang@huawei.com>
References: <1430546297-80481-1-git-send-email-houpengyang@huawei.com>
Message-ID: <1430546297-80481-2-git-send-email-houpengyang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For ARM, when tracing with tracepoint events, the IP and cpsr are set
to 0, preventing the perf code parsing the callchain and resolving the
symbols correctly.

 ./perf record -e sched:sched_switch -g --call-graph dwarf ls
    [ perf record: Captured and wrote 0.006 MB perf.data ]
 ./perf report -f
    Samples: 5  of event 'sched:sched_switch', Event count (approx.): 5 
    Children      Self    Command  Shared Object     Symbol
    100.00%       100.00%  ls       [unknown]         [.] 00000000

The fix is to implement perf_arch_fetch_caller_regs for ARM, which fills
several necessary registers used for callchain unwinding, including pc,sp,
fp and cpsr.

With this patch, callchain can be parsed correctly as :
	
   .....
-  100.00%   100.00%  ls       [kernel.kallsyms]  [k] __sched_text_start 
   + __sched_text_start 
+   20.00%     0.00%  ls       libc-2.18.so       [.] _dl_addr 
+   20.00%     0.00%  ls       libc-2.18.so       [.] write    
   .....

Jean Pihet found this in ARM and come up with a patch:
http://thread.gmane.org/gmane.linux.kernel/1734283/focus=1734280

This patch rewrite Jean's patch in C.

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 arch/arm/include/asm/perf_event.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
index d9cf138..4f9dec4 100644
--- a/arch/arm/include/asm/perf_event.h
+++ b/arch/arm/include/asm/perf_event.h
@@ -19,4 +19,11 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
 #define perf_misc_flags(regs)	perf_misc_flags(regs)
 #endif
 
+#define perf_arch_fetch_caller_regs(regs, __ip) { \
+	(regs)->ARM_pc = (__ip); \
+	(regs)->ARM_fp = (unsigned long) __builtin_frame_address(0); \
+	(regs)->ARM_sp = current_stack_pointer; \
+	(regs)->ARM_cpsr = SVC_MODE; \
+}
+
 #endif /* __ARM_PERF_EVENT_H__ */
-- 
1.8.3.4
