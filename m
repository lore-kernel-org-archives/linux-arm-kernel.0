From: panand@redhat.com (Pratyush Anand)
Date: Mon,  6 Jul 2015 10:33:22 +0530
Subject: [PATCH 2/2] arm64: Make all entry code as non-kprobe-able
In-Reply-To: <cover.1436158027.git.panand@redhat.com>
References: <cover.1436158027.git.panand@redhat.com>
Message-ID: <683f80cef9b2b778be868e77b01a245585448a86.1436158027.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Entry symbols are not kprobe safe. So blacklist them for kprobing.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/kernel/entry.S       | 3 +++
 arch/arm64/kernel/kprobes.c     | 9 +++++++++
 arch/arm64/kernel/vmlinux.lds.S | 1 +
 3 files changed, 13 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index a7691a378668..2ea24f6bc06b 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -202,6 +202,7 @@ tsk	.req	x28		// current thread_info
  * Exception vectors.
  */
 
+	.section ".entry.text", "ax"
 	.align	11
 ENTRY(vectors)
 	ventry	el1_sync_invalid		// Synchronous EL1t
@@ -737,3 +738,5 @@ ENTRY(sys_rt_sigreturn_wrapper)
 	mov	x0, sp
 	b	sys_rt_sigreturn
 ENDPROC(sys_rt_sigreturn_wrapper)
+
+	.section ".text", "ax"
diff --git a/arch/arm64/kernel/kprobes.c b/arch/arm64/kernel/kprobes.c
index 6c9f8b5f04ce..9bc02c151f7f 100644
--- a/arch/arm64/kernel/kprobes.c
+++ b/arch/arm64/kernel/kprobes.c
@@ -28,6 +28,7 @@
 #include <asm/debug-monitors.h>
 #include <asm/system_misc.h>
 #include <asm/insn.h>
+#include <asm-generic/sections.h>
 
 #include "kprobes.h"
 #include "kprobes-arm64.h"
@@ -661,6 +662,14 @@ int __kprobes arch_trampoline_kprobe(struct kprobe *p)
 	return 0;
 }
 
+bool arch_within_kprobe_blacklist(unsigned long addr)
+{
+	return  (addr >= (unsigned long)__kprobes_text_start &&
+		 addr < (unsigned long)__kprobes_text_end) ||
+		(addr >= (unsigned long)__entry_text_start &&
+		 addr < (unsigned long)__entry_text_end);
+}
+
 int __init arch_init_kprobes(void)
 {
 	return 0;
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 1fa6adc7aa83..11fb2b0117d0 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -97,6 +97,7 @@ SECTIONS
 			*(.exception.text)
 			__exception_text_end = .;
 			IRQENTRY_TEXT
+			ENTRY_TEXT
 			TEXT_TEXT
 			SCHED_TEXT
 			LOCK_TEXT
-- 
2.4.3
