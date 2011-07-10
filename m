From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 10 Jul 2011 16:10:38 +0100
Subject: [PATCH v8 14/14] ARM: gic: add gic_ppi_map_on_cpu()
In-Reply-To: <20110708195708.GR4812@n2100.arm.linux.org.uk>
References: <1309855755-6261-1-git-send-email-marc.zyngier@arm.com>
	<1309855755-6261-15-git-send-email-marc.zyngier@arm.com>
	<20110708195708.GR4812@n2100.arm.linux.org.uk>
Message-ID: <20110710161038.46770f08@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Jul 2011 20:57:08 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Tue, Jul 05, 2011 at 09:49:15AM +0100, Marc Zyngier wrote:
> > It is sometimes usefull to compute the mapping of a PPI on a CPU
> > that is not the one handling the interrupt (in the probe function
> > of a driver, for example).
> 
> This is unsafe.  Firstly, smp_processor_id() in preemptible contexts
> is not valid as you can be migrated to another CPU at any moment.

Point taken. I think I can solve this by having a per-cpu variable
instead of hijacking the gic_chip_data structure.

> Secondly, if you have a driver probe function, and you want to
> register a PPI interrupt for a different CPU, while you can call the
> request function, the resulting ->unmask will be called on the
> calling CPU (assuming preempt is disabled and we don't schedule).
> You might get lucky and it may be called on your intended CPU...

I think you're going way beyond than the intended use of this function.
It is only there to be able to compute the PPI->IRQ mapping, *not* to
register the IRQ, which of course only make sense on the target CPU.

> That means the mask registers you access are on the local CPU, not
> the target CPU, so you end up with the wrong interrupt enabled.
> 
> As request_threaded_irq() contains a kzalloc() which can schedule,
> I can't see how you can safely request a particular per-CPU interrupt
> and guarantee that you'll enable it on the appropriate core.
> 
> Finally, note that using request_irq() from the secondary_startup()
> thread is probably a very bad idea - should it require to schedule,
> there is nothing for the secondary CPU to switch to - we're the
> secondary CPUs idle thread.
> 
> I think you'll need to use setup_irq() to register the PPI interrupts,
> especially for the TWD.  However, that then gives you a problem when
> you come to tear it down on CPU hot unplug, as free_irq() can't be
> used - it'll try to kfree() the static irqaction structure.

Actually, you wouldn't need to to do anything on CPU hot unplug (just
as it is now, actually). You could directly do another setup_irq() once
the CPU is hot plugged back. I'll have a look at this.

> So I think more thought is required on this entire patch set.
> 
> I have thought (before this patch set appeared) about making the PPI
> stuff entirely GIC specific, having an array of 16 function pointers
> in the GIC code to allow things like TWD to hook into.  No preemption
> or sleep problems, no genirq overhead to their handling, etc.  Then
> again, I think we do need irq_enter()..irq_exit().

Wouldn't that be another interrupt mechanism? I agree that it would be
simpler, but it would make the PPI handling different from normal
interrupts. genirq already has a percpu flow that is relatively cheap.
And being able to rely on the usual kernel semantics is probably the
best we can do while undergoing drastic changes such as DT.

If in the end we cannot efficiently cast PPI handling into genirq, then
I agree that your proposal is a sensible alternative.

	M.
-- 
I'm the slime oozin' out from your TV set...
