From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 17 May 2017 17:10:41 +0100
Subject: [PATCH] clocksource: arm_arch_timer: fix DEFINE_PER_CPU expansion
Message-ID: <1495037441-11211-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our ctags mangling script can't handle newlines inside of a
DEFINE_PER_CPU(), leading to an annoying message whenever tags are
built:

  ctags: Warning: drivers/clocksource/arm_arch_timer.c:302: null expansion of name pattern "\1"

This was dealt with elsewhere in commit:

  25528213fe9f75f4 ("tags: Fix DEFINE_PER_CPU expansions")

... by ensuring each DEFINE_PER_CPU() was contained on a single line,
even where this would violate the usual code style (checkpatch warnings
and all).

Let's do the same for the arch timer driver, and get rid of the
distraction.

Fixes: 6acc71ccac7187fc ("arm64: arch_timer: Allows a CPU-specific erratum to only affect a subset of CPUs")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/clocksource/arm_arch_timer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Daniel/Thomas, this fixes a small bit of fallout from the recent merge window.
Would it be possible to pick it up as a fix for v4.12?

Thanks,
Mark.

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 4bed671..21669ec 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -299,8 +299,7 @@ static u64 notrace arm64_858921_read_cntvct_el0(void)
 #endif
 
 #ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
-DEFINE_PER_CPU(const struct arch_timer_erratum_workaround *,
-	       timer_unstable_counter_workaround);
+DEFINE_PER_CPU(const struct arch_timer_erratum_workaround *, timer_unstable_counter_workaround);
 EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
 
 DEFINE_STATIC_KEY_FALSE(arch_timer_read_ool_enabled);
-- 
1.9.1
