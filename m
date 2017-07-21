From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Jul 2017 18:15:42 +0100
Subject: [PATCH 16/16] clocksource/arm_arch_timer: Trap user access to CNT{VCT,
 FRQ} if CNTFRQ is invalid
In-Reply-To: <20170721171542.27639-1-marc.zyngier@arm.com>
References: <20170721171542.27639-1-marc.zyngier@arm.com>
Message-ID: <20170721171542.27639-17-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we end-up in a situation where any of the CPUs doesn't have its
CNTFRQ register correctly programmed, we cannot reliably expose this
register to userspace. It means that in this case, we have to trap
it, and CNTVCT at the same time (since they are controlled by the
same trapping bit).

It also means that there is no point in enabling the VDSO access to
the counter, since we're going to enter the kernel.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 4f4633157978..37404a6a1bfa 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -759,6 +759,25 @@ static void arch_timer_configure_evtstream(void)
 	arch_timer_evtstrm_enable(min(pos, 15));
 }
 
+static bool cntfrq_valid(void)
+{
+	u32 freq = arch_timer_get_cntfrq();
+
+	if (freq != arch_timer_rate) {
+		/*
+		 * If any of the CPUs disagrees on what CNTFRQ should
+		 * actually be, we end-up disabling the vdso fastpath
+		 * for the whole system.
+		 */
+		pr_warn("CPU%d: Invalid CNTFRQ (%u, expected %u)\n",
+			smp_processor_id(), freq, arch_timer_rate);
+		disable_vdso();
+		return false;
+	}
+
+	return true;
+}
+
 static void arch_counter_set_user_access(void)
 {
 	u32 cntkctl = arch_timer_get_cntkctl();
@@ -773,11 +792,12 @@ static void arch_counter_set_user_access(void)
 
 	/*
 	 * Enable user access to the virtual counter if it doesn't
-	 * need to be workaround. The vdso may have been already
-	 * disabled though.
+	 * need to be workaround, and that the frequency has been
+	 * correctly set. The vdso may have been already disabled
+	 * though.
 	 */
-	if (arch_timer_this_cpu_has_cntvct_wa())
-		pr_info("CPU%d: Trapping CNTVCT access\n", smp_processor_id());
+	if (arch_timer_this_cpu_has_cntvct_wa() || !cntfrq_valid())
+		pr_info("CPU%d: Trapping CNTVCT/CNTFRQ access\n", smp_processor_id());
 	else
 		cntkctl |= ARCH_TIMER_USR_VCT_ACCESS_EN;
 
-- 
2.11.0
