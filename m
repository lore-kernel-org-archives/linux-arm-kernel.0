From: jszhang@marvell.com (Jisheng Zhang)
Date: Sat, 4 Jul 2015 17:43:42 +0800
Subject: [PATCH v2 2/2] irqchip: dw-apb-ictl: add irq_set_affinity support
In-Reply-To: <20150704173533.39919c40@xhacker>
References: <1435987170-3962-1-git-send-email-jszhang@marvell.com>
 <1435987170-3962-3-git-send-email-jszhang@marvell.com>
 <20150704082623.GA7557@n2100.arm.linux.org.uk>
 <20150704165007.45aa9f45@xhacker>
 <20150704092546.GB7557@n2100.arm.linux.org.uk>
 <20150704173533.39919c40@xhacker>
Message-ID: <20150704174342.3fc8bd67@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell,

On Sat, 4 Jul 2015 17:35:33 +0800
Jisheng Zhang <jszhang@marvell.com> wrote:

> Dear Russell,
> 
> On Sat, 4 Jul 2015 10:25:46 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Sat, Jul 04, 2015 at 04:50:07PM +0800, Jisheng Zhang wrote:
> > > Dear Russell,
> > > 
> > > On Sat, 4 Jul 2015 09:26:23 +0100
> > > Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
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
> > > 
> > > I think it's due to broadcast timer interrupt. Let me describe the situation:
> > > 
> > > 1. cpu1 is going offline
> > > 2. cpuidle notify timer framework to use a broadcast timer instead due to localtimer
> > > is CLOCK_EVT_FEAT_C3STOP
> > > 3. when timer is expired, CPU0 will be waken up by the timer interrupt if it has
> > > gone offline
> > > 4. CPU0 sends broadcast timer IPI to CPU1
> > 
> > If CPU1 is going offline, then CPU1 should have no interrupts delivered to
> 
> "sleep $i" on CPU1 will make the timer framework to wake up it at current_time+$i
> in the future then go offline, currently this is achieved by programming one
> broadcast timer. In our case, the broadcast timer interrupt will be routed to
> CPU0 by default, so CPU0 has to send broadcast timer IPI to CPU1.
> 
> > it.  However, this is not the situation you're testing - in your results
> > below, and your "simple test" you never take CPU1 offline.
> > 
> 
> when cpu1 executes "sleep $i", cpu1 will go to deepest cpuidle level, in our
> case it will go offline.
> 

I may misread your emails. I guess the "offline" means "cpu hot unplug"? Sorry
for misunderstanding.

This patch doesn't try to improve anything related with "hog unplug", it tries to
improve the following situation instead:

1. cpu1 is entering deepest cpuidle level, shutdown in our case.
2. cpuidle notify timer framework to use a broadcast timer instead due to localtimer
is CLOCK_EVT_FEAT_C3STOP
3. when timer is expired, CPU0 will be waken up by the timer interrupt if it has
 been shutdown
4. CPU0 sends broadcast timer IPI to CPU1

Thanks,
Jisheng
