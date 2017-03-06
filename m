From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  6 Mar 2017 11:26:11 +0000
Subject: [PATCH 06/17] arm64: arch_timer: Get rid of erratum_workaround_set_sne
In-Reply-To: <20170306112622.13853-1-marc.zyngier@arm.com>
References: <20170306112622.13853-1-marc.zyngier@arm.com>
Message-ID: <20170306112622.13853-7-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's move the handling of workarounds affecting set_next_event
to the affected function, instead of overwriding the pointers
as an afterthough. Yes, this is an extra indirection on the
erratum handling path, but the HW is busted anyway.

This will allow for some more flexibility later.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 89 ++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 49 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 53cb862eb6df..3e5f9539c0c0 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -241,6 +241,38 @@ EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
 DEFINE_STATIC_KEY_FALSE(arch_timer_read_ool_enabled);
 EXPORT_SYMBOL_GPL(arch_timer_read_ool_enabled);
 
+static void erratum_set_next_event_tval_generic(const int access, unsigned long evt,
+						struct clock_event_device *clk)
+{
+	unsigned long ctrl;
+	u64 cval = evt + arch_counter_get_cntvct();
+
+	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
+	ctrl |= ARCH_TIMER_CTRL_ENABLE;
+	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
+
+	if (access == ARCH_TIMER_PHYS_ACCESS)
+		write_sysreg(cval, cntp_cval_el0);
+	else
+		write_sysreg(cval, cntv_cval_el0);
+
+	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
+}
+
+static int erratum_set_next_event_tval_virt(unsigned long evt,
+					    struct clock_event_device *clk)
+{
+	erratum_set_next_event_tval_generic(ARCH_TIMER_VIRT_ACCESS, evt, clk);
+	return 0;
+}
+
+static int erratum_set_next_event_tval_phys(unsigned long evt,
+					    struct clock_event_device *clk)
+{
+	erratum_set_next_event_tval_generic(ARCH_TIMER_PHYS_ACCESS, evt, clk);
+	return 0;
+}
+
 static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 #ifdef CONFIG_FSL_ERRATUM_A008585
 	{
@@ -354,6 +386,8 @@ static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type t
 
 #else
 #define arch_timer_check_ool_workaround(t,a)		do { } while(0)
+#define erratum_set_next_event_tval_virt(...)		({BUG_ON(1); 0;})
+#define erratum_set_next_event_tval_phys(...)		({BUG_ON(1); 0;})
 #endif /* CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND */
 
 static __always_inline irqreturn_t timer_handler(const int access,
@@ -443,43 +477,12 @@ static __always_inline void set_next_event(const int access, unsigned long evt,
 	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
 }
 
-#ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
-static __always_inline void erratum_set_next_event_generic(const int access,
-		unsigned long evt, struct clock_event_device *clk)
-{
-	unsigned long ctrl;
-	u64 cval = evt + arch_counter_get_cntvct();
-
-	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
-	ctrl |= ARCH_TIMER_CTRL_ENABLE;
-	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
-
-	if (access == ARCH_TIMER_PHYS_ACCESS)
-		write_sysreg(cval, cntp_cval_el0);
-	else if (access == ARCH_TIMER_VIRT_ACCESS)
-		write_sysreg(cval, cntv_cval_el0);
-
-	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
-}
-
-static int erratum_set_next_event_virt(unsigned long evt,
-					   struct clock_event_device *clk)
-{
-	erratum_set_next_event_generic(ARCH_TIMER_VIRT_ACCESS, evt, clk);
-	return 0;
-}
-
-static int erratum_set_next_event_phys(unsigned long evt,
-					   struct clock_event_device *clk)
-{
-	erratum_set_next_event_generic(ARCH_TIMER_PHYS_ACCESS, evt, clk);
-	return 0;
-}
-#endif /* CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND */
-
 static int arch_timer_set_next_event_virt(unsigned long evt,
 					  struct clock_event_device *clk)
 {
+	if (needs_unstable_timer_counter_workaround())
+		return erratum_set_next_event_tval_virt(evt, clk);
+
 	set_next_event(ARCH_TIMER_VIRT_ACCESS, evt, clk);
 	return 0;
 }
@@ -487,6 +490,9 @@ static int arch_timer_set_next_event_virt(unsigned long evt,
 static int arch_timer_set_next_event_phys(unsigned long evt,
 					  struct clock_event_device *clk)
 {
+	if (needs_unstable_timer_counter_workaround())
+		return erratum_set_next_event_tval_phys(evt, clk);
+
 	set_next_event(ARCH_TIMER_PHYS_ACCESS, evt, clk);
 	return 0;
 }
@@ -505,19 +511,6 @@ static int arch_timer_set_next_event_phys_mem(unsigned long evt,
 	return 0;
 }
 
-static void erratum_workaround_set_sne(struct clock_event_device *clk)
-{
-#ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
-	if (!static_branch_unlikely(&arch_timer_read_ool_enabled))
-		return;
-
-	if (arch_timer_uses_ppi == VIRT_PPI)
-		clk->set_next_event = erratum_set_next_event_virt;
-	else
-		clk->set_next_event = erratum_set_next_event_phys;
-#endif
-}
-
 static void __arch_timer_setup(unsigned type,
 			       struct clock_event_device *clk)
 {
@@ -548,8 +541,6 @@ static void __arch_timer_setup(unsigned type,
 		}
 
 		arch_timer_check_ool_workaround(ate_match_local_cap_id, NULL);
-
-		erratum_workaround_set_sne(clk);
 	} else {
 		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
 		clk->name = "arch_mem_timer";
-- 
2.11.0
