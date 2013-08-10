From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 10 Aug 2013 09:43:01 -0300
Subject: [PATCH 2/3] clocksource: orion: Use atomic access for shared registers
In-Reply-To: <1376138582-7550-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1376138582-7550-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1376138582-7550-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the driver-specific thread-safe shared register API
by the recently introduced atomic_io_clear_set().

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/clocksource/time-orion.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/time-orion.c b/drivers/clocksource/time-orion.c
index ecbeb68..4334ea7 100644
--- a/drivers/clocksource/time-orion.c
+++ b/drivers/clocksource/time-orion.c
@@ -35,20 +35,15 @@
 #define ORION_ONESHOT_MAX	0xfffffffe
 
 static void __iomem *timer_base;
-static DEFINE_SPINLOCK(timer_ctrl_lock);
 
 /*
  * Thread-safe access to TIMER_CTRL register
  * (shared with watchdog timer)
  */
-void orion_timer_ctrl_clrset(u32 clr, u32 set)
+static void orion_timer_ctrl_clrset(u32 clr, u32 set)
 {
-	spin_lock(&timer_ctrl_lock);
-	writel((readl(timer_base + TIMER_CTRL) & ~clr) | set,
-		timer_base + TIMER_CTRL);
-	spin_unlock(&timer_ctrl_lock);
+	atomic_io_clear_set(timer_base + TIMER_CTRL, clr, set);
 }
-EXPORT_SYMBOL(orion_timer_ctrl_clrset);
 
 /*
  * Free-running clocksource handling.
-- 
1.8.1.5
