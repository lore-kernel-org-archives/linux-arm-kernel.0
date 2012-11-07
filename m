From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 7 Nov 2012 13:01:25 -0600
Subject: [PATCH V2 09/14] ARM: OMAP: Don't restore of DMTIMER TISTAT register
In-Reply-To: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1352314890-22224-10-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer TISTAT register is a read-only register and therefore restoring the
context is not needed. Furthermore, the context of TISTAT is never saved
anywhere in the current code. The TISTAT register is read-only for all OMAP
devices from OMAP1 to OMAP4. OMAP5 timers no longer have this register.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |    3 ---
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 -
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 5a9f29b..a350f12 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -86,9 +86,6 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
 
 static void omap_timer_restore_context(struct omap_dm_timer *timer)
 {
-	if (timer->revision == 1)
-		__raw_writel(timer->context.tistat, timer->sys_stat);
-
 	__raw_writel(timer->context.tisr, timer->irq_stat);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG,
 				timer->context.twer);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index ef93017..36b71a5 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -85,7 +85,6 @@ struct omap_dm_timer;
 
 struct timer_regs {
 	u32 tidr;
-	u32 tistat;
 	u32 tisr;
 	u32 tier;
 	u32 twer;
-- 
1.7.9.5
