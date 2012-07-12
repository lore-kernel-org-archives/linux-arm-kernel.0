From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 12 Jul 2012 18:35:13 +0300
Subject: [PATCHv3 8/9] ARM: OMAP3: prevent per_clkdm from attempting
 manual domain transitions
In-Reply-To: <4FFE9BB9.7000209@ti.com>
References: <1338470942-20185-1-git-send-email-t-kristo@ti.com>
 <1338470942-20185-9-git-send-email-t-kristo@ti.com>
 <4FFE9BB9.7000209@ti.com>
Message-ID: <1342107313.4672.40.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-07-12 at 15:11 +0530, Rajendra Nayak wrote:
> On Thursday 31 May 2012 06:59 PM, Tero Kristo wrote:
> > Previously, PER clock domain was always enabled, as the usecounts
> > for this domain incorrectly always showed positive value. On HW
> > level though, the domain enters idle as it is set in HW supervised
> > mode. Now, when the usecounts reflect real values, PER domain will
> > attempt to enter software supervised idle, which is not supported by the
> > hardware/kernel that well, and causes multiple problems. First of all,
> > coming back from idle, PER domain remains idle as the wakedeps have
> > been disabled for the domain, and this causes a crash with the GPIO
> > code, as the resume code attempts to access domain which is not active.
> > Just enabling the interface clocks for the GPIO does not help, as they
> > are autoidled and don't bring the domain out of idle. Secondly, there
> > are multiple erratas for omap3, which say that the wakedeps should be
> > enabled for the PER domain, see e.g. errata i582 for omap3630.
> 
> If PER software supervised idle is so *buggy* then shouldn't the flags
> just reflect that PER *does not* support software supervised idle?
> Using a flag which reflects that the clkdm supports both hardware
> and software supervised idle ('CLKDM_CAN_HWSUP_SWSUP') and then using
> another one to actually skip putting it in software supervised sounds
> a little round about, no?
> Does updating the flag to 'CLKDM_CAN_HWSUP' also fix all the issues
> for you? without adding the additional 'CLKDM_SKIP_MANUAL_TRANS' flag.

Simple CAN_HWSUP doesn't work, as the whole problem is with HWSUP mode
and manual enabling / disabling of autodeps by kernel. I can rename the
flag to something like CLKDM_NO_AUTODEP_DISABLE and move the checking of
flag from the generic clockdomain code to omap3 clockdomain part though.

-Tero

> 
> >
> > Signed-off-by: Tero Kristo<t-kristo@ti.com>
> > ---
> >   arch/arm/mach-omap2/clockdomains3xxx_data.c |    2 +-
> >   1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
> > index 6038adb..0dae4c8 100644
> > --- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
> > +++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
> > @@ -282,7 +282,7 @@ static struct clockdomain usbhost_clkdm = {
> >   static struct clockdomain per_clkdm = {
> >   	.name		= "per_clkdm",
> >   	.pwrdm		= { .name = "per_pwrdm" },
> > -	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> > +	.flags		= CLKDM_CAN_HWSUP_SWSUP | CLKDM_SKIP_MANUAL_TRANS,
> >   	.dep_bit	= OMAP3430_EN_PER_SHIFT,
> >   	.wkdep_srcs	= per_wkdeps,
> >   	.sleepdep_srcs	= per_sleepdeps,
> 
