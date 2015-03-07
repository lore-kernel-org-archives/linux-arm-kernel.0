From: gradator@gradator.net (Sylvain Rochet)
Date: Sat, 7 Mar 2015 11:59:53 +0100
Subject: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
In-Reply-To: <20150307103939.GA17964@amd>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150304183809.GD22156@leverpostej>
 <20150305095306.3db98ac8@bbrezillon>
 <20150305105308.GA13617@leverpostej>
 <20150305121723.1da0d016@bbrezillon>
 <20150305115307.GA14093@leverpostej>
 <20150307091846.GN23367@worktop.ger.corp.intel.com>
 <20150307102056.GA28436@gradator.net> <20150307103939.GA17964@amd>
Message-ID: <20150307105953.GC28436@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,


On Sat, Mar 07, 2015 at 11:39:39AM +0100, Pavel Machek wrote:
> On Sat 2015-03-07 11:20:56, Sylvain Rochet wrote:
> > Hello,
> > 
> > On Sat, Mar 07, 2015 at 10:18:46AM +0100, Peter Zijlstra wrote:
> > > On Thu, Mar 05, 2015 at 11:53:08AM +0000, Mark Rutland wrote:
> > > > If everyone else is happy with this using IRQF_NO_SUSPEND for now then
> > > > don't let my comments above block this patch.
> > > 
> > > Yeah, I'm really not happy with NO_SUSPEND + enable_irq_wake().
> > > 
> > > I really want that combo to BUG/WARN -- esp. since there's so much cargo
> > > culted crap out there.
> > > 
> > > We should make robust interfaces, not randomly toggle flags until it
> > > mostly works by accident rather than by design -- which is what this
> > > feels like.
> > > 
> > > And while I appreciate the watchdog use-case; I think the easiest
> > > solution for now is to simply disable the wathdog over suspend until
> > > we've come up with something that makes sense.
> > > 
> > > As it is, you need to 'suspend' the watchdog at some point anyhow; you
> > > don't want that thing to wake you from whatever suspend state you're in.
> > 
> > The Atmel watchdog can't be stopped once it's started. This is actually 
> > very useful so we can reset if suspend or resume failed, the only 
> > drawback is that you have to wake up from time to time (e.g. by using 
> > the RTC/RTT) to clear the watchdog and then go back to sleep ASAP.
> 
> Yeah. So you do "echo mem > /sys/power/state", and few seconds/minutes
> after watchdog kills the system. But you did not ask for dead system,
> you asked for suspend.

Yeah, that's why I'm setting the RTC/RTT in the pm_enter() callback on 
our products. On wake-up I'm checking if we woke up using the RTC/RTT in 
the pm_suspend_again() callback, if true we clear the watchdog and we go 
back to sleep. This can't easily be mainlined because it adds 
RTC/RTT/WDT calls from PM code, which will not be accepted anyway.


> And while that behaviour is useful for you, I don't think it is
> exactly useful behaviour, nor it is the behaviour user would expect.

I agree, but it still can't be stopped, IMHO users wanting to suspend 
without being protected by the watchdog during suspend and resume should 
just don't use the hardware watchdog at all, they are already missing 
the watchdog in a tricky area where the kernel can fail more than 
anywhere else, the software watchdog should be fine as well for them.


Sylvain
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150307/8947ab85/attachment.sig>
