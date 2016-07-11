From: anna-maria@linutronix.de (Anna-Maria Gleixner)
Date: Mon, 11 Jul 2016 12:28:58 -0000
Subject: [patch 50/66] arm: l2c: Convert to hotplug state machine
References: <20160711122450.923603742@linutronix.de>
Message-ID: <20160711122534.845045890@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Cochran <rcochran@linutronix.de>

Install the callbacks via the state machine and let the core invoke
the callbacks on the already online CPUs.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>

---
 arch/arm/mm/cache-l2x0.c   |   27 +++++++++++++--------------
 include/linux/cpuhotplug.h |    1 +
 2 files changed, 14 insertions(+), 14 deletions(-)

--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -597,17 +597,16 @@ static void l2c310_configure(void __iome
 			      L310_POWER_CTRL);
 }
 
-static int l2c310_cpu_enable_flz(struct notifier_block *nb, unsigned long act, void *data)
+static int l2c310_starting_cpu(unsigned int cpu)
 {
-	switch (act & ~CPU_TASKS_FROZEN) {
-	case CPU_STARTING:
-		set_auxcr(get_auxcr() | BIT(3) | BIT(2) | BIT(1));
-		break;
-	case CPU_DYING:
-		set_auxcr(get_auxcr() & ~(BIT(3) | BIT(2) | BIT(1)));
-		break;
-	}
-	return NOTIFY_OK;
+	set_auxcr(get_auxcr() | BIT(3) | BIT(2) | BIT(1));
+	return 0;
+}
+
+static int l2c310_dying_cpu(unsigned int cpu)
+{
+	set_auxcr(get_auxcr() & ~(BIT(3) | BIT(2) | BIT(1)));
+	return 0;
 }
 
 static void __init l2c310_enable(void __iomem *base, unsigned num_lock)
@@ -678,10 +677,10 @@ static void __init l2c310_enable(void __
 			power_ctrl & L310_STNDBY_MODE_EN ? "en" : "dis");
 	}
 
-	if (aux & L310_AUX_CTRL_FULL_LINE_ZERO) {
-		set_auxcr(get_auxcr() | BIT(3) | BIT(2) | BIT(1));
-		cpu_notifier(l2c310_cpu_enable_flz, 0);
-	}
+	if (aux & L310_AUX_CTRL_FULL_LINE_ZERO)
+		cpuhp_setup_state(CPUHP_AP_ARM_L2X0_STARTING,
+				  "AP_ARM_L2X0_STARTING", l2c310_starting_cpu,
+				  l2c310_dying_cpu);
 }
 
 static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -38,6 +38,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_METAG_STARTING,
 	CPUHP_AP_ARM_VFP_STARTING,
 	CPUHP_AP_PERF_ARM_STARTING,
+	CPUHP_AP_ARM_L2X0_STARTING,
 	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
 	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
 	CPUHP_AP_DUMMY_TIMER_STARTING,
