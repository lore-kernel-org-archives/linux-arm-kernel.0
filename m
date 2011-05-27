From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Fri, 27 May 2011 17:20:30 +0100
Subject: [RFC PATCH v3 00/13] Consolidating GIC per-cpu interrupts
In-Reply-To: <4DDD5309.9050505@codeaurora.org>
References: <1306342208-32754-1-git-send-email-marc.zyngier@arm.com>
	<4DDD5309.9050505@codeaurora.org>
Message-ID: <1306513230.27474.286.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-05-25 at 12:05 -0700, Stephen Boyd wrote:
> On 05/25/2011 09:49 AM, Marc Zyngier wrote:
> > The current GIC per-cpu interrupts (aka PPIs) suffer from a number of
> > problems:
> >
> > - They use a completely separate scheme to handle the interrupts,
> >   mostly because the PPI concept doesn't really match the kernel view
> >   of an interrupt.
> > - Some low-level code gets duplicated, as usual...
> > - At least one platform (msm) has started implementing its own
> >   alternative scheme.
> >
> > The proposed solution is to let the GIC code expose the PPIs as
> > something that the kernel can manage. Instead of having a single
> > interrupt number shared on all cores, make the interrupt number be
> > different on each CPU.
> >
> > This enables the use of the normal kernel API (request_irq() and
> > friends) and the elimination of some low level code.
> >
> > This patch set is based on 2.6.39+ as of May 24th. Tested on PB-11MP,
> > Pandaboard and SMDK-V310.
> 
> Hmm. I still get problems when I apply patch 1 and patch 9:
> 
> # echo 0 > /sys/devices/system/cpu/cpu1/online
> [  554.060000]_CPU1:_shutdown
> # echo 1 > /sys/devices/system/cpu/cpu1/online
> [  562.310000] CPU1: Booted secondary processor
> [  562.310000] CPU1: Unknown IPI message 0x1
> [  562.310000] BUG: sleeping function called from invalid context at kernel/mm/slub.c:847
> [  562.310000] in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swapper
> [  562.310000] no locks held by swapper/0.
> [  562.310000] [<c00424cc>] (unwind_backtrace+0x0/0x138) from [<c0233ba4>] (dump_stack+0x20/0x24)
> [  562.310000] [<c0233ba4>] (dump_stack+0x20/0x24) from [<c00538dc>] (__might_sleep+0x114/0x134)
> [  562.310000] [<c00538dc>] (__might_sleep+0x114/0x134) from [<c0114c80>] (kmem_cache_alloc_trace+0x54/0x2a8)
> [  562.310000] [<c0114c80>] (kmem_cache_alloc_trace+0x54/0x2a8) from [<c00aaca8>] (request_threaded_irq+0x8c/0x11c)
> [  562.310000] [<c00aaca8>] (request_threaded_irq+0x8c/0x11c) from [<c0230c28>](local_timer_setup+0x164/0x1bc)
> [  562.310000] [<c0230c28>] (local_timer_setup+0x164/0x1bc) from [<c0230528>] (percpu_timer_setup+0x4c/0xa0)
> [  562.310000] [<c0230528>] (percpu_timer_setup+0x4c/0xa0) from [<c0230678>] (secondary_start_kernel+0xfc/0x148)
> [  562.310000] [<c0230678>] (secondary_start_kernel+0xfc/0x148) from [<c004a76c>] (platform_cpu_die+0x24/0x6c)
> [  562.320000] Switched to NOHz mode on CPU #1
> 
> Which seems to be due to how secondary_start_kernel() has disabled
> preemption.

Indeed. request_irq() does a memory allocation, which is frowned upon
with preemption disabled. The only reason it doesn't scream at boot time
is because __might_sleep() is quite forgiving when the system is not
fully booted...

One possibility is to simply do a request_irq() at boot time, and then
using disable_irq()/enable_irq() the rest of the time.

New patch series following...

	M.
-- 
Reality is an implementation detail.
