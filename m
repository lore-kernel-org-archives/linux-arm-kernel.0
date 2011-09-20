From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Tue, 20 Sep 2011 17:00:22 +0530
Subject: [PATCH v16 07/12] OMAP: dmtimer: add timeout to low-level routines
In-Reply-To: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1316518227-28116-8-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The low-level read and write access routines wait on write-pending register
in posted mode to make sure that previous write is complete on respective
registers. This waiting is done in an infinite while loop. Now it is being
modified to use timeout instead.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/plat-omap/include/plat/dmtimer.h |   29 +++++++++++++++++++++++------
 1 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 351b6cd..e29adfa 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -37,6 +37,8 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 
+#include <plat/common.h>
+
 #ifndef __ASM_ARCH_DMTIMER_H
 #define __ASM_ARCH_DMTIMER_H
 
@@ -227,6 +229,9 @@ int omap_dm_timers_active(void);
 #define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
 		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
 
+/* 10ms timeout delay */
+#define MAX_WRITE_PEND_WAIT            10000
+
 struct omap_dm_timer {
 	unsigned long phys_base;
 	int id;
@@ -254,9 +259,15 @@ int omap_dm_timer_prepare(struct omap_dm_timer *timer);
 static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
 						int posted)
 {
-	if (posted)
-		while (__raw_readl(timer->pend) & (reg >> WPSHIFT))
-			cpu_relax();
+	int i = 0;
+
+	if (posted) {
+		omap_test_timeout(!(__raw_readl(timer->pend) & (reg >> WPSHIFT))
+						, MAX_WRITE_PEND_WAIT, i);
+
+		if (WARN_ON_ONCE(i == MAX_WRITE_PEND_WAIT))
+			pr_err("Read timeout!\n");
+	}
 
 	return __raw_readl(timer->func_base + (reg & 0xff));
 }
@@ -264,9 +275,15 @@ static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
 static inline void __omap_dm_timer_write(struct omap_dm_timer *timer,
 					u32 reg, u32 val, int posted)
 {
-	if (posted)
-		while (__raw_readl(timer->pend) & (reg >> WPSHIFT))
-			cpu_relax();
+	int i = 0;
+
+	if (posted) {
+		omap_test_timeout(!(__raw_readl(timer->pend) & (reg >> WPSHIFT))
+						, MAX_WRITE_PEND_WAIT, i);
+
+		if (WARN_ON_ONCE(i == MAX_WRITE_PEND_WAIT))
+			pr_err("Write timeout!\n");
+	}
 
 	__raw_writel(val, timer->func_base + (reg & 0xff));
 }
-- 
1.7.0.4
