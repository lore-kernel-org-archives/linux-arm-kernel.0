From: jszhang@marvell.com (Jisheng Zhang)
Date: Sat, 4 Jul 2015 21:16:02 +0800
Subject: [PATCH v2 2/2] irqchip: dw-apb-ictl: add irq_set_affinity support
In-Reply-To: <alpine.DEB.2.11.1507041437470.3916@nanos>
References: <1435987170-3962-1-git-send-email-jszhang@marvell.com>
 <1435987170-3962-3-git-send-email-jszhang@marvell.com>
 <20150704082623.GA7557@n2100.arm.linux.org.uk>
 <alpine.DEB.2.11.1507041151010.3916@nanos>
 <20150704100827.GC7557@n2100.arm.linux.org.uk>
 <alpine.DEB.2.11.1507041437470.3916@nanos>
Message-ID: <20150704211602.2b8c3632@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Thomas,

On Sat, 4 Jul 2015 14:49:31 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Sat, 4 Jul 2015, Russell King - ARM Linux wrote:
> > On Sat, Jul 04, 2015 at 11:53:57AM +0200, Thomas Gleixner wrote:
> > > On Sat, 4 Jul 2015, Russell King - ARM Linux wrote:
> > > 
> > > > On Sat, Jul 04, 2015 at 01:19:30PM +0800, Jisheng Zhang wrote:
> > > > > On Marvell Berlin SoCs, the cpu's local timer is shutdown when the cpu
> > > > > goes to a deep idle state, then the timer framework will be notified to
> > > > > use a broadcast timer instead. The broadcast timer uses dw-apb-ictl as
> > > > > interrupt chip, this patch adds irq_set_affinity support so that the
> > > > > going to deep idle state cpu can set the interrupt affinity of the
> > > > > broadcast interrupt to avoid unnecessary wakeups and IPIs.
> > > > 
> > > > NAK to this patch.
> > > > 
> > > > The real question is - if CPU0 is the CPU going offline, why is it
> > > > still receiving _any_ interrupts - all interrupts should be migrated
> > > > off it, including the chained interrupts.
> > > > 
> > > > Sounds like there's a bug in the migration code which needs further
> > > > investigation, rather than hacking around the problem by introducing
> > > > lots of driver code.
> > > 
> > > I think you misunderstood the changelog, which is horrible btw.
> > > 
> > > So the real reason to do this is to steer the broadcast interrupt to
> > > the CPU which has the earliest expiry time. This avoids that another
> > > cpu is woken from idle just to deliver the broadcast IPI to the other
> > > cpu.
> > 
> > Unless I'm mistaken, the code does this by messing around with the parent
> > interrupt affinity of a chained interrupt, which really isn't a good thing
> > to do, because it migrates every interrupt on the child interrupt
> > controller.
> 
> Fair enough, I missed that chained hackery.
> 
> For that powersaving scenario it's probably ok to move the all child
> irqs around, but we should at least make that an opt-in behaviour and
> not enabled by default.

Thank you for your suggestion. Is is acceptable to make an config option
such as DW_APB_ICTL_SET_AFFINITY, and warn enabled this would migrates every
interrupt, and disable it by default?

Thanks a lot,
Jisheng
