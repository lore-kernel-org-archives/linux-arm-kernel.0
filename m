From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 24 Feb 2011 01:13:38 -0700 (MST)
Subject: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent
	hwmodright before timer init
In-Reply-To: <581270b49665fcf8227a96065dbbc584@mail.gmail.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
	<20110223071153.5874.58923.stgit@twilight.localdomain>
	<581270b49665fcf8227a96065dbbc584@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1102240109500.6198@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Santosh,

On Wed, 23 Feb 2011, Santosh Shilimkar wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul at pwsan.com]
> > Sent: Wednesday, February 23, 2011 12:42 PM
> >
> > diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-
> > omap2/timer-gp.c
> > index 0fc550e..a4e51a2 100644
> > --- a/arch/arm/mach-omap2/timer-gp.c
> > +++ b/arch/arm/mach-omap2/timer-gp.c
> > @@ -40,10 +40,11 @@
> >  #include <plat/dmtimer.h>
> >  #include <asm/localtimer.h>
> >  #include <asm/sched_clock.h>
> > +#include <plat/common.h>
> >
> >  #include "timer-gp.h"
> > +#include <plat/omap_hwmod.h>
> >
> > -#include <plat/common.h>
> >
> >  /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
> >  #define MAX_GPTIMER_ID		12
> > @@ -133,9 +134,13 @@ static void __init
> > omap2_gp_clockevent_init(void)
> >  {
> >  	u32 tick_rate;
> >  	int src;
> > +	const char *clockevent_hwmod_name;
> >
> >  	inited = 1;
> >
> > +	clockevent_hwmod_name = (gptimer_id == 12) ? "timer12" :
> > "timer1";
> > +	omap_hwmod_late_init_one(clockevent_hwmod_name);
> > +
> 
> Do we need above hard-coding ? This takes away flexibility of
> choosing system timer from board files, right ?
> 
> Am I missing something here?

You are absolutely right.  That was an error on my part.  I propose the 
following change instead - please let me know what you think.


- Paul


From: Paul Walmsley <paul@pwsan.com>
Date: Wed, 23 Feb 2011 00:14:08 -0700
Subject: [PATCH] OMAP2+: clockevent: late-init GPTIMER clockevent hwmod right before timer init

Late-initialize the GPTIMER hwmod used for the clockevent source immediately
before it is used.  This avoids the need to late-initialize all of the hwmods
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
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap2/timer-gp.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 7b7c268..d23767f 100644
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
+	char *clockevent_hwmod_name;
 
 	inited = 1;
 
+	sprintf(clockevent_hwmod_name, "timer%d", gptimer_id);
+	omap_hwmod_late_init_one(clockevent_hwmod_name);
+
 	gptimer = omap_dm_timer_request_specific(gptimer_id);
 	BUG_ON(gptimer == NULL);
 	gptimer_wakeup = gptimer;
-- 
1.7.2.3
