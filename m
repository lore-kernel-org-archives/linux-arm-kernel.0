From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 18 Jan 2011 16:39:33 +0000
Subject: [PATCH] arm: Configure reference clock for Versatile Express timers
Message-ID: <1295368773-14531-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Timers on Versatile Express mainboard are used as system clock/event
sources. Driver assumes that they are clocked with 1MHz signal.
Old V2M firmware apparently configured it by default, but on newer
boards one can observe that "sleep 1" command takes over 30 seconds
to finish, as the timers are fed with 32kHz instead...

This patch performs required magic and also removes code clearing
timer's control registers, as exactly the same operations are
performed by the timer driver few jiffies later.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
Tested-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-vexpress/v2m.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index a9ed342..6edace3 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -19,6 +19,7 @@
 #include <asm/mach/time.h>
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/timer-sp.h>
+#include <asm/hardware/sp810.h>
 
 #include <mach/motherboard.h>
 
@@ -50,10 +51,15 @@ void __init v2m_map_io(struct map_desc *tile, size_t num)
 
 static void __init v2m_timer_init(void)
 {
+	u32 scctrl;
+
 	versatile_sched_clock_init(MMIO_P2V(V2M_SYS_24MHZ), 24000000);
 
-	writel(0, MMIO_P2V(V2M_TIMER0) + TIMER_CTRL);
-	writel(0, MMIO_P2V(V2M_TIMER1) + TIMER_CTRL);
+	/* Select 1MHz TIMCLK as the reference clock for SP804 timers */
+	scctrl = readl(MMIO_P2V(V2M_SYSCTL + SCCTRL));
+	scctrl |= (1 << 15);    /* TIMCLK is used for timer 0 */
+	scctrl |= (1 << 17);    /* TIMCLK is used for timer 1 */
+	writel(scctrl, MMIO_P2V(V2M_SYSCTL + SCCTRL));
 
 	sp804_clocksource_init(MMIO_P2V(V2M_TIMER1));
 	sp804_clockevents_init(MMIO_P2V(V2M_TIMER0), IRQ_V2M_TIMER0);
-- 
1.6.3.3
