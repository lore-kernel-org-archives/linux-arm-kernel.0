From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Jul 2011 14:23:53 +0100
Subject: [PATCH 0/4] Fix CPU hotplug IRQ migration
In-Reply-To: <4E2D69C7.4040609@ti.com>
References: <20110721151413.GD28942@n2100.arm.linux.org.uk>
	<4E290C05.7020209@ti.com> <4E2D69C7.4040609@ti.com>
Message-ID: <20110725132353.GJ9653@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 06:34:07PM +0530, Santosh Shilimkar wrote:
> After CPU1 offline, the IRQ is handled by CPU0
> even though masks say's it's CPU0. Mask should have

ITYM CPU1 here.

> been corrected by hotplug code but as per your comments
> this is just userspace settings and shouldn't dictate
> which CPU handles the IRQ.
>
> The interesting part is once you online CPU now,
> IRQ44 continues to be on CPU0.

Yes, we don't migrate IRQs back onto their affine CPUs when they come
back online - I don't think anyone does.

> You think above behavior is fine? My i686 UBUNTU box,
> I don't see above behaviour. The hotplug code updates
> the IRQ mask to available CPU.

Yes, I noticed that, and the code is really weird - and I think buggy -
there for two reasons:

1. If you bind an interrupt to CPUs 1, and you take CPU 1 offline,
   the result is that the interrupt now is bound to _all_ CPUs even
   when CPU 1 comes back online.

2. irq_set_affinity() returns a code to indicate whether the affinity
   mask is to be updated (see __irq_set_affinity_locked - IRQ_SET_MASK_OK
   or IRQ_SET_MASK_OK_NOCOPY which defines whether irq_data->affinity
   is updated.

To have the individual irq_set_affinity() directly set irq_data->affinity
like x86 does seems to go against the intentions of
__irq_set_affinity_locked().

> Secondly, GIC smp_set_affinity is kind of set_target_cpu function.

No, the gic_set_affinity() has always been a "set this interrupt to be
routed to one of these IRQs", except when our IRQ migration code used
to call it with a specific CPU.  That's an exceptional (and incorrect)
case though.

Why?  The interface is that the affinity mask contains a set of CPUs,
and that's how generic code will call it when you write to the
/proc/irq/*/smp_affinity files.  If you have a 4-CPU system, and you
echo '3' into one of those files, gic_set_affinity() will be called
with a mask containing CPU0,1 and not 2,3.

The fact that gic_set_affinity() has always chosen the first CPU in the
mask is an implementation detail, one which should stay private to
gic_set_affinity().

> How can we relay the target CPU information to gic_arch_extn, so that
> they can update their settings as per GIC.

That was my point to Colin - the set_affinity() interface, nor
irq_data->affinity really isn't suitable for doing that.

One way we _could_ do it is have the GIC code recompose a CPU mask
containing exactly one CPU - but if we ever end up with NR_CPUS > 32
the CPU mask idea may become unmanagable - it may be better to pass
the exact CPU number down.  It depends how its going to be used, and
so far I can see no examples of that.
