From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Sep 2011 18:53:12 +0100
Subject: [patch] ARM: smpboot: Enable interrupts after marking CPU
	online/active
In-Reply-To: <CAKfTPtCWuiOM5+sOwdh1FzXZb1EFT__tVEpRPY5suGOxpYTdQQ@mail.gmail.com>
References: <20110908215314.829452535@linutronix.de>
	<CADGdYn6V_eQJZ4=irMbSS7XJj4MJVeALxcrWdD7o2bGs1sEJZQ@mail.gmail.com>
	<20110913133258.GA6267@n2100.arm.linux.org.uk>
	<CAKfTPtCWuiOM5+sOwdh1FzXZb1EFT__tVEpRPY5suGOxpYTdQQ@mail.gmail.com>
Message-ID: <20110913175312.GB6267@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2011 at 07:22:16PM +0200, Vincent Guittot wrote:
> The assumption done in the 1st patch that smp_store_cpu_info can be
> delayed is no more true. The smp_store_cpu_info is now also used to
> store the cpu topology information
> (https://lkml.org/lkml/2011/7/5/209). This must be done before calling
> sched_init_smp, which will use this information for building
> sched_domain.
> If we move set_cpu_online before smp_store_cpu_info, sched_init_smp
> can be called before having called smp_store_cpu_info on all cpus.

Right.  We hold off returning from cpu_up() by watching for the upcoming
CPU setting its online bit.

The bug which Thomas' patch introduces is to move the setting of that
before we've finished bringing the CPU up - specifically, allowing the
requesting CPU to continue while the brought-up CPU is still calibrating
loops_per_jiffy, and before it's stored that information and setup the
scheduler domain information.

The other issue is that moving the marking of the CPU online in the
way Thomas has means that we then invite the delivery of IPIs to the
CPU which is still in the process of coming up.  Whether that's an
issue depends on what the IPIs are.

So, we must have the setting of CPU online _after_ we've setup the
scheduler domain information etc - so the following is a strict
ordering:

1. calibrate_delay()
2. smp_store_cpu_info()
3. set_cpu_online()

Now, the question is do we need interrupts enabled to setup timers
via percpu_timer_setup() and calibrate delay.  Can we move enabling
interrupts after smp_store_cpu_info().  IOW, instead of moving the
setting of cpu online before all this, can we move notify_cpu_starting()
and the enabling of _both_ interrupts after smp_store_cpu_info()...
No idea at the moment.
