From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 29 Oct 2017 22:20:31 +0100
Subject: [PATCH 14/17] clocksource/drivers/arm_arch_timer: Fix DEFINE_PER_CPU
 expansion
In-Reply-To: <1509312035-17368-1-git-send-email-daniel.lezcano@linaro.org>
References: <c4d8b83b-b884-415b-8c92-b195de1dae7f@linaro.org>
 <1509312035-17368-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1509312035-17368-14-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

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
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 14e2419..0ecf5be 100644
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
2.7.4
