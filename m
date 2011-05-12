From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 May 2011 14:49:24 +0100
Subject: [PATCH 14/13] clocksource: ARM sp804: allow clocksource name to be
	specified
In-Reply-To: <20110510072700.GA29869@n2100.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
Message-ID: <20110512134924.GB6098@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows platforms to specify the clocksource name upon
registration, which is necessary should they wish to register more
than one sp804 clocksource.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/timer-sp.c               |    4 ++--
 arch/arm/include/asm/hardware/timer-sp.h |    2 +-
 arch/arm/mach-integrator/integrator_cp.c |    2 +-
 arch/arm/mach-realview/core.c            |    2 +-
 arch/arm/mach-versatile/core.c           |    2 +-
 arch/arm/mach-vexpress/ct-ca9x4.c        |    2 +-
 arch/arm/mach-vexpress/v2m.c             |    2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index 445b05e..f6b9011 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -32,7 +32,7 @@
 #define TIMER_FREQ_KHZ	(1000)
 #define TIMER_RELOAD	(TIMER_FREQ_KHZ * 1000 / HZ)
 
-void __init sp804_clocksource_init(void __iomem *base)
+void __init sp804_clocksource_init(void __iomem *base, const char *name)
 {
 	/* setup timer 0 as free-running clocksource */
 	writel(0, base + TIMER_CTRL);
@@ -41,7 +41,7 @@ void __init sp804_clocksource_init(void __iomem *base)
 	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
 		base + TIMER_CTRL);
 
-	clocksource_mmio_init(base + TIMER_VALUE, "timer3",
+	clocksource_mmio_init(base + TIMER_VALUE, name,
 		TIMER_FREQ_KHZ * 1000, 200, 32, clocksource_mmio_readl_down);
 }
 
diff --git a/arch/arm/include/asm/hardware/timer-sp.h b/arch/arm/include/asm/hardware/timer-sp.h
index 21e75e3..11c386b 100644
--- a/arch/arm/include/asm/hardware/timer-sp.h
+++ b/arch/arm/include/asm/hardware/timer-sp.h
@@ -1,2 +1,2 @@
-void sp804_clocksource_init(void __iomem *);
+void sp804_clocksource_init(void __iomem *, const char *);
 void sp804_clockevents_init(void __iomem *, unsigned int);
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 9e3ce26..46fb7f5 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -476,7 +476,7 @@ static void __init intcp_timer_init(void)
 	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
 
-	sp804_clocksource_init(TIMER2_VA_BASE);
+	sp804_clocksource_init(TIMER2_VA_BASE, "timer2");
 	sp804_clockevents_init(TIMER1_VA_BASE, IRQ_TIMERINT1);
 }
 
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 75dbc87..6356b5e 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -545,7 +545,7 @@ void __init realview_timer_init(unsigned int timer_irq)
 	writel(0, timer2_va_base + TIMER_CTRL);
 	writel(0, timer3_va_base + TIMER_CTRL);
 
-	sp804_clocksource_init(timer3_va_base);
+	sp804_clocksource_init(timer3_va_base, "timer3");
 	sp804_clockevents_init(timer0_va_base, timer_irq);
 }
 
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index eb7ffa0..aad6d39 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -764,7 +764,7 @@ static void __init versatile_timer_init(void)
 	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER3_VA_BASE + TIMER_CTRL);
 
-	sp804_clocksource_init(TIMER3_VA_BASE);
+	sp804_clocksource_init(TIMER3_VA_BASE, "timer3");
 	sp804_clockevents_init(TIMER0_VA_BASE, IRQ_TIMERINT0_1);
 }
 
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index ebc22e7..c833fd9 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -71,7 +71,7 @@ static void __init ct_ca9x4_timer_init(void)
 	writel(0, MMIO_P2V(CT_CA9X4_TIMER0) + TIMER_CTRL);
 	writel(0, MMIO_P2V(CT_CA9X4_TIMER1) + TIMER_CTRL);
 
-	sp804_clocksource_init(MMIO_P2V(CT_CA9X4_TIMER1));
+	sp804_clocksource_init(MMIO_P2V(CT_CA9X4_TIMER1), "ct-timer1");
 	sp804_clockevents_init(MMIO_P2V(CT_CA9X4_TIMER0), IRQ_CT_CA9X4_TIMER0);
 }
 
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index ba46e8e..ccf1f89 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -65,7 +65,7 @@ static void __init v2m_timer_init(void)
 	writel(0, MMIO_P2V(V2M_TIMER0) + TIMER_CTRL);
 	writel(0, MMIO_P2V(V2M_TIMER1) + TIMER_CTRL);
 
-	sp804_clocksource_init(MMIO_P2V(V2M_TIMER1));
+	sp804_clocksource_init(MMIO_P2V(V2M_TIMER1), "v2m-timer1");
 	sp804_clockevents_init(MMIO_P2V(V2M_TIMER0), IRQ_V2M_TIMER0);
 }
 
-- 
1.7.4.4
