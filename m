From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Wed,  3 May 2017 16:37:46 +0100
Subject: [PATCH v2 2/4] arm64: hw_breakpoint: fix watchpoint matching for
 tagged pointers
In-Reply-To: <1493825868-30872-1-git-send-email-kristina.martsenko@arm.com>
References: <1493825868-30872-1-git-send-email-kristina.martsenko@arm.com>
Message-ID: <1493825868-30872-3-git-send-email-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we take a watchpoint exception, the address that triggered the
watchpoint is found in FAR_EL1. We compare it to the address of each
configured watchpoint to see which one was hit.

The configured watchpoint addresses are untagged, while the address in
FAR_EL1 will have an address tag if the data access was done using a
tagged address. The tag needs to be removed to compare the address to
the watchpoints.

Currently we don't remove it, and as a result can report the wrong
watchpoint as being hit (specifically, always either the highest TTBR0
watchpoint or lowest TTBR1 watchpoint). This patch removes the tag.

Fixes: d50240a5f6ce ("arm64: mm: permit use of tagged pointers at EL0")
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/uaccess.h  | 6 +++---
 arch/arm64/kernel/hw_breakpoint.c | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 5308d696311b..0221029e27ff 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -106,9 +106,9 @@ static inline void set_fs(mm_segment_t fs)
 })
 
 /*
- * When dealing with data aborts or instruction traps we may end up with
- * a tagged userland pointer. Clear the tag to get a sane pointer to pass
- * on to access_ok(), for instance.
+ * When dealing with data aborts, watchpoints, or instruction traps we may end
+ * up with a tagged userland pointer. Clear the tag to get a sane pointer to
+ * pass on to access_ok(), for instance.
  */
 #define untagged_addr(addr)		sign_extend64(addr, 55)
 
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 0296e7924240..749f81779420 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -36,6 +36,7 @@
 #include <asm/traps.h>
 #include <asm/cputype.h>
 #include <asm/system_misc.h>
+#include <asm/uaccess.h>
 
 /* Breakpoint currently in use for each BRP. */
 static DEFINE_PER_CPU(struct perf_event *, bp_on_reg[ARM_MAX_BRP]);
@@ -721,6 +722,8 @@ static u64 get_distance_from_watchpoint(unsigned long addr, u64 val,
 	u64 wp_low, wp_high;
 	u32 lens, lene;
 
+	addr = untagged_addr(addr);
+
 	lens = __ffs(ctrl->len);
 	lene = __fls(ctrl->len);
 
-- 
2.1.4
