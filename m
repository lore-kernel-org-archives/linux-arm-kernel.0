From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Feb 2018 15:22:53 +0000
Subject: [PATCHv2 6/8] arm_pmu: explicitly enable/disable SPIs at hotplug
In-Reply-To: <CAMuHMdU9UPhKdNGknZDkrzWDE75sKDdbMNu4RFfU25eVEswLkg@mail.gmail.com>
References: <20180205164202.26502-1-mark.rutland@arm.com>
 <20180205164202.26502-7-mark.rutland@arm.com>
 <CAMuHMdU9UPhKdNGknZDkrzWDE75sKDdbMNu4RFfU25eVEswLkg@mail.gmail.com>
Message-ID: <20180226152253.GA19446@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 04:16:19PM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 5, 2018 at 5:42 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > To support ACPI systems, we need to request IRQs before CPUs are
> > hotplugged, and thus we need to request IRQs before we know their
> > associated PMU.
> >
> > This is problematic if a PMU IRQ is pending out of reset, as it may be
> > taken before we know the PMU, and thus the IRQ handler won't be able to
> > handle it, leaving it screaming.
> >
> > To avoid such problems, lets request all IRQs in a disabled state, and
> > explicitly enable/disable them at hotplug time, when we're sure the PMU
> > has been probed.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> 
> This is now commit 6de3f79112cc26bf in v4.16-rc3, and causes a BUG during
> CPU offlining (e.g. during system suspend, or during boot with
> CONFIG_ARM_PSCI_CHECKER=y).
> 
> With CONFIG_ARM_PSCI_CHECKER=y:
> 
> psci_checker: PSCI checker started using 6 CPUs
> psci_checker: Starting hotplug tests
> psci_checker: Trying to turn off and on again all CPUs
> BUG: sleeping function called from invalid context at kernel/irq/manage.c:112
> in_atomic(): 1, irqs_disabled(): 128, pid: 15, name: migration/1
> no locks held by migration/1/15.
> irq event stamp: 192
> hardirqs last  enabled at (191): [<00000000803c2507>]
> _raw_spin_unlock_irq+0x2c/0x4c
> hardirqs last disabled at (192): [<000000007f57ad28>] multi_cpu_stop+0x9c/0x140
> softirqs last  enabled at (0): [<0000000004ee1b58>]
> copy_process.isra.77.part.78+0x43c/0x1504
> softirqs last disabled at (0): [<          (null)>]           (null)
> CPU: 1 PID: 15 Comm: migration/1 Not tainted 4.16.0-rc3-salvator-x #1651
> Hardware name: Renesas Salvator-X board based on r8a7796 (DT)
> Call trace:
>  dump_backtrace+0x0/0x140
>  show_stack+0x14/0x1c
>  dump_stack+0xb4/0xf0
>  ___might_sleep+0x1fc/0x218
>  __might_sleep+0x70/0x80
>  synchronize_irq+0x40/0xa8
>  disable_irq+0x20/0x2c

Given that these things are CPU-affine, I reckon this should be
disable_irq_nosync. Mark?

Will

--->8

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 0c2ed11c0603..f63db346c219 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -638,7 +638,7 @@ static int arm_perf_teardown_cpu(unsigned int cpu, struct hlist_node *node)
 		if (irq_is_percpu_devid(irq))
 			disable_percpu_irq(irq);
 		else
-			disable_irq(irq);
+			disable_irq_nosync(irq);
 	}
 
 	per_cpu(cpu_armpmu, cpu) = NULL;
