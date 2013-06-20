From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 Jun 2013 11:28:56 +0100
Subject: BUG: commit "ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on
 pre-ARMv6 CPUs" breaks armv5 with CONFIG_PREEMPT
In-Reply-To: <51C2D5EF.3040803@pengutronix.de>
References: <51C2C0B5.8020802@pengutronix.de> <20130620095705.GA18536@arm.com>
 <51C2D5EF.3040803@pengutronix.de>
Message-ID: <20130620102856.GC18536@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 11:14:07AM +0100, Marc Kleine-Budde wrote:
> On 06/20/2013 11:57 AM, Catalin Marinas wrote:
> >>> :040000 040000 034899bdcbc9aa59b5455a85a9d78b646b4cf784 ecc23e33a4ca807d4153f87fbea85a9437ff2928 M      arch
> >>
> >> The problem can be reproduced on several mx28 and an at91sam9263 and
> >> only occurs of CONFIG_PREEMPT (Preemptible Kernel (Low-Latency Desktop))
> >> is enabled.
> >>
> >> I have the gut feeling that the "if (irqs_disabled())" check in the
> >> above patch is not correct for CONFIG_PREEMPT.
> > 
> > The check is there to avoid long interrupt latencies (flushing the whole
> > cache with interrupts disabled during context switch). You can drop the
> > check and always call cpu_switch_mm() to confirm that it fixes the
> > faults.
> > 
> > finish_task_switch() calls finish_arch_post_lock_switch() after the
> > interrupts have been enabled so that the CPU can actually switch the mm.
> > I wonder whether we could actually be preempted after
> > finish_lock_switch() but before we actually switched the MMU.
> > 
> > Here's an untested patch (trying to keep it in the arch/arm code):
> 
> [...]
> 
> When stating userspace I get this reproducible:
> 
> init started: BusyBox v1.18.5 (2013-04-04 18:31:36 CEST)
> starting pid 50, tty '/dev/console': '/etc/init.d/rcS'
> [    7.000828] ------------[ cut here ]------------
> [    7.005560] WARNING: at kernel/sched/core.c:2809 finish_task_switch.constprop.84+0xf8/0x164()
> [    7.014650] DEBUG_LOCKS_WARN_ON(val > preempt_count())

We may need to place the preempt disable/enable at a higher level in the
scheduler. My theory is that we have a context switch from prev to next.
We get preempted just before finish_arch_post_lock_switch(), so the MMU
hasn't been switched yet. The new switch during preemption happens to a
thread with the same next mm, so the scheduler no longer switch_mm() and
the TIF_SWITCH_MM isn't set for the new thread.

I'll come back with another patch shortly.

-- 
Catalin
