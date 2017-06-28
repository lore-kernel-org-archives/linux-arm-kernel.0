From: msalter@redhat.com (Mark Salter)
Date: Wed, 28 Jun 2017 12:04:10 -0400
Subject: arm64 lockdep splat
In-Reply-To: <20170628151105.GC8252@leverpostej>
References: <1498661397.15177.12.camel@redhat.com>
 <20170628151105.GC8252@leverpostej>
Message-ID: <1498665850.15177.14.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-06-28 at 16:11 +0100, Mark Rutland wrote:
> On Wed, Jun 28, 2017 at 10:49:57AM -0400, Mark Salter wrote:
> > Hi Mark.
> 
> Hi Mark,
> 
> > I'm seeing this with lock debugging turned on and booting with ACPI:
> > 
> > [????0.137762] DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))?
> > [????0.137773] ------------[ cut here ]------------?
> > [????0.137785] WARNING: CPU: 0 PID: 12 at kernel/locking/lockdep.c:2881 lockdep_trace_alloc+0xb4/0xbc?
> > [????0.137788] Modules linked in:?
> > [????0.137793]??
> > [????0.137797] CPU: 0 PID: 12 Comm: cpuhp/0 Not tainted 4.11.0-10.el7a.aarch64.debug #1?
> > [????0.137800] Hardware name: HPE ProLiant m400 Server/ProLiant m400 Server, BIOS U02 08/19/2016?
> > [????0.137803] task: ffff800fc656d000 task.stack: ffff800fc65c8000?
> > [????0.137807] PC is at lockdep_trace_alloc+0xb4/0xbc?
> > [????0.137810] LR is at lockdep_trace_alloc+0xb4/0xbc?
> > ...
> > [????0.137939] [<ffff00000814559c>] lockdep_trace_alloc+0xb4/0xbc?
> > [????0.137944] [<ffff0000082b4fa0>] kmem_cache_alloc_trace+0x48/0x400?
> > [????0.137949] [<ffff000008737ac8>] armpmu_alloc+0x38/0x1e4?
> > [????0.137954] [<ffff000008738588>] arm_pmu_acpi_cpu_starting+0x170/0x1c4?
> > [????0.137958] [<ffff0000080d5f6c>] cpuhp_invoke_callback+0x100/0xcc0?
> > [????0.137961] [<ffff0000080d758c>] cpuhp_thread_fun+0xd8/0x12c?
> > [????0.137966] [<ffff000008104670>] smpboot_thread_fn+0x170/0x27c?
> > [????0.137970] [<ffff0000080fe910>] kthread+0x114/0x140?
> > [????0.137975] [<ffff0000080833d0>] ret_from_fork+0x10/0x40?
> 
> Sorry about this; I have a partial fix for this, but nothing complete
> yet.
> 
> > Specifically, warning about possible __GFP_FS reclaim with interrupts off.
> > Interrupts are disabled for cpuhp startup threads before CPUHP_AP_ONLINE, Is
> > there any reason why CPUHP_AP_PERF_ARM_ACPI_STARTING can't be moved after
> > CPUHP_AP_ONLINE??
> 
> I'll need to go digging into this. I can't immediately recall why
> CPUHP_AP_PERF_ARM_ACPI_STARTING and CPUHP_AP_PERF_ARM_STARTING need to
> be prior to CPUHP_AP_ONLINE.
> 
> I'm confused by the relationship with CPUHP_AP_PERF_ONLINE, and I think
> we might have other subtle breakage here in other perf drivers.

CPUHP_AP_PERF_ONLINE was introduced here:

commit 00e16c3d68fce504e880f59c9bdf23b2a4759d6d
Author: Thomas Gleixner <tglx@linutronix.de>
Date:???Wed Jul 13 17:16:09 2016 +0000

????perf/core: Convert to hotplug state machine
???
????Actually a nice symmetric startup/teardown pair which fits properly into
????the state machine concept. In the long run we should be able to invoke
????the startup callback for the boot CPU via the state machine and get
 ???rid of the init function which invokes it on the boot CPU.
????
????Note: This comes actually before the perf hardware callbacks. In the notifier
????model the hardware callbacks have a higher priority than the core
????callback. But that's solely for CPU offline so that hardware migration of
????events happens before the core is notified about the outgoing CPU.
????
??? With the symetric state array model we have the following ordering:
????
?????UP:?????core -> hardware
?????DOWN:???hardware -> core

> 
> Thanks for pointing this out -- this isn't an avenue I'd considered for
> fixing this.
> 
> > Or we could enabled irqs in arm_pmu_acpi_cpu_starting()?
> 
> I don't beleive that this is safe, given the CPU isn't fully up yet.
> Interrupts are presumably disabled with good reason.

Well, interrupts are already enabled but cpuhp_thread_fun() brackets
the invocation of the callback with local_irq_disable()/local_irq_enable().


> 
> > Or change the alloc flags?
> 
> Doing that's a first step, but we'll subsequently hit similar issues
> when fiddling with the irqs, and I haven't yet found a way to make that
> work.
> 
> Thanks,
> Mark.
