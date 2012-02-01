From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  1 Feb 2012 16:59:33 +0000
Subject: [PATCH v2 2/4] ARM: architected timers: Add A15 specific sched_clock
 implementation
In-Reply-To: <1328115575-24866-1-git-send-email-marc.zyngier@arm.com>
References: <1328115575-24866-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1328115575-24866-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide an A15 sched_clock implementation using the virtual counter,
which is thought to be more useful than the physical one in a
virtualised environment, as it can offset the time spent in another
VM or the hypervisor.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arch_timer.h |    1 +
 arch/arm/kernel/arch_timer.c      |   25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 20de858..ca0f783 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -8,5 +8,6 @@ struct arch_timer {
 };
 
 int arch_timer_register(struct arch_timer *);
+int arch_timer_sched_clock_init(void);
 
 #endif
diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index 680cf1e..1a203f0 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -22,6 +22,7 @@
 #include <asm/cputype.h>
 #include <asm/localtimer.h>
 #include <asm/arch_timer.h>
+#include <asm/sched_clock.h>
 
 static unsigned long arch_timer_rate;
 static int arch_timer_ppi;
@@ -202,6 +203,18 @@ static inline cycle_t arch_counter_get_cntvct(void)
 	return ((u64) cvalh << 32) | cvall;
 }
 
+static u32 notrace arch_counter_get_cntvct32(void)
+{
+	cycle_t cntvct = arch_counter_get_cntvct();
+
+	/*
+	 * The sched_clock infrastructure only knows about counters
+	 * with@most 32bits. Forget about the upper 24 bits for the
+	 * time being...
+	 */
+	return (u32)(cntvct & (u32)~0);
+}
+
 static cycle_t arch_counter_read(struct clocksource *cs)
 {
 	return arch_counter_get_cntpct();
@@ -284,3 +297,15 @@ out_free:
 
 	return err;
 }
+
+int arch_timer_sched_clock_init(void)
+{
+	int err;
+
+	err = arch_timer_available();
+	if (err)
+		return err;
+
+	setup_sched_clock(arch_counter_get_cntvct32, 32, arch_timer_rate);
+	return 0;
+}
-- 
1.7.7.1
