From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 28 Feb 2011 14:12:34 -0700
Subject: [PATCH v2 9/9] OMAP2+: clockevent: set up GPTIMER clockevent hwmod
	right before timer init
In-Reply-To: <20110228210858.15286.3200.stgit@twilight.localdomain>
References: <20110228210858.15286.3200.stgit@twilight.localdomain>
Message-ID: <20110228211231.15286.48237.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set up the GPTIMER hwmod used for the clockevent source immediately
before it is used.  This avoids the need to set up all of the hwmods
until the boot process is further along.  (In general, we want to defer
as much as possible until late in the boot process.)

This second version fixes a bug pointed out by Santosh Shilimkar
<santosh.shilimkar@ti.com>, that would cause the kernel to use an
incorrect timer hwmod name if the selected GPTIMER was not 1 or 12 -
thanks Santosh.  Also, Tarun Kanti DebBarma <tarun.kanti@ti.com>
pointed out that the original patch did not apply cleanly; this has
now been fixed.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap2/timer-gp.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 7b7c268..fb8d656 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -39,10 +39,11 @@
 #include <asm/mach/time.h>
 #include <plat/dmtimer.h>
 #include <asm/localtimer.h>
+#include <plat/common.h>
+#include <plat/omap_hwmod.h>
 
 #include "timer-gp.h"
 
-#include <plat/common.h>
 
 /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
 #define MAX_GPTIMER_ID		12
@@ -132,9 +133,13 @@ static void __init omap2_gp_clockevent_init(void)
 {
 	u32 tick_rate;
 	int src;
+	char clockevent_hwmod_name[8]; /* 8 = sizeof("timerXX0") */
 
 	inited = 1;
 
+	sprintf(clockevent_hwmod_name, "timer%d", gptimer_id);
+	omap_hwmod_setup_one(clockevent_hwmod_name);
+
 	gptimer = omap_dm_timer_request_specific(gptimer_id);
 	BUG_ON(gptimer == NULL);
 	gptimer_wakeup = gptimer;
