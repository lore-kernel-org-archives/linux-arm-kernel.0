From: junxiao.bi@windriver.com (Junxiao Bi)
Date: Thu, 8 Dec 2011 18:07:50 +0800
Subject: [PATCH 4/6] ARM: SMP: fix big endian support
In-Reply-To: <1323338872-24716-1-git-send-email-junxiao.bi@windriver.com>
References: <1323338872-24716-1-git-send-email-junxiao.bi@windriver.com>
Message-ID: <1323338872-24716-5-git-send-email-junxiao.bi@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xue Ying <ying.xue@windriver.com>

Since data from arm peripheral are little-endian and __raw_read*/__raw_write*
don't do any endian conversion, we should use read*/write*_relaxed to replace
them as the _relaxed version only adds endian conversion based on __raw version
which isn't like read*/write* that adds IO barriers which will affect performance.

Signed-off-by: Xue Ying <ying.xue@windriver.com>
Signed-off-by: Junxiao Bi <junxiao.bi@windriver.com>
---
 arch/arm/kernel/smp_scu.c |   10 +++++-----
 arch/arm/kernel/smp_twd.c |   20 ++++++++++----------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index 8f5dd79..0324435 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -27,7 +27,7 @@
  */
 unsigned int __init scu_get_core_count(void __iomem *scu_base)
 {
-	unsigned int ncores = __raw_readl(scu_base + SCU_CONFIG);
+	unsigned int ncores = readl_relaxed(scu_base + SCU_CONFIG);
 	return (ncores & 0x03) + 1;
 }
 
@@ -41,19 +41,19 @@ void scu_enable(void __iomem *scu_base)
 #ifdef CONFIG_ARM_ERRATA_764369
 	/* Cortex-A9 only */
 	if ((read_cpuid(CPUID_ID) & 0xff0ffff0) == 0x410fc090) {
-		scu_ctrl = __raw_readl(scu_base + 0x30);
+		scu_ctrl = readl_relaxed(scu_base + 0x30);
 		if (!(scu_ctrl & 1))
-			__raw_writel(scu_ctrl | 0x1, scu_base + 0x30);
+			writel_relaxed(scu_ctrl | 0x1, scu_base + 0x30);
 	}
 #endif
 
-	scu_ctrl = __raw_readl(scu_base + SCU_CTRL);
+	scu_ctrl = readl_relaxed(scu_base + SCU_CTRL);
 	/* already enabled? */
 	if (scu_ctrl & 1)
 		return;
 
 	scu_ctrl |= 1;
-	__raw_writel(scu_ctrl, scu_base + SCU_CTRL);
+	writel_relaxed(scu_ctrl, scu_base + SCU_CTRL);
 
 	/*
 	 * Ensure that the data accessed by CPU0 before the SCU was
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index a8a6682..0864d92 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -39,7 +39,7 @@ static void twd_set_mode(enum clock_event_mode mode,
 		/* timer load already set up */
 		ctrl = TWD_TIMER_CONTROL_ENABLE | TWD_TIMER_CONTROL_IT_ENABLE
 			| TWD_TIMER_CONTROL_PERIODIC;
-		__raw_writel(twd_timer_rate / HZ, twd_base + TWD_TIMER_LOAD);
+		writel_relaxed(twd_timer_rate / HZ, twd_base + TWD_TIMER_LOAD);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		/* period set, and timer enabled in 'next_event' hook */
@@ -51,18 +51,18 @@ static void twd_set_mode(enum clock_event_mode mode,
 		ctrl = 0;
 	}
 
-	__raw_writel(ctrl, twd_base + TWD_TIMER_CONTROL);
+	writel_relaxed(ctrl, twd_base + TWD_TIMER_CONTROL);
 }
 
 static int twd_set_next_event(unsigned long evt,
 			struct clock_event_device *unused)
 {
-	unsigned long ctrl = __raw_readl(twd_base + TWD_TIMER_CONTROL);
+	unsigned long ctrl = readl_relaxed(twd_base + TWD_TIMER_CONTROL);
 
 	ctrl |= TWD_TIMER_CONTROL_ENABLE;
 
-	__raw_writel(evt, twd_base + TWD_TIMER_COUNTER);
-	__raw_writel(ctrl, twd_base + TWD_TIMER_CONTROL);
+	writel_relaxed(evt, twd_base + TWD_TIMER_COUNTER);
+	writel_relaxed(ctrl, twd_base + TWD_TIMER_CONTROL);
 
 	return 0;
 }
@@ -75,8 +75,8 @@ static int twd_set_next_event(unsigned long evt,
  */
 int twd_timer_ack(void)
 {
-	if (__raw_readl(twd_base + TWD_TIMER_INTSTAT)) {
-		__raw_writel(1, twd_base + TWD_TIMER_INTSTAT);
+	if (readl_relaxed(twd_base + TWD_TIMER_INTSTAT)) {
+		writel_relaxed(1, twd_base + TWD_TIMER_INTSTAT);
 		return 1;
 	}
 
@@ -111,15 +111,15 @@ static void __cpuinit twd_calibrate_rate(void)
 		waitjiffies += 5;
 
 				 /* enable, no interrupt or reload */
-		__raw_writel(0x1, twd_base + TWD_TIMER_CONTROL);
+		writel_relaxed(0x1, twd_base + TWD_TIMER_CONTROL);
 
 				 /* maximum value */
-		__raw_writel(0xFFFFFFFFU, twd_base + TWD_TIMER_COUNTER);
+		writel_relaxed(0xFFFFFFFFU, twd_base + TWD_TIMER_COUNTER);
 
 		while (get_jiffies_64() < waitjiffies)
 			udelay(10);
 
-		count = __raw_readl(twd_base + TWD_TIMER_COUNTER);
+		count = readl_relaxed(twd_base + TWD_TIMER_COUNTER);
 
 		twd_timer_rate = (0xFFFFFFFFU - count) * (HZ / 5);
 
-- 
1.7.0.4
