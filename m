From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 31 Jan 2011 13:36:09 +0100
Subject: [PATCH] ARM: pxa: fix suspend on PXA3XX
In-Reply-To: <AANLkTimUg=y49H6THn5s7f7v418W68fhAsMLZGnDqabF@mail.gmail.com>
References: <20110124101701.GE16202@n2100.arm.linux.org.uk>
	<1296029447.2013.8.camel@sven>
	<AANLkTimUg=y49H6THn5s7f7v418W68fhAsMLZGnDqabF@mail.gmail.com>
Message-ID: <201101311336.09994.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 January 2011 15:46:54 Eric Miao wrote:
> On Wed, Jan 26, 2011 at 4:10 PM, Sven Neumann <s.neumann@raumfeld.com> wrote:
> > On Wed, 2011-01-26 at 05:06 +0800, Eric Miao wrote:
> >> How about this instead?
> >> 
> >> diff --git a/arch/arm/mach-pxa/pm.c b/arch/arm/mach-pxa/pm.c
> >> index 978e1b2..1807c9a 100644
> >> --- a/arch/arm/mach-pxa/pm.c
> >> +++ b/arch/arm/mach-pxa/pm.c
> >> @@ -33,7 +33,7 @@ int pxa_pm_enter(suspend_state_t state)
> >>  #endif
> >> 
> >>       /* skip registers saving for standby */
> >> -     if (state != PM_SUSPEND_STANDBY) {
> >> +     if (state != PM_SUSPEND_STANDBY && pxa_cpu_pm_fns->save) {
> >>               pxa_cpu_pm_fns->save(sleep_save);
> >>               /* before sleeping, calculate and save a checksum */
> >>               for (i = 0; i < pxa_cpu_pm_fns->save_count - 1; i++)
> >> @@ -44,7 +44,7 @@ int pxa_pm_enter(suspend_state_t state)
> >>       pxa_cpu_pm_fns->enter(state);
> >>       cpu_init();
> >> 
> >> -     if (state != PM_SUSPEND_STANDBY) {
> >> +     if (state != PM_SUSPEND_STANDBY && pxa_cpu_pm_fns->restore) {
> >>               /* after sleeping, validate the checksum */
> >>               for (i = 0; i < pxa_cpu_pm_fns->save_count - 1; i++)
> >>                       checksum += sleep_save[i];
> > 
> > Not sure if that will work as well. With this change the code is
> > skipping more than just the calls to pxa_cpu_pm_fns->save() and
> > pxa_cpu_pm_fns->restore(). In particular it doesn't call
> > pxa_cpu_pm_fns->enter(state).
> 
> Nah, that ->enable() is called if the checksum is incorrect. Please compare
> with the original code?

I won't hesitate to Ack Eric's code. It looks to me as a much cleaner solution.
> 
> > Thanks,
> > Sven
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
