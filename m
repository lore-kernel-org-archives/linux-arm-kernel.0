From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 24 Feb 2011 14:27:13 +0530
Subject: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent
	hwmodright before timer init
In-Reply-To: <alpine.DEB.2.00.1102240114160.6198@utopia.booyaka.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
	<20110223071153.5874.58923.stgit@twilight.localdomain>
	<581270b49665fcf8227a96065dbbc584@mail.gmail.com>
	<alpine.DEB.2.00.1102240109500.6198@utopia.booyaka.com>
	<alpine.DEB.2.00.1102240114160.6198@utopia.booyaka.com>
Message-ID: <1f61c4651cf90f6a906f042ee4ec8c27@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Thursday, February 24, 2011 1:45 PM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Tony Lindgren; Kevin Hilman; Benoit
> Cousson
> Subject: RE: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER
> clockevent hwmodright before timer init
>
> Hello Santosh,
>
> On Thu, 24 Feb 2011, Paul Walmsley wrote:
>
> > I propose the following change instead - please let me know what
> you
> > think.
>
> Oops - the patch I sent you was not completely refreshed in the
> local
> tree.  Here is the correct one.
>
>
> - Paul
>
> From: Paul Walmsley <paul@pwsan.com>
> Date: Wed, 23 Feb 2011 00:14:08 -0700
> Subject: [PATCH] OMAP2+: clockevent: late-init GPTIMER clockevent
> hwmod right before timer init
>
> Late-initialize the GPTIMER hwmod used for the clockevent source
> immediately
> before it is used.  This avoids the need to late-initialize all of
> the hwmods
> until the boot process is further along.  (In general, we want to
> defer
> as much as possible until late in the boot process.)
>
> This second version fixes a bug pointed out by Santosh Shilimkar
> <santosh.shilimkar@ti.com>, that would cause the kernel to use an
> incorrect timer hwmod name if the selected GPTIMER was not 1 or 12 -
> thanks Santosh.  Also, Tarun Kanti DebBarma <tarun.kanti@ti.com>
> pointed out that the original patch did not apply cleanly; this has
> now been fixed.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Beno?t Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
Looks good and thanks for fixing this one.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

>  arch/arm/mach-omap2/timer-gp.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-
> omap2/timer-gp.c
> index 7b7c268..b289d53 100644
> --- a/arch/arm/mach-omap2/timer-gp.c
> +++ b/arch/arm/mach-omap2/timer-gp.c
> @@ -39,10 +39,11 @@
>  #include <asm/mach/time.h>
>  #include <plat/dmtimer.h>
>  #include <asm/localtimer.h>
> +#include <plat/common.h>
> +#include <plat/omap_hwmod.h>
>
>  #include "timer-gp.h"
>
> -#include <plat/common.h>
>
>  /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
>  #define MAX_GPTIMER_ID		12
> @@ -132,9 +133,13 @@ static void __init
> omap2_gp_clockevent_init(void)
>  {
>  	u32 tick_rate;
>  	int src;
> +	char clockevent_hwmod_name[8]; /* 8 = sizeof("timerXX0") */
>
>  	inited = 1;
>
> +	sprintf(clockevent_hwmod_name, "timer%d", gptimer_id);
> +	omap_hwmod_late_init_one(clockevent_hwmod_name);
> +
>  	gptimer = omap_dm_timer_request_specific(gptimer_id);
>  	BUG_ON(gptimer == NULL);
>  	gptimer_wakeup = gptimer;
> --
> 1.7.2.3
