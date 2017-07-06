From: dingtianhong@huawei.com (Ding Tianhong)
Date: Thu, 6 Jul 2017 20:49:33 +0800
Subject: [PATCH] arm64: arch_timer: fix the infinite recursion when enable
 ftrace and erratum workaround
Message-ID: <43ec809d-b8f2-eb73-8ad6-9966cf67625f@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When enable preempt and ftrace, and perform the following steps, the system will hang:
mount -t debugfs nodev /sys/kernel/debug/
cd /sys/kernel/debug/tracing/
echo function_graph > current_tracer

This is because the preempt_disable and preempt_enable calls would cause infinite
recursion for some chips which needs the timer erratum workaround and the system
will hang, so use the preempt_disable/enable_notrace calls to prevent recursion.

Fixes: 6acc71ccac71 ("arm64: arch_timer: Allows a CPU-specific erratum to only affect a subset of CPUs")
Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
 arch/arm64/include/asm/arch_timer.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 74d08e4..67bb7a4 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -65,13 +65,13 @@ struct arch_timer_erratum_workaround {
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
1.9.0
