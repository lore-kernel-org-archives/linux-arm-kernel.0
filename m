From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 19 Oct 2015 16:03:31 +0100
Subject: [PATCH] clocksource; armada-370: implement ARM delay timer
Message-ID: <E1ZoByF-0002E9-9O@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement an ARM delay timer to be used for udelay() on Armada 37x
platforms.  This allows us to skip the delay loop calibration at boot,
saving 180ms on the boot time of the kernel (which is around 10%).

It also means that udelay() will be unaffected by CPU frequency changes
when cpufreq is enabled on these platforms.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig                         |  1 +
 arch/arm/plat-orion/time.c               | 13 +++++++++++++
 drivers/clocksource/time-armada-370-xp.c | 14 ++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f3dfca632a8a..194569c23271 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -10,6 +10,7 @@ config ARM
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_EXTABLE_SORT if MMU
 	select CLONE_BACKWARDS
diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
index 8085a8aac812..ffb93db68e9c 100644
--- a/arch/arm/plat-orion/time.c
+++ b/arch/arm/plat-orion/time.c
@@ -18,6 +18,7 @@
 #include <linux/irq.h>
 #include <linux/sched_clock.h>
 #include <plat/time.h>
+#include <asm/delay.h>
 
 /*
  * MBus bridge block registers.
@@ -188,6 +189,15 @@ orion_time_set_base(void __iomem *_timer_base)
 	timer_base = _timer_base;
 }
 
+static unsigned long orion_delay_timer_read(void)
+{
+	return ~readl(timer_base + TIMER0_VAL_OFF);
+}
+
+static struct delay_timer orion_delay_timer = {
+	.read_current_timer = orion_delay_timer_read,
+};
+
 void __init
 orion_time_init(void __iomem *_bridge_base, u32 _bridge_timer1_clr_mask,
 		unsigned int irq, unsigned int tclk)
@@ -202,6 +212,9 @@ orion_time_init(void __iomem *_bridge_base, u32 _bridge_timer1_clr_mask,
 
 	ticks_per_jiffy = (tclk + HZ/2) / HZ;
 
+	orion_delay_timer.freq = tclk;
+	register_current_timer_delay(&orion_delay_timer);
+
 	/*
 	 * Set scale and timer for sched_clock.
 	 */
diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index 2162796fd504..d93ec3c4f139 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -45,6 +45,8 @@
 #include <linux/percpu.h>
 #include <linux/syscore_ops.h>
 
+#include <asm/delay.h>
+
 /*
  * Timer block registers.
  */
@@ -249,6 +251,15 @@ struct syscore_ops armada_370_xp_timer_syscore_ops = {
 	.resume		= armada_370_xp_timer_resume,
 };
 
+static unsigned long armada_370_delay_timer_read(void)
+{
+	return ~readl(timer_base + TIMER0_VAL_OFF);
+}
+
+static struct delay_timer armada_370_delay_timer = {
+	.read_current_timer = armada_370_delay_timer_read,
+};
+
 static void __init armada_370_xp_timer_common_init(struct device_node *np)
 {
 	u32 clr = 0, set = 0;
@@ -287,6 +298,9 @@ static void __init armada_370_xp_timer_common_init(struct device_node *np)
 		TIMER0_RELOAD_EN | enable_mask,
 		TIMER0_RELOAD_EN | enable_mask);
 
+	armada_370_delay_timer.freq = timer_clk;
+	register_current_timer_delay(&armada_370_delay_timer);
+
 	/*
 	 * Set scale and timer for sched_clock.
 	 */
-- 
2.1.0
