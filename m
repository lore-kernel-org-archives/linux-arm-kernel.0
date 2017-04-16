From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 16 Apr 2017 22:27:00 +0200
Subject: [PATCH 10/29] arm64: arch_timer: Rework the set_next_event workarounds
In-Reply-To: <1492374441-23336-1-git-send-email-daniel.lezcano@linaro.org>
References: <20170416202542.GV2078@mai>
 <1492374441-23336-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1492374441-23336-10-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

The way we work around errata affecting set_next_event is not very
nice, at it imposes this workaround on errata that do not need it.

Add new workaround hooks and let the existing workarounds use them.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/arch_timer.h  |  4 ++++
 drivers/clocksource/arm_arch_timer.c | 31 ++++++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 1b0d7e9..cc1e081 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -42,6 +42,8 @@ enum arch_timer_erratum_match_type {
 	ate_match_local_cap_id,
 };
 
+struct clock_event_device;
+
 struct arch_timer_erratum_workaround {
 	enum arch_timer_erratum_match_type match_type;
 	const void *id;
@@ -49,6 +51,8 @@ struct arch_timer_erratum_workaround {
 	u32 (*read_cntp_tval_el0)(void);
 	u32 (*read_cntv_tval_el0)(void);
 	u64 (*read_cntvct_el0)(void);
+	int (*set_next_event_phys)(unsigned long, struct clock_event_device *);
+	int (*set_next_event_virt)(unsigned long, struct clock_event_device *);
 };
 
 extern const struct arch_timer_erratum_workaround *timer_unstable_counter_workaround;
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 2c02e25..a0c9ee8 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -282,6 +282,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.read_cntp_tval_el0 = fsl_a008585_read_cntp_tval_el0,
 		.read_cntv_tval_el0 = fsl_a008585_read_cntv_tval_el0,
 		.read_cntvct_el0 = fsl_a008585_read_cntvct_el0,
+		.set_next_event_phys = erratum_set_next_event_tval_phys,
+		.set_next_event_virt = erratum_set_next_event_tval_virt,
 	},
 #endif
 #ifdef CONFIG_HISILICON_ERRATUM_161010101
@@ -292,6 +294,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.read_cntp_tval_el0 = hisi_161010101_read_cntp_tval_el0,
 		.read_cntv_tval_el0 = hisi_161010101_read_cntv_tval_el0,
 		.read_cntvct_el0 = hisi_161010101_read_cntvct_el0,
+		.set_next_event_phys = erratum_set_next_event_tval_phys,
+		.set_next_event_virt = erratum_set_next_event_tval_virt,
 	},
 #endif
 };
@@ -377,11 +381,24 @@ static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type t
 		local ? "local" : "global", wa->desc);
 }
 
+#define erratum_handler(fn, r, ...)					\
+({									\
+	bool __val;							\
+	if (needs_unstable_timer_counter_workaround() &&		\
+	    timer_unstable_counter_workaround->fn) {			\
+		r = timer_unstable_counter_workaround->fn(__VA_ARGS__);	\
+		__val = true;						\
+	} else {							\
+		__val = false;						\
+	}								\
+	__val;								\
+})
+
 #else
 #define arch_timer_check_ool_workaround(t,a)		do { } while(0)
 #define erratum_set_next_event_tval_virt(...)		({BUG(); 0;})
 #define erratum_set_next_event_tval_phys(...)		({BUG(); 0;})
-#define needs_unstable_timer_counter_workaround()	({false;})
+#define erratum_handler(fn, r, ...)			({false;})
 #endif /* CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND */
 
 static __always_inline irqreturn_t timer_handler(const int access,
@@ -474,8 +491,10 @@ static __always_inline void set_next_event(const int access, unsigned long evt,
 static int arch_timer_set_next_event_virt(unsigned long evt,
 					  struct clock_event_device *clk)
 {
-	if (needs_unstable_timer_counter_workaround())
-		return erratum_set_next_event_tval_virt(evt, clk);
+	int ret;
+
+	if (erratum_handler(set_next_event_virt, ret, evt, clk))
+		return ret;
 
 	set_next_event(ARCH_TIMER_VIRT_ACCESS, evt, clk);
 	return 0;
@@ -484,8 +503,10 @@ static int arch_timer_set_next_event_virt(unsigned long evt,
 static int arch_timer_set_next_event_phys(unsigned long evt,
 					  struct clock_event_device *clk)
 {
-	if (needs_unstable_timer_counter_workaround())
-		return erratum_set_next_event_tval_phys(evt, clk);
+	int ret;
+
+	if (erratum_handler(set_next_event_phys, ret, evt, clk))
+		return ret;
 
 	set_next_event(ARCH_TIMER_PHYS_ACCESS, evt, clk);
 	return 0;
-- 
2.7.4
