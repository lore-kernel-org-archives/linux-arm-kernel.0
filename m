From: james.morse@arm.com (James Morse)
Date: Fri,  2 Dec 2016 16:42:47 +0000
Subject: [stable:PATCH 3/3] arm64: suspend: Reconfigure PSTATE after resume
 from idle [v4.4]
In-Reply-To: <20161202164247.19496-1-james.morse@arm.com>
References: <20161202164247.19496-1-james.morse@arm.com>
Message-ID: <20161202164247.19496-4-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit d08544127d9fb4505635e3cb6871fd50a42947bd upstream.

The suspend/resume path in kernel/sleep.S, as used by cpu-idle, does not
save/restore PSTATE. As a result of this cpufeatures that were detected
and have bits in PSTATE get lost when we resume from idle.

PAN will be re-enabled next time we return from user-space, but on a
preemptible kernel we may run work accessing user space before this point.

Add code to re-enable this feature in __cpu_suspend_exit().

Signed-off-by: James Morse <james.morse@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>

[Removed UAO hooks and commit-message references: this feature is not
 present in v4.4]

Signed-off-by: James Morse <james.morse@arm.com>
Cc: <stable@vger.kernel.org> # 4.4.35
---
 arch/arm64/kernel/suspend.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index 1095aa483a1c..00c1372bf57b 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -1,7 +1,9 @@
 #include <linux/ftrace.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
+#include <asm/alternative.h>
 #include <asm/cacheflush.h>
+#include <asm/cpufeature.h>
 #include <asm/debug-monitors.h>
 #include <asm/pgtable.h>
 #include <asm/memory.h>
@@ -111,6 +113,13 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 		set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
 
 		/*
+		 * PSTATE was not saved over suspend/resume, re-enable any
+		 * detected features that might not have been set correctly.
+		 */
+		asm(ALTERNATIVE("nop", SET_PSTATE_PAN(1), ARM64_HAS_PAN,
+				CONFIG_ARM64_PAN));
+
+		/*
 		 * Restore HW breakpoint registers to sane values
 		 * before debug exceptions are possibly reenabled
 		 * through local_dbg_restore.
-- 
2.10.1
