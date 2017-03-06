From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  6 Mar 2017 11:26:10 +0000
Subject: [PATCH 05/17] arm64: arch_timer: Move arch_timer_reg_read/write around
In-Reply-To: <20170306112622.13853-1-marc.zyngier@arm.com>
References: <20170306112622.13853-1-marc.zyngier@arm.com>
Message-ID: <20170306112622.13853-6-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we're about to move things around, let's start with the low
level read/write functions. This allows us to use these functions
in the errata handling code without having to use forward declaration
of static functions.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 124 +++++++++++++++++------------------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 3018eeeee7fa..53cb862eb6df 100644
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
@@ -294,68 +356,6 @@ static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type t
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
2.11.0
