From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 11 Aug 2017 16:17:41 +0200
Subject: [PATCH 5/5] clocksource/drivers/arm_arch_timer: Avoid infinite
 recursion when ftrace is enabled
In-Reply-To: <1502461061-28065-1-git-send-email-daniel.lezcano@linaro.org>
References: <20170811141520.GA795@mai>
 <1502461061-28065-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1502461061-28065-5-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ding Tianhong <dingtianhong@huawei.com>

On platforms with an arch timer erratum workaround, it's possible for
arch_timer_reg_read_stable() to recurse into itself when certain
tracing options are enabled, leading to stack overflows and related
problems.

For example, when PREEMPT_TRACER and FUNCTION_GRAPH_TRACER are
selected, it's possible to trigger this with:

$ mount -t debugfs nodev /sys/kernel/debug/
$ echo function_graph > /sys/kernel/debug/tracing/current_tracer

The problem is that in such cases, preempt_disable() instrumentation
attempts to acquire a timestamp via trace_clock(), resulting in a call
back to arch_timer_reg_read_stable(), and hence recursion.

This patch changes arch_timer_reg_read_stable() to use
preempt_{disable,enable}_notrace(), which avoids this.

This problem is similar to the fixed by upstream commit 96b3d28bf4
("sched/clock: Prevent tracing recursion in sched_clock_cpu()").

Fixes: 6acc71ccac71 ("arm64: arch_timer: Allows a CPU-specific erratum to only affect a subset of CPUs")
Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/include/asm/arch_timer.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 74d08e4..a652ce0 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -65,13 +65,13 @@ DECLARE_PER_CPU(const struct arch_timer_erratum_workaround *,
 	u64 _val;							\
 	if (needs_unstable_timer_counter_workaround()) {		\
 		const struct arch_timer_erratum_workaround *wa;		\
-		preempt_disable();					\
+		preempt_disable_notrace();				\
 		wa = __this_cpu_read(timer_unstable_counter_workaround); \
 		if (wa && wa->read_##reg)				\
 			_val = wa->read_##reg();			\
 		else							\
 			_val = read_sysreg(reg);			\
-		preempt_enable();					\
+		preempt_enable_notrace();				\
 	} else {							\
 		_val = read_sysreg(reg);				\
 	}								\
-- 
2.7.4
