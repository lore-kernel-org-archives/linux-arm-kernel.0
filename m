From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 25 Feb 2015 11:47:48 -0500 (EST)
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <20150225125610.GY8656@n2100.arm.linux.org.uk>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
 <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <20150205142918.GA10634@linux.vnet.ibm.com>
 <20150205161100.GQ8656@n2100.arm.linux.org.uk>
 <20150225125610.GY8656@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1502250941210.25484@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Feb 2015, Russell King - ARM Linux wrote:

> On Thu, Feb 05, 2015 at 04:11:00PM +0000, Russell King - ARM Linux wrote:
> > On Thu, Feb 05, 2015 at 06:29:18AM -0800, Paul E. McKenney wrote:
> > > Works for me, assuming no hidden uses of RCU in the IPI code.  ;-)
> > 
> > Sigh... I kind'a new it wouldn't be this simple.  The gic code which
> > actually raises the IPI takes a raw spinlock, so it's not going to be
> > this simple - there's a small theoretical window where we have taken
> > this lock, written the register to send the IPI, and then dropped the
> > lock - the update to the lock to release it could get lost if the
> > CPU power is quickly cut at that point.
> > 
> > Also, we _do_ need the second cache flush in place to ensure that the
> > unlock is seen to other CPUs.
> 
> It's time to start discussing this problem again now that we're the
> other side of the merge window.
> 
> I've been thinking about the lock in the GIC code.  Do we actually need
> this lock in gic_raise_softirq(), or could we move this lock into the
> higher level code?

It could be a rw lock as you say.

> Let's consider the bL switcher.
> 
> I think the bL switcher is racy wrt CPU hotplug at the moment.  What
> happens if we're sleeping in wait_for_completion(&inbound_alive) and
> CPU hotplug unplugs the CPU outgoing CPU?  What protects us against
> this scenario?  I can't see anything in bL_switch_to() which ensures
> that CPU hotplug can't run.

True.  The actual switch would then be suspended in mid air until that 
CPU is plugged back in.  The inbound CPU would wait at mcpm_entry_gated 
until the outbound CPU comes back to open the gate.  There wouldn't be 
much harm besides the minor fact that the inbound CPU would be wasting 
more power while looping on a WFE compared to its previously disabled 
state.  I'm still debating if this is worth fixing.

> Let's assume that this rather glaring bug has been fixed, and that CPU
> hotplug can't run in parallel with the bL switcher (and hence
> gic_migrate_target() can't run concurrently with a CPU being taken
> offline.)

I'm still trying to figure out how this might happen.  At the point 
where gic_migrate_target() is called, IRQs are disabled and nothing can 
prevent the switch from happening anymore.  Any IPI attempting to stop 
that CPU for hotplug would be pending until the inbound CPU 
eventually honors it.

> If we have that guarantee, then we don't need to take a lock when sending
> the completion IPI - we would know that while a CPU is being taken down,
> the bL switcher could not run.  What we now need is a lock-less way to
> raise an IPI.
>
> Now, is the locking between the normal IPI paths and the bL switcher
> something that is specific to the interrupt controller, or should generic
> code care about it?  I think it's something generic code should care about
> - and I believe that would make life a little easier.

Well... The only reason for having a lock there is to ensure that no 
IPIs are sent to the outbound CPU after gic_cpu_map[] has been modified 
and pending IPIs on the outbound CPU have been migrated to the inbound 
CPU.  I think this is pretty specific to the GIC driver code.

If there was a way for gic_migrate_target() to be sure no other CPUs are 
using the old gic_cpu_map value any longer then no lock would be needed 
in gic_raise_softirq().  The code in gic_migrate_target() would only 
have to wait until it is safe to migrate pending IPIs on the outbound 
CPU without missing any.

> The current bL switcher idea is to bring the new CPU up, disable IRQs
> and FIQs on the outgoing CPU, change the IRQ/IPI targets, then read
> any pending SGIs and raise them on the new CPU.  But what about any
> pending SPIs?  These look like they could be lost.

SPIs are raised and cleared independently of their distribution config.  
So the only thing that gic_migrate_target() has to do is to disable the 
distribution target for the outbound CPU and enable the target for the 
inbound CPU.  This way unserviced IRQs become pending on the outbound 
CPU automatically. The only other part that plays with targets is 
gic_set_affinity() and irq_controller_lock protects against concurrency 
here.

> How about this for an idea instead - the bL switcher code:
> 
> - brings the new CPU online.
> - disables IRQs and FIQs.
> - takes the IPI lock, which prevents new IPIs being raised.
> - re-targets IRQs and IPIs onto the new CPU.
> - releases the IPI lock.

But aren't we trying to get rid of that IPI lock to start with?  I'd 
personally love to remove it -- it's been nagging me since I initially 
added it.

> - re-enables IRQs and FIQs.
> - polls the IRQ controller to wait for any remaining IRQs and IPIs
>   to be delivered.

Poll for how long? How can you be sure no other CPU is in the process of 
targetting an IPI to the outbound CPU?  With things like the FIQ 
debugger coming to mainline or even JTAG-based debuggers, this could 
represent an indetermined amount of time if the sending CPU is stopped 
at the right moment.

That notwithstanding, I'm afraid this would open a big can of worms.  
The CPU would no longer have functional interrupts since they're all 
directed to the inbound CPU at that point.  Any IRQ controls are now 
directed to the new CPU and things like self-IPIs (first scenario that 
comes to my mind) would no longer produce the expected result.  I'd much 
prefer to get over with the switch ASAP at that point rather than 
letting the outbound CPU run much longer in a degraded state.

> - re-disables IRQs and FIQs (which shouldn't be received anyway since
>   they're now targetting the new CPU.)
> - shuts down the tick device.
> - completes the switch
> 
> What this means is that we're not needing to have complex code in the
> interrupt controllers to re-raise interrupts on other CPUs, and we
> don't need a lock in the interrupt controller code synchronising IPI
> raising with the bL switcher.
> 
> I'd also suggest is that this IPI lock should _not_ be a spinlock - it
> should be a read/write spin lock - it's perfectly acceptable to have
> multiple CPUs raising IPIs to each other, but it is not acceptable to
> have any CPU raising an IPI when the bL switcher is modifying the IRQ
> targets.  That fits the rwlock semantics.
> 
> What this means is that gic_raise_softirq() should again become a lock-
> less function, which opens the door to using an IPI to complete the
> CPU hot-unplug operation cleanly.
> 
> Thoughts (especially from Nico)?

I completely agree with the r/w spinlock. Something like this ought to 
be sufficient to make gic_raise_softirq() reentrant which is the issue 
here, right?  I've been stress-testing it for a while with no problems 
so far.

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4634cf7d0e..3404c6bc12 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -80,6 +80,9 @@ static DEFINE_RAW_SPINLOCK(irq_controller_lock);
 #define NR_GIC_CPU_IF 8
 static u8 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
 
+/* This allows for multiple concurrent users of gic_cpu_map[] */
+static DEFINE_RWLOCK(gic_cpu_map_lock);
+
 /*
  * Supported arch specific GIC irq extension.
  * Default make them NULL.
@@ -627,7 +630,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	int cpu;
 	unsigned long flags, map = 0;
 
-	raw_spin_lock_irqsave(&irq_controller_lock, flags);
+	read_lock_irqsave(&gic_cpu_map_lock, flags);
 
 	/* Convert our logical CPU mask into a physical one. */
 	for_each_cpu(cpu, mask)
@@ -642,7 +645,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	/* this always happens on GIC0 */
 	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
 
-	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
+	read_unlock_irqrestore(&gic_cpu_map_lock, flags);
 }
 #endif
 
@@ -711,6 +714,7 @@ void gic_migrate_target(unsigned int new_cpu_id)
 	cur_target_mask = 0x01010101 << cur_cpu_id;
 	ror_val = (cur_cpu_id - new_cpu_id) & 31;
 
+	write_lock(&gic_cpu_map_lock);
 	raw_spin_lock(&irq_controller_lock);
 
 	/* Update the target interface for this logical CPU */
@@ -731,6 +735,7 @@ void gic_migrate_target(unsigned int new_cpu_id)
 		}
 	}
 
+	write_unlock(&gic_cpu_map_lock);
 	raw_spin_unlock(&irq_controller_lock);
 
 	/*
