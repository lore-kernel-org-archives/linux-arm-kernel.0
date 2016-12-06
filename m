From: james.morse@arm.com (James Morse)
Date: Tue,  6 Dec 2016 19:04:53 +0000
Subject: [stable:PATCH 2/3] arm64: mm: Set PSTATE.PAN from the
 cpu_enable_pan() call [v4.8]
In-Reply-To: <20161206190454.19083-1-james.morse@arm.com>
References: <20161206190454.19083-1-james.morse@arm.com>
Message-ID: <20161206190454.19083-3-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 7209c868600bd8926e37c10b9aae83124ccc1dd8 upstream.

Commit 338d4f49d6f7 ("arm64: kernel: Add support for Privileged Access
Never") enabled PAN by enabling the 'SPAN' feature-bit in SCTLR_EL1.
This means the PSTATE.PAN bit won't be set until the next return to the
kernel from userspace. On a preemptible kernel we may schedule work that
accesses userspace on a CPU before it has done this.

Now that cpufeature enable() calls are scheduled via stop_machine(), we
can set PSTATE.PAN from the cpu_enable_pan() call.

Add WARN_ON_ONCE(in_interrupt()) to check the PSTATE value we updated
is not immediately discarded.

Reported-by: Tony Thompson <anthony.thompson@arm.com>
Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
[will: fixed typo in comment]
Signed-off-by: Will Deacon <will.deacon@arm.com>

Signed-off-by: James Morse <james.morse@arm.com>
Cc: <stable@vger.kernel.org> # 4.8.12
---
 arch/arm64/mm/fault.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 2001ebd12666..67506c3c5476 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -29,7 +29,9 @@
 #include <linux/sched.h>
 #include <linux/highmem.h>
 #include <linux/perf_event.h>
+#include <linux/preempt.h>
 
+#include <asm/bug.h>
 #include <asm/cpufeature.h>
 #include <asm/exception.h>
 #include <asm/debug-monitors.h>
@@ -673,7 +675,14 @@ NOKPROBE_SYMBOL(do_debug_exception);
 #ifdef CONFIG_ARM64_PAN
 int cpu_enable_pan(void *__unused)
 {
+	/*
+	 * We modify PSTATE. This won't work from irq context as the PSTATE
+	 * is discarded once we return from the exception.
+	 */
+	WARN_ON_ONCE(in_interrupt());
+
 	config_sctlr_el1(SCTLR_EL1_SPAN, 0);
+	asm(SET_PSTATE_PAN(1));
 	return 0;
 }
 #endif /* CONFIG_ARM64_PAN */
-- 
2.10.1
