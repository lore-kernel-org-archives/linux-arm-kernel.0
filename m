From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 21 Feb 2011 14:23:07 +0530
Subject: [PATCH] perf: add OMAP support for the new power events
In-Reply-To: <AANLkTiktdLja39dC38E_LciYZK7+pTp3_Sgm9jf5FA4R@mail.gmail.com>
References: <1298052645-4164-1-git-send-email-j-pihet@ti.com><ec45f3f591691ce6a5253dfb70cc8e90@mail.gmail.com>
	<AANLkTiktdLja39dC38E_LciYZK7+pTp3_Sgm9jf5FA4R@mail.gmail.com>
Message-ID: <5dad46ab75a15145f907aeca53f769c1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Jean Pihet [mailto:jean.pihet at newoldbits.com]
> Sent: Monday, February 21, 2011 2:14 PM
> To: Santosh Shilimkar
> Cc: Kevin Hilman; Thomas Renninger; linux-omap at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; Jean Pihet-XID
> Subject: Re: [PATCH] perf: add OMAP support for the new power events
>
> Hi Santosh,
>

[...]

> >> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-
> >> omap2/pm34xx.c
> >> index 2f864e4..d1cc3f4 100644
> >> --- a/arch/arm/mach-omap2/pm34xx.c
> >> +++ b/arch/arm/mach-omap2/pm34xx.c
> >> @@ -29,6 +29,7 @@
> >> ?#include <linux/delay.h>
> >> ?#include <linux/slab.h>
> >> ?#include <linux/console.h>
> >> +#include <trace/events/power.h>
> >>
> >> ?#include <plat/sram.h>
> >> ?#include "clockdomain.h"
> >> @@ -519,8 +520,14 @@ static void omap3_pm_idle(void)
> >> ? ? ? if (omap_irq_pending() || need_resched())
> >> ? ? ? ? ? ? ? goto out;
> >>
> >> + ? ? trace_power_start(POWER_CSTATE, 1, smp_processor_id());
> >> + ? ? trace_cpu_idle(1, smp_processor_id());
> >> +
> >
> > This default idle code won't be used when you enable the
> > CONFIG_CPUIDLE. That case the cpuidle34xx.c idle code gets
> > registered.
> That is correct. OMAP has a default idle handler (omap3_pm_idle) and
> a
> cpuidle handler (omap3_enter_idle in
> arch/arm/mach-omap2/cpuidle34xx.c).
>
> > Shouldn't you patch that code instead? This is more or less
> > dead code and it is just like default idle code when idle
> > drivers isn't registered.
> The cpuidle framework already is instrumented in a generic way. This
> code adds the instrumentation to the default idle handler so that
> all
> cases are covered. BTW the patch description gives that information.
>
> If there is dead code then it is not only the code from this patch
> but
> all the code for the default idle handler.
>
I read your change log. It says.

>> The trace points are for:
>> - default idle handler. Since the cpuidle framework is
>> ? instrumented in the generic way there is no need to
>> ? add trace points in the OMAP specific cpuidle handler;
Now code in cpuilde34xx.c is also OMAP specific and hence the
confusion at least for me.
Regarding dead code, I meant existing code of default handler.

Thanks for clarification.

Regards,
Santosh
