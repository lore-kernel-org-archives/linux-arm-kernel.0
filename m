From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 16 Apr 2017 22:26:58 +0200
Subject: [PATCH 08/29] arm64: arch_timer: Move arch_timer_reg_read/write around
In-Reply-To: <1492374441-23336-1-git-send-email-daniel.lezcano@linaro.org>
References: <20170416202542.GV2078@mai>
 <1492374441-23336-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1492374441-23336-8-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

As we're about to move things around, let's start with the low
level read/write functions. This allows us to use these functions
in the errata handling code without having to use forward declaration
of static functions.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 124 +++++++++++++++++------------------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 532e47fa..b5c83cc 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -96,6 +96,68 @@ early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
  * Architected system timer support.
  */
 
+static __always_inline
+void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
+			  struct clock_event_device *clk)
+{
+	if (access == ARCH_TIMER_MEM_PHYS_ACCESS) {
+		struct arch_timer *timer = to_arch_timer(clk);
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			writel_relaxed(val, timer->base + CNTP_CTL);
+			break;
+		case ARCH_TIMER_REG_TVAL:
+			writel_relaxed(val, timer->base + CNTP_TVAL);
+			break;
+		}
+	} else if (access == ARCH_TIMER_MEM_VIRT_ACCESS) {
+		struct arch_timer *timer = to_arch_timer(clk);
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			writel_relaxed(val, timer->base + CNTV_CTL);
+			break;
+		case ARCH_TIMER_REG_TVAL:
+			writel_relaxed(val, timer->base + CNTV_TVAL);
+			break;
+		}
+	} else {
+		arch_timer_reg_write_cp15(access, reg, val);
+	}
+}
+
+static __always_inline
+u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
+			struct clock_event_device *clk)
+{
+	u32 val;
+
+	if (access == ARCH_TIMER_MEM_PHYS_ACCESS) {
+		struct arch_timer *timer = to_arch_timer(clk);
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			val = readl_relaxed(timer->base + CNTP_CTL);
+			break;
+		case ARCH_TIMER_REG_TVAL:
+			val = readl_relaxed(timer->base + CNTP_TVAL);
+			break;
+		}
+	} else if (access == ARCH_TIMER_MEM_VIRT_ACCESS) {
+		struct arch_timer *timer = to_arch_timer(clk);
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			val = readl_relaxed(timer->base + CNTV_CTL);
+			break;
+		case ARCH_TIMER_REG_TVAL:
+			val = readl_relaxed(timer->base + CNTV_TVAL);
+			break;
+		}
+	} else {
+		val = arch_timer_reg_read_cp15(access, reg);
+	}
+
+	return val;
+}
+
 #ifdef CONFIG_FSL_ERRATUM_A008585
 /*
  * The number of retries is an arbitrary value well beyond the highest number
@@ -287,68 +349,6 @@ static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type t
 #define arch_timer_check_ool_workaround(t,a)		do { } while(0)
 #endif /* CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND */
 
-static __always_inline
-void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
-			  struct clock_event_device *clk)
-{
-	if (access == ARCH_TIMER_MEM_PHYS_ACCESS) {
-		struct arch_timer *timer = to_arch_timer(clk);
-		switch (reg) {
-		case ARCH_TIMER_REG_CTRL:
-			writel_relaxed(val, timer->base + CNTP_CTL);
-			break;
-		case ARCH_TIMER_REG_TVAL:
-			writel_relaxed(val, timer->base + CNTP_TVAL);
-			break;
-		}
-	} else if (access == ARCH_TIMER_MEM_VIRT_ACCESS) {
-		struct arch_timer *timer = to_arch_timer(clk);
-		switch (reg) {
-		case ARCH_TIMER_REG_CTRL:
-			writel_relaxed(val, timer->base + CNTV_CTL);
-			break;
-		case ARCH_TIMER_REG_TVAL:
-			writel_relaxed(val, timer->base + CNTV_TVAL);
-			break;
-		}
-	} else {
-		arch_timer_reg_write_cp15(access, reg, val);
-	}
-}
-
-static __always_inline
-u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
-			struct clock_event_device *clk)
-{
-	u32 val;
-
-	if (access == ARCH_TIMER_MEM_PHYS_ACCESS) {
-		struct arch_timer *timer = to_arch_timer(clk);
-		switch (reg) {
-		case ARCH_TIMER_REG_CTRL:
-			val = readl_relaxed(timer->base + CNTP_CTL);
-			break;
-		case ARCH_TIMER_REG_TVAL:
-			val = readl_relaxed(timer->base + CNTP_TVAL);
-			break;
-		}
-	} else if (access == ARCH_TIMER_MEM_VIRT_ACCESS) {
-		struct arch_timer *timer = to_arch_timer(clk);
-		switch (reg) {
-		case ARCH_TIMER_REG_CTRL:
-			val = readl_relaxed(timer->base + CNTV_CTL);
-			break;
-		case ARCH_TIMER_REG_TVAL:
-			val = readl_relaxed(timer->base + CNTV_TVAL);
-			break;
-		}
-	} else {
-		val = arch_timer_reg_read_cp15(access, reg);
-	}
-
-	return val;
-}
-
 static __always_inline irqreturn_t timer_handler(const int access,
 					struct clock_event_device *evt)
 {
-- 
2.7.4
