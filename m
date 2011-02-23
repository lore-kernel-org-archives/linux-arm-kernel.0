From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 23 Feb 2011 00:11:54 -0700
Subject: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent hwmod
	right before timer init
In-Reply-To: <20110223070455.5874.51326.stgit@twilight.localdomain>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
Message-ID: <20110223071153.5874.58923.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Late-initialize the GPTIMER hwmod used for the clockevent source immediately
before it is used.  This avoids the need to late-initialize all of the hwmods
until the boot process is further along.  (In general, we want to defer
as much as possible until late in the boot process.)

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/timer-gp.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 0fc550e..a4e51a2 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -40,10 +40,11 @@
 #include <plat/dmtimer.h>
 #include <asm/localtimer.h>
 #include <asm/sched_clock.h>
+#include <plat/common.h>
 
 #include "timer-gp.h"
+#include <plat/omap_hwmod.h>
 
-#include <plat/common.h>
 
 /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
 #define MAX_GPTIMER_ID		12
@@ -133,9 +134,13 @@ static void __init omap2_gp_clockevent_init(void)
 {
 	u32 tick_rate;
 	int src;
+	const char *clockevent_hwmod_name;
 
 	inited = 1;
 
+	clockevent_hwmod_name = (gptimer_id == 12) ? "timer12" : "timer1";
+	omap_hwmod_late_init_one(clockevent_hwmod_name);
+
 	gptimer = omap_dm_timer_request_specific(gptimer_id);
 	BUG_ON(gptimer == NULL);
 	gptimer_wakeup = gptimer;
@@ -250,6 +255,7 @@ static void __init omap2_gp_timer_init(void)
 		BUG_ON(!twd_base);
 	}
 #endif
+
 	omap_dm_timer_init();
 
 	omap2_gp_clockevent_init();
