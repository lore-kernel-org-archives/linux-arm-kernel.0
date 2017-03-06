From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  6 Mar 2017 11:26:14 +0000
Subject: [PATCH 09/17] arm64: arch_timer: Allows a CPU-specific erratum to
 only affect a subset of CPUs
In-Reply-To: <20170306112622.13853-1-marc.zyngier@arm.com>
References: <20170306112622.13853-1-marc.zyngier@arm.com>
Message-ID: <20170306112622.13853-10-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of applying a CPU-specific workaround to all CPUs in the system,
allow it to only affect a subset of them (typical big-little case).

This is done by turning the erratum pointer into a per-CPU variable.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/arch_timer.h  | 31 ++++++++++++++++----------
 drivers/clocksource/arm_arch_timer.c | 42 +++++++++++++++++++++++++-----------
 2 files changed, 50 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 7fbb55ded0c9..159513479f6e 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -25,6 +25,7 @@
 #include <linux/bug.h>
 #include <linux/init.h>
 #include <linux/jump_label.h>
+#include <linux/smp.h>
 #include <linux/types.h>
 
 #include <clocksource/arm_arch_timer.h>
@@ -56,17 +57,25 @@ struct arch_timer_erratum_workaround {
 	int (*set_next_event_virt)(unsigned long, struct clock_event_device *);
 };
 
-extern const struct arch_timer_erratum_workaround *timer_unstable_counter_workaround;
-
-#define arch_timer_reg_read_stable(reg) 		\
-({							\
-	u64 _val;					\
-	if (needs_unstable_timer_counter_workaround() &&		\
-	    timer_unstable_counter_workaround->read_##reg)		\
-		_val = timer_unstable_counter_workaround->read_##reg();	\
-	else						\
-		_val = read_sysreg(reg);		\
-	_val;						\
+DECLARE_PER_CPU(const struct arch_timer_erratum_workaround *,
+		timer_unstable_counter_workaround);
+
+#define arch_timer_reg_read_stable(reg)					\
+({									\
+	u64 _val;							\
+	if (needs_unstable_timer_counter_workaround()) {		\
+		const struct arch_timer_erratum_workaround *wa;		\
+		preempt_disable();					\
+		wa = __this_cpu_read(timer_unstable_counter_workaround); \
+		if (wa && wa->read_##reg)				\
+			_val = wa->read_##reg();			\
+		else							\
+			_val = read_sysreg(reg);			\
+		preempt_enable();					\
+	} else {							\
+		_val = read_sysreg(reg);				\
+	}								\
+	_val;								\
 })
 
 /*
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index ac0ddb380d3a..2bbe0b9c3c24 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -235,7 +235,8 @@ static u64 notrace hisi_161010101_read_cntvct_el0(void)
 #endif
 
 #ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
-const struct arch_timer_erratum_workaround *timer_unstable_counter_workaround = NULL;
+DEFINE_PER_CPU(const struct arch_timer_erratum_workaround *,
+	       timer_unstable_counter_workaround);
 EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
 
 DEFINE_STATIC_KEY_FALSE(arch_timer_read_ool_enabled);
@@ -345,9 +346,18 @@ arch_timer_iterate_errata(enum arch_timer_erratum_match_type type,
 }
 
 static
-void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa)
+void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa,
+				  bool local)
 {
-	timer_unstable_counter_workaround = wa;
+	int i;
+
+	if (local) {
+		__this_cpu_write(timer_unstable_counter_workaround, wa);
+	} else {
+		for_each_possible_cpu(i)
+			per_cpu(timer_unstable_counter_workaround, i) = wa;
+	}
+
 	static_branch_enable(&arch_timer_read_ool_enabled);
 }
 
@@ -376,14 +386,17 @@ static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type t
 		return;
 
 	if (static_branch_unlikely(&arch_timer_read_ool_enabled)) {
-		if (wa != timer_unstable_counter_workaround)
+		const struct arch_timer_erratum_workaround *__wa;
+		__wa = __this_cpu_read(timer_unstable_counter_workaround);
+		if (__wa && wa != __wa)
 			pr_warn("Can't enable workaround for %s (clashes with %s\n)",
-				wa->desc_str,
-				timer_unstable_counter_workaround->desc_str);
-		return;
+				wa->desc_str, __wa->desc_str);
+
+		if (__wa)
+			return;
 	}
 
-	arch_timer_enable_workaround(wa);
+	arch_timer_enable_workaround(wa, local);
 	pr_info("Enabling %s workaround for %s\n",
 		local ? "local" : "global", wa->desc_str);
 }
@@ -391,10 +404,15 @@ static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type t
 #define erratum_handler(fn, r, ...)					\
 ({									\
   	bool __val;							\
-	if (needs_unstable_timer_counter_workaround() &&		\
-	    timer_unstable_counter_workaround->fn) {			\
-		r = timer_unstable_counter_workaround->fn(__VA_ARGS__);	\
-		__val = true;						\
+	if (needs_unstable_timer_counter_workaround()) {		\
+		const struct arch_timer_erratum_workaround *__wa;	\
+		__wa = __this_cpu_read(timer_unstable_counter_workaround); \
+		if (__wa && __wa->fn) {					\
+			r = __wa->fn(__VA_ARGS__);			\
+			__val = true;					\
+		} else {						\
+			__val = false;					\
+		}							\
 	} else {							\
 		__val = false;						\
 	}								\
-- 
2.11.0
