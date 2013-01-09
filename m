From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  9 Jan 2013 14:46:10 +0000
Subject: [PATCHv2 4/4] arm: Add generic timer broadcast support
In-Reply-To: <1357742770-15028-1-git-send-email-mark.rutland@arm.com>
References: <1357742770-15028-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1357742770-15028-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement timer_broadcast for the arm architecture, allowing for the use
of clock_event_device_drivers decoupled from the timer tick broadcast
mechanism.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/Kconfig      |    1 +
 arch/arm/kernel/smp.c |    3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f95ba14..b051266 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -4,6 +4,7 @@ config ARM
 	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAVE_CUSTOM_GPIO_H
+	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_EXTABLE_SORT if MMU
 	select CPU_PM if (SUSPEND || CPU_IDLE)
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index a9d7e70..a901054 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -476,7 +476,7 @@ u64 smp_irq_stat_cpu(unsigned int cpu)
 static DEFINE_PER_CPU(struct clock_event_device, percpu_clockevent);
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
-static void smp_timer_broadcast(const struct cpumask *mask)
+void tick_broadcast(const struct cpumask *mask)
 {
 	smp_cross_call(mask, IPI_TIMER);
 }
@@ -524,7 +524,6 @@ static void __cpuinit percpu_timer_setup(void)
 	struct clock_event_device *evt = &per_cpu(percpu_clockevent, cpu);
 
 	evt->cpumask = cpumask_of(cpu);
-	evt->broadcast = smp_timer_broadcast;
 
 	if (!lt_ops || lt_ops->setup(evt))
 		broadcast_timer_setup(evt);
-- 
1.7.0.4
