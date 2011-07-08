From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jul 2011 20:57:08 +0100
Subject: [PATCH v8 14/14] ARM: gic: add gic_ppi_map_on_cpu()
In-Reply-To: <1309855755-6261-15-git-send-email-marc.zyngier@arm.com>
References: <1309855755-6261-1-git-send-email-marc.zyngier@arm.com>
	<1309855755-6261-15-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110708195708.GR4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 09:49:15AM +0100, Marc Zyngier wrote:
> It is sometimes usefull to compute the mapping of a PPI on a CPU
> that is not the one handling the interrupt (in the probe function
> of a driver, for example).

This is unsafe.  Firstly, smp_processor_id() in preemptible contexts
is not valid as you can be migrated to another CPU at any moment.

Secondly, if you have a driver probe function, and you want to
register a PPI interrupt for a different CPU, while you can call the
request function, the resulting ->unmask will be called on the
calling CPU (assuming preempt is disabled and we don't schedule).
You might get lucky and it may be called on your intended CPU...

That means the mask registers you access are on the local CPU, not
the target CPU, so you end up with the wrong interrupt enabled.

As request_threaded_irq() contains a kzalloc() which can schedule,
I can't see how you can safely request a particular per-CPU interrupt
and guarantee that you'll enable it on the appropriate core.

Finally, note that using request_irq() from the secondary_startup()
thread is probably a very bad idea - should it require to schedule,
there is nothing for the secondary CPU to switch to - we're the
secondary CPUs idle thread.

I think you'll need to use setup_irq() to register the PPI interrupts,
especially for the TWD.  However, that then gives you a problem when
you come to tear it down on CPU hot unplug, as free_irq() can't be
used - it'll try to kfree() the static irqaction structure.

So I think more thought is required on this entire patch set.

I have thought (before this patch set appeared) about making the PPI
stuff entirely GIC specific, having an array of 16 function pointers
in the GIC code to allow things like TWD to hook into.  No preemption
or sleep problems, no genirq overhead to their handling, etc.  Then
again, I think we do need irq_enter()..irq_exit().
