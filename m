From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Thu, 18 Sep 2014 09:59:34 -0500
Subject: [PATCH v2 2/3] clocksource: arm_arch_timer: enable counter access for
 32-bit ARM
In-Reply-To: <1411052390-27238-1-git-send-email-nathan_lynch@mentor.com>
References: <1411052390-27238-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <1411052390-27238-3-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only difference between arm and arm64's implementations of
arch_counter_set_user_access is that 32-bit ARM does not enable user
access to the virtual counter.  We want to enable this access for the
32-bit ARM VDSO, so copy the arm64 version to the driver itself, and
remove the arch-specific implementations.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm/include/asm/arch_timer.h    | 14 --------------
 arch/arm64/include/asm/arch_timer.h  | 17 -----------------
 drivers/clocksource/arm_arch_timer.c | 17 +++++++++++++++++
 3 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 0704e0cf5571..b7ae44464231 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -99,20 +99,6 @@ static inline void arch_timer_set_cntkctl(u32 cntkctl)
 	asm volatile("mcr p15, 0, %0, c14, c1, 0" : : "r" (cntkctl));
 }
 
-static inline void arch_counter_set_user_access(void)
-{
-	u32 cntkctl = arch_timer_get_cntkctl();
-
-	/* Disable user access to both physical/virtual counters/timers */
-	/* Also disable virtual event stream */
-	cntkctl &= ~(ARCH_TIMER_USR_PT_ACCESS_EN
-			| ARCH_TIMER_USR_VT_ACCESS_EN
-			| ARCH_TIMER_VIRT_EVT_EN
-			| ARCH_TIMER_USR_VCT_ACCESS_EN
-			| ARCH_TIMER_USR_PCT_ACCESS_EN);
-	arch_timer_set_cntkctl(cntkctl);
-}
-
 static inline void arch_timer_evtstrm_enable(int divider)
 {
 	u32 cntkctl = arch_timer_get_cntkctl();
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 9400596a0f39..49e94c677e7a 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -104,23 +104,6 @@ static inline void arch_timer_set_cntkctl(u32 cntkctl)
 	asm volatile("msr	cntkctl_el1, %0" : : "r" (cntkctl));
 }
 
-static inline void arch_counter_set_user_access(void)
-{
-	u32 cntkctl = arch_timer_get_cntkctl();
-
-	/* Disable user access to the timers and the physical counter */
-	/* Also disable virtual event stream */
-	cntkctl &= ~(ARCH_TIMER_USR_PT_ACCESS_EN
-			| ARCH_TIMER_USR_VT_ACCESS_EN
-			| ARCH_TIMER_VIRT_EVT_EN
-			| ARCH_TIMER_USR_PCT_ACCESS_EN);
-
-	/* Enable user access to the virtual counter */
-	cntkctl |= ARCH_TIMER_USR_VCT_ACCESS_EN;
-
-	arch_timer_set_cntkctl(cntkctl);
-}
-
 static inline void arch_timer_evtstrm_enable(int divider)
 {
 	u32 cntkctl = arch_timer_get_cntkctl();
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index c99afdf12e98..31781fdd7c19 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -312,6 +312,23 @@ static void arch_timer_configure_evtstream(void)
 	arch_timer_evtstrm_enable(min(pos, 15));
 }
 
+static void arch_counter_set_user_access(void)
+{
+	u32 cntkctl = arch_timer_get_cntkctl();
+
+	/* Disable user access to the timers and the physical counter */
+	/* Also disable virtual event stream */
+	cntkctl &= ~(ARCH_TIMER_USR_PT_ACCESS_EN
+			| ARCH_TIMER_USR_VT_ACCESS_EN
+			| ARCH_TIMER_VIRT_EVT_EN
+			| ARCH_TIMER_USR_PCT_ACCESS_EN);
+
+	/* Enable user access to the virtual counter */
+	cntkctl |= ARCH_TIMER_USR_VCT_ACCESS_EN;
+
+	arch_timer_set_cntkctl(cntkctl);
+}
+
 static int arch_timer_setup(struct clock_event_device *clk)
 {
 	__arch_timer_setup(ARCH_CP15_TIMER, clk);
-- 
1.9.3
