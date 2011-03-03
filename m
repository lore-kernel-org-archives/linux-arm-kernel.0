From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 3 Mar 2011 12:10:27 +0100
Subject: [PATCH 0/8] OMAP2+: hwmod/clockevent: allow late-init of
	individual hwmods
In-Reply-To: <20110302175422.GY20560@atomide.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
	<4D651998.3040002@ti.com>
	<alpine.DEB.2.00.1102271928550.505@utopia.booyaka.com>
	<4D6B845A.9000900@ti.com> <20110302175422.GY20560@atomide.com>
Message-ID: <4D6F7723.5040001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/2/2011 6:54 PM, Tony Lindgren wrote:
>> On 2/28/2011 3:31 AM, Paul Walmsley wrote:
>>> Tony, I guess the omap-for-linus branch will probably need to get rebuilt
>>> to drop that patch, once this series is merged...
>
> Let's rather apply a fix or revert instead than start messing with
> omap-for-linus. That branch is supposed to be a stable base for others
> to base their branches on.

Paul,

It is probably better to add the fix in that series at the same time you 
setup the timer hwmod in the following commit 38698bef5454.
It will avoid breaking bisect.

Regards,
Benoit

---
 From 35e0aff709a7ea27c65e08c7bd5d904d3193ec75 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Wed, 23 Feb 2011 00:14:08 -0700
Subject: [PATCH] OMAP2+: clockevent: set up GPTIMER clockevent hwmod 
right before timer init
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

Revert as well commit 3b03b58dab847883e6b9a431558c7d8e43fa94c6:
"OMAP4: hwmod data: Prevent timer1 to be reset and idle during init",
that is not longer needed since hwmod is setup before timer used it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno??t Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 -
  arch/arm/mach-omap2/timer-gp.c             |    7 ++++++-
  2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c 
b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 2c58827..b4d3b3c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3989,7 +3989,6 @@ static struct omap_hwmod_ocp_if 
*omap44xx_timer1_slaves[] = {
  static struct omap_hwmod omap44xx_timer1_hwmod = {
  	.name		= "timer1",
  	.class		= &omap44xx_timer_1ms_hwmod_class,
-	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
  	.mpu_irqs	= omap44xx_timer1_irqs,
  	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer1_irqs),
  	.main_clk	= "timer1_fck",
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
-- 
1.7.0.4
