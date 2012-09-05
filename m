From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 5 Sep 2012 14:04:28 -0500
Subject: [PATCH 06/10] ARM: OMAP: Fix dmtimer reset for timer1
In-Reply-To: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
References: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1346871872-24413-7-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit e32f7ec2 (ARM: OMAP: Fix 32 kHz timer and modify GP timer to use GPT1)
a fix was added to prevent timer1 being reset in the function
omap_dm_timer_reset() because timer1 was being used as the system timer for
OMAP2 devices. Although timer1 is still used by most OMAP2+ devices as a system
timer, the function omap_dm_timer_reset() is now only being called for OMAP1
devices and OMAP1 does not use timer1 as a system timer. Therefore, remove the
check in omap_dm_timer_reset() so that timer1 is reset for OMAP1 devices.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 22790ea..623c1f3 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -122,10 +122,8 @@ static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
 
 static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 {
-	if (timer->pdev->id != 1) {
-		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
-		omap_dm_timer_wait_for_reset(timer);
-	}
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
+	omap_dm_timer_wait_for_reset(timer);
 	__omap_dm_timer_reset(timer, 0, 0);
 }
 
-- 
1.7.9.5
