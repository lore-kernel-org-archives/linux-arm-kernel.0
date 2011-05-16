From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 16 May 2011 10:08:30 -0700
Subject: [PATCH] clocksource: use the correct base address to setup timer 0
Message-ID: <201105161008.30604.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The static variable clksrc_base was removed by:

commit 3f3808c30612334e38e0641024d2c020c0eda7d4

Use the base address passed to sp804_clocksource_init() when
doing the setup for timer 0.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Russell King <linux@arm.linux.org.uk>

---

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index 27f7c22..445b05e 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -35,11 +35,11 @@
 void __init sp804_clocksource_init(void __iomem *base)
 {
 	/* setup timer 0 as free-running clocksource */
-	writel(0, clksrc_base + TIMER_CTRL);
-	writel(0xffffffff, clksrc_base + TIMER_LOAD);
-	writel(0xffffffff, clksrc_base + TIMER_VALUE);
+	writel(0, base + TIMER_CTRL);
+	writel(0xffffffff, base + TIMER_LOAD);
+	writel(0xffffffff, base + TIMER_VALUE);
 	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
-		clksrc_base + TIMER_CTRL);
+		base + TIMER_CTRL);
 
 	clocksource_mmio_init(base + TIMER_VALUE, "timer3",
 		TIMER_FREQ_KHZ * 1000, 200, 32, clocksource_mmio_readl_down);
