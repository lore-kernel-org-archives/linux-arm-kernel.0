From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 15 Jul 2011 02:10:46 -0600 (MDT)
Subject: [PATCH] OMAP: powerdomains: Make all powerdomain target states
	as ON at init
In-Reply-To: <20110715080315.GC2611@legolas.emea.dhcp.ti.com>
References: <1310527588-13022-1-git-send-email-santosh.shilimkar@ti.com>
	<20110715080315.GC2611@legolas.emea.dhcp.ti.com>
Message-ID: <alpine.DEB.2.00.1107150204510.16606@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 15 Jul 2011, Felipe Balbi wrote:

> > diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> > index e0490bc..e61866c 100644
> > --- a/arch/arm/mach-omap2/powerdomain.c
> > +++ b/arch/arm/mach-omap2/powerdomain.c
> > @@ -109,6 +109,16 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
> >  
> >  	list_add(&pwrdm->node, &pwrdm_list);
> >  
> > +	/*
> > +	* Program all powerdomain target state as ON; This is to
> > +	* prevent domains from hitting low power states (if bootloader
> > +	* has target states set to something other than ON) and potentially
> > +	* even losing context while PM is not fully initilized.
> > +	* The PM late init code can then program the desired target
> > +	* state for all the power domains.
> > +	*/
> > +	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_ON);
> 
> Just out of curiosity, I was wondering if it really makes sense to power
> up all power domains during boot just to avoid loosing context. Doesn't
> hwmod/omap_device soft-reset all IPs during initialization ? If that's
> really the case, shouldn't we then choose which powerdomains are
> strictly necessary for boot and only power those up ?
> 
> Sorry if this is a non-sensical question, but I was curious about it
> ;-)

This patch only sets the powerdomain's next power state to ON.  It doesn't 
affect the current power state of the powerdomain.

Let's say that the bootloader, previous OS (in the kexec case), or ROM 
code programs the next power state of some powerdomains to OFF.  Let's 
also say that the kernel that is booted has PM disabled.  The moment a 
powerdomain's clockdomains go inactive, the powerdomain will then switch 
off and all devices in that powerdomain will lose context.  On a 
non-PM-enabled kernel, that will be unexpected and will probably cause the 
system to crash.  This patch prevents that from happening.


- Paul
