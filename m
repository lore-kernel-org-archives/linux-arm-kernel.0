From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 26 Feb 2015 16:47:24 +0100
Subject: [RFC PATCH 0/3] genirq: mixing IRQF_NO_SUSPEND and wakeup
 sources on shared IRQs
In-Reply-To: <20964379.cuQSlojCVH@vostro.rjw.lan>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com>
 <2154999.DTKV1bGBcx@vostro.rjw.lan>
 <20150226090347.777c47ec@bbrezillon>
 <20964379.cuQSlojCVH@vostro.rjw.lan>
Message-ID: <20150226164724.4f3c5921@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Feb 2015 16:44:16 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Thursday, February 26, 2015 09:03:47 AM Boris Brezillon wrote:
> > Hi Rafael,
> > 
> > On Wed, 25 Feb 2015 22:59:36 +0100
> > "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> > 
> > > On Tuesday, February 24, 2015 10:55:59 AM Boris Brezillon wrote:
> > > > Hello,
> > > > 
> > > > I put the IRQF_NO_SUSPEND_SAFE/IRQF_TIMER_SIBLING_OK/WHATEVER_NAME_YOU_CHOOSE
> > > > debate aside to concentrate on another problem pointed out by Rafael and
> > > > Mark: the fact that we cannot mix IRQF_NO_SUSPEND and wakeup sources on
> > > > a shared IRQ line.
> > > > 
> > > > This is because the wakeup code is prevailing the IRQF_NO_SUSPEND case
> > > > and will trigger a system wakeup as soon as the IRQ line is tagged as a
> > > > wakeup source.
> > > > 
> > > > This series propose an approach to deal with such cases by doing the
> > > > following:
> > > > 1/ Prevent any system wakeup when at least one of the IRQ user has set
> > > >    the IRQF_NO_SUSPEND flag
> > > > 2/ Adapt IRQ handlers so that they can safely be called in suspended
> > > >    state
> > > > 3/ Let drivers decide when the system should be woken up
> > > > 
> > > > Let me know what you think of this approach.
> > > 
> > > So I have the appended patch that should deal with all that too (it doesn't
> > > rework drivers that need to share NO_SUSPEND IRQs and do wakeup, but that
> > > can be done on top of it in a straightforward way).
> > > 
> > > The idea is quite simple.  By default, the core replaces the interrupt handlers
> > > of everyone sharing NO_SUSPEND lines and not using IRQF_NO_SUSPEND with a null
> > > handler always returning IRQ_NONE at the suspend_device_irqs() time (the
> > > rationale being that if you don't use IRQF_NO_SUSPEND, then your device has
> > > no reason to generate interrupts after that point).  The original handlers are
> > > then restored by resume_device_irqs().
> > > 
> > > However, if the IRQ is configured for wakeup, there may be a reason to generate
> > > interrupts from a device not using IRQF_NO_SUSPEND.  For that, the patch adds
> > > IRQF_COND_SUSPEND that, if set, will prevent the default behavior described
> > > above from being applied to irqactions using it if the IRQs in question are
> > > configured for wakeup.  Of course, the users of IRQF_COND_SUSPEND are supposed
> > > to implement wakeup detection in their interrupt handlers and then call
> > > pm_system_wakeup() if necessary.
> > 
> > That patch sounds good to me.
> 
> But it is still a bit risky.  Namely, if the driver in question is sufficiently
> broken (eg. it may not suspend the device and rely on the fact that its interrupt
> handler will be run just because it is sharing a "no suspend" IRQ), we may get
> an interrupt storm.
> 
> Isn't that a problem?

For me no (I'll fix all the drivers to handle wakeup, and they are all
already masking interrupts coming from their side in the suspend
callback).
I can't talk for other people though.
The only problem I see here is that you're not informing people that
they are erroneously mixing IRQF_NO_SUSPEND and !IRQF_NO_SUSPEND anymore
(you removed the warning backtrace).
Moreover, you are replacing their handler by a stub when entering
suspend, so they might end-up receiving spurious interrupts when
suspended without knowing why ?

How about checking if the number of actions registered with
IRQF_NO_SUSPEND + those registered with IRQF_COND_SUSPEND (or another
flag stating that the handler can safely be called in suspended state
even if it didn't ask for NO_SUSPEND) are equal to the total number of
registered actions, and complain if it's not the case.
If some actions are offending this rule, you could keep the previous
behavior by leaving its handler in place when entering suspend so that
existing drivers/systems will keep working (but with a warning
backtrace).

> 
> > Could you send it on its own to the appropriate MLs ?
> 
> Sure, I can do that, but I'd like to hear from the other people on the CC first.

Sure, but that doesn't prevent sending it as an RFC, you'll still have
the same review ;-).




-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
