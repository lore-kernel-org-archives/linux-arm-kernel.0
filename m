From: junxiao.bi@windriver.com (Junxiao Bi)
Date: Tue, 15 Nov 2011 10:06:23 +0800
Subject: [PATCH 4/6] ARM: add big endian support for peripheral access
In-Reply-To: <1321322785-2981-1-git-send-email-junxiao.bi@windriver.com>
References: <1321322785-2981-1-git-send-email-junxiao.bi@windriver.com>
Message-ID: <1321322785-2981-4-git-send-email-junxiao.bi@windriver.com>
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
 include/linux/mtd/map.h   |   16 ++++++++--------
 3 files changed, 23 insertions(+), 23 deletions(-)

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
 
diff --git a/include/linux/mtd/map.h b/include/linux/mtd/map.h
index a9e6ba4..74b266d 100644
--- a/include/linux/mtd/map.h
+++ b/include/linux/mtd/map.h
@@ -393,14 +393,14 @@ static inline map_word inline_map_read(struct map_info *map, unsigned long ofs)
 	map_word r;
 
 	if (map_bankwidth_is_1(map))
-		r.x[0] = __raw_readb(map->virt + ofs);
+		r.x[0] = readb_relaxed(map->virt + ofs);
 	else if (map_bankwidth_is_2(map))
-		r.x[0] = __raw_readw(map->virt + ofs);
+		r.x[0] = readw_relaxed(map->virt + ofs);
 	else if (map_bankwidth_is_4(map))
-		r.x[0] = __raw_readl(map->virt + ofs);
+		r.x[0] = readl_relaxed(map->virt + ofs);
 #if BITS_PER_LONG >= 64
 	else if (map_bankwidth_is_8(map))
-		r.x[0] = __raw_readq(map->virt + ofs);
+		r.x[0] = readq_relaxed(map->virt + ofs);
 #endif
 	else if (map_bankwidth_is_large(map))
 		memcpy_fromio(r.x, map->virt+ofs, map->bankwidth);
@@ -413,14 +413,14 @@ static inline map_word inline_map_read(struct map_info *map, unsigned long ofs)
 static inline void inline_map_write(struct map_info *map, const map_word datum, unsigned long ofs)
 {
 	if (map_bankwidth_is_1(map))
-		__raw_writeb(datum.x[0], map->virt + ofs);
+		writeb_relaxed(datum.x[0], map->virt + ofs);
 	else if (map_bankwidth_is_2(map))
-		__raw_writew(datum.x[0], map->virt + ofs);
+		writew_relaxed(datum.x[0], map->virt + ofs);
 	else if (map_bankwidth_is_4(map))
-		__raw_writel(datum.x[0], map->virt + ofs);
+		writel_relaxed(datum.x[0], map->virt + ofs);
 #if BITS_PER_LONG >= 64
 	else if (map_bankwidth_is_8(map))
-		__raw_writeq(datum.x[0], map->virt + ofs);
+		writeq_relaxed(datum.x[0], map->virt + ofs);
 #endif
 	else if (map_bankwidth_is_large(map))
 		memcpy_toio(map->virt+ofs, datum.x, map->bankwidth);
-- 
1.7.0.4
