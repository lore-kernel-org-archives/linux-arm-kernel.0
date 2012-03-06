From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 6 Mar 2012 10:54:08 +0200
Subject: [PATCHv3 1/4] ARM: OMAP4: suspend: Program all domains to
 retention
In-Reply-To: <4F55CE19.7000309@ti.com>
References: <1330529106-10423-1-git-send-email-t-kristo@ti.com>
 <1330529106-10423-2-git-send-email-t-kristo@ti.com> <871up6in50.fsf@ti.com>
 <1331022713.2116.144.camel@sokoban> <4F55CE19.7000309@ti.com>
Message-ID: <1331024048.2116.157.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-03-06 at 14:13 +0530, Rajendra Nayak wrote:
> On Tuesday 06 March 2012 02:01 PM, Tero Kristo wrote:
> > On Mon, 2012-03-05 at 16:33 -0800, Kevin Hilman wrote:
> >> Tero Kristo<t-kristo@ti.com>  writes:
> >>
> >>> From: Rajendra Nayak<rnayak@ti.com>
> >>>
> >>> Remove the FIXME's in the suspend sequence since
> >>> we now intend to support system level RET support.
> >>>
> >>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> >>> Signed-off-by: Tero Kristo<t-kristo@ti.com>
> >>> Reviewed-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
> >>
> >> So this is the only patch in this series that is still needed.  However...
> >>
> >> It doesn't seem like this all by itself is ready for mainline as we'll
> >> suddenly start putting all powerdomains in retention without any
> >> additional support.
> >>
> >> I guess at a minimum it needs working IO wakeup support from the IO
> >> daisy chain series.  Are there other dependencies here?
> >
> > Only IO chain is needed for wakeup capability. Actually even with the
> > current mainline kernel, I am unable to wake-up the device from MPU
> > retention, as there are no wakeup sources. So this patch doesn't really
> 
> Why?, doesn't debug console wakeup work?

At least I couldn't get it to work. I tried with no_console_suspend
kernel param to no avail. Don't know if I was missing something else.

-Tero

> 
> > change the behavior to worse even without any additional patches. :) But
> > yea, good to wait until IO chain is in.
> 
> IO chain, according to documentation :) should be needed only if you
> hit OSWR or OFF, async wakeups should be functional as long as you
> only hit CSWR.
> 
> >
> > The other dependencies are that the stuff handled by patches 2,3 and 4
> > have to be handled somehow:
> >
> > -patch2: must be in (this patch is queued by Paul)
> > -patch3: will be taken care of by Paul's pwrdm fixes (I guess this is
> > queued by Paul himself already)
> > -patch4: OMAP interrupt count must be increased (this is handled by
> > Benoit's patch, which is queued by Tony)
> >
> > -Tero
> >
> >>
> >> If not, I can queue this when Paul is ready to merge the IO wakeup
> >> stuff.
> >>
> >> Kevin
> >>
> >>> ---
> >>>   arch/arm/mach-omap2/pm44xx.c |    6 ------
> >>>   1 files changed, 0 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> >>> index c264ef7..1ab30a3 100644
> >>> --- a/arch/arm/mach-omap2/pm44xx.c
> >>> +++ b/arch/arm/mach-omap2/pm44xx.c
> >>> @@ -151,12 +151,6 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
> >>>   	if (!strncmp(pwrdm->name, "cpu", 3))
> >>>   		return 0;
> >>>
> >>> -	/*
> >>> -	 * FIXME: Remove this check when core retention is supported
> >>> -	 * Only MPUSS power domain is added in the list.
> >>> -	 */
> >>> -	if (strcmp(pwrdm->name, "mpu_pwrdm"))
> >>> -		return 0;
> >>>
> >>>   	pwrst = kmalloc(sizeof(struct power_state), GFP_ATOMIC);
> >>>   	if (!pwrst)
> >
> >
> 
