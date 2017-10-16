From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Oct 2017 16:28:39 +0100
Subject: [PATCH 2/2] clocksource: arm_arch_timer: fix DEFINE_PER_CPU expansion
In-Reply-To: <20171016152839.14964-1-mark.rutland@arm.com>
References: <20171016152839.14964-1-mark.rutland@arm.com>
Message-ID: <20171016152839.14964-3-mark.rutland@arm.com>
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

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/clocksource/arm_arch_timer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 14e2419063e9..0ecf5beb56ec 100644
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
2.11.0
