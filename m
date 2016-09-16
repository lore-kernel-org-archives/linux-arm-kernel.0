From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 16 Sep 2016 12:30:05 +0200 (CEST)
Subject: [PATCH] ARM: Kconfig: select GENERIC_CLOCKEVENTS_BROADCAST also
 on UP
In-Reply-To: <20160916102051.GG1041@n2100.armlinux.org.uk>
References: <1467993522-9176-1-git-send-email-l.stach@pengutronix.de>
 <1474018340.2243.103.camel@pengutronix.de>
 <20160916102051.GG1041@n2100.armlinux.org.uk>
Message-ID: <alpine.DEB.2.20.1609161223311.5384@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Sep 2016, Russell King - ARM Linux wrote:
> On Fri, Sep 16, 2016 at 11:32:20AM +0200, Lucas Stach wrote:
> > Hi Russell,
> > 
> > can you please take a look at this and tell if there is something wrong
> > about it, or if you think it can go in?
> > 
> > Without this patch the kernel is unable to use the deeper CPU idle
> > states on i.MX6S if it isn't built with SMP support enabled.
> 
> Without spending a lot of time digging into this code, working out what
> these configuration symbols do, I frankly don't know if it's a sensible
> thing to do or not.  I guess tglx knows this code like the back of his
> hand, and would be in a better position to comment.
> 
> There's two factors there:
> 1. the amount of undocumented code in the kernel needing the code to be
>    read and understood to understand various aspects of it from the
>    architecture point of view.

Yeah. I know that this stuff lacks documentation.
 
> 2. your architecture maintainer has done very little actual platform
>    development (not through his own choice) for the last 10 or so years,
>    which means he's not had to dig into these areas.
> 
> So, I'm afraid I feel less than qualified on this at the moment.  I'll
> try to look into this and talk to tglx to work out whether it's a
> sensible change. 

The broadcast feature has the following functionality:

    It lets you use fast accessible (cpu local) timers for normal operation
    and in case of deep idle sleeps where the cpu local timer stops switch
    to broadcast operation, which arms a slower to access (global) timer
    device which does not stop in deep idle.

    On UP we usually just use the global device, but on SMP we need the cpu
    local timers for normal (non idle) operation. Though there is no reason
    to restrict this UP from a technical POV especially when the local
    timer is way cheaper to access than the other device.

Hope that helps.

> As I never had a reply to my last email to tglx about threaded interrupts
> vs tasklets (for a reported performance regression in my crypto patches
> already queued for the next merge window) I'm not hoping for much help.

Sorry, got lost in my mail backlog. Looking at it next.

Thanks,

	tglx
