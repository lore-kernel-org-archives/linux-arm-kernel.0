From: sramana@codeaurora.org (Srinivas Ramana)
Date: Fri,  2 Dec 2016 13:44:55 +0530
Subject: [PATCH] trace: extend trace_clock to support arch_arm clock counter
Message-ID: <1480666495-26536-1-git-send-email-sramana@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the trace_clock to support the arch timer cycle
counter so that we can get the monotonic cycle count
in the traces. This will help in correlating the traces with the
timestamps/events in other subsystems in the soc which share
this common counter for driving their timers.

Signed-off-by: Srinivas Ramana <sramana@codeaurora.org>
---
 arch/arm64/include/asm/Kbuild        |  1 -
 arch/arm64/include/asm/trace_clock.h | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/trace_clock.h

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 44e1d7f10add..c943e9c9823a 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -41,7 +41,6 @@ generic-y += swab.h
 generic-y += switch_to.h
 generic-y += termbits.h
 generic-y += termios.h
-generic-y += trace_clock.h
 generic-y += types.h
 generic-y += unaligned.h
 generic-y += user.h
diff --git a/arch/arm64/include/asm/trace_clock.h b/arch/arm64/include/asm/trace_clock.h
new file mode 100644
index 000000000000..dc9af640738d
--- /dev/null
+++ b/arch/arm64/include/asm/trace_clock.h
@@ -0,0 +1,20 @@
+#ifndef _ASM_ARM64_TRACE_CLOCK_H
+#define _ASM_ARM64_TRACE_CLOCK_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <asm/arch_timer.h>
+
+/*
+ * trace_clock_arm64_count_vct(): A clock that is just the cycle counter.
+ * Unlike the other clocks, this is not in nanoseconds.
+ */
+static inline u64 notrace trace_clock_arm64_count_vct(void)
+{
+	return arch_counter_get_cntvct();
+}
+
+# define ARCH_TRACE_CLOCKS \
+	{ trace_clock_arm64_count_vct,	"arm64-count-vct",	0 },
+
+#endif  /* _ASM_ARM64_TRACE_CLOCK_H */
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., 
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
