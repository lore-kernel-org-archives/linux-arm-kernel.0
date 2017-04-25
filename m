From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Tue, 25 Apr 2017 15:44:30 +0200
Subject: [PATCH v2 2/2] arm64: process: dump memory around registers when
 displaying regs
In-Reply-To: <20170425134430.5545-1-enric.balletbo@collabora.com>
References: <20170425134430.5545-1-enric.balletbo@collabora.com>
Message-ID: <20170425134430.5545-2-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Greg Hackmann <ghackmann@google.com>

Dump a block of kernel memory from around the registers in the kernel oops
dump. This is behind a config option (DEBUG_AROUND_REGS), since it adds
a bunch of noise to the kernel logs (which someone can find valuable but
not everyone else will).

This is extremely useful in diagnosing remote crashes, and is based heavily
on original work by Michael Davidson <md@google.com> and San Mehat
<san@google.com>.

Signed-off-by: Greg Hackmann <ghackmann@google.com>
[rework to use dump_mem]
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Same as 1/2 but for arm64 architecture.

Changes since v1:
 - Did not exists.
---
 arch/arm64/include/asm/traps.h |  3 +++
 arch/arm64/kernel/process.c    | 26 ++++++++++++++++++++++++++
 arch/arm64/kernel/traps.c      |  4 ++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index 02e9035..140f642 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -60,4 +60,7 @@ static inline int in_exception_text(unsigned long ptr)
 	return in ? : __in_irqentry_text(ptr);
 }
 
+void dump_mem(const char *lvl, const char *str, unsigned long bottom,
+	      unsigned long top);
+
 #endif
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index ae2a835..5ee2f48 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -58,6 +58,7 @@
 #include <asm/mmu_context.h>
 #include <asm/processor.h>
 #include <asm/stacktrace.h>
+#include <asm/traps.h>
 
 #ifdef CONFIG_CC_STACKPROTECTOR
 #include <linux/stackprotector.h>
@@ -170,6 +171,28 @@ void machine_restart(char *cmd)
 	while (1);
 }
 
+/*
+ * Dump a block of kernel memory from around the given address
+ */
+static void __show_regs_extra_data(struct pt_regs *regs, int nbytes)
+{
+#ifdef CONFIG_DEBUG_AROUND_REGS
+	int i;
+
+	dump_mem("", "PC ", regs->pc - nbytes, regs->pc + nbytes);
+	dump_mem("", "LR ", regs->regs[30] - nbytes, regs->regs[30] + nbytes);
+	dump_mem("", "SP ", regs->sp - nbytes, regs->sp + nbytes);
+
+	for (i = 0; i < 30; i++) {
+		char name[4];
+
+		snprintf(name, sizeof(name), "X%u", i);
+		dump_mem("", name, regs->regs[i] - nbytes,
+			 regs->regs[i] + nbytes);
+	}
+#endif
+}
+
 void __show_regs(struct pt_regs *regs)
 {
 	int i, top_reg;
@@ -205,6 +228,9 @@ void __show_regs(struct pt_regs *regs)
 
 		pr_cont("\n");
 	}
+
+	if (!user_mode(regs))
+		__show_regs_extra_data(regs, 128);
 }
 
 void show_regs(struct pt_regs * regs)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 1de444e..6d07675 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -59,8 +59,8 @@ int show_unhandled_signals = 1;
 /*
  * Dump out the contents of some kernel memory nicely...
  */
-static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
-		     unsigned long top)
+void dump_mem(const char *lvl, const char *str, unsigned long bottom,
+	      unsigned long top)
 {
 	unsigned long first;
 	mm_segment_t fs;
-- 
2.9.3
