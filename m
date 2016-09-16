From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 16 Sep 2016 13:08:53 +0200
Subject: [PATCH] ARM: Kconfig: select GENERIC_CLOCKEVENTS_BROADCAST also
 on UP
In-Reply-To: <alpine.DEB.2.20.1609161223311.5384@nanos>
References: <1467993522-9176-1-git-send-email-l.stach@pengutronix.de>
 <1474018340.2243.103.camel@pengutronix.de>
 <20160916102051.GG1041@n2100.armlinux.org.uk>
 <alpine.DEB.2.20.1609161223311.5384@nanos>
Message-ID: <1474024133.2243.117.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 16.09.2016, 12:30 +0200 schrieb Thomas Gleixner:
> On Fri, 16 Sep 2016, Russell King - ARM Linux wrote:
> > On Fri, Sep 16, 2016 at 11:32:20AM +0200, Lucas Stach wrote:
> > > Hi Russell,
> > > 
> > > can you please take a look at this and tell if there is something wrong
> > > about it, or if you think it can go in?
> > > 
> > > Without this patch the kernel is unable to use the deeper CPU idle
> > > states on i.MX6S if it isn't built with SMP support enabled.
> > 
> > Without spending a lot of time digging into this code, working out what
> > these configuration symbols do, I frankly don't know if it's a sensible
> > thing to do or not.  I guess tglx knows this code like the back of his
> > hand, and would be in a better position to comment.
> > 
> > There's two factors there:
> > 1. the amount of undocumented code in the kernel needing the code to be
> >    read and understood to understand various aspects of it from the
> >    architecture point of view.
> 
> Yeah. I know that this stuff lacks documentation.
>  
> > 2. your architecture maintainer has done very little actual platform
> >    development (not through his own choice) for the last 10 or so years,
> >    which means he's not had to dig into these areas.
> > 
> > So, I'm afraid I feel less than qualified on this at the moment.  I'll
> > try to look into this and talk to tglx to work out whether it's a
> > sensible change. 
> 
> The broadcast feature has the following functionality:
> 
>     It lets you use fast accessible (cpu local) timers for normal operation
>     and in case of deep idle sleeps where the cpu local timer stops switch
>     to broadcast operation, which arms a slower to access (global) timer
>     device which does not stop in deep idle.
> 
>     On UP we usually just use the global device, but on SMP we need the cpu
>     local timers for normal (non idle) operation. Though there is no reason
>     to restrict this UP from a technical POV especially when the local
>     timer is way cheaper to access than the other device.
> 
> Hope that helps.

What I take from this is that the i.MX6 decision to use the local timer
for normal operation on UP is sane, as it's both cheaper to access, as
well as providing higher accuracy.

In fact this behavior has been explicitly enabled by a patch "ARM: imx:
always use TWD on IMX6Q" from Sebastian Andrzej Siewior to get better
responsiveness in cyclictest.

So the subject patch is actually a regression fix, as we now need the
timer broadcast infrastructure to be able to use the deeper idle states,
instead of having them enabled by always using the global timer on UP.

Russell, okay to put it in the patch system?

Regards,
Lucas
