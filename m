From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 24 Jan 2011 19:14:49 +0000
Subject: [PATCH v3] arm: Configure reference clock for Versatile Express timers
Message-ID: <1295896489-5330-1-git-send-email-pawel.moll@arm.com>
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
 arch/arm/include/asm/hardware/sp810.h |    6 ++++++
 arch/arm/mach-vexpress/v2m.c          |    9 +++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/hardware/sp810.h b/arch/arm/include/asm/hardware/sp810.h
index a101f10..721847d 100644
--- a/arch/arm/include/asm/hardware/sp810.h
+++ b/arch/arm/include/asm/hardware/sp810.h
@@ -50,6 +50,12 @@
 #define SCPCELLID2		0xFF8
 #define SCPCELLID3		0xFFC
 
+#define SCCTRL_TIMEREN0SEL_REFCLK	(0 << 15)
+#define SCCTRL_TIMEREN0SEL_TIMCLK	(1 << 15)
+
+#define SCCTRL_TIMEREN1SEL_REFCLK	(0 << 17)
+#define SCCTRL_TIMEREN1SEL_TIMCLK	(1 << 17)
+
 static inline void sysctl_soft_reset(void __iomem *base)
 {
 	/* writing any value to SCSYSSTAT reg will reset system */
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 28dea89..e02c80f 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -19,6 +19,7 @@
 #include <asm/mach/time.h>
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/timer-sp.h>
+#include <asm/hardware/sp810.h>
 
 #include <mach/motherboard.h>
 
@@ -50,8 +51,16 @@ void __init v2m_map_io(struct map_desc *tile, size_t num)
 
 static void __init v2m_timer_init(void)
 {
+	u32 scctrl;
+
 	versatile_sched_clock_init(MMIO_P2V(V2M_SYS_24MHZ), 24000000);
 
+	/* Select 1MHz TIMCLK as the reference clock for SP804 timers */
+	scctrl = readl(MMIO_P2V(V2M_SYSCTL + SCCTRL));
+	scctrl |= SCCTRL_TIMEREN0SEL_TIMCLK;
+	scctrl |= SCCTRL_TIMEREN1SEL_TIMCLK;
+	writel(scctrl, MMIO_P2V(V2M_SYSCTL + SCCTRL));
+
 	writel(0, MMIO_P2V(V2M_TIMER0) + TIMER_CTRL);
 	writel(0, MMIO_P2V(V2M_TIMER1) + TIMER_CTRL);
 
-- 
1.6.3.3
